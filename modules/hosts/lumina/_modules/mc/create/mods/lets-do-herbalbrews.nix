{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/letsdo-herbalbrews-neoforge-1.1.3.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Eh11TaTm/versions/gtG21Zrn/letsdo-herbalbrews-neoforge-1.1.3.jar";
        hash = "sha512-z8/EfCTa/xuChJ02y+WqHXMai/zYFLxq/aKQmuGMT/KekoEio8N7tiLBRziCXwoNsAVHswtUzQbNqvtK8VXiAQ==";
      }}";
    };
  };
}
