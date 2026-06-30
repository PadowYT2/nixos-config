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
