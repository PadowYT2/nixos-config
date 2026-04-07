{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createconfectionery1211.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/WPE5gRs9/versions/m9KI739R/create-confectionery1.21.1_v1.1.2.jar";
        hash = "sha512-Lqf54BFMWiLwwXlbGm/dhB5LHX+qr1eV+SOz/PfS3gwIQf36N63nEaaOHNfO2xV20pETvxSwEpKeOspvM2v+yQ==";
      }}";
    };
  };
}
