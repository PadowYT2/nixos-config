{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/betternether.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fxX3RlL5/versions/zjCPvMgN/BetterNether-21.0.19.jar";
        hash = "sha512-8FZAQ/19pnn4Laqiw7re0JUTtj6QUTrR5m79uyL1beq3/FzEy2JlTgnGWbm+P4ubQGFyWPSGwgdHmFC2Myg0Tg==";
      }}";
    };
  };
}
