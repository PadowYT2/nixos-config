{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/smallships-neoforge-1.21.1-2.0.0-b2.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/rGWEHQrP/versions/6poGZvvr/smallships-neoforge-1.21.1-2.0.0-b2.1.jar";
        hash = "sha512-5fnn79U3Mw5BJTaWgn1y3gZi/Ua4Oko7KYOy3hBXGBJa9T4jevUEfBZgxFqHJIYng3WmWnHOOXiGMpk5B5ABIA==";
      }}";
    };
  };
}
