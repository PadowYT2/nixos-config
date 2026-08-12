{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/FarmersDelight-1.21.1-1.3.2.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/R2OftAxM/versions/GbNuOZ4S/FarmersDelight-1.21.1-1.3.2.jar";
        hash = "sha512-2lpCNkJ9+AENdZkiAchyOshKj6ce+lVnBVHTM8rJSpCujoxTbaY64Hpn9NANwndK5BUQMPQdJohuUI9KA3yGlA==";
      }}";
    };
  };
}
