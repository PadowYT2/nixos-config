{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/interiors-1.21.1-neoforge-0.6.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/r4Knci2k/versions/gBrfZy6S/interiors-1.21.1-neoforge-0.6.1.jar";
        hash = "sha512-aLDZFeQfsM6dEqjFgNaIpgR3De0rIeljBYqm2Ay8VmHEgUFtBRpUE5W1x59GHty2WARuU8/PtAUXmkUGYu0BtQ==";
      }}";
    };
  };
}
