{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/expandeddelight-0.1.4.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/e9V6wFcR/versions/RTRYPIJp/expandeddelight-0.1.4.jar";
        hash = "sha512-E6K9F8XBhJAtqet4zpuZMHOGQwHoy0oDj3/X5ZYYiCbvEzgc9hVTMob1Pq6qv8TIsnq5EROhXqaOS9n4TKFriw==";
      }}";
    };
  };
}
