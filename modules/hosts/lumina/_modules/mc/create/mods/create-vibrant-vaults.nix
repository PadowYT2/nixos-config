{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_vibrant_vaults-0.3.2.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/hddN8ksR/versions/t17qYXjn/create_vibrant_vaults-0.3.2.jar";
        hash = "sha512-O9Uwl0guYU3E5eY1d4ryUCD6J8HEU9SSjR2LqmdnyTyzAIEKWsDEmvhoE3SaGA4/CSqy5lsH53QcKxKq69RwBg==";
      }}";
    };
  };
}
