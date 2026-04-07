{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/shulkerboxtooltip.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/2M01OLQq/versions/IuqNIoAi/shulkerboxtooltip-neoforge-5.1.9%2B1.21.1.jar";
        hash = "sha512-gF5FZsY9JA2ewB+gt4XhttW+Mj25R2oEG5bLAm4ZSW8A1aFNOpTOmZiE5EvFzX5yXs5vE/fVlSrMJ0/7H8GDqw==";
      }}";
    };
  };
}
