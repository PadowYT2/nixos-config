{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mca.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/1W98a849/versions/pUsRHHSh/mca-neoforge-7.7.6%2B1.21.1.jar";
        hash = "sha512-7dxM5dkdU2Od3gb0aCaEeTaaexYXO4X5eBUSoS/jPonxZMx3jVBXvoPmrTCvSxT3VNDUnrMGm8JescvN9yVvYA==";
      }}";
    };
  };
}
