{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sophisticatedstoragecreateintegration.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/MJ0hdevs/versions/g1GUAckO/sophisticatedstoragecreateintegration-1.21.1-0.1.14.98.jar";
        hash = "sha512-ilU0sOEeSAnXZRE1eVe1bl2zTgAEXLsEwOY95TLE20TlJYdQiUUqIgcl8VWXODGyzAdm/fdWi+45tB6L22YPpw==";
      }}";
    };
  };
}
