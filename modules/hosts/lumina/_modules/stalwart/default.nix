{config, ...}: {
  services.caddy.virtualHosts = {
    "mail-test.proxied.host".extraConfig = ''
      reverse_proxy http://127.0.0.1:8025
    '';
  };

  services.stalwart = {
    enable = true;

    settings = {
      server = {
        hostname = "mail-test.proxied.host";
        listener.http = {
          protocol = "http";
          bind = ["127.0.0.1:8025"];
          url = "https://mail-test.proxied.host";
        };
      };

      authentication.fallback-admin = {
        user = "admin";
        secret = "%{file:${config.age.secrets."stalwart.admin".path}}%";
      };
    };
  };

  age.secrets = {
    "stalwart.admin" = {
      file = secrets/admin.age;
      owner = "stalwart-mail";
      group = "stalwart-mail";
    };
  };
}
