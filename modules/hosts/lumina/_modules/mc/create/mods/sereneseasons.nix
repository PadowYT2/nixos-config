{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sereneseasons.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/e0bNACJD/versions/SPj5bJoM/SereneSeasons-neoforge-1.21.1-10.1.0.3.jar";
        hash = "sha512-jWwnEgGdpYbJ86E3LylRFzzV96ghZF/6A+REjlb2sneqsGUTB+HU2eCUTLAtMrLK/1gb3pEssh/G/Xt9hGVbjA==";
      }}";
    };
  };
}
