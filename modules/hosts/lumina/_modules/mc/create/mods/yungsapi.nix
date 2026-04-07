{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/yungsapi.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ua7DFN59/versions/ZB22DE9q/YungsApi-1.21.1-NeoForge-5.1.6.jar";
        hash = "sha512-XzbVFmpnoVbfUmmQcfICGbwjILPE+82drDhjH2YTbwNOMhmsif9L+24m5MaFE6lMgzeX8uXtW/WM+hUx7u0WLQ==";
      }}";
    };
  };
}
