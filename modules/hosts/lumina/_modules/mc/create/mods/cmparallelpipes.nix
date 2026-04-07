{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/cmparallelpipes.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/5jfUeix5/versions/aYrPugrv/cmparallelpipes-neoforge-2.0.2.jar";
        hash = "sha512-Ggjbp6HO89nkrtvbNhbqxsHS8LP3eqk2xaKT5gmfQLt4BbH1NGH+ub2KkZbPEN2PvSfeNd2f1bxIp6neEViwcg==";
      }}";
    };
  };
}
