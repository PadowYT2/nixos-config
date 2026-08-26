{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/create-aeronautics-bundled-1.21.1-1.3.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/oWaK0Q19/versions/w7zlLnea/create-aeronautics-bundled-1.21.1-1.3.0.jar";
        hash = "sha512-Krui4Wag7I1CqwYQi2MHDWH5hUIOzKhznFsjAFYbMUhrabOtEzELDEWe257evv+1WkzfTOSTgFgz0y9b3pzneA==";
      }}";
    };
  };
}
