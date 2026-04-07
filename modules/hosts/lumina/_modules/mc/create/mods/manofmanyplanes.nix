{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/manofmanyplanes.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/9qdTHi0q/versions/onE42Qs7/man_of_many_planes-0.2.1%2B1.21.1-neoforge.jar";
        hash = "sha512-swb1+uMIzNA6tytVL2NLP19X6SVKkw/6/troWMvOdMJVfPWY5++5WYI8P1dVRIWc8PGfJsO0d8df7sPGoUgXRA==";
      }}";
    };
  };
}
