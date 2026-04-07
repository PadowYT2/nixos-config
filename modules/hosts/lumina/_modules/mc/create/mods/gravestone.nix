{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/gravestone.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/RYtXKJPr/versions/AZm51eX1/gravestone-neoforge-1.21.1-1.0.35.jar";
        hash = "sha512-T6xLFB34EWEXf7CIIzXifRJZ0F/9PzeVoCWONHH05yhAz6W3P7G8GtjNyiVbg9xG9xP4H+pTPk+x5yg04XJIhg==";
      }}";
    };
  };
}
