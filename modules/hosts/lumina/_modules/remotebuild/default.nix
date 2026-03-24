{keys, ...}: {
  nix.settings.trusted-users = ["remotebuild"];

  users = {
    users.remotebuild = {
      isSystemUser = true;
      group = "remotebuild";
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [keys.flopux keys.transit keys.vpn];
    };

    groups.remotebuild = {};
  };
}
