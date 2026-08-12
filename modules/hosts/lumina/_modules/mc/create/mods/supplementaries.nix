{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/supplementaries-1.21.1-3.8.9-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fFEIiSDQ/versions/ZHJvgW8G/supplementaries-1.21.1-3.8.9-neoforge.jar";
        hash = "sha512-yNbCqlOH4axJk1tEiV82SdBUy302YMX6WzY2I9EPA5dOdeuGrUJsgXBaBFO/QGuC5dcRGFhrndjcQc1guB9EtA==";
      }}";
    };
  };
}
