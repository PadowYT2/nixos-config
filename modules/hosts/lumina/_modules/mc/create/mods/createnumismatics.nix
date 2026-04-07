{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createnumismatics.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Jdbbtt0i/versions/KMFhYqZ9/CreateNumismatics-1.0.19%2Bneoforge-mc1.21.1.jar";
        hash = "sha512-GpTO8l863rlfOmwZXi/xyElM9I/N+VL+en+Zoj3nNa59lK+CYRF3HH/v2Ez6KXvM55X5zCyMdgoMdEnM8ycfkg==";
      }}";
    };
  };
}
