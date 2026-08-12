{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/rechiseled-1.2.5-neoforge-mc1.21.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/B0g2vT6l/versions/S5FnErRw/rechiseled-1.2.5-neoforge-mc1.21.jar";
        hash = "sha512-2Em8PndVd5eLv5bczuEbCQT6koxVahLgWt91ntq5R5vXV/SQOAR16XTqoTfFZv/ov7YtXfGflm39mbZ6L+Dumw==";
      }}";
    };
  };
}
