{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sliceanddice-4.3.3-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/GmjmRQ0A/versions/N67LJgrN/sliceanddice-4.3.3-neoforge.jar";
        hash = "sha512-O9vSgq5aoR72wYa3Ukl1QXMLUPtADEliIwvNdzTP5Ojaou5WU4dFDf4Ott6qD6RL+B+Zx4i6wJsaYNjxmR2zfw==";
      }}";
    };
  };
}
