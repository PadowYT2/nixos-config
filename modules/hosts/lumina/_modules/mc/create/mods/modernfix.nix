{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/modernfix-neoforge-5.27.20+mc1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nmDcB62a/versions/VsJnrw8k/modernfix-neoforge-5.27.20%2Bmc1.21.1.jar";
        hash = "sha512-sfDTrFragRuCBLyCrcHKuP9xdS2o6XrjgfIb5fd4wZmuWRCIUP68h9HEZ1eyfMuyZp8/xjQMg320UKIFyi2MnA==";
      }}";
    };
  };
}
