{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/letsdo-meadow-neoforge-1.4.8.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ra7o6Sl7/versions/GwAjZwzx/letsdo-meadow-neoforge-1.4.8.jar";
        hash = "sha512-pFpCsXicPJeekbxlxCK/WDLVFABagt7zhg2BKpvwKiptUHnVP2Jdl2sJWFzs2o8dJoArMQzi5EdRxfXJMO/lDQ==";
      }}";
    };
  };
}
