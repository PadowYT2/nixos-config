{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/gaboulibs.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/N8aGZtvj/versions/LsfPosIY/gaboulibs-neoforge-1.4.jar";
        hash = "sha512-FUo069a1f7ZlFK0JDeNpbXmYIZHPgY42WpifDmp10SAMYuxzDTUbZJky4RhQx1OQnW/2bYmcog3kHnfj1Adssw==";
      }}";
    };
  };
}
