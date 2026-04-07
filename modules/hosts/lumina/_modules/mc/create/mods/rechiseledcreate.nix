{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/rechiseledcreate.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/E6867niZ/versions/TzPaH8MY/rechiseledcreate-1.1.0-neoforge-mc1.21.jar";
        hash = "sha512-9e8u0m6Crc30A0MPnQ6lfL/2FqfZZLmJHrCgYQfxgOdAxHKEpEpMhzP93G2PWGN+ce3uaP+FPZON8NvytwhP4A==";
      }}";
    };
  };
}
