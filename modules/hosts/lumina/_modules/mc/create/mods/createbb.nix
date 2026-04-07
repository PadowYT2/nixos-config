{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createbb.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/j4ARnQwY/versions/rUu97B0K/create_bb-1.0.7-1.21.1-Neoforge.jar";
        hash = "sha512-d3QfK3dCa7JGByIeqY5UQoCoG6dMrbdzNMPQkR+P+/Y9PT8mjUNcHB4OV5TPwz9/u1/A5DunqJCYtKl6pDlphw==";
      }}";
    };
  };
}
