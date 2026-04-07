{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/modernfix.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nmDcB62a/versions/c759JLsq/modernfix-neoforge-5.26.1%2Bmc1.21.1.jar";
        hash = "sha512-1t8W4hxFS4aweZFAjdDrD2EZQu4B2VmDdaawkHFnqvKeKQbIrRHF8JcZeeaOqCZ9mo3rgrpji9hczUJl0kSKHQ==";
      }}";
    };
  };
}
