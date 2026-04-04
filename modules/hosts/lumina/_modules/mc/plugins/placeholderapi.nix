{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "plugins/PlaceholderAPI.jar" = "${pkgs.fetchurl {
        url = "https://jenkins.padow.ru/job/PlaceholderAPI/8/artifact/build/libs/PlaceholderAPI-2.11.7.jar";
        hash = "sha256-wJC2pXGghS3h5y7tzxb/JpM0KnEZgiQaAg+aWiIpWOI=";
      }}";
    };

    files = {
      "plugins/PlaceholderAPI/config.yml".value = {
        check_updates = false;
        cloud_enabled = true;
        cloud_sorting = "name";
        boolean = {
          "true" = "yes";
          "false" = "no";
        };
        date_format = "MM/dd/yy HH:mm:ss";
        debug = false;
      };
    };
  };
}
