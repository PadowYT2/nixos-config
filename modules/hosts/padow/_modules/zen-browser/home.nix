{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.zen-browser.homeModules.beta];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = [pkgs.gnome-browser-connector];
  };
}
