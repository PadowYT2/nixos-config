{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [./_frankenphp.nix];

  services.caddy.virtualHosts = {
    "panel.magmamc.org".extraConfig = ''
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
    user = "caddy";
    group = "caddy";
    enableNginx = false;
    app = {
      name = "MagmaMC";
      url = "https://panel.magmamc.org";
      keyFile = config.age.secrets."pterodactyl.panel.key".path;
    };
    database.user = "caddy";
    hashids.saltFile = config.age.secrets."pterodactyl.panel.salt".path;
  };

  age.secrets = {
    "pterodactyl.panel.key" = {
      file = secrets/key.age;
      owner = "caddy";
      group = "caddy";
    };

    "pterodactyl.panel.salt" = {
      file = secrets/salt.age;
      owner = "caddy";
      group = "caddy";
    };
  };
}
