{
  inputs,
  pkgs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.millennium.overlays.default
    # https://nixpk.gs/pr-tracker.html?pr=515956
    (_final: prev: {
      openldap = prev.openldap.overrideAttrs (_: {
        doCheck = !prev.stdenv.hostPlatform.isi686;
      });
    })
  ];
  imports = [inputs.flatpaks.nixosModules.default];

  fileSystems = {
    "/media/storage/hot" = {
      device = "/dev/disk/by-partlabel/storage-hot";
      fsType = "ntfs-3g";
      options = ["uid=1000" "gid=100" "umask=0022" "windows_names" "nofail" "x-gvfs-show"];
    };

    "/media/storage/cold" = {
      device = "/dev/disk/by-partlabel/storage-cold";
      fsType = "ntfs-3g";
      options = ["uid=1000" "gid=100" "umask=0022" "windows_names" "nofail" "x-gvfs-show"];
    };
  };

  systemd.tmpfiles.rules = [
    "d /home/padow/.steam 0755 padow users -"
    "d /home/padow/.steam/steam 0755 padow users -"
    "d /home/padow/.steam/steam/steamapps 0755 padow users -"
    "d /home/padow/.steam/steam/steamapps/compatdata_hot 0755 padow users -"
    "d /home/padow/.steam/steam/steamapps/compatdata_cold 0755 padow users -"
    "d /media/storage/hot/Steam/steamapps - - - -"
    "d /media/storage/cold/Steam/steamapps - - - -"
    "L /media/storage/hot/Steam/steamapps/compatdata - - - - /home/padow/.steam/steam/steamapps/compatdata_hot"
    "L /media/storage/cold/Steam/steamapps/compatdata - - - - /home/padow/.steam/steam/steamapps/compatdata_cold"
  ];

  environment.systemPackages = with pkgs; [
    bottles
    wineWow64Packages.stableFull
    winetricks

    lunar-client
    tetrio-desktop
  ];

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      # package = pkgs.millennium-steam;
      extraCompatPackages = with pkgs; [proton-ge-bin];
    };
  };

  services.flatpak = {
    enable = true;
    remotes.flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    packages = ["flathub:app/ch.tlaun.TL//stable"];
  };
}
