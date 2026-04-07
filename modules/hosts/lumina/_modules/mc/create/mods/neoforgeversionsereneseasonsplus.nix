{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/neoforgeversionsereneseasonsplus.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/4Al4H3t9/versions/QiOlBGcz/NeoForge-Version-Serene%20Seasons%20Plus-1.21.1-4.2.3.jar";
        hash = "sha512-Aic7SP9BgMN5JXs89IBwoGeUmSjeacIgF47wf5dg1ekQGn4pp43ckonoBw7jIpvOY99KOpvvEXvR9uFvcPewCQ==";
      }}";
    };
  };
}
