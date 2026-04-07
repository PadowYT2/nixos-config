{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/bellsandwhistles.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gJ5afkVv/versions/w0mifib8/bellsandwhistles-0.4.7-1.21.1.jar";
        hash = "sha512-SC7glkd7ie2Oxc4AikqKwK6FMHmk9c4WrQ4N2bLrErMybxesqsoergvFGtI49OUcjVuT3tcf5yQHF6yGAAQcWQ==";
      }}";
    };
  };
}
