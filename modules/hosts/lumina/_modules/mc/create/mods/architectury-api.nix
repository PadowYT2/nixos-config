{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/architectury-13.0.11-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/1IiqEQGl/architectury-13.0.11-neoforge.jar";
        hash = "sha512-2ffDu4FiV337Rh/98EvWo1Y8dYaTSg4qdEwUQhvv+4KG8NiNTHWDFwA/IPmf6AcqObnWda8GHgNpcNNts2An8A==";
      }}";
    };
  };
}
