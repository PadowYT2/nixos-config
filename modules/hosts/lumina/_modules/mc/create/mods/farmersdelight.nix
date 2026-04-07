{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/farmersdelight.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/R2OftAxM/versions/cYqC3svy/FarmersDelight-1.21.1-1.2.11.jar";
        hash = "sha512-CvFC8IXbsxeL21IbgLy/b9DQ12ffKomd+QZvD+VkEkDaFTQ/5e10QdHkSu/3LkAv4XFX8gA5Mq4DdheIQX4DMg==";
      }}";
    };
  };
}
