{inputs, ...}: {
  imports = [
    inputs.pterodactyl.nixosModules.default
    ./panel
  ];

  nixpkgs.overlays = [inputs.pterodactyl.overlays.default];
}
