{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/connector-2.0.0-beta.16+1.21.1-full.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/u58R1TMW/versions/9Bz9VtV5/connector-2.0.0-beta.16%2B1.21.1-full.jar";
        hash = "sha512-OQlOuMUU2w/8R0v2SpXrsaVdUNtqaPyx3A/K6i0dH960Sqc96bd6B7BMt9dXQffArJu2Pq5d7SJbK7BpVYjAZA==";
      }}";
    };
  };
}
