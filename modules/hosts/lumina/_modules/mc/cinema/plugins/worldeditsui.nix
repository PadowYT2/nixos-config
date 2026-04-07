{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/WorldEditSUI.jar" = "${pkgs.fetchurl {
        url = "https://github.com/kennytv/WorldEditSUI/releases/download/1.7.4/WorldEditSUI-1.7.4.jar";
        hash = "sha256-cAbPnllEx14bV8wZ3IjtF/wXmg4oNU/aQkqjKpWqw9g=";
      }}";
    };

    files = {
      "plugins/WorldEditSUI/config.yml".value = {
        cache-calculated-positions = true;
        particle = "FLAME";
        clipboard-particle = "END_ROD";
        wg-region-particle = "END_ROD";
        particles-per-block = 3;
        particle-send-interval = 12;
        max-ping = 150;
        max-selection-size-to-display = 10000000;
        enable-max-selection-bypass-perm = true;
        advanced-grid = {
          enabled = true;
          particles-per-block = 5;
        };
        advanced-clipboard-grid = {
          enabled = false;
          particles-per-block = 2;
        };
        advanced-wg-region-grid = {
          enabled = false;
          particles-per-block = 2;
        };
        particle-expiry = {
          enabled = false;
          expires-after-seconds = 180;
          expire-message = true;
        };
        permission = "none";
        send-particles-to-all = {
          enabled = false;
          view-others-particles-perm = "none";
          others-particle = "FLAME";
          others-clipboard-particle = "END_ROD";
        };
        show-selection-by-default = true;
        show-clipboard-by-default = false;
        persistent-toggles = false;
        particle-viewdistance = 99;
        update-checks = false;
      };
    };
  };
}
