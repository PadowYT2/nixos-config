{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/wunderlib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/HZmhgdJk/versions/5db3GZzg/wunderlib-21.0.10.jar";
        hash = "sha512-h4WxaWjtgurQ/D9vQso91/qUuUp57rl6YeV7JYv4wOZ3UAKlYc8ooYQCFr0G87hqMdpCDUzMLTfBSr4iBYvflg==";
      }}";
    };
  };
}
