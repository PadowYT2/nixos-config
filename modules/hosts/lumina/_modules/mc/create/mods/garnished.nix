{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/garnished.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/6e2SlzR4/versions/Y41ntUK1/garnished-2.1.9.1%2B1.21.1-neoforged.jar";
        hash = "sha512-7Vkg4Lkd0l2VK+E/H2sNvo0YkQqdn8oeDe9vASEGh8OxM7TqE0vm3cadfo1lKAm+I1T1G1zCTBNAF4oTwHrvJw==";
      }}";
    };
  };
}
