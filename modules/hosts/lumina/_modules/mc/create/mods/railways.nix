{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/railways.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/L3Jv0QZI/versions/sG8TppGl/railways-0.2.0-beta%2Bneoforge-mc1.21.1.jar";
        hash = "sha512-hyOGItG/9Y5KwxJ1SY4rUgVV90EGLPLdlwX6JEis+bNz6TmSN3OxIF+osHOv6rUHhljjmtaNrY++T7otqBZ1Zw==";
      }}";
    };
  };
}
