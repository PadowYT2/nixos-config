{config, ...}: {
  services.caddy.virtualHosts = {
    "surf.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:9100
    '';

    "surfing.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:9101
    '';
  };

  systemd.services.arion-remnawave = {
    after = ["postgresql.service" "redis-remnawave.service"];
    requires = ["postgresql.service" "redis-remnawave.service"];
  };

  services.postgresql = {
    ensureDatabases = ["remnawave"];
    ensureUsers = [
      {
        name = "remnawave";
        ensureDBOwnership = true;
      }
    ];
  };

  services.redis.servers.remnawave = {
    enable = true;
    user = "remnawave";
    group = "remnawave";
    requirePassFile = config.age.secrets."remnawave.pass".path;
  };

  virtualisation.arion.projects.remnawave.settings = {
    project.name = "remnawave";

    services = {
      remnawave.service = {
        user = "9997:9997";
        image = "remnawave/backend:2.7.4";
        restart = "unless-stopped";

        environment = {
          APP_PORT = "3000";
          METRICS_PORT = "3001";
          DATABASE_URL = "postgresql://remnawave@localhost/remnawave?host=/run/postgresql";
          REDIS_SOCKET = "/run/redis/redis.sock";
          FRONT_END_DOMAIN = "surf.proxied.host";
          SUB_PUBLIC_DOMAIN = "surfing.proxied.host/waves";
          PANEL_DOMAIN = "surf.proxied.host";
          METRICS_USER = "admin";
          PM2_HOME = "/tmp/.pm2";
        };

        env_file = [config.age.secrets."remnawave.environment".path];

        volumes = [
          "${config.services.redis.servers.remnawave.unixSocket}:/run/redis/redis.sock"
          "/run/postgresql:/run/postgresql"
        ];

        ports = ["9100:3000"];
      };

      remnawave-subscription.service = {
        image = "remnawave/subscription-page:7.2.1";
        restart = "unless-stopped";

        environment = {
          APP_PORT = "3010";
          REMNAWAVE_PANEL_URL = "http://remnawave:3000";
          CUSTOM_SUB_PREFIX = "waves";
        };

        env_file = [config.age.secrets."remnawave-subscription.environment".path];

        ports = ["9101:3010"];

        depends_on = ["remnawave"];
      };
    };
  };

  users = {
    users.remnawave = {
      isSystemUser = true;
      uid = 9997;
      group = "remnawave";
    };

    groups.remnawave = {
      gid = 9997;
    };
  };

  age.secrets = {
    "remnawave.environment" = {
      file = secrets/environment.age;
    };

    "remnawave.pass" = {
      file = secrets/pass.age;
    };

    "remnawave-subscription.environment" = {
      file = secrets/subscription/environment.age;
    };
  };
}
