{
  pkgs,
  config,
  ...
}: {
  services.caddy = {
    package = pkgs.caddy.withPlugins {
      plugins = ["github.com/caddy-dns/cloudflare@v0.2.4"];
      hash = "sha256-bzMqxWTqrJ1skZmRTXyEMCKStXpljbqe5r0Ve2cnBfM=";
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

      "*.djoh.pw".extraConfig = ''
        tls {
          dns cloudflare {$CF_API_TOKEN}
        }
        reverse_proxy http://localhost:4080
      '';

      "unitedconvoys.cc static.unitedconvoys.cc static-admin.unitedconvoys.cc".extraConfig = ''
        reverse_proxy http://localhost:4080
      '';
    };
  };

  systemd = {
    services = {
      arion-coolify = {
        after = ["postgresql.service" "redis-coolify.service"];
        requires = ["postgresql.service" "redis-coolify.service"];
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
  };

  services.redis.servers.coolify = {
    enable = true;
    user = "coolify";
    group = "coolify";
    requirePassFile = config.age.secrets."coolify.pass".path;
  };

  virtualisation.arion.projects.coolify.settings = {
    project.name = "coolify";

    services = {
      coolify.service = {
        user = "9999:9999";
        image = "ghcr.io/coollabsio/coolify:4.1.2";
        restart = "unless-stopped";

        environment = {
          APP_ENV = "production";
          APP_NAME = "Coolify";
          APP_URL = "https://deploy.proxied.host";
          SSL_MODE = "off";
          AUTOUPDATE = "false";
          SELF_HOSTED = "true";

          DB_CONNECTION = "pgsql";
          DB_HOST = "/run/postgresql";
          DB_PORT = "5432";
          DB_DATABASE = "coolify";
          DB_USERNAME = "coolify";

          REDIS_HOST = "/run/redis/redis.sock";
          REDIS_PORT = "0";
          QUEUE_CONNECTION = "redis";

          PUSHER_HOST = "realtime.deploy.proxied.host";
          PUSHER_PORT = "443";
          PUSHER_SCHEME = "https";
          PUSHER_BACKEND_HOST = "coolify-realtime";
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

        env_file = [config.age.secrets."coolify.environment".path];

        volumes = [
          "${config.age.secrets."coolify.environment".path}:/var/www/html/.env:ro"
          "${config.services.redis.servers.coolify.unixSocket}:/run/redis/redis.sock"
          "/run/postgresql:/run/postgresql"
          "/var/lib/coolify/ssh:/var/www/html/storage/app/ssh"
          "/var/lib/coolify/applications:/var/www/html/storage/app/applications"
          "/var/lib/coolify/databases:/var/www/html/storage/app/databases"
          "/var/lib/coolify/services:/var/www/html/storage/app/services"
          "/var/lib/coolify/backups:/var/www/html/storage/app/backups"
          "/var/lib/coolify/webhooks-during-maintenance:/var/www/html/storage/app/webhooks-during-maintenance"
          "/var/run/docker.sock:/var/run/docker.sock"
        ];

        ports = ["7345:8080"];
        extra_hosts = ["host-gateway:host-gateway" "host.docker.internal:host-gateway"];

        depends_on = ["coolify-realtime"];
      };

      coolify-realtime.service = {
        image = "ghcr.io/coollabsio/coolify-realtime:1.0.16";
        restart = "unless-stopped";

        environment = {
          APP_NAME = "Coolify";
          SOKETI_DEBUG = "false";
          REDIS_HOST = "/run/redis/redis.sock";
          REDIS_PORT = "0";
        };

        env_file = [config.age.secrets."coolify.environment".path];

        volumes = [
          "/var/lib/coolify/ssh:/var/www/html/storage/app/ssh"
          "${config.services.redis.servers.coolify.unixSocket}:/run/redis/redis.sock"
        ];

        ports = ["6001:6001"];
      };
    };
  };

  users = {
    users = {
      root.openssh.authorizedKeys.keys = ["ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIHZilp8Htz7R9+SM0XfVW+APrK/UMsJa5HeV0zszAHw"];

      coolify = {
        isSystemUser = true;
        uid = 9999;
        group = "coolify";
        home = "/var/lib/coolify";
      };
    };

    groups.coolify = {
      gid = 9999;
    };
  };

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
