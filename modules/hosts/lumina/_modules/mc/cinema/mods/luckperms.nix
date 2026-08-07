{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/LuckPerms-NeoForge-5.4.140.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Vebnzrzj/versions/rnvg05YO/LuckPerms-NeoForge-5.4.140.jar";
        hash = "sha512-UNlMWp0mNaRFor1PLxbCIXJni5MxXj2R+ggpNJzNKwKUQ1Sve6o+auDHv+GfSXsJr0YfhKrMk5ALWbdaB80CkA==";
      }}";
    };
  };
}
