{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/creativecore.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/tXZudQfR/CreativeCore_NEOFORGE_v2.13.36_mc1.21.1.jar";
        hash = "sha512-ZUuiKivtZt/ZXKTs042xFknKQUlbkoNVSnlcQzyVCPb1FaAllNeraMRe0eO5mxJAEMk2InIGvWfoWqIkfOJQvw==";
      }}";
    };
  };
}
