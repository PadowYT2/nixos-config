{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/CinemaMod.jar" = "${pkgs.fetchurl {
        url = "https://i.proxied.host/u/slzEq5.jar";
        hash = "sha256-UMlzVNS2W+6ZbErsipAKX0fBfPrD3ZK0ma+cUJVZAUw=";
      }}";
    };
    files = {
      "plugins/CinemaMod/config.yml".value = {
        youtube-data-api-key = "abc123";
        enable-tab-theater-list = true;
        storage = {
          mysql = {
            use = false;
            host = "localhost";
            port = 3306;
            database = "cinemamod";
            username = "root";
            password = "password";
          };
          sqlite.use = true;
        };

        theaters = {
          theater1 = {
            name = "Theater 1";
            hidden = true;
            type = "public";
            screen = {
              world = "world";
              x = -28;
              y = -51;
              z = 71;
              facing = "NORTH";
              width = 15;
              height = 8;
              visible = true;
              muted = false;
            };
          };
        };

        autogenCubicRegions = false;
      };
    };
  };
}
