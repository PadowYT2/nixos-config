{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_power_loader-2.0.5-mc1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/wPQ6GgFE/versions/3Y4r0ItR/create_power_loader-2.0.5-mc1.21.1.jar";
        hash = "sha512-5PBs/nnq+lOKLt9F0LFzBRR18qINbCNSZo9pgPRDMHjyzdj/3QR5hMMN/ZAxQuo36t3kj/caOJLxgVRmLyDrVw==";
      }}";
    };
  };
}
