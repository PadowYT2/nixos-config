{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_ultimate_factory-2.2.4-neoforge-1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/N9QToVpw/versions/AEMRNsNS/create_ultimate_factory-2.2.4-neoforge-1.21.1.jar";
        hash = "sha512-Kh0ebieqB0TRMa0S3MTjvK4tXRDGIMxWbLAwDGOma87RxVvgtjaZjzdz46ezhOdO8GOV7H7mqQZJ93Asmok7DQ==";
      }}";
    };
  };
}
