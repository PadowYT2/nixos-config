{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/MoogsVoyagerStructures-1.21-5.0.14.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/OQAgZMH1/versions/uEZeTQ4b/MoogsVoyagerStructures-1.21-5.0.14.jar";
        hash = "sha512-IiZo0GCCcMjNEkQoenZZqPVUJsPWQ4nkAsAfQHD80DrpBwmP6OuOL5MXx4byJ/ka1P/qWL8/SbxbK0O9bEk+pg==";
      }}";
    };
  };
}
