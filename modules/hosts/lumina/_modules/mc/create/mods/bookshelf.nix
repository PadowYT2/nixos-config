{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/bookshelf.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uy4Cnpcm/versions/1sdJl7J1/bookshelf-neoforge-1.21.1-21.1.81.jar";
        hash = "sha512-eNRXeo6PuyQSFpaEdd1z9bnl7+t9qAKxik5sKQ5Jr2y0pWdumFXQ2P82E/lngS5L02O7uRlsF8lU0ZRU+EsiFA==";
      }}";
    };
  };
}
