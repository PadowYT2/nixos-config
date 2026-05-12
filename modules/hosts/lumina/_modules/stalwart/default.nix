{
  config,
  pkgs,
  lib,
  ...
}: let
  domains = [
    "mail.proxied.host"
    "padow.dev"
    "djoh.pw"
    "konyogony.dev"
    "qntm.sh"
  ];

  setupScript = pkgs.writeShellApplication {
    name = "stalwart-cert-setup";
    runtimeInputs = with pkgs; [coreutils];
    text = ''
      install -Dm600 -o ${config.services.stalwart.user} -g ${config.services.stalwart.group} \
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/mail.proxied.host/mail.proxied.host.crt ${config.services.stalwart.dataDir}/certs/mail.proxied.host.crt

      install -Dm600 -o ${config.services.stalwart.user} -g ${config.services.stalwart.group} \
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/mail.proxied.host/mail.proxied.host.key ${config.services.stalwart.dataDir}/certs/mail.proxied.host.key
    '';
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
      extraConfig = ''
        reverse_proxy http://127.0.0.1:8025
      '';
    })
    // {
      "inbox.proxied.host" = {
        extraConfig = ''
          reverse_proxy http://127.0.0.1:7249
        '';
      };
    };

  systemd = {
    services = {
      stalwart = {
        after = ["postgresql.service" "redis-stalwart.service"];
        requires = ["postgresql.service" "redis-stalwart.service"];
        serviceConfig = {
          RestrictAddressFamilies = ["AF_UNIX" "AF_INET" "AF_INET6"];
        };
      };

      stalwart-cert-sync = {
        description = "Stalwart cert sync";
        wantedBy = ["stalwart.service"];
        before = ["stalwart.service"];

        serviceConfig = {
          Type = "oneshot";
          User = "root";
          Group = "root";
          ExecStart = lib.getExe setupScript;
          ExecStartPost = "${pkgs.systemd}/bin/systemctl try-restart stalwart.service";
        };
      };
    };

    paths.stalwart-cert-sync = {
      wantedBy = ["multi-user.target"];
      pathConfig = {
        PathModified = ["/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/mail.proxied.host"];
        Unit = "stalwart-cert-sync.service";
      };
    };

    tmpfiles.rules = [
      "d /var/lib/bulwark 0700 9998 9998 -"
    ];
  };

  services.stalwart = {
    enable = true;
    stateVersion = "26.05";

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

        auto-ban.scan = {
          rate = "65535/1d";
          paths = ["/__completly_non_existing_route__/"];
        };
      };

      http = {
        use-x-forwarded = true;
        url = "https://mail.proxied.host";
        permissive-cors = true;
      };

      certificate."mail.proxied.host" = {
        cert = "%{file:${config.services.stalwart.dataDir}/certs/mail.proxied.host.crt}%";
        private-key = "%{file:${config.services.stalwart.dataDir}/certs/mail.proxied.host.key}%";
        default = true;
      };

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
          urls = "unix://${config.services.redis.servers.stalwart.unixSocket}";
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

      queue.tls.default.dane = "optional";

      session = {
        mta-sts.mode = "enforce";
        rcpt.script = "'noreply'";
      };

      sieve.trusted.scripts.noreply.contents = ''
        require ["envelope", "reject"];

        if envelope :localpart :is "to" "no-reply" {
          reject "550 This address does not accept incoming mail.";
          stop;
        }
      '';

      contacts.max-size = "524288000"; # 512MB
      calendar.max-size = "524288000"; # 512MB
      file-storage.max-size = "524288000"; # 512MB

      config.local-keys = [
        "server.*"
        "!server.blocked-ip.*"
        "!server.allowed-ip.*"
        "http.*"
        "certificate.*"
        "store.*"
        "directory.*"
        "storage.*"
        "authentication.fallback-admin.*"
        "queue.tls.default.dane"
        "session.mta-sts.*"
        "session.rcpt.script"
        "sieve.trusted.scripts.*"
        "contacts.max-size"
        "calendar.max-size"
        "file-storage.max-size"
      ];
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
        image = "ghcr.io/bulwarkmail/webmail:1.6.3";
        restart = "unless-stopped";

        environment = {
          APP_NAME = "mail.proxied.host";
          JMAP_SERVER_URL = "https://mail.proxied.host";
          SETTINGS_SYNC_ENABLED = "true";
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
