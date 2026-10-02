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

  systemd.mounts = [
    {
      what = "/home/padow/.local/share/Steam/steamapps/compatdata_hot";
      where = "/media/storage/hot/SteamLibrary/steamapps/compatdata";
      type = "none";
      options = "bind";
      after = ["media-storage-hot.mount"];
      wantedBy = ["multi-user.target"];
    }
    {
      what = "/home/padow/.local/share/Steam/steamapps/compatdata_cold";
      where = "/media/storage/cold/SteamLibrary/steamapps/compatdata";
      type = "none";
      options = "bind";
      after = ["media-storage-cold.mount"];
      wantedBy = ["multi-user.target"];
    }
  ];

  systemd.tmpfiles.rules = [
    "d /home/padow/.steam 0755 padow users -"
    "d /home/padow/.steam/steam 0755 padow users -"
    "d /home/padow/.steam/steam/steamapps 0755 padow users -"
    "d /home/padow/.steam/steam/steamapps/compatdata_hot 0755 padow users -"
    "d /home/padow/.steam/steam/steamapps/compatdata_cold 0755 padow users -"
  ];

  environment.systemPackages = with pkgs; [
    (bottles.override {removeWarningPopup = true;})
    wineWow64Packages.stableFull
    winetricks

    lunar-client
    tetrio-desktop
    (pkgs.writeShellScriptBin "truckersmp-cli" ''
      exec ${lib.getExe pkgs.steam-run} ${lib.getExe (pkgs.callPackage (inputs.self.outPath + "/packages/truckersmp-cli") {})} "$@"
    '')
  ];

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      package = pkgs.millennium-steam;
      extraCompatPackages = [(pkgs.callPackage (inputs.self.outPath + "/packages/proton-ge-bin") {steamDisplayName = "Proton-GE 10-35";})];
    };
  };

  services.flatpak = {
    enable = true;
    remotes.flathub = "https://dl.flathub.org/repo/flathub.flatpakrepo";
    packages = ["flathub:app/ch.tlaun.TL//stable"];
  };
}
