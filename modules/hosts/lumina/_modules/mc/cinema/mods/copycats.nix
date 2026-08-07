{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/copycats-3.0.4+mc.1.21.1-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/UT2M39wf/versions/kecZ0sl7/copycats-3.0.4%2Bmc.1.21.1-neoforge.jar";
        hash = "sha512-7MmOZZvmanGvCu5mqfTHyIOPTwEBQCZEkpB5znKApXKgAOfkF5BeGGmlHW5J671gEAj1RYXgfuTtAfLEvHUr/g==";
      }}";
    };
  };
}
