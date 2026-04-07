{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/ferritecore.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/uXXizFIs/versions/x7kQWVju/ferritecore-7.0.3-neoforge.jar";
        hash = "sha512-Ga+JogdbsQpjiE+oU+v4SwLHncMkJDDs2tBW/XZP3N42enMDJ2synfAbBzbi7yZMXYDH3JLGrr0kT1VqIwu0Fw==";
      }}";
    };
  };
}
