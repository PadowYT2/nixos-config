{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/wakes-1.21.1-NeoForge-1.4.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/E0SdeAoH/versions/YQWPuboy/wakes-1.21.1-NeoForge-1.4.0.jar";
        hash = "sha512-oJIF7ZDf5+I1gZpp+DZ1wTDJo2uk09BMqoF9Lh6YxlR8264H4+tcB/WDqqfbqwJhXUd6/2FcUt4HzUd+zO8f3g==";
      }}";
    };
  };
}
