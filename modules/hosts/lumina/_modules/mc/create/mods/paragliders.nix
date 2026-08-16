{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/Paraglider-neoforge-21.1.5.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/esqWA0aQ/versions/tkTruHIA/Paraglider-neoforge-21.1.5.jar";
        hash = "sha512-stmGteshsSrVmwtKw/SsAEV1YgMQZOraeHDAI/IroGtXcS1noKEeSRStTrulGGDuNwYLiyC67h76FnOPl4AkNA==";
      }}";
    };
  };
}
