{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createthreadedtrains.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/RYJzdkDr/versions/ry1hvo4l/createthreadedtrains-neoforge-1.21.1-1.0.0.jar";
        hash = "sha512-k1EdMujHSE/c/ZBkbUjyl7oxiHiODqZBKQC+OK5rguabwTG7sBFRm1KsByin39UxwKw1ank1M1wG9pGtIOOMaQ==";
      }}";
    };
  };
}
