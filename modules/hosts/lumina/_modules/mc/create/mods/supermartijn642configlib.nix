{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/supermartijn642configlib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/LN9BxssP/versions/qKL9jM75/supermartijn642configlib-1.1.8-neoforge-mc1.21.jar";
        hash = "sha512-do2MoXjF5lOYb1Ext663+lfOfTLBbtOZztAbJzVlorZAEwxVxwknR+/v9A27A0iHaxi0FfWbDRbdLH8y8XmM4g==";
      }}";
    };
  };
}
