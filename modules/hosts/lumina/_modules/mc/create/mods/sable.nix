{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sable-neoforge-1.21.1-2.0.3.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/T9PomCSv/versions/1L6XJqnY/sable-neoforge-1.21.1-2.0.3.jar";
        hash = "sha512-wTxNoIYAHCBTYZBc06bFmnbjx9TAgiZarzuvL9MMeYCPZjS8qJq6KdtcCWqn2kBm92RUCTwwbDrpHGwNTWOuDQ==";
      }}";
    };
  };
}
