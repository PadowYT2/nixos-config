{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/NBTAPI.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nfGCP9fk/versions/xYMUSA23/item-nbt-api-plugin-2.15.5.jar";
        hash = "sha256-lAVqDJJSyzzYH/L+TcluZ0tRCYyGsWK4YbfcodLTOSE=";
      }}";
    };

    files = {
      "plugins/NBTAPI/config.yml".value = {
        bStats = {
          enabled = true;
        };
        updateCheck = {
          enabled = false;
        };
        silentquickstart = true;
      };
    };
  };
}
