{config, ...}: {
  services.caddy.virtualHosts = {
    "cap.wayclip.com".extraConfig = ''
      reverse_proxy http://127.0.0.1:3005
    '';
  };

  systemd.services.arion-cap = {
    after = ["redis-cap.service"];
    requires = ["redis-cap.service"];
  };

  services.redis.servers.cap = {
    enable = true;
    user = "cap";
    group = "cap";
  };

  virtualisation.arion.projects.cap.settings = {
    project.name = "cap";

    services.cap.service = {
      user = "9995:9995";
      image = "tiago2/cap:3.1.15";
      restart = "unless-stopped";

      environment = {
        REDIS_URL = "redis+unix:///run/redis/redis.sock";
        RATELIMIT_IP_HEADER = "x-forwarded-for";
        ENABLE_ASSETS_SERVER = "true";
        WIDGET_VERSION = "0.1.58";
        WASM_VERSION = "0.0.8";
      };

      env_file = [config.age.secrets."cap.environment".path];

      volumes = [
        "${config.services.redis.servers.cap.unixSocket}:/run/redis/redis.sock"
      ];

      ports = ["127.0.0.1:3005:3000"];
    };
  };

  users = {
    users.cap = {
      isSystemUser = true;
      uid = 9995;
      group = "cap";
      home = "/var/lib/cap";
    };

    groups.cap = {
      gid = 9995;
    };
  };

  age.secrets = {
    "cap.environment" = {
      file = secrets/environment.age;
    };
  };
}
