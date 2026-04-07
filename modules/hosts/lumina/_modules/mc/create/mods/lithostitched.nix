{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/lithostitched.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/XaDC71GB/versions/keVceya0/lithostitched-1.6.5-neoforge-21.1.jar";
        hash = "sha512-mvnbX1havgmBaOgg7fppyFLCwCj+4uOld4MNB/Xb8AMpziThKj10gACSZvi/uehQsd3iB4cQNSVxep3xezQDuQ==";
      }}";
    };
  };
}
