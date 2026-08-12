{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sparsestructures-neoforge-1.21.1-3.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/qwvI41y9/versions/MoJZpi20/sparsestructures-neoforge-1.21.1-3.0.jar";
        hash = "sha512-re+RUQT+egELfjMF87uFwzNsx2T7K4xt/sO3SeCNDQt9NrbKRwaZ7IW6JHTWxybZaiu5wZUmaCAtnf4Dgvva6Q==";
      }}";
    };
  };
}
