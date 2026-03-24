{config, ...}: {
  services.caddy.virtualHosts = {
    "cdn.flop4ik.dev".extraConfig = ''
      reverse_proxy http://localhost:3000
    '';
  };

  services.zipline = {
    enable = true;
    environmentFiles = [config.age.secrets."zipline.environment".path];
    database.createLocally = true;
  };

  age.secrets = {
    "zipline.environment" = {
      file = secrets/environment.age;
    };
  };
}
