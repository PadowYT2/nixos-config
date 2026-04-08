{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/journeymap.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/lfHFW1mp/versions/nu4oHXle/journeymap-neoforge-1.21.1-6.0.0-beta.60.jar";
        hash = "sha512-BIY/fbI9YQx3w/AiHtUTx3hnppp7KOcVsw9/2OQWWvDPYmka45RVMNiDVxZPS9VeRG4K9scXsYSCOYAsQ3RqOw==";
      }}";
    };
  };
}
