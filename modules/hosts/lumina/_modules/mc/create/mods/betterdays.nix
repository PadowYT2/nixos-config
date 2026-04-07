{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/betterdays.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/tPLE214j/versions/O3sUSfWA/betterdays-1.21.1-3.3.6.2-NEOFORGE.jar";
        hash = "sha512-AJBouw0qzX4k+d7FBjYtpoyWf4MFTxh+YUbU6GqOHNF4/ZmZBPjTf9SDyFr5B15FPH9yOh9CbTdI4HzYUMy/xA==";
      }}";
    };
  };
}
