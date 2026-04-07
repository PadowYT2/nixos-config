{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createcopperandzinc.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/aqYNR6rI/versions/1Z1LCW5Z/create_copper_and_zinc-2.0.0-neoforge-1.21.1.jar";
        hash = "sha512-x6o8HDX/eqIywGJ/yVUrhF+DTAMZwkvzE1ObrHVcLz46dFTzS3/WEUt3OFmLOq6wAYd1kU07y8A/aLeXBg0/qQ==";
      }}";
    };
  };
}
