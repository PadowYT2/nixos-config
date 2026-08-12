{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createdieselgenerators-1.21.1-1.3.15.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ZM3tt6p1/versions/UoPH8lO1/createdieselgenerators-1.21.1-1.3.15.jar";
        hash = "sha512-FQfrzQfTGFqsOubOdotNa6sWy285d20lqFDIEzpNxYJrjdvsoRLXavxk3qo37Bd8rEI3xsNGIcS2XnPYP4q0Pw==";
      }}";
    };
  };
}
