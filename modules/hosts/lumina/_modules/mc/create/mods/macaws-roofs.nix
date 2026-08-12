{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcw-roofs-2.3.2-mc1.21.1neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/B8jaH3P1/versions/jiXRXiSt/mcw-roofs-2.3.2-mc1.21.1neoforge.jar";
        hash = "sha512-wOgqPQo6svL6xfsL3Xx8Io8IT+qoFlQNPZUk80HIsQjDuxr+ytri6BGObJPw5zKAxi2hr0NJrKh7aqM35eIq5A==";
      }}";
    };
  };
}
