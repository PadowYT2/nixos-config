{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/iceandfire-2.1-beta.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/VpmCsizY/versions/o6K8vx54/iceandfire-2.1-beta.1.jar";
        hash = "sha512-jhlkOfOnCdZWSJiaKcZ0LOw6fc5UDF/gpj3G2qtarYj9lq18IyiFR3HcoZ8p+i/BcPmeEUErPcJaqAWFJGDOZw==";
      }}";
    };
  };
}
