{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/forgified-fabric-api-0.116.15+2.3.1+1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Aqlf1Shp/versions/L9bk5uA9/forgified-fabric-api-0.116.15%2B2.3.1%2B1.21.1.jar";
        hash = "sha512-3mzHakBjccbKuGAGIeqb9jCnlrqqZK+iEDp1zdzIq1LgoVpcPeybLtLPPvzX2TxiJDTrPo0Ac2H91U8lBMCXVw==";
      }}";
    };
  };
}
