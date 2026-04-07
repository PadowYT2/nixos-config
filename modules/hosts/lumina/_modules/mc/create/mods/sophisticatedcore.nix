{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sophisticatedcore.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nmoqTijg/versions/mCDWyGrY/sophisticatedcore-1.21.1-1.4.19.1639.jar";
        hash = "sha512-DmO8cjkexxM/gnAC9FiNl/LyU/56MiaCm9PFYZ+Kmr8Z6lHMbeID9U2rxQ3WMHPjUEIG4+KnTBovAh7fommuBA==";
      }}";
    };
  };
}
