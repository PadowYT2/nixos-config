{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createfood-neoforge-1.21.1-2.7.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/4HnO3el1/versions/CnuisYs3/createfood-neoforge-1.21.1-2.7.1.jar";
        hash = "sha512-n0pURnGzgaDL+OJCjc3hV4dyzFIz+zB02Kk82YegZA55VSov+uivDI+QjtVzdus8KbMnRLTyV8PwARAed6GEIA==";
      }}";
    };
  };
}
