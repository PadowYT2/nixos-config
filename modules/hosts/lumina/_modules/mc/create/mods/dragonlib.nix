{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/dragonlib-neoforge-1.21.1-beta-3.0.28.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/sbIsGaOV/versions/x376YU9w/dragonlib-neoforge-1.21.1-beta-3.0.28.jar";
        hash = "sha512-hZ/1vPl9qyr/99dWIKJLsvRyp16MvwT1NrsNllXR9/Xb3KuM8TynBt/FfgWBu7HV4zMcPf7OcyR2G55VvNYpMQ==";
      }}";
    };
  };
}
