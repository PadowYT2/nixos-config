{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/WorldGuard.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/DKY9btbd/versions/J66QOTLZ/worldguard-bukkit-7.0.12-dist.jar";
        hash = "sha256-SLE2k4s81IFqlYh4R/8o5WoG+xEBAzRLtXRznDX56Gw=";
      }}";
    };
  };
}
