{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/jei.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/u6dRKJwZ/versions/YAcQ6elZ/jei-1.21.1-neoforge-19.27.0.340.jar";
        hash = "sha512-i62Os8jpdPhn4j5NdFmPYDxfvwPrU1ajht03y5+iPgitH1i+a3vlDS+/nT+/rqyFhMcM7XNt9Lj4LHx1viQpmA==";
      }}";
    };
  };
}
