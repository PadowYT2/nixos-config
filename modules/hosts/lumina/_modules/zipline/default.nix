{config, ...}: {
  services.caddy.virtualHosts = {
    "i.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:3000
    '';

    "cdn.konyogony.dev".extraConfig = ''
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
      CORE_DEFAULT_DOMAIN = "i.proxied.host";
      CORE_TRUST_PROXY = "true";
      CHUNKS_ENABLED = "true";
      FEATURES_IMAGE_COMPRESSION = "false";
      FEATURES_USER_REGISTRATION = "false";
      FEATURES_OAUTH_REGISTRATION = "false";
      FILES_DISABLED_EXTENSIONS = "";
      FILES_MAX_FILE_SIZE = "100gb";
      INVITES_ENABLED = "true";
      DOMAINS = "cdn.konyogony.dev";
      WEBSITE_TITLE = "i.proxied.host";
      WEBSITE_EXTERNAL_LINKS = "[]";
      OAUTH_GITHUB_CLIENT_ID = "Ov23liGy7UGmHxw4uJzO";
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
