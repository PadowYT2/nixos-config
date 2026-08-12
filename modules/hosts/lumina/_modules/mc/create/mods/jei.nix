{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/jei-1.21.1-neoforge-19.44.0.401.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/u6dRKJwZ/versions/Tbomhybz/jei-1.21.1-neoforge-19.44.0.401.jar";
        hash = "sha512-1S7FpU7E8d9q3fax9M5mB3DAA9bqRbPzMIedmE0zYABQ5zkOCqAlsGeJh3Gulp157zx/zZB3UTF/0XAJG0Uxcw==";
      }}";
    };
  };
}
