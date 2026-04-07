{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/rechiseled.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/B0g2vT6l/versions/b3uurWWs/rechiseled-1.2.4-neoforge-mc1.21.jar";
        hash = "sha512-t48BQGC4LuoCBkChDMPndMs1X1KJ6RGR8vASLutCQOrJILOZHRD9HYYo6/IkgyLd9XAxF8VXg949mUj6u9Ti+A==";
      }}";
    };
  };
}
