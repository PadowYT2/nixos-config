{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/journeymap-neoforge-1.21.1-6.0.4.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/lfHFW1mp/versions/BWZbAAhc/journeymap-neoforge-1.21.1-6.0.4.jar";
        hash = "sha512-HkRy98V/SaXAeXEJdFwdqa6YAGRmlrDWTj+zRl0TT1H1jkP5JNwcwvRPHjGiKszG2kZWqCbDsygDI2TVKDcSEQ==";
      }}";
    };
  };
}
