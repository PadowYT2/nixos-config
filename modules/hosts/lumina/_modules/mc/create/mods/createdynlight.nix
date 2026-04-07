{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createdynlight.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/evMQRxqV/versions/ltFc9AWJ/create-dyn-light-forge-1.21.1-2.0.1.jar";
        hash = "sha512-JTsEr7/fSGOx9LyvoM9bqAbIL6+BSX5raYM9T07e/aXzLxCovD9w5upeRv1pxUXsJtMhy9qAd4Rs+urlhNLe0Q==";
      }}";
    };
  };
}
