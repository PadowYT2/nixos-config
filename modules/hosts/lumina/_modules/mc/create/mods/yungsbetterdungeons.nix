{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/yungsbetterdungeons.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/o1C1Dkj5/versions/D6aZn0Em/YungsBetterDungeons-1.21.1-NeoForge-5.1.4.jar";
        hash = "sha512-QFE7rNE/qYYKvKtQex/AncUWSa9LYVzkZuDsNhVX8C015uRL6hzBfLQSCAX4YqrQE5TrGF9GYR575j39l/Jy3w==";
      }}";
    };
  };
}
