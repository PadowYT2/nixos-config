{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/cloth-config-15.0.140-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/9s6osm5g/versions/izKINKFg/cloth-config-15.0.140-neoforge.jar";
        hash = "sha512-qvmwEJVbjNKU5akvBpmFsYcp/V4s8i01Hx3/loDxVIhoiAPsQed+lBy94TDOtTUBTKTIaAR9gKtpwtUI4hZlTQ==";
      }}";
    };
  };
}
