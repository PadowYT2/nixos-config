{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sliceanddice.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/GmjmRQ0A/versions/tyVnEa75/sliceanddice-forge-4.2.4.jar";
        hash = "sha512-ODSJO6ZhS++6h+a+E0gb7fp7zhuhludaboM1tHGL53JIH372vqELIvvPFUsBR+qXU2EC3c9wkS5YQ/VH7j9xHQ==";
      }}";
    };
  };
}
