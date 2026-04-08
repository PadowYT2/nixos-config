{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/netherportalfix.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nPZr02ET/versions/O09BGtgh/netherportalfix-neoforge-1.21.1-21.1.1.jar";
        hash = "sha512-vibFO056qdwnsF/kyv3RIKPRNWQQs10lOB1HO9mnqhnObOwbuYL9qELypmPRXexdEiSLUBQflHml6ewz7Sqz9w==";
      }}";
    };
  };
}
