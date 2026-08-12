{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/dynamictrees-neoforge-1.21.1-1.7.2.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/vdjF5PL5/versions/G4uJ0UA0/dynamictrees-neoforge-1.21.1-1.7.2.jar";
        hash = "sha512-H6pfKSB4+65F/Y7phz0i4TUiqIP2ZQ5x0fR1XM/lw2P2BuDU3EIjhFU0gwQ4gwAhNpIc5e+1RMcNQSr/stoHbw==";
      }}";
    };
  };
}
