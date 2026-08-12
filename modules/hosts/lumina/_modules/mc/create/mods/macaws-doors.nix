{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcw-doors-1.1.5-mc1.21.1neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/kNxa8z3e/versions/u7BRX44F/mcw-doors-1.1.5-mc1.21.1neoforge.jar";
        hash = "sha512-Q93wC+Rq+RwAmpU5KglPBQFxVSFMRseYAELLz4cYZNx5JBZJcBnmiOtViJfIeEi9cMKC7EpteyaOG6MDibqYeg==";
      }}";
    };
  };
}
