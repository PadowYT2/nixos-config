{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/dreamdisplays-neoforge-1.21.1-1.9.0-preview.5.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/4IIKQyBu/versions/XUjSg8AS/dreamdisplays-neoforge-1.21.1-1.9.0-preview.5.jar";
        hash = "sha512-E23T+xNMVOuuXSGLVDT60uVdAFE2nuA1ILC68EkNKo0Xd6uPJE/VKjzEvCS0e9U7CGYhyPnVfn9KhL/XttNFjQ==";
      }}";
    };
  };
}
