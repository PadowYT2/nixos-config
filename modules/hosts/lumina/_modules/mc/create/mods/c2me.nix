{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/c2me.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/COlSi5iR/versions/4ra0NTk5/c2me-neoforge-mc1.21.1-0.3.0%2Balpha.0.90.jar";
        hash = "sha512-zf3fpLmYIPzI3FRjMKkM//mJ9meC6pvgP4YmhPOsNT5PcqpxwwNp7J5GNcv9d0q/StfhpPY+7p1rRykT4o9YhA==";
      }}";
    };
  };
}
