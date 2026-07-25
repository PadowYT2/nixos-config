{keys, ...}: {
  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  nix.settings.trusted-users = ["remotebuild"];

  users = {
    users.remotebuild = {
      isSystemUser = true;
      group = "remotebuild";
      useDefaultShell = true;
      openssh.authorizedKeys.keys = with keys; [
        # konyogony
        sol

        # proxied infra
        transit
        solara
        helius
        noctis
      ];
    };

    groups.remotebuild = {};
  };
}
