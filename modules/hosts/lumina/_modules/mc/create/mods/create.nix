{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create-1.21.1-6.0.10.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LNytGWDc/versions/UjX6dr61/create-1.21.1-6.0.10.jar";
        hash = "sha512-EcyPwEnS9n9lSMer+tprgqOttcfKQQp0LeBLvKduA4YsUYchuI2Ab25tdopNaFMf25A6hYWbJdFITVUMx7r9Sw==";
      }}";
    };
  };
}
