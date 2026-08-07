{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/worldedit-mod-7.3.8.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/1u6JkXh5/versions/WTAFvuRx/worldedit-mod-7.3.8.jar";
        hash = "sha512-4DlJLfC0hufOdtDq+MsR6trS54IgYAuEmKuO70ZCop4xCmvLQ3gldVOzY5xtC8Hr8Pc986emd8ava6+GcWsLxw==";
      }}";
    };
  };
}
