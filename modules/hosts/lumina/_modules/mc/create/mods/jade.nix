{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/Jade-1.21.1-NeoForge-15.10.6.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nvQzSEkH/versions/eYz2YBGT/Jade-1.21.1-NeoForge-15.10.6.jar";
        hash = "sha512-2tl1Xc6NhdkU/E3yuqAhHxPlg5pxwZJf3QH2kIGpXjCik05ic/iwHwFprevnqdrleo2QTeDEyzbcFzabtHTw8g==";
      }}";
    };
  };
}
