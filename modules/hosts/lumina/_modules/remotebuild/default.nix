{keys, ...}: {
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  nix.settings.trusted-users = ["remotebuild"];

  users = {
    users.remotebuild = {
      isSystemUser = true;
      group = "remotebuild";
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [
        # padow
        keys.vpn

        # konyogony
        keys.sol

        # flop4ik
        keys.flopux

        # proxied infra
        keys.transit
        keys.solara
        keys.helius
        keys.noctis
      ];
    };

    groups.remotebuild = {};
  };
}
