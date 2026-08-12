{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcacapitals-1.2.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/tHmppiXj/versions/6q02vy3l/mcacapitals-1.2.0.jar";
        hash = "sha512-7VseotWqK05hGpJ7RumIeFPDKEN2u3FS/sGCpgGqBBVyXit+jdyg2JTYGWNweUCqImBilTHWSdovZHnm8WUWLw==";
      }}";
    };
  };
}
