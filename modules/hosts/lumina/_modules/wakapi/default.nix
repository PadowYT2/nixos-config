{config, ...}: {
  services.caddy.virtualHosts = {
    "wakatime.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:3002
    '';
  };

  services.wakapi = {
    enable = true;

    database = {
      dialect = "postgres";
      createLocally = true;
    };

    settings = {
      server = {
        port = 3002;
        public_url = "https://wakatime.proxied.host";
      };
      db = {
        dialect = "postgres";
        host = "127.0.0.1";
        port = 5432;
        name = "wakapi";
        user = "wakapi";
      };
      app = {
        max_inactive_months = -1;
      };
      security = {
        allow_signup = false;
        disable_frontpage = true;
      };
    };

    environmentFiles = [config.age.secrets."wakapi.environment".path];
  };

  age.secrets = {
    "wakapi.environment" = {
      file = secrets/environment.age;
      owner = "wakapi";
      group = "wakapi";
    };
  };
}
