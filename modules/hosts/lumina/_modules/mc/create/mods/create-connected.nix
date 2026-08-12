{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_connected-1.3.2-mc1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Vg5TIO6d/versions/klOWKza5/create_connected-1.3.2-mc1.21.1.jar";
        hash = "sha512-sHv7xevwrWOx219yFfDhFJDwJjYj40SwmmMRbYQZmknH+RZhBBAmLdtkDmABfQjonzNjraOKYhmsalsvwZMi4A==";
      }}";
    };
  };
}
