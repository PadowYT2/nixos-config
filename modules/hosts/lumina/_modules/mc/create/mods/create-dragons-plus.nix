{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/CreateDragonsPlus-1.11.7.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/dzb1a5WV/versions/kocCfVQd/CreateDragonsPlus-1.11.7.jar";
        hash = "sha512-DAF8T/l7DhI3IY8ptEYHBzWluW3M9lwusuSA+0/vGhpxBHnvfBSGUJnXSmvIPPDkKaapKiMeeQehnIuTCHWX8Q==";
      }}";
    };
  };
}
