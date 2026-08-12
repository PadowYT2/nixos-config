{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcw-trapdoors-1.1.5-mc1.21.1neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/n2fvCDlM/versions/StnP0RNi/mcw-trapdoors-1.1.5-mc1.21.1neoforge.jar";
        hash = "sha512-cHIbVYAhktZ4tvtmYZxuIQpJ1egp/BlRxwwn2O2UDERpeeNt0GIhxqNeNY6X+1fCLEHtCyTNbQNRmSa4HVjUtA==";
      }}";
    };
  };
}
