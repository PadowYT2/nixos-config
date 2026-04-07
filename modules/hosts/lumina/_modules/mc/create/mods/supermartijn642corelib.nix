{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/supermartijn642corelib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/rOUBggPv/versions/hcYSe7v7/supermartijn642corelib-1.1.21-neoforge-mc1.21.jar";
        hash = "sha512-keZ75xjcKIyV4iunjlTet1xPEQr93d++9YSAAZAI05qu63EE/N39RaScXm7nA7IMHSLFrTL2MFne7wgMe65PYg==";
      }}";
    };
  };
}
