{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sophisticatedstorage.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/hMlaZH8f/versions/W2ChxwuG/sophisticatedstorage-1.21.1-1.5.35.1599.jar";
        hash = "sha512-A3WjcB/k+AIYY7QisRoioFjW4B7ex1qMSC/FMAmrJfhkqplh9pVxHljURu6K69/a6yElb9ejM3hLkLyDEWDFww==";
      }}";
    };
  };
}
