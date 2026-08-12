{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_structures_arise-176.49.48 NeoForge 1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/9enMEvoc/versions/ZFrDlvkl/create_structures_arise-176.49.48%20NeoForge%201.21.1.jar";
        hash = "sha512-lf9lqDrj9B/O47sTJ85trPTpFuDqhBqOWEsdGSftrQKJcLD2qAFJccwkRMzvALqmKjOiAh5h1g8s+U34s3fEqA==";
      }}";
    };
  };
}
