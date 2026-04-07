{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/clumps.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Wnxd13zP/versions/jo7lDoK4/Clumps-neoforge-1.21.1-19.0.0.1.jar";
        hash = "sha512-MU2NjmQNcwQfJ+Dz8srXqti0x329f7MXAO93YDYiYfdwhe7VKJVVxyXZnD9HoRTnKQzWCPOcnw8S73SVhGO9zA==";
      }}";
    };
  };
}
