{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createencased.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/hSSqdyU1/versions/sjCAxK2s/Create%20Encased-1.21.1-1.8-ht2.jar";
        hash = "sha512-WjkOQ/0O8M7fJ3yphRmbzX3T+DzjoTJ3RDaAgZHvJGEVQcM0ndvqfIKlo83hHth8chc6RkmMdVWUdDa1GJTyTg==";
      }}";
    };
  };
}
