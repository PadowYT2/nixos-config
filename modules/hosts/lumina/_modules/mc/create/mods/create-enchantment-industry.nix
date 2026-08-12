{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create-enchantment-industry-2.5.1b.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/JWGBpFUP/versions/wYGhrJPO/create-enchantment-industry-2.5.1b.jar";
        hash = "sha512-AQQxSXzieYmtor53O7usHciA2wsG+CyJD+zyts4pHMb+amWweQ55cED003tX2uvuUKLErn3D4qqkY6xR1CLM6Q==";
      }}";
    };
  };
}
