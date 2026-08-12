{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcw-mcwpaths-1.1.1-mc1.21.1neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/VRLhWB91/versions/tlymsxUG/mcw-mcwpaths-1.1.1-mc1.21.1neoforge.jar";
        hash = "sha512-invAEA5XNp/c+7ZRZP35fNf2qTGILQ9jquFf09uJdaeMyHNPNPZApXkN3ayliD2OlxF+eWbatQ3kebGo82YmeA==";
      }}";
    };
  };
}
