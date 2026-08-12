{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/trainutilities-neoforge-3.0.3.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/kVIxLqso/versions/CPAbSUUg/trainutilities-neoforge-3.0.3.jar";
        hash = "sha512-Mr0Z53kMFhG3z3kUwll5UYlIvwTXRD+WzGU4xsV1Mjeq/rn6q1oLMP0xu/6cKocH7/KT6YG7axn3iSg1Zm6qpg==";
      }}";
    };
  };
}
