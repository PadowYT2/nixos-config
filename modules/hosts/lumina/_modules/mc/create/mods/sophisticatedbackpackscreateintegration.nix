{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sophisticatedbackpackscreateintegration.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/s85zLEDe/versions/bWd7B59k/sophisticatedbackpackscreateintegration-1.21.1-0.1.5.29.jar";
        hash = "sha512-Ew2ad/K0OSbJOYmDdAgT0mjOWOAio8jg6rmLokObnTsrgZsKhFqOsGvDNr3rFuhs1Mvo96+DTBGq8a5niXf8rA==";
      }}";
    };
  };
}
