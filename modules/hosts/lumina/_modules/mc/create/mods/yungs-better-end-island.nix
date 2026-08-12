{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/YungsBetterEndIsland-1.21.1-NeoForge-3.1.2.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/2BwBOmBQ/versions/I52NZ1qK/YungsBetterEndIsland-1.21.1-NeoForge-3.1.2.jar";
        hash = "sha512-ApI6GpfrgewT1pvca36LNt+55vGpit/PEDcH7Dr941gxzNSyEOmzqcdmJUHDjqWTo9lMEhcbQHLqf+r6dclflg==";
      }}";
    };
  };
}
