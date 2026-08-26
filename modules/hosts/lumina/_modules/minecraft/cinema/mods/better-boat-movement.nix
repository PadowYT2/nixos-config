{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/better-boat-movement-2.5.4-1.21+neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/wTfH1dkt/versions/67C3cArI/better-boat-movement-2.5.4-1.21%2Bneoforge.jar";
        hash = "sha512-seFSmT4nPfG1r26VewiLXUWNzNnKqRwGwVab7yHd/lXCB4Y4fgfuRKorfYTdIiOsbmgrGueRfNoLOidLGfFzHQ==";
      }}";
    };
  };
}
