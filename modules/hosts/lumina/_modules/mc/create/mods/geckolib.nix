{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/geckolib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/8BmcQJ2H/versions/gFmrC8Ru/geckolib-neoforge-1.21.1-4.8.4.jar";
        hash = "sha512-NA2WFJoExXwJSF9bHGnn+Ow7aCI8YY44t9hMWPQoDcuj0OlIC4/HlzXZ71/X2l/I8wgdV1v0u80sRLbc8h2YwA==";
      }}";
    };
  };
}
