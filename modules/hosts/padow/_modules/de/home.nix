{pkgs, ...}: {
  xdg = {
    portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-gtk];
      config.common.default = "*";
    };

    userDirs = {
      enable = true;
      createDirectories = true;
      desktop = null;
      music = null;
      pictures = null;
      projects = null;
      publicShare = null;
      templates = null;
    };

    configFile = {
      "gtk-3.0/bookmarks".force = true;
      "user-dirs.dirs".force = true;
      "mimeapps.list".force = true;
    };

    mimeApps = {
      enable = true;
    };
  };

  gtk = {
    enable = true;
    gtk3 = {
      theme = {
        name = "adw-gtk3-dark";
        package = pkgs.adw-gtk3;
      };
      bookmarks = ["file:/// Filesystem"];
    };
  };
}
