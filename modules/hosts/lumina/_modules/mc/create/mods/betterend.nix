{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/betterend.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/IcERKldh/versions/QWW9Gwwf/BetterEnd-21.0.24.jar";
        hash = "sha512-Bistb1Vf4Agn09xVdA/wo8KtPzAj3nBQnY38Qi+4aF9sSLKeUlagjbvhcGnCE3YQ2AwxqYHYIHf0Ux0IVwazEQ==";
      }}";
    };
  };
}
