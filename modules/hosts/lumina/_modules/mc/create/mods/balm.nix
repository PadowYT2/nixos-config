{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/balm.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/MBAkmtvl/versions/Yoii3Xj6/balm-neoforge-1.21.1-21.0.56.jar";
        hash = "sha512-CKtEg5mb7o9KE7AGnglWUlUzY3VUKvSYGIIZ4VCeK1jq8oG/51x+E1yNXigEwJglOMv1188Cpd7BvYvo+bB15g==";
      }}";
    };
  };
}
