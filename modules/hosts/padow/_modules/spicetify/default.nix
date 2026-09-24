{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.spicetify.nixosModules.spicetify];

  programs.spicetify = {
    enable = true;
    wayland = false;
    theme = {
      name = "custom";
      src = ./theme;
      homeConfig = false;
    };
    enabledExtensions = with inputs.spicetify.legacyPackages.${pkgs.stdenv.system}.extensions; [
      trashbin
      adblock
      volumePercentage
      sidebarCustomizer
    ];
  };
}
