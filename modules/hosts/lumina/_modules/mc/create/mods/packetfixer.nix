{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/packetfixer.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/c7m1mi73/versions/2C41Q8WX/packetfixer-3.3.1-1.20.5-1.21.X-merged.jar";
        hash = "sha512-0Kz6pu85T8fZ5ncCK9oGpsi+eFG6iGCJeZl3W2V7XhCHhXj+YmUFsMnbwB0m9VnbsSFKq7CB0HaCRkgEcJTi4Q==";
      }}";
    };
  };
}
