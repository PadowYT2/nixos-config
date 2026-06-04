{
  lib,
  pkgs,
  ...
}: {
  services = {
    desktopManager.gnome.enable = true;
    gnome = {
      core-apps.enable = false;
      gnome-online-accounts.enable = true;
    };

    displayManager = {
      gdm.enable = true;
      defaultSession = "gnome";
    };

    accounts-daemon.enable = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita";
  };

  programs = {
    xwayland.enable = true;

    dconf = {
      enable = true;
      profiles = {
        gdm.databases = [
          {
            lockAll = true;
            settings = {
              "org/gnome/desktop/interface" = {
                color-scheme = "dark";
                font-name = "Monocraft 10";
                document-font-name = "Monocraft 10";
                monospace-font-name = "Monocraft 10";
                clock-show-seconds = true;
              };
            };
          }
        ];

        user.databases = [
          {
            lockAll = true;
            settings = with lib.gvariant; {
              "org/gnome/desktop/app-folders".folder-children = mkEmptyArray type.string;
              "org/gnome/desktop/background" = {
                picture-uri = "file:///home/padow/nixos-config/assets/banner.png";
              };
              "org/gnome/desktop/screensaver" = {
                picture-uri = "file:///home/padow/nixos-config/assets/banner.png";
              };
              "org/gnome/desktop/sound".event-sounds = false;
              "org/gnome/desktop/session".idle-delay = mkUint32 900;
              "org/gnome/desktop/interface" = {
                enable-hot-corners = false;
                color-scheme = "prefer-dark";
                font-name = "Monocraft 10";
                document-font-name = "Monocraft 10";
                monospace-font-name = "Monocraft 10";
                clock-show-seconds = true;
              };
              "org/gnome/desktop/notifications".show-banners = false;
              "org/gnome/desktop/peripherals/mouse" = {
                accel-profile = "flat";
                speed = 0.2;
              };
              "org/gnome/desktop/input-sources" = {
                sources = mkArray [(mkTuple ["xkb" "us"]) (mkTuple ["xkb" "ru"])];
                xkb-options = ["grp:lalt_lshift_toggle" "lv3:ralt_switch"];
              };
              "org/gnome/desktop/wm/preferences".button-layout = ":minimize,maximize,close";
              "org/gnome/desktop/wm/keybindings" = {
                show-desktop = ["<Super>d"];
                switch-panels-backward = mkEmptyArray type.string;
                cycle-panels = mkEmptyArray type.string;
                cycle-panels-backward = mkEmptyArray type.string;
                cycle-windows = mkEmptyArray type.string;
                cycle-windows-backward = mkEmptyArray type.string;
                cycle-group = mkEmptyArray type.string;
                cycle-group-backward = mkEmptyArray type.string;
                show-screen-recording-ui = mkEmptyArray type.string;
                screenshot = mkEmptyArray type.string;
                screenshot-window = mkEmptyArray type.string;
                activate-window-menu = mkEmptyArray type.string;
                minimize = mkEmptyArray type.string;
                begin-move = mkEmptyArray type.string;
                begin-resize = mkEmptyArray type.string;
                toggle-maximized = mkEmptyArray type.string;
              };
              "org/gnome/shell/app-switcher".current-workspace-only = true;
              "org/gnome/shell/keybindings" = {
                focus-active-notification = mkEmptyArray type.string;
                toggle-quick-settings = mkEmptyArray type.string;
                toggle-application-view = mkEmptyArray type.string;
                toggle-message-tray = mkEmptyArray type.string;
              };
              "org/gnome/shell" = {
                disable-user-extensions = false;
                enabled-extensions = with pkgs.gnomeExtensions; [
                  advanced-media-controller.extensionUuid
                  appindicator.extensionUuid
                  blur-my-shell.extensionUuid
                  # copyous.extensionUuid
                  valent.extensionUuid
                ];
                favorite-apps = mkEmptyArray type.string;
              };
              "org/gnome/settings-daemon/plugins/media-keys".help = mkEmptyArray type.string;
              "org/gnome/settings-daemon/plugins/power".sleep-inactive-ac-type = "nothing";
              "org/gnome/mutter/wayland/keybindings".restore-shortcuts = mkEmptyArray type.string;
            };
          }
        ];
      };
    };

    kdeconnect = {
      enable = true;
      package = pkgs.valent;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      adwaita-qt6
      (lib.hiPrio pkgs.makeDesktopItem {
        name = "nixos-manual";
        desktopName = "NixOS Manual";
        exec = "nixos-help";
        noDisplay = true;
      })
      gnomeExtensions.advanced-media-controller
      gnomeExtensions.appindicator
      gnomeExtensions.blur-my-shell
      gnomeExtensions.copyous
      gnomeExtensions.valent
    ];
    gnome.excludePackages = with pkgs; [gnome-tour gnome-user-docs];
    sessionVariables.NIXOS_OZONE_WL = "1";
  };
}
