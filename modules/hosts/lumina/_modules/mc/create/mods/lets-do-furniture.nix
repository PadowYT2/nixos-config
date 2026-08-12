{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/letsdo-furniture-neoforge-1.1.4.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/3JQDJrYW/versions/aYYcQFNB/letsdo-furniture-neoforge-1.1.4.jar";
        hash = "sha512-0ya3NHLI72QoFnzVa9OfnAcdzaMMoGG7ISNYHReFkPNd0IwXA6CYVaxdTihd3LuxAMaqNaQLd4qOu/Aleahc0w==";
      }}";
    };
  };
}
