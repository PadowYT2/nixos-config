{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sophisticatedbackpacks.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/TyCTlI4b/versions/Ve3HZfRi/sophisticatedbackpacks-1.21.1-3.25.37.1646.jar";
        hash = "sha512-CF6wLYZCJSbC0qvv9QJl5/qHrRcJWa99icN9/Mugfa5HljqF3JW8US+dz1Xg9FJ6bPyiTAT7sFY8+qpClttSPQ==";
      }}";
    };
  };
}
