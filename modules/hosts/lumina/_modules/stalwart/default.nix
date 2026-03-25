{
  config,
  pkgs,
  lib,
  ...
}: let
  domains = [
    "mail.proxied.host"
  ];

  setupScript = pkgs.writeShellApplication {
    name = "stalwart-cert-setup";
    runtimeInputs = with pkgs; [coreutils];
    text =
      lib.concatMapStrings (domain: ''
        install -Dm600 -o ${config.services.stalwart.user} -g ${config.services.stalwart.group} \
          /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/${domain}/${domain}.crt ${config.services.stalwart.dataDir}/certs/${domain}.crt

        install -Dm600 -o ${config.services.stalwart.user} -g ${config.services.stalwart.group} \
          /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/${domain}/${domain}.key ${config.services.stalwart.dataDir}/certs/${domain}.key
      '')
      domains;
  };
in {
  services.caddy.virtualHosts =
    lib.genAttrs (
      lib.concatMap (domain: [
        "autoconfig.${lib.removePrefix "mail." domain}"
        "autodiscover.${lib.removePrefix "mail." domain}"
        "mta-sts.${lib.removePrefix "mail." domain}"
      ])
      domains
      ++ ["mail.proxied.host"]
    ) (_: {
      extraConfig = "reverse_proxy http://127.0.0.1:8025";
    });

  systemd = {
    services.stalwart = {
      after = ["postgresql.service" "redis-stalwart.service" "stalwart-cert-install.service"];
      requires = ["postgresql.service" "redis-stalwart.service" "stalwart-cert-install.service"];
    };

    services.stalwart-cert-install = {
      description = "Stalwart cert install";
      after = ["caddy.service"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
        Group = "root";
        ExecStart = lib.getExe setupScript;
      };
    };

    services.stalwart-cert-sync = {
      description = "Stalwart cert sync";

      serviceConfig = {
        Type = "oneshot";
        User = "root";
        Group = "root";
        ExecStart = lib.getExe setupScript;
        ExecStartPost = "${pkgs.systemd}/bin/systemctl restart stalwart.service";
      };
    };

    paths.stalwart-cert-sync = {
      wantedBy = ["multi-user.target"];
      pathConfig = {
        PathModified = map (domain: "/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/${domain}") domains;
        Unit = "stalwart-cert-sync.service";
      };
    };
  };

  services.stalwart = {
    enable = true;

    settings = {
      server = {
        hostname = "mail.proxied.host";

        tls = {
          enable = true;
          implicit = false;
          certificate = "mail.proxied.host";
        };

        listener = {
          smtp = {
            protocol = "smtp";
            bind = ["[::]:25"];
          };

          submission = {
            protocol = "smtp";
            bind = ["[::]:587"];
          };

          submissions = {
            protocol = "smtp";
            bind = ["[::]:465"];
            tls.implicit = true;
          };

          imap = {
            protocol = "imap";
            bind = ["[::]:143"];
          };

          imaps = {
            protocol = "imap";
            bind = ["[::]:993"];
            tls.implicit = true;
          };

          pop3 = {
            protocol = "pop3";
            bind = ["[::]:110"];
          };

          pop3s = {
            protocol = "pop3";
            bind = ["[::]:995"];
            tls.implicit = true;
          };

          sieve = {
            protocol = "managesieve";
            bind = ["[::]:4190"];
          };

          http = {
            protocol = "http";
            bind = ["127.0.0.1:8025"];
            url = "https://mail.proxied.host";
          };
        };
      };

      http = {
        use-x-forwarded = true;
        url = "https://mail.proxied.host";
      };

      certificate = lib.genAttrs domains (domain: {
        cert = "%{file:${config.services.stalwart.dataDir}/certs/${domain}.crt}%";
        private-key = "%{file:${config.services.stalwart.dataDir}/certs/${domain}.key}%";
        default = domain == "mail.proxied.host";
      });

      store = {
        postgresql = {
          type = "postgresql";
          host = "/run/postgresql";
          database = "stalwart";
          user = "stalwart";
        };

        redis = {
          type = "redis";
          redis-type = "single";
          urls = config.services.redis.servers.stalwart.unixSocket;
        };
      };

      directory.internal = {
        type = "internal";
        store = "postgresql";
      };

      storage = {
        data = "postgresql";
        blob = "postgresql";
        fts = "postgresql";
        lookup = "redis";
        directory = "internal";
      };

      authentication.fallback-admin = {
        user = "admin";
        secret = "%{file:${config.age.secrets."stalwart.admin".path}}%";
      };
    };
  };

  services.postgresql = {
    ensureDatabases = ["stalwart"];
    ensureUsers = [
      {
        name = "stalwart";
        ensureDBOwnership = true;
      }
    ];
  };

  services.redis.servers.stalwart = {
    enable = true;
    user = "stalwart";
    group = "stalwart";
  };

  age.secrets = {
    "stalwart.admin" = {
      file = secrets/admin.age;
      owner = "stalwart";
      group = "stalwart";
    };
  };
}
