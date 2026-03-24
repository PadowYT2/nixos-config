{
  pkgs,
  lib,
  config,
  ...
}: {
  services.caddy = {
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.3"];
      hash = "sha256-bL1cpMvDogD/pdVxGA8CAMEXazWpFDBiGBxG83SmXLA=";
    };

    virtualHosts = {
      "deploy.proxied.host".extraConfig = ''
        reverse_proxy http://localhost:7345
      '';

      "realtime.deploy.proxied.host".extraConfig = ''
        reverse_proxy http://localhost:6001
      '';

      "*.deploy.proxied.host".extraConfig = ''
        tls {
          dns cloudflare {$CF_API_TOKEN}
        }
        reverse_proxy http://localhost:4080
      '';
    };
  };

  systemd = {
    services = {
      docker-coolify = {
        after = ["postgresql.service" "redis-coolify.service"];
        requires = ["postgresql.service" "redis-coolify.service"];
      };

      docker-coolify-realtime = {
        after = ["redis-coolify.service"];
        requires = ["redis-coolify.service"];
      };

      caddy = {
        serviceConfig = {
          EnvironmentFile = [config.age.secrets."coolify.caddy".path];
          AmbientCapabilities = "CAP_NET_BIND_SERVICE";
          CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
        };
      };
    };

    tmpfiles.rules = [
      "d /var/lib/coolify/ssh 0700 9999 9999 -"
      "d /var/lib/coolify/ssh/keys 0700 9999 9999 -"
      "d /var/lib/coolify/ssh/mux 0700 9999 9999 -"
      "d /var/lib/coolify/applications 0700 9999 9999 -"
      "d /var/lib/coolify/databases 0700 9999 9999 -"
      "d /var/lib/coolify/services 0700 9999 9999 -"
      "d /var/lib/coolify/backups 0700 9999 9999 -"
      "d /var/lib/coolify/webhooks-during-maintenance 0700 9999 9999 -"
    ];
  };

  services.postgresql = {
    ensureDatabases = ["coolify"];
    ensureUsers = [
      {
        name = "coolify";
        ensureDBOwnership = true;
      }
    ];
    settings.listen_addresses = lib.mkForce "127.0.0.1,172.17.0.1,172.19.0.1";
    authentication = lib.mkAfter ''
      host coolify coolify 172.17.0.0/16 trust
      host coolify coolify 172.19.0.0/16 trust
    '';
  };

  services.redis.servers.coolify = {
    enable = true;
    bind = "127.0.0.1 172.17.0.1 172.19.0.1";
    port = 6380;
    requirePassFile = config.age.secrets."coolify.pass".path;
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers = {
      coolify = {
        image = "ghcr.io/coollabsio/coolify:4.0.0-beta.469";
        pull = "always";
        autoStart = true;

        environment = {
          APP_ENV = "production";
          APP_NAME = "Coolify";
          APP_URL = "https://deploy.proxied.host";
          APP_PORT = "7345";
          SSL_MODE = "off";
          AUTOUPDATE = "false";
          SELF_HOSTED = "true";

          DB_CONNECTION = "pgsql";
          DB_HOST = "host.docker.internal";
          DB_PORT = "5432";
          DB_DATABASE = "coolify";
          DB_USERNAME = "coolify";

          REDIS_HOST = "host.docker.internal";
          REDIS_PORT = "6380";
          QUEUE_CONNECTION = "redis";

          PUSHER_HOST = "realtime.deploy.proxied.host";
          PUSHER_PORT = "443";
          PUSHER_SCHEME = "http";
          PUSHER_BACKEND_HOST = "host.docker.internal";
          PUSHER_BACKEND_PORT = "6001";

          PHP_MEMORY_LIMIT = "512M";
          HORIZON_BALANCE = "auto";
          HORIZON_MAX_PROCESSES = "10";
          HORIZON_BALANCE_MAX_SHIFT = "1";
          HORIZON_BALANCE_COOLDOWN = "3";
          PHP_PM_CONTROL = "dynamic";
          PHP_PM_START_SERVERS = "1";
          PHP_PM_MIN_SPARE_SERVERS = "1";
          PHP_PM_MAX_SPARE_SERVERS = "10";
        };

        environmentFiles = [config.age.secrets."coolify.environment".path];

        volumes = [
          "${config.age.secrets."coolify.environment".path}:/var/www/html/.env:ro"
          "/var/lib/coolify/ssh:/var/www/html/storage/app/ssh"
          "/var/lib/coolify/applications:/var/www/html/storage/app/applications"
          "/var/lib/coolify/databases:/var/www/html/storage/app/databases"
          "/var/lib/coolify/services:/var/www/html/storage/app/services"
          "/var/lib/coolify/backups:/var/www/html/storage/app/backups"
          "/var/lib/coolify/webhooks-during-maintenance:/var/www/html/storage/app/webhooks-during-maintenance"
          "/var/run/docker.sock:/var/run/docker.sock"
        ];

        ports = ["7345:8080"];

        extraOptions = [
          "--add-host=host.docker.internal:host-gateway"
        ];

        dependsOn = ["coolify-realtime"];
      };

      coolify-realtime = {
        image = "ghcr.io/coollabsio/coolify-realtime:1.0.11";
        pull = "always";
        autoStart = true;

        environment = {
          APP_NAME = "Coolify";
          SOKETI_DEBUG = "false";
        };

        environmentFiles = [config.age.secrets."coolify.environment".path];

        volumes = [
          "/var/lib/coolify/ssh:/var/www/html/storage/app/ssh"
        ];

        ports = ["6001:6001"];

        extraOptions = [
          "--add-host=host.docker.internal:host-gateway"
        ];
      };
    };
  };

  users.users.root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHZilp8Htz7R9+SM0XfVW+APrK/UMsJa5HeV0zszAHw"];

  age.secrets = {
    "coolify.caddy" = {
      file = secrets/caddy.age;
      owner = "caddy";
      group = "caddy";
    };

    "coolify.environment" = {
      file = secrets/environment.age;
    };

    "coolify.pass" = {
      file = secrets/pass.age;
    };
  };
}
