{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/xaeroworldmap.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/NcUtCpym/versions/arbQPyvf/xaeroworldmap-neoforge-1.21.1-1.40.11.jar";
        hash = "sha512-pLuJDbrCeTdBH1cEMuvFpMxd+VYsIufD1qZRb/MDv8t/Nfs50s5CpRWRpLKltd6/yTP9o/WlUlYEQv5p+IKLCw==";
      }}";
    };
  };
}
