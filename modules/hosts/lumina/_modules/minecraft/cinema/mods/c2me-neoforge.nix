{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.116.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/COlSi5iR/versions/5Q757s3v/c2me-neoforge-mc1.21.1-0.4.0-alpha.0.116.jar";
        hash = "sha512-VLW4AmSEv0TcefRrYZZcLUX0czu2tYClnSJoxdTcEeiuP+kjjU7gRSksw63IDsm8/S4hpLdDPjHb8TRKUrky8g==";
      }}";
    };
  };
}
