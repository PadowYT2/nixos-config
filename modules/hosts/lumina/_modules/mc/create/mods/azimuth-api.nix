{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/azimuth-1.4.5.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/RpH8tmT1/versions/5NkrnFXe/azimuth-1.4.5.jar";
        hash = "sha512-u79bE0PF7X19v1/URqHknV+N07yZzOmFsl2vQv7V3S9xrUiH+qpjSJj4IKnvxK6VR9PjUB8k33IppXZU1+dNGg==";
      }}";
    };
  };
}
