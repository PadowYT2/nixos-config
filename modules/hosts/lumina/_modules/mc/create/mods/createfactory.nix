{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createfactory.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/j6Zt3N7W/versions/7wShOUOC/create_factory-0.5a-1.21.1.jar";
        hash = "sha512-Wnnf5UOLLN3WK5Bdo+QGInAGNgy9gXjQiLJApZ1Einy2OiTJ7kDI5l2HvdpZiMTD7R8YoUWbMT9OqDphbFpq3Q==";
      }}";
    };
  };
}
