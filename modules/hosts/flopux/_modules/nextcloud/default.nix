{
  config,
  pkgs,
  ...
}: {
  services.caddy.virtualHosts = {
    "nextcloud.flop4ik.dev".extraConfig = ''
      reverse_proxy http://localhost:8080
    '';
  };

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    hostName = "nextcloud.flop4ik.dev";
    database.createLocally = true;
    configureRedis = true;
    caching.redis = true;
    maxUploadSize = "20G";

    config = {
      dbtype = "pgsql";
      adminuser = "flop4ik";
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
  };

  services.nginx.virtualHosts.${config.services.nextcloud.hostName}.listen = [
    {
      addr = "127.0.0.1";
      port = 8080;
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
