{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/citadel.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/XjY0RcQj/versions/e5w5IEqp/citadel-1.21.1-2.7.5.jar";
        hash = "sha512-zzS3JTbBSxaTbHXRjz7aS32OFkUsOw/XNvsRB8HZzJSVVUMhznr5zMK556/QD2AuE2UbFix0seLhrbxsbEfekw==";
      }}";
    };
  };
}
