{
  pkgs,
  config,
  ...
}: {
  imports = [./_frankenphp.nix];
  nixpkgs.overlays = [inputs.quantum.overlays.default];

  services.caddy.virtualHosts = {
    "manage.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:4645
    '';
  };

  services.frankenphp = {
    enable = true;

    package = pkgs.frankenphp.override {
      php = config.services.pterodactyl.panel.phpPackage;
    };

    globalConfig = ''
      admin localhost:2020
    '';

    virtualHosts = {
      "http://:4645".extraConfig = ''
        root * ${config.services.pterodactyl.panel.package}/public
        file_server {
          precompressed br
        }
        php_server
      '';
    };
  };

  systemd.services.frankenphp = {
    serviceConfig = {
      AmbientCapabilities = "CAP_NET_BIND_SERVICE";
      CapabilityBoundingSet = "CAP_NET_BIND_SERVICE";
    };
  };

  users.groups.caddy.members = ["redis"];

  services.pterodactyl.panel = {
    enable = true;
    package = pkgs.quantum;
    user = "caddy";
    group = "caddy";
    enableNginx = false;
    app = {
      name = "proxied.host";
      url = "https://manage.proxied.host";
      keyFile = config.age.secrets."pterodactyl.panel.key".path;
    };
    database.user = "caddy";
    redis.passwordFile = config.age.secrets."pterodactyl.panel.redis".path;
    hashids.saltFile = config.age.secrets."pterodactyl.panel.salt".path;
    mail = {
      host = "mail.proxied.host";
      port = 587;
      username = "no-reply@proxied.host";
      passwordFile = config.age.secrets."pterodactyl.panel.smtp".path;
      fromAddress = "no-reply@proxied.host";
      fromName = "proxied.host";
    };
  };

  age.secrets = {
    "pterodactyl.panel.key" = {
      file = secrets/key.age;
      owner = "caddy";
      group = "caddy";
    };

    "pterodactyl.panel.redis" = {
      file = secrets/redis.age;
      owner = "caddy";
      group = "caddy";
    };

    "pterodactyl.panel.salt" = {
      file = secrets/salt.age;
      owner = "caddy";
      group = "caddy";
    };

    "pterodactyl.panel.smtp" = {
      file = secrets/smtp.age;
      owner = "caddy";
      group = "caddy";
    };
  };
}
