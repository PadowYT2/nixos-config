{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/anotherfurniture.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ulloLmqG/versions/Q29JlZfU/another_furniture-neoforge-4.0.2.jar";
        hash = "sha512-Syr6W9c7ap30PMTcPo37Jns0OIuoOBDMPZwTTlR+lUWPRgiovn406wnWes3hpyINLDEceJ5tH6f2gPCa1mkp6g==";
      }}";
    };
  };
}
