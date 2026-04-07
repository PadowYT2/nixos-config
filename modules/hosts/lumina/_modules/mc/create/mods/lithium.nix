{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/lithium.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/RXHf27Wv/lithium-neoforge-0.15.3%2Bmc1.21.1.jar";
        hash = "sha512-ZVaObH5BaErSDljbh2aBOEDAyEBu7Z7cP3olFNpyUKxGveK/sJNphMxVFsJ4L4Y4etDtPRuAS4vd3H9wSHWd9A==";
      }}";
    };
  };
}
