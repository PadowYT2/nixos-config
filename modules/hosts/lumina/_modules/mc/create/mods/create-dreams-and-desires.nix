{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/DnDesires-1.21.1-2.3a-BETA.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/JmybsfWs/versions/bqMxf6Ua/DnDesires-1.21.1-2.3a-BETA.jar";
        hash = "sha512-wtcMXvJZ0gumCmb6FG/A03tYjFxCwAKKZQrx4QZ4xORgSWaqRu/SXzgk30Yg73Gdqo5U/IIiDXobIqf8qk4gdw==";
      }}";
    };
  };
}
