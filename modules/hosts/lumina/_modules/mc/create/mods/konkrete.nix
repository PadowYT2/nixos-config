{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/konkrete_neoforge_1.9.9_MC_1.21.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/J81TRJWm/versions/stJDU839/konkrete_neoforge_1.9.9_MC_1.21.jar";
        hash = "sha512-N4vRLjwyMpq7rlzVFOHRzCo8w6RZef7bHU5MCmcyvc9LfRv396ESB0vyiJV+34YVLJwJCifR1d6EqaeCXT1lEQ==";
      }}";
    };
  };
}
