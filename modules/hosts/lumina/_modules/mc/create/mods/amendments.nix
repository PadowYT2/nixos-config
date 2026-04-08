{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/amendments.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/6iTJugQR/versions/8xf6Wpxs/amendments-1.21-2.0.15-neoforge.jar";
        hash = "sha512-qepQKctHiOnh2ujtlPBekRF1TgZNQfzWv35XDCgQbcHmgNLy6CMkuHoKFUo9cUu98kJRJKYsukdlxBwQl9Fgmg==";
      }}";
    };
  };
}
