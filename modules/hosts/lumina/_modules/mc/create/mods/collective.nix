{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/collective-1.21.1-8.39.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/e0M1UDsY/versions/4XRlrKGN/collective-1.21.1-8.39.jar";
        hash = "sha512-Xo0ldlCyrOBB30dDFyeX36hvrqo/otsTiQSC9DOxibrQN8T1OZtbWw4+ZfqwwIh+9l5cXCTrpsCdqPle00NbAg==";
      }}";
    };
  };
}
