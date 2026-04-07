{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createdeco.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/sMvUb4Rb/versions/k95JcfbJ/createdeco-2.1.2-1.21.1-neo.jar";
        hash = "sha512-xgDxXOFzsB+GrtEtQNl8ESmNY8D3B/g+Wh8UEpzv1FwV6ihkKyO3hHAz/dPTbGGwoT226WsGDVXqd4F4EDtLCQ==";
      }}";
    };
  };
}
