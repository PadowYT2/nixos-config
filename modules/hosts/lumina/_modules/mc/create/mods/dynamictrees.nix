{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/dynamictrees.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/vdjF5PL5/versions/1sD1u4G2/dynamictrees-neoforge-1.21.1-1.7.0.jar";
        hash = "sha512-Plbgc8L6008/35CUbNb+otRy55aoFhMuUUIVMedTzM7G+X0deOPVWS8qiBwiiBDgntC9NgqDBPwwohkJ09YaXg==";
      }}";
    };
  };
}
