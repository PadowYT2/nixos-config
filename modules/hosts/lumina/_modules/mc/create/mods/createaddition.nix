{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createaddition-1.6.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/kU1G12Nn/versions/qPr8V4G2/createaddition-1.6.0.jar";
        hash = "sha512-46Me77FdN70aK6kBLQwA7JL3yeV7ejXJk2duoMyFuk81oFWp+Y1XY28koFYtbaGLTpBxP09G1HlZZmoJempc6g==";
      }}";
    };
  };
}
