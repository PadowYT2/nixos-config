{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create-new-age-1.2.0+neoforge-mc1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/FTeXqI9v/versions/IwtuwMZy/create-new-age-1.2.0%2Bneoforge-mc1.21.1.jar";
        hash = "sha512-UHXGSCuACvcES1lK1pSFXn1W84bLA1SWfq/pnXfoS04m7n+IDSh2ctJNhOqAhv0HS3aV5GYy8y8hWzHOhZracg==";
      }}";
    };
  };
}
