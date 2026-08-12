{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/balm-neoforge-1.21.1-21.0.64.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/AMOGoVGH/balm-neoforge-1.21.1-21.0.64.jar";
        hash = "sha512-6Y37KK69FIiLTLIZvYjCaasZkfq0Umo/O3J8324ukZormo1VHAo3u8SAFwidtyYFNSIVVa17LrL7VtIxilX00w==";
      }}";
    };
  };
}
