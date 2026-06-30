{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [inputs.millennium.overlays.default];
  imports = [inputs.flatpaks.nixosModules.default];

  environment.systemPackages = with pkgs; [
    wineWow64Packages.stableFull
    winetricks

    lunar-client
    tetrio-desktop
  ];

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      package = pkgs.millennium-steam;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };
  };

  services.flatpak = {
    enable = true;
    remotes.flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    packages = ["flathub:app/ch.tlaun.TL//stable"];
  };
}
