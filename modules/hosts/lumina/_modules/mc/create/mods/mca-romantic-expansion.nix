{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcaromanticexpansion-1.1.0-1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/yGNIAsvP/versions/gqwEPFmM/mcaromanticexpansion-1.1.0-1.21.1.jar";
        hash = "sha512-wAkAS5I7K5ZmxHT8nARmYge1PQUBlHq/Ps7cVU35qTPWWfpx+NF7U+bzL2TlSXBEoQqk6VVrrm9uHoXLBZ7vWA==";
      }}";
    };
  };
}
