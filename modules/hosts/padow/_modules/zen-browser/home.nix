{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    nativeMessagingHosts = [pkgs.gnome-browser-connector];

    profiles.default = {
      search = {
        force = true;
        default = "google";
      };
    };
  };
}
