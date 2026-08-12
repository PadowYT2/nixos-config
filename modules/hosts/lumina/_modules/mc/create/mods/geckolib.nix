{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/geckolib-neoforge-1.21.1-4.9.2.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/8BmcQJ2H/versions/tPkJmim6/geckolib-neoforge-1.21.1-4.9.2.jar";
        hash = "sha512-yRASsWzEDI9I9pt4y44uXABkhq4kMfvSid/AG+ekIXKUvs6iLYOhVdazKzlpRQ34cTUqNpXhRSFouE9BNV97ng==";
      }}";
    };
  };
}
