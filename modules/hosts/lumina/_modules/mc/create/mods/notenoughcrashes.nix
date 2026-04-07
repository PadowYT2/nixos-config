{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/notenoughcrashes.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/yM94ont6/versions/alR8L7vF/notenoughcrashes-neoforge-4.4.9%2B1.21.1.jar";
        hash = "sha512-kSwxxugG5FelAXQtZouCtw8D1c27ci8J2ie6GfNAjyNrFwTM+e1KK+6CzCcrp4Zxv+H9i0a67+8axO5W1wPwTw==";
      }}";
    };
  };
}
