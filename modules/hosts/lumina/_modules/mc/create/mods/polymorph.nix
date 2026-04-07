{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/polymorph.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/tagwiZkJ/versions/VEburL70/polymorph-neoforge-1.1.0%2B1.21.1.jar";
        hash = "sha512-NzWOGdjyUbfUNepRmO3texNh6Q1XKOEfyxWutVeG9O4Q/Y/s0UsR80qZvZKuoBqZd8DbxGq2uwevYabIlFW2/w==";
      }}";
    };
  };
}
