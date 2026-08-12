{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createdeco-2.1.3.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/sMvUb4Rb/versions/qrcMVoBD/createdeco-2.1.3.jar";
        hash = "sha512-xTZmL51HrVejdBkWXe0Ug1sjrWw+gqkgKY7NfuB0JEsLYGLvnMfqRQHd01kZqED6zNf8ZOQ+uN8x4SB2aBw8DQ==";
      }}";
    };
  };
}
