{inputs, ...}: {
  nixpkgs.overlays = [inputs.minecraft.overlay];
  imports = [
    inputs.minecraft.nixosModules.minecraft-servers
    ./cinema
    ./create
  ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
  };
}
