{inputs, ...}: {
  imports = [
    inputs.pterodactyl.nixosModules.default
    ./panel
    ./wings
  ];

  nixpkgs.overlays = [inputs.pterodactyl.overlays.default];
}
