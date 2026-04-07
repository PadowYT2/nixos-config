{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/immersiveaircraft.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/x3HZvrj6/versions/lEyfKM50/immersive_aircraft-1.4.3%2B1.21.1-neoforge.jar";
        hash = "sha512-uXq42hkCCRh/L6Iq2F2HSxBs6mD8IaIRJFaZ6E0vQXjaJk0NhIQuvM9j9L2jchHsaUv5NpED/Ym/ifcLGbFA9A==";
      }}";
    };
  };
}
