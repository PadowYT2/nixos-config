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
    ) (_: {
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8025
      '';
    })
    // {
      "mail.proxied.host" = {
        extraConfig = ''
          @bulwark path /web*
          handle @bulwark {
            reverse_proxy http://127.0.0.1:7249
          }

          handle {
            reverse_proxy http://127.0.0.1:8025
          }
        '';
      };
    };

  systemd = {
    services = {
      stalwart = {
        after = ["postgresql.service" "redis-stalwart.service"];
        requires = ["postgresql.service" "redis-stalwart.service"];
      };

      stalwart-cert-sync = {
        description = "Stalwart cert sync";

        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Group = "root";
          ExecStart = lib.getExe setupScript;
          ExecStartPost = "${pkgs.systemd}/bin/systemctl restart stalwart.service";
        };
      };
    };

    paths.stalwart-cert-sync = {
      wantedBy = ["multi-user.target"];
      pathConfig = {
        PathModified = map (domain: "/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/${domain}") domains;
        Unit = "stalwart-cert-sync.service";
      };
    };

    tmpfiles.rules = [
      "d /var/lib/bulwark 0700 9998 9998 -"
    ];
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

      contacts.max-size = "524288000"; # 512MB
      calendar.max-size = "524288000"; # 512MB
      file-storage.max-size = "524288000"; # 512MB
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

  virtualisation.arion.projects.bulwark.settings = {
    project.name = "bulwark";

    services = {
      bulwark.service = {
        user = "9998:9998";
        image = "ghcr.io/bulwarkmail/webmail:1.4.9";
        restart = "unless-stopped";

        environment = {
          APP_NAME = "mail.proxied.host";
          JMAP_SERVER_URL = "https://mail.proxied.host";
          SETTINGS_SYNC_ENABLED = "true";
          COOKIE_SAME_SITE = "strict";
        };

        env_file = [config.age.secrets."bulwark.environment".path];

        volumes = [
          "/var/lib/bulwark:/app/data/settings"
        ];

        ports = ["7249:3000"];
      };
    };
  };

  users = {
    users.bulwark = {
      isSystemUser = true;
      uid = 9998;
      group = "bulwark";
      home = "/var/lib/bulwark";
    };

    groups.bulwark = {
      gid = 9998;
    };
  };

  age.secrets = {
    "stalwart.admin" = {
      file = secrets/admin.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "bulwark.environment" = {
      file = secrets/environment.age;
    };
  };
}
