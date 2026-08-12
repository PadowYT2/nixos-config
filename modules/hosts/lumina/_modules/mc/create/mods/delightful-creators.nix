{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/delightfulcreators-1.2.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/jmJ87gsb/versions/xde79BbO/delightfulcreators-1.2.1.jar";
        hash = "sha512-7D0nn8+QwRyrdrRmzJ33T9M9AFTB1TzprhaVYMh7jVuo6fnvLK/GPRgcLGhH2SDhp0BQ+0WY7vhv2Wd0KQaDWA==";
      }}";
    };
  };
}
