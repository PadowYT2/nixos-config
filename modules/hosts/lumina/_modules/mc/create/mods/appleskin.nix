{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/appleskin.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/EsAfCjCV/versions/uAKA6Laj/appleskin-neoforge-mc1.21-3.0.9.jar";
        hash = "sha512-9OpGJz5AczS2PiYuJVXJqCBPe15g8j8nL7qoOtnoiADg7hhqyoQHEN8tvgoYs3dYaV/vKuGpAsELNwbj3ncpNw==";
      }}";
    };
  };
}
