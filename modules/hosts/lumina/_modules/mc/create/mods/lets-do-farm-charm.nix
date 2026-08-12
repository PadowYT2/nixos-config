{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/letsdo-farm_and_charm-neoforge-1.1.23.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/HJetCzWo/versions/DlXdACqc/letsdo-farm_and_charm-neoforge-1.1.23.jar";
        hash = "sha512-53JLSaKSEDQ46LqYLKmli6zeFeVYiophDdYo2m+SEQtwoRbCXTwVCuBLauDDOVPrWFjsK2a8dj96qnflBQ3DnA==";
      }}";
    };
  };
}
