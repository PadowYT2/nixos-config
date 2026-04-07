{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createtrackmap.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/NHRXB9Bi/versions/EYyY9A0V/create-track-map-2.1%2Bmc1.21.1-neoforge.jar";
        hash = "sha512-Rr95fN9CbI0Sdp+qzcQ6VlzWJCAPi8YGdfLXvVVY1sAZYTHLCSGhPxt847jTy/ZH+8u75UflUtdSYy6UQSCQ4Q==";
      }}";
    };
  };

  services.caddy.virtualHosts = {
    "createmap.konoyogony.dev".extraConfig = ''
      reverse_proxy http://localhost:3817
    '';
  };
}
