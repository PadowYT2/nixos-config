{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/midnightlib-neoforge-1.9.3+1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/codAaoxh/versions/6Gv5jvTB/midnightlib-neoforge-1.9.3%2B1.21.1.jar";
        hash = "sha512-WRPn6Ou/+3IyNRSqW+3OGQVohEFtCjOzivF2HudM+mAJls3pvX1wnuIVhHb6ouc1subqYQcpbUcdLFt7NdnabA==";
      }}";
    };
  };
}
