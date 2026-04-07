{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/chipped.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/BAscRYKm/versions/eqVowbGc/chipped-neoforge-1.21.1-4.0.2.jar";
        hash = "sha512-8wg7ASZ+fGdMS0L0WjF8k+53I0Q8uiBR/lvFk2OLUzsP6QaZ4hAWYck03/RY6raTzOThiFM7/pd3eMJJVjovpQ==";
      }}";
    };
  };
}
