{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/dragonlib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/sbIsGaOV/versions/M6CMBAur/dragonlib-neoforge-1.21.1-beta-3.0.24.jar";
        hash = "sha512-8SqtEl95tQuGcNMQApNmO0guIsgZQ1tkhnqMi+7oPkizwvWo7WDkytYhW/rQb4ok8j1s3tLAA9kb8y50dJ95VQ==";
      }}";
    };
  };
}
