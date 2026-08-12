{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/railways-0.3.0-beta.2+neoforge-mc1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/L3Jv0QZI/versions/czVeSmZo/railways-0.3.0-beta.2%2Bneoforge-mc1.21.1.jar";
        hash = "sha512-3vXHZ0Z794Y+LvwajMO/NELhCQ7hUE5EfEEguf9P9ngN6T0qfRv2ls0ZQHAQ1GW5nwC794B3awqWSIBPobRfdQ==";
      }}";
    };
  };
}
