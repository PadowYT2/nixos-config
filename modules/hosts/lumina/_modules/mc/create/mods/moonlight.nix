{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/moonlight-1.21.1-3.3.3-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/twkfQtEc/versions/Gh4IJiwq/moonlight-1.21.1-3.3.3-neoforge.jar";
        hash = "sha512-aILBePMCwxVRzrLc+fK4/drCigO6FxV2p1JUgxKc8rorhT828gCxfF6npcRxR7qSb20Ze+TtOMObQIfsY+ZI5Q==";
      }}";
    };
  };
}
