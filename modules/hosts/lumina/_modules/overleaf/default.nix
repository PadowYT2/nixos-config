{
  pkgs,
  config,
  ...
}: {
  services.caddy.virtualHosts = {
    "overleaf.konyogony.dev".extraConfig = ''
      reverse_proxy http://localhost:7875
    '';
  };

  systemd = {
    services.arion-overleaf = {
      after = ["mongodb.service" "redis-overleaf.service"];
      requires = ["mongodb.service" "redis-overleaf.service"];
    };

    services.mongodb.serviceConfig = {
      RuntimeDirectory = "mongodb";
      RuntimeDirectoryMode = "0755";
    };

    tmpfiles.rules = [
      "d /var/lib/overleaf 0700 9996 9996 -"
    ];
  };

  services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
    replSetName = "overleaf";
    initialScript = pkgs.writeText "overleaf-rs-init.js" ''
      rs.initiate({ _id: "overleaf", members: [{ _id: 0, host: "127.0.0.1:27017" }] })
    '';
    extraConfig = ''
      net.unixDomainSocket.pathPrefix: /run/mongodb
      net.unixDomainSocket.filePermissions: 0777
    '';
  };

  services.redis.servers.overleaf = {
    enable = true;
    user = "overleaf";
    group = "overleaf";
  };

  virtualisation.arion.projects.overleaf.settings = {
    project.name = "overleaf";

    services = {
      redis-proxy.service = {
        image = "alpine/socat:1.8.0.3";
        command = ["tcp-listen:6379,fork,reuseaddr" "unix-connect:/run/redis/redis.sock"];
        volumes = [
          "${config.services.redis.servers.overleaf.unixSocket}:/run/redis/redis.sock"
        ];
        restart = "unless-stopped";
      };

      overleaf.service = {
        image = "rigon/sharelatex-full:6.1.2";
        restart = "unless-stopped";

        environment = {
          OVERLEAF_ADMIN_EMAIL = "admin@example.com";
          OVERLEAF_SITE_URL = "https://overleaf.konyogony.dev";

          OVERLEAF_MONGO_URL = "mongodb://%2Frun%2Fmongodb%2Fmongodb-27017.sock/sharelatex?directConnection=true";
          OVERLEAF_REDIS_HOST = "redis-proxy";
          REDIS_HOST = "redis-proxy";
          REDIS_PORT = "6379";

          ENABLED_LINKED_FILE_TYPES = "project_file,project_output_file";
          ENABLE_CONVERSIONS = "true";
          EMAIL_CONFIRMATION_DISABLED = "false";

          OVERLEAF_EMAIL_SMTP_USER = "no-reply@konyogony.dev";
          OVERLEAF_EMAIL_SMTP_HOST = "mail.proxied.host";
          OVERLEAF_EMAIL_SMTP_PORT = "587";
          OVERLEAF_EMAIL_SMTP_SECURE = "false";
          OVERLEAF_EMAIL_FROM_ADDRESS = "no-reply@konyogony.dev";
        };

        env_file = [config.age.secrets."overleaf.environment".path];

        volumes = [
          "/run/mongodb:/run/mongodb"
          "/var/lib/overleaf:/var/lib/overleaf"
        ];

        ports = ["7875:80"];
        extra_hosts = ["host-gateway:host-gateway" "host.docker.internal:host-gateway"];

        depends_on = ["redis-proxy"];
      };
    };
  };

  users = {
    users.overleaf = {
      isSystemUser = true;
      uid = 9996;
      group = "overleaf";
      home = "/var/lib/overleaf";
    };

    groups.overleaf = {
      gid = 9996;
    };
  };

  age.secrets = {
    "overleaf.environment" = {
      file = secrets/environment.age;
    };

    "overleaf.pass" = {
      file = secrets/pass.age;
    };
  };
}
