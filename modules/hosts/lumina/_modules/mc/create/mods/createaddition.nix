{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createaddition.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/kU1G12Nn/versions/CP8Lhuwu/createaddition-1.5.10.jar";
        hash = "sha512-IlIshtXKeYye6fPCDxj1QL4SX6HHbXNtHC6HajFGm17mHu8ngp57afFpQGdRhlGUSPa0l4Y1tgENsUItqO3KDQ==";
      }}";
    };
  };
}
