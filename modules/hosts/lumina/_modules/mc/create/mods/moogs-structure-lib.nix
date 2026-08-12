{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/moogs_structures-neoforge-1.21.1-3.0.3.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/1oUDhxuy/versions/DqC2bbIY/moogs_structures-neoforge-1.21.1-3.0.3.jar";
        hash = "sha512-2r7MNW2UF5knpKVpZBr3Zpin3KdbvlB/9yTP8+LPgojvs2XN/5fDrucNe0iWIQGk7tW5BkFZzkzMeSw7FIdL7g==";
      }}";
    };
  };
}
