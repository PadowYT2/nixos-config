{config, ...}: {
  services.caddy.virtualHosts = {
    "i.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:3000
    '';

    "cdn.padow.ru".extraConfig = ''
      respond "unfortunately, a data loss occurred and this link no longer works"
    '';
  };

  services.zipline = {
    enable = true;
    settings = {
      CORE_RETURN_HTTPS_URLS = "true";
      CORE_TRUST_PROXY = "true";
      FILES_MAX_FILE_SIZE = "100gb";
      WEBSITE_TITLE = "i.proxied.host";
      WEBSITE_EXTERNAL_LINKS = "[]";
    };
    environmentFiles = [config.age.secrets."zipline.environment".path];
    database.createLocally = true;
  };

  age.secrets = {
    "zipline.environment" = {
      file = secrets/environment.age;
    };
  };
}
