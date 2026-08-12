{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/struts-1.3.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/sHO3MhQx/versions/Nrn7hYca/struts-1.3.0.jar";
        hash = "sha512-gYN+l+vAgb1K+w1FaDfntZj3nDex0xh051UNSi9C+MhkWH+aBPRPFPF16c9piEzS5ZP6H7MVcnBAr/odacLfBg==";
      }}";
    };
  };
}
