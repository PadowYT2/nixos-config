{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createfood.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/4HnO3el1/versions/txCTwiim/createfood-neoforge-1.21.1-2.2.0a.jar";
        hash = "sha512-oH2sslwXiAVa1xEqXcxDWUGgCUhedDooIauB4IDhkSBKlVvCtFHtHsgz0rDJBVQmczGb0qC/II8qPvxzvsTfBA==";
      }}";
    };
  };
}
