{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/midnightlib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/codAaoxh/versions/Puk24qHu/midnightlib-neoforge-1.9.2%2B1.21.1.jar";
        hash = "sha512-UsIF4E+HnNtkUbKv+YVvZUHOmDZ5Z5SfTnemWAMEWHV3BZvqcuX4ummwQMZz2KeWb3BiabGAuLM5RlIrQfLDaQ==";
      }}";
    };
  };
}
