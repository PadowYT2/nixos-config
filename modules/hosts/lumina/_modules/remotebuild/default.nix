{keys, ...}: {
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  nix.settings.trusted-users = ["remotebuild"];

  users = {
    users.remotebuild = {
      isSystemUser = true;
      group = "remotebuild";
      useDefaultShell = true;
      openssh.authorizedKeys.keys = with keys; [
        # padow
        padow
        zorin

        # konyogony
        sol

        # flop4ik
        flopux

        # proxied infra
        transit
        solara
        helius
        noctis
        glacius
      ];
    };

    groups.remotebuild = {};
  };
}
