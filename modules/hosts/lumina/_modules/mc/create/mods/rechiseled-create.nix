{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/rechiseledcreate-1.1.1-neoforge-mc1.21.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/E6867niZ/versions/VnOezhJR/rechiseledcreate-1.1.1-neoforge-mc1.21.jar";
        hash = "sha512-ynfepN0ydhBRdleIVbD/2fSCVr7VhwGoYXGwXbERailZKHHKfW1azJoCMnCkVlT+tKtxUwJut1HVZ+e/iSylYA==";
      }}";
    };
  };
}
