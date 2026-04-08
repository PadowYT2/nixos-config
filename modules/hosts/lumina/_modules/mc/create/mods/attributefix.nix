{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/attributefix.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/lOOpEntO/versions/TyNITLDY/attributefix-neoforge-1.21.1-21.1.3.jar";
        hash = "sha512-CeH/YBLVt773u3AdOP6qq0HbTy/IufZpuCD8LJHlMJjgk+QBBirYCgziScaKp6YgmsnuNBUYuPZAuuI5OxWVrg==";
      }}";
    };
  };
}
