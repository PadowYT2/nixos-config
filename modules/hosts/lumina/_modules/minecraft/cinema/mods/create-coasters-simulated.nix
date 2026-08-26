{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/simulatedcoasters-0.1.4.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/W1ZUfWdr/versions/RIBBfVi3/simulatedcoasters-0.1.4.jar";
        hash = "sha512-sEMqvvCWFdDxXkEF4hE8l7iORbGKMFg05tuAopxZUehgOoCDDvRN4UJ+Q0YCgyhOtY8Du6Vy1FxSsw+t7CBaVg==";
      }}";
    };
  };
}
