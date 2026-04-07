{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/architectury.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/lhGA9TYQ/versions/ZxYGwlk0/architectury-13.0.8-neoforge.jar";
        hash = "sha512-ZeNmSVM4XYgDIN1ruBi8uW02HAfFPip/ZeZMakdyDuJrIzIkrpytRl7wsruu/a8w+wF1qYPOzZHeBYgX1vz1fg==";
      }}";
    };
  };
}
