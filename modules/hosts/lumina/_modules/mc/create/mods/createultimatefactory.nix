{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createultimatefactory.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/N9QToVpw/versions/t5APrWmo/create_ultimate_factory-2.2.3-neoforge-1.21.1.jar";
        hash = "sha512-GDR/p4ydPFghhVH78+uuXihf4NQBwWydovX7cpzfBOr2TWQX6XW34wqIlgrwPECBnuvLgCebeSkw+uUXhyQJiw==";
      }}";
    };
  };
}
