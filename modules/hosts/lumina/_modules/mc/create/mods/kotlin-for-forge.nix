{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/kotlinforforge-5.12.0-all.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ordsPcFz/versions/uhJhCT7X/kotlinforforge-5.12.0-all.jar";
        hash = "sha512-uMOUL00zF57fPxAvPYcLmd1Db4uCNtu9MapRuIgWLGks/YiScpXyTci0N1Iy9MbBc2DF1sSCP5PLzXz0vci9FA==";
      }}";
    };
  };
}
