{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/escalated-1.3.1-mc.1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LyOBYG8Q/versions/kEo89EkW/escalated-1.3.1-mc.1.21.1.jar";
        hash = "sha512-qyXt5tiIfj02z2plARIHoMpUNdvX5cwA4CdIke/9mtvuP0Tbf+r6rymStAMLk7PGAOmDhNQ14PdeE0S0wSqOTQ==";
      }}";
    };
  };
}
