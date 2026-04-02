{
  config,
  pkgs,
  ...
}: {
  services.caddy.virtualHosts = {
    "api.ente.padow.ru".extraConfig = ''
      reverse_proxy http://127.0.0.1:8085
    '';

    "s3.ente.padow.ru".extraConfig = ''
      reverse_proxy http://127.0.0.1:3900
    '';
  };

  services.garage = {
    enable = true;
    package = pkgs.garage_2;
    environmentFile = config.age.secrets."garage.environment".path;

    settings = {
      replication_factor = 1;
      rpc_bind_addr = "127.0.0.1:3901";
      rpc_public_addr = "127.0.0.1:3901";
      rpc_secret = "@env:GARAGE_RPC_SECRET";
      s3_api = {
        s3_region = "local";
        api_bind_addr = "127.0.0.1:3900";
        root_domain = ".s3.ente.padow.ru";
      };
    };
  };

  services.ente = {
    api = {
      enable = true;
      enableLocalDB = true;
      domain = "api.ente.padow.ru";
      settings = {
        http.port = 8085;
        s3 = {
          use_path_style_urls = true;
          garage = {
            endpoint = "https://s3.ente.padow.ru";
            region = "local";
            bucket = "ente";
            key = "GK746d4ea2d53bf7c0b8db5b06";
            secret._secret = config.age.secrets."ente.key".path;
          };
        };
        key = {
          encryption._secret = config.age.secrets."ente.encryption".path;
          hash._secret = config.age.secrets."ente.hash".path;
        };
        jwt.secret._secret = config.age.secrets."ente.jwt".path;
      };
    };
  };

  age.secrets = {
    "garage.environment" = {
      file = secrets/environment.age;
    };

    "ente.key" = {
      file = secrets/key.age;
      owner = "ente";
      group = "ente";
    };

    "ente.encryption" = {
      file = secrets/encryption.age;
      owner = "ente";
      group = "ente";
    };

    "ente.hash" = {
      file = secrets/hash.age;
      owner = "ente";
      group = "ente";
    };

    "ente.jwt" = {
      file = secrets/jwt.age;
      owner = "ente";
      group = "ente";
    };
  };
}
