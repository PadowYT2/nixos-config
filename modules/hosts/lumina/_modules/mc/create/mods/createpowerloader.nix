{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createpowerloader.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/wPQ6GgFE/versions/ydVSjzJR/create_power_loader-2.0.3-mc1.21.1.jar";
        hash = "sha512-sFUv8foNI93dZrQlpUVHhPNztjWnMIkmdZIckNKtKIFk9IP+U/E7ec5gMX1UVsjNnGMI7DgGu/ELEmdLi5Tneg==";
      }}";
    };
  };
}
