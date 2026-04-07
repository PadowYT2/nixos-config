{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createnuclear.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/z611fdf7/versions/waO2BSHO/createnuclear-1.3.2-beta.3-neoforge.jar";
        hash = "sha512-OdlpHY8A83WkOBkxOcMP5gAyzwTNmdg/pCj+/vXI7XnUnY8JtfDlf7SyxAWPxMK62UKgkT3YhfcBpenw2dLzbw==";
      }}";
    };
  };
}
