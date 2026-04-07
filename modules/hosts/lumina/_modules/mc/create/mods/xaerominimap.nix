{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/xaerominimap.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/1bokaNcj/versions/CatMvRfN/xaerominimap-neoforge-1.21.1-25.3.10.jar";
        hash = "sha512-l9vH3ci4bt6tcfYOMlcXWr6eBelDh0R6rSRnz88KUhHthI7j35uzwwgYNAX5l/is1QisAfjuN08I2a8Acp/B2A==";
      }}";
    };
  };
}
