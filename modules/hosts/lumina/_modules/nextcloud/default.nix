{
  pkgs,
  config,
  ...
}: {
  services.caddy.virtualHosts = {
    "drive.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:8079
    '';
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    hostName = "drive.proxied.host";
    database.createLocally = true;
    configureRedis = true;
    caching.redis = true;
    maxUploadSize = "100G";

    config = {
      dbtype = "pgsql";
      adminuser = "PadowYT2";
      adminpassFile = config.age.secrets."nextcloud.password".path;
    };

    settings = {
      overwriteprotocol = "https";
      mail_domain = "proxied.host";
      mail_smtphost = "mail.proxied.host";
      mail_smtpmode = "smtp";
      mail_smtpport = 587;
      mail_smtpauth = true;
      mail_smtpname = "no-reply@proxied.host";
      mail_from_address = "no-reply";
      trusted_proxies = ["127.0.0.1" "10.0.0.1" "fd00:1337::1"];
      forwarded_for_headers = ["HTTP_X_FORWARDED_FOR"];
      enabledPreviewProviders = [
        "OC\\Preview\\BMP"
        "OC\\Preview\\GIF"
        "OC\\Preview\\JPEG"
        "OC\\Preview\\Krita"
        "OC\\Preview\\MarkDown"
        "OC\\Preview\\MP3"
        "OC\\Preview\\OpenDocument"
        "OC\\Preview\\PNG"
        "OC\\Preview\\TXT"
        "OC\\Preview\\XBitmap"
        "OC\\Preview\\HEIC"
      ];
    };

    secretFile = config.age.secrets."nextcloud.secrets".path;

    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar contacts richdocuments;
    };

    notify_push = {
      enable = true;
      nextcloudUrl = "https://drive.proxied.host";
    };
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName}.listen = [
    {
      addr = "127.0.0.1";
      port = 8079;
    }
  ];

  age.secrets = {
    "nextcloud.password" = {
      file = secrets/password.age;
      owner = "nextcloud";
      group = "nextcloud";
    };

    "nextcloud.secrets" = {
      file = secrets/secrets.age;
      owner = "nextcloud";
      group = "nextcloud";
    };
  };
}
