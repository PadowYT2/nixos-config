{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/yungsextras.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ZYgyPyfq/versions/N2EpMhR7/YungsExtras-1.21.1-NeoForge-5.1.1.jar";
        hash = "sha512-1O+DGgNJd6vcrsQKdmKtvDfDLPFBxoJFJQ2lAfatos4ZPFNRFm+88v+xxFK2C/yorFeJYzMqpKG1I+Q5ErjLjA==";
      }}";
    };
  };
}
