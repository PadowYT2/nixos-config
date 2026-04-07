{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/yungsbettermineshafts.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/HjmxVlSr/versions/Go3nbneL/YungsBetterMineshafts-1.21.1-NeoForge-5.1.1.jar";
        hash = "sha512-iwGzhvU/7qpV8MYml1eLguAFAeReQosqaN9r2jTvtqSztONYKr8T/nZ+vLYa75NoGG9TwDmZlYvvOPMcQaf4sg==";
      }}";
    };
  };
}
