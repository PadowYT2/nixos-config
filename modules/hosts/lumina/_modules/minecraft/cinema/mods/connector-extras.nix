{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/ConnectorExtras-1.12.1+1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/FYpiwiBR/versions/dgLCqZyo/ConnectorExtras-1.12.1%2B1.21.1.jar";
        hash = "sha512-/5/F1IqB6CDIwmuKBF4Kt6Ow6bXq7nNpsurbP5PX60IyVQc9/DJ9Exy2Z9+TvgZlYPNwS0zIoSsHSGuYoSutHQ==";
      }}";
    };
  };
}
