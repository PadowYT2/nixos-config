{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LNytGWDc/versions/n7NADxiG/create-1.21.1-6.0.9.jar";
        hash = "sha512-izs9m2h08xpTit2BOQ3/JrX5R12mNJ3FL8INvegC7fwy6tUR4SKRGYWRV01CYF+RbxrLrcJDcFbuphXYWGv3zw==";
      }}";
    };
  };
}
