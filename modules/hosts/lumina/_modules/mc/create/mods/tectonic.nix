{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/tectonic.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/lWDHr9jE/versions/qrX9Y1PI/tectonic-3.0.21-neoforge-21.1.jar";
        hash = "sha512-kRHBWOdccd/VJD6b8r5O3MkV8NsEKx1dVzzyHh6gcpNWH+uDGIf4QD287/BiRUZ3j4TIjG72EUhjb2C8qNLagg==";
      }}";
    };
  };
}
