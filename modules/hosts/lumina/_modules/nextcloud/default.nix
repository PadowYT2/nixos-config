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
      trusted_proxies = ["127.0.0.1"];
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

    extraAppsEnable = true;
    extraApps = with config.services.nextcloud.package.packages.apps; {
      inherit calendar contacts richdocuments;
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
  };
}
