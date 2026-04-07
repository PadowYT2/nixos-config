{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/ProtocolLib.jar" = "${pkgs.fetchurl {
        url = "https://github.com/dmulloy2/ProtocolLib/releases/download/dev-build/ProtocolLib.jar";
        hash = "sha256-HxJ6d8QMuDDxobV8e1Z9qfthiDAMQjEiB5bIgoXgC5o=";
      }}";
    };

    files = {
      "plugins/ProtocolLib/config.yml".value = {
        global = {
          "auto updater" = {
            notify = false;
            download = false;
            delay = 43200;
          };
          metrics = false;
          "chat warnings" = true;
          "background compiler" = true;
          "ignore version check" = null;
          debug = false;
          "detailed error" = false;
          "script engine" = "JavaScript";
          "suppressed reports" = null;
        };
      };
    };
  };
}
