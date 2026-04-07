{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/escalated.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LyOBYG8Q/versions/6DNGSw3t/escalated-1.2.1%2Bcreate.6.0.8-mc.1.21.1-neoforge.jar";
        hash = "sha512-I5omItZgwLJo6DJ3SdgbO2ksK0GKvhtyaeypSPhMfbqA7mXXx/nfSBXPUCnSvtLxBcj1kOpIsjvhndHXEYG+xQ==";
      }}";
    };
  };
}
