{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/worldweaver.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/R8uGDQpB/versions/CPsdGopd/worldweaver-21.0.19.jar";
        hash = "sha512-cet2/Z6eZO5WzYKEEOzT7nx1DSpcg0W4H82rsiOyXnBPGv1p4JPQim2/1JaR77FTFhPxhS5RsDncoyDRmMY2/w==";
      }}";
    };
  };
}
