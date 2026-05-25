{keys, ...}: {
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  nix.settings.trusted-users = ["remotebuild"];

  users = {
    users.remotebuild = {
      isSystemUser = true;
      group = "remotebuild";
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [keys.flopux keys.transit keys.solara keys.helius keys.vpn keys.sol];
    };

    groups.remotebuild = {};
  };
}
