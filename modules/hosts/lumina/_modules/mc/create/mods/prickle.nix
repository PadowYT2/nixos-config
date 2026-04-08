{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/prickle.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/aaRl8GiW/versions/EE1FHDyD/prickle-neoforge-1.21.1-21.1.11.jar";
        hash = "sha512-FU1CeVzPHz4HcUd1zbgv1dsXV0MZKGztE9hrBFa2Tkz1u4n/vL/O/OZ7c+0Lg+TilE5JPXnZo4X/neIwBu579Q==";
      }}";
    };
  };
}
