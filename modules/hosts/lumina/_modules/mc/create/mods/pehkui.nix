{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/Pehkui-3.8.3+1.21-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/t5W7Jfwy/versions/nKHizsl6/Pehkui-3.8.3%2B1.21-neoforge.jar";
        hash = "sha512-pCE8Fv/JgRMDG58yYmaugJivjMtAnBGehK3/7A9PR9Fbpt3Fnm/BBQTRSCKE9sbCjGoTm/KNLMwIz8ttbudJvg==";
      }}";
    };
  };
}
