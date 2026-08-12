{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcw-mcwstairs-1.0.2-mc1.21.1neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/iP3wH1ha/versions/4t8L0dGP/mcw-mcwstairs-1.0.2-mc1.21.1neoforge.jar";
        hash = "sha512-UVM4mbXmRhCmQu6enYnrnxk9CHeoy6FtO/omJ4kzTIZBKLAXV7/509snGL098fwXf5stRbhPBvwKbuFUdK8vrA==";
      }}";
    };
  };
}
