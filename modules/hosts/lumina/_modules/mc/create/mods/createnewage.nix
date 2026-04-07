{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createnewage.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/FTeXqI9v/versions/eQ9rbApE/create-new-age-1.1.7c%2Bneoforge-mc1.21.1.jar";
        hash = "sha512-gQ9QeWR+TT8YG55Cx0E3mvLZBNO+D66D76Xdn2fnusMEFTnpcuzAvA4MU8K0U/z6CTHHSTJ6VXPuLsumH/xQcA==";
      }}";
    };
  };
}
