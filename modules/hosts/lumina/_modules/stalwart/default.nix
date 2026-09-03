{
  inputs,
  config,
  pkgs,
  lib,
  ...
}: let
  domains = [
    "proxied.host"
    "padow.dev"
    "padow.ru"
    "djoh.pw"
    "konyogony.dev"
    "wayclip.com"
  ];

  set = elements:
    builtins.listToAttrs (map (el: {
        name = el;
        value = true;
      })
      elements);
  variant = type: value: {"@type" = type;} // value;
in {
  disabledModules = ["services/mail/stalwart.nix"];
  imports = [
    "${inputs.nixpkgs-stalwart}/nixos/modules/services/mail/stalwart"
    "${inputs.nixpkgs-stalwart}/nixos/modules/services/mail/stalwart/provision.nix"
  ];

  services.caddy.virtualHosts =
    lib.genAttrs (
      lib.concatMap (domain: [
        "ua-auto-config.${lib.removePrefix "mail." domain}"
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
      "inbox.proxied.host".extraConfig = ''
        reverse_proxy http://127.0.0.1:7249
      '';
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

  systemd.services.stalwart = {
    after = ["postgresql.service" "redis-stalwart.service"];
    requires = ["postgresql.service" "redis-stalwart.service"];
  };

  services.stalwart = {
    enable = true;
    package = pkgs.stalwart_0_16;
    stateVersion = "26.11";

    settings = variant "PostgreSql" {
      host = "/run/postgresql";
      port = config.services.postgresql.settings.port;
      database = "stalwart";
      authUsername = "stalwart";
      authSecret = variant "None" {};
    };

    provision = {
      enable = true;
      url = "http://127.0.0.1:8025/";
      username = "admin";
      passwordFile = config.age.secrets."stalwart.admin".path;

      singletons = {
        SystemSettings = {
          defaultHostname = "mail.proxied.host";
          defaultDomainId = "#domain-proxied-host";
          proxyTrustedNetworks = {};
        };

        InMemoryStore = variant "Redis" {
          url = "unix://${config.services.redis.servers.stalwart.unixSocket}";
        };

        Http = {
          enableHsts = true;
          usePermissiveCors = true;
          useXForwarded = true;
        };

        SenderAuth = {
          dkimStrict = true;
          dmarcVerify = {
            match = {
              "0" = {
                "if" = "listener == 'smtp'";
                "then" = "strict";
              };
            };
            "else" = "disable";
          };
        };

        MtaSts = {
          mode = "enforce";
          mxHosts = set ["mail.proxied.host"];
        };

        MtaStageRcpt = {
          script = {"else" = "'noreply'";};
          allowRelaying = {
            match = {
              "0" = {
                "if" = "!is_empty(authenticated_as)";
                "then" = "true";
              };
            };
            "else" = "false";
          };
        };

        ReportSettings = {
          outboundReportDomain = "proxied.host";
          inboundReportAddresses = set ["postmaster@proxied.host" "dmarc-reports@proxied.host"];
        };
      };

      objects = {
        SieveSystemScript = {
          reconcile = true;
          match = ["name"];
          objects = {
            noreply = {
              name = "noreply";
              isActive = true;
              contents = ''
                require ["envelope", "reject"];
                if envelope :localpart :is "to" "no-reply" {
                  reject "550 This address does not accept incoming mail.";
                  stop;
                }
              '';
            };
          };
        };

        DnsServer = {
          reconcile = true;
          match = ["description"];
          objects = builtins.listToAttrs (map (domain: {
              name = "cloudflare-${lib.replaceStrings ["."] ["-"] domain}";
              value = variant "Cloudflare" {
                description = "Cloudflare ${domain}";
                secret = variant "File" {
                  filePath = config.age.secrets."stalwart.domains.${lib.replaceStrings ["."] ["-"] domain}".path;
                };
              };
            })
            domains);
        };

        Tracer = {
          reconcile = true;
          match = ["level"];
          objects = {
            journal = variant "Journal" {
              enable = true;
              level = "info";
            };
          };
        };

        AcmeProvider = {
          reconcile = true;
          match = ["directory"];
          objects = {
            acme-cloudflare = {
              directory = "https://acme-v02.api.letsencrypt.org/directory";
              challengeType = "Dns01";
              contact = set ["postmaster@proxied.host"];
              renewBefore = "R23";
            };
          };
        };

        NetworkListener = {
          reconcile = true;
          match = ["name"];
          objects = {
            smtp = {
              name = "smtp";
              protocol = "smtp";
              bind = set ["[::]:25"];
              tlsImplicit = false;
            };

            submissions = {
              name = "submissions";
              protocol = "smtp";
              bind = set ["[::]:465"];
              tlsImplicit = true;
            };

            submission = {
              name = "submission";
              protocol = "smtp";
              bind = set ["[::]:587"];
              tlsImplicit = false;
            };

            imaps = {
              name = "imaps";
              protocol = "imap";
              bind = set ["[::]:993"];
              tlsImplicit = true;
            };

            imap = {
              name = "imap";
              protocol = "imap";
              bind = set ["[::]:143"];
              tlsImplicit = false;
            };

            pop3s = {
              name = "pop3s";
              protocol = "pop3";
              bind = set ["[::]:995"];
              tlsImplicit = true;
            };

            pop3 = {
              name = "pop3";
              protocol = "pop3";
              bind = set ["[::]:110"];
              tlsImplicit = false;
            };

            sieve = {
              name = "sieve";
              protocol = "manageSieve";
              bind = set ["[::]:4190"];
              tlsImplicit = false;
            };

            http = {
              name = "http";
              protocol = "http";
              bind = set ["127.0.0.1:8025"];
              tlsImplicit = false;
            };
          };
        };

        Domain = {
          reconcile = true;
          match = ["name"];
          objects = builtins.listToAttrs (map (domain: {
              name = "domain-${lib.replaceStrings ["."] ["-"] domain}";
              value = {
                name = domain;
                isEnabled = true;
                catchAllAddress = null;
                reportAddressUri = "mailto:postmaster@proxied.host";
                subAddressing = variant "Enabled" {};

                dnsManagement = variant "Automatic" {
                  dnsServerId = "#cloudflare-${lib.replaceStrings ["."] ["-"] domain}";
                  publishRecords =
                    if domain == "proxied.host"
                    then set ["mx" "dkim" "dmarc" "mtaSts" "tlsRpt" "caa" "autoConfig" "autoConfigLegacy" "autoDiscover" "tlsa"]
                    else set ["mx" "dkim" "dmarc" "mtaSts" "tlsRpt" "caa" "autoConfig" "autoConfigLegacy" "autoDiscover"];
                };

                certificateManagement = variant "Automatic" {
                  acmeProviderId = "#acme-cloudflare";
                };

                dkimManagement = variant "Automatic" {
                  algorithms = set ["Dkim1Ed25519Sha256" "Dkim1RsaSha256"];
                  selectorTemplate = "v{version}-{algorithm}-{date-%Y%m%d}";
                  rotateAfter = 90 * 24 * 60 * 60 * 1000;
                  retireAfter = 7 * 24 * 60 * 60 * 1000;
                  deleteAfter = 30 * 24 * 60 * 60 * 1000;
                };
              };
            })
            domains);
        };
      };
    };

    environmentFile = config.age.secrets."stalwart.environment".path;
  };

  virtualisation.arion.projects.bulwark.settings = {
    project.name = "bulwark";

    services = {
      bulwark.service = {
        user = "9998:9998";
        image = "ghcr.io/bulwarkmail/webmail:1.9.2";
        restart = "unless-stopped";

        environment = {
          APP_NAME = "mail.proxied.host";
          JMAP_SERVER_URL = "https://mail.proxied.host";
          SETTINGS_SYNC_ENABLED = "true";
          SESSION_SECRET_FILE = "/app/data/session_secret";
        };

        volumes = [
          "${config.age.secrets."bulwark.secret".path}:/app/data/session_secret:ro"
          "/var/lib/bulwark/settings:/app/data/settings"
          "/var/lib/bulwark/admin:/app/data/admin"
          "/var/lib/bulwark/admin-state:/app/data/admin-state"
          "/var/lib/bulwark/telemetry:/app/data/telemetry"
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

  systemd.tmpfiles.rules = [
    "d /var/lib/bulwark 0700 bulwark bulwark -"
    "Z /var/lib/bulwark 0700 bulwark bulwark -"
  ];

  age.secrets = {
    "stalwart.environment" = {
      file = secrets/environment.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "stalwart.admin" = {
      file = secrets/admin.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "bulwark.secret" = {
      file = secrets/secret.age;
      owner = "bulwark";
      group = "bulwark";
    };

    "stalwart.domains.proxied-host" = {
      file = secrets/domains/proxied-host.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "stalwart.domains.padow-dev" = {
      file = secrets/domains/padow-dev.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "stalwart.domains.padow-ru" = {
      file = secrets/domains/padow-ru.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "stalwart.domains.djoh-pw" = {
      file = secrets/domains/djoh-pw.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "stalwart.domains.konyogony-dev" = {
      file = secrets/domains/konyogony-dev.age;
      owner = "stalwart";
      group = "stalwart";
    };

    "stalwart.domains.wayclip-com" = {
      file = secrets/domains/wayclip-com.age;
      owner = "stalwart";
      group = "stalwart";
    };
  };
}
