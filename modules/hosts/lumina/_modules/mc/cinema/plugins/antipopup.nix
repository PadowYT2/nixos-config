{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/AntiPopup.jar" = "${pkgs.fetchurl {
        url = "https://jenkins.padow.ru/job/AntiPopup/5/artifact/build/libs/AntiPopup-12.3.jar";
        hash = "sha256-hsEBO3Gc65q71YR51R++TviWofGIqXjTU2otCh3/pN4=";
      }}";
    };

    files = {
      "plugins/AntiPopup/config.yml".value = {
        config-version = 33;
        bstats = true;
        filter-not-secure = true;
        send-header = false;
        auto-setup = false;
        block-chat-reports = true;
        show-popup = false;
        clickable-urls = false;
        properties-location = "server.properties";
        first-run = false;
        ask-bstats = false;
        setup-mode = true;
      };
    };
  };
}
