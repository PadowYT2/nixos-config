{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/Design-n-Decor-1.21.1-2.2b.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/x49wilh8/versions/uQsIRky8/Design-n-Decor-1.21.1-2.2b.jar";
        hash = "sha512-2IhVPIolTDZU+Noq4srgu2QllFRscZiHOck79rGGaBReDOWxwgrgVEubYBnxfk2pRL1bwX5Ma3Pn8TdM+iyduQ==";
      }}";
    };
  };
}
