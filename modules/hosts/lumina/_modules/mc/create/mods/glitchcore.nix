{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/glitchcore.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/s3dmwKy5/versions/8wmCpbQ2/GlitchCore-neoforge-1.21.1-2.1.0.0.jar";
        hash = "sha512-AI7JaXFv+ipFv3T4xE0sKOFlWGiKcYBmcOMH0p+naoLa9NL5kKSWQ0Uiinune9uFktFXLHI7ewbI+cP/rmOs2w==";
      }}";
    };
  };
}
