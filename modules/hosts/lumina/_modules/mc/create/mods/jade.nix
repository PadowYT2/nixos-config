{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/jade.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nvQzSEkH/versions/yd8FKCmx/Jade-1.21.1-NeoForge-15.10.5.jar";
        hash = "sha512-Z4uZhnej1z+Y+C2sQJOJO/yKPCM17GJ7QUeBHDgaBAR13s242zHMPL5gCrtaem3tzTVu7Qukca8L7Nz0m/WxNw==";
      }}";
    };
  };
}
