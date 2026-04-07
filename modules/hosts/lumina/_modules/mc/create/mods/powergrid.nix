{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/powergrid.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/eWiBLJ9R/versions/bli22EIb/powergrid-mc1.21.1-0.5.4.jar";
        hash = "sha512-q64CMiD+GhGoChEOKKgwrSU/WYp5Xt0Jv7xKXI/L3Rsesp6J9xZvoyVSE7VBZNXR9wc5hX1ronwr5IH2+EQC+A==";
      }}";
    };
  };
}
