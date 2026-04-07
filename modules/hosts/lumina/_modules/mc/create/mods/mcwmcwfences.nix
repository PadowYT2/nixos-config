{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcwmcwfences.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/GmwLse2I/versions/jVdb0r4W/mcw-mcwfences-1.2.1-mc1.21.1neoforge.jar";
        hash = "sha512-m/SWqNuMYHSrMjdAQq4V6H/ofYl+Id4p1FlVb6jX0Oc/JxjyigI2GBz7PBvGbHdrTQefCnCEaWrUkCdasbnrbg==";
      }}";
    };
  };
}
