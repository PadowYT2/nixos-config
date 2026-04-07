{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createframed.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/15fFZ3f4/versions/1BtGyIVR/createframed-1.21.1-1.7.3.jar";
        hash = "sha512-so3ua1xJ8g0HCu3peeTxt1mPERkyEZWjE5XXHmQEeTFPv1d2N0uOHB31ATmz6REyrKjyFRyuIv8FID8cYwxSrA==";
      }}";
    };
  };
}
