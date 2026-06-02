{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify.nixosModules.spicetify];

  programs.spicetify = {
    enable = true;
    wayland = false;
    alwaysEnableDevTools = true;
    experimentalFeatures = true;
    theme = {
      name = "custom";
      src = ./theme;
      homeConfig = false;
    };
    enabledExtensions = with inputs.spicetify.legacyPackages.${pkgs.stdenv.system}.extensions; [
      autoSkipVideo
      trashbin
      adblock
      hidePodcasts
      volumePercentage
      sideHide
      sidebarCustomizer
    ];
  };
}
