{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mca-neoforge-7.7.35-beta.3+1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/1W98a849/versions/9KVEft4s/mca-neoforge-7.7.35-beta.3%2B1.21.1.jar";
        hash = "sha512-KbDR61wDkTs3BO8vtc1FP28jWJtZCOzuQxgdb99l8S8lcZ/OW45eOlf/Bm2rpCU3H6qQoeJDRyacxarwrPmZwQ==";
      }}";
    };
  };
}
