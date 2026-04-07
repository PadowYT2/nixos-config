{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/distanthorizons.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uCdwusMi/versions/bLPLghy9/DistantHorizons-2.4.5-b-1.21.1-fabric-neoforge.jar";
        hash = "sha512-buiwSvhYRQ6sLg/mw6bLCd/A+cFpH7D3b3m7xz4I5dym8YJXKUumR7FSDU+yEQu7sIWDDlNsj0Y4mVx19m/h6w==";
      }}";
    };
  };
}
