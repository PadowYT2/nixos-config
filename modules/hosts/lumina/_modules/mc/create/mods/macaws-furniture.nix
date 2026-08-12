{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcw-furniture-3.4.1-mc1.21.1neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/dtWC90iB/versions/Z5V3Ps7S/mcw-furniture-3.4.1-mc1.21.1neoforge.jar";
        hash = "sha512-kxA/hopqe0+mE9vpCLz4PEqqv0cZBX1ITRY2yY5uPe+gDVUKiYj/kdTQoJBGPCW4mDNuZ12lLBm9O9DON+BT5A==";
      }}";
    };
  };
}
