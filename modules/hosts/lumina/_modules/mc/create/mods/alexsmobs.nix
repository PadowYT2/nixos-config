{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/alexsmobs.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/EmNhnNnt/versions/KSgki4uc/alexsmobs-1.22.17.jar";
        hash = "sha512-n1fyBpO7GHxU9taNw0WSuH0OVaWkYorQl7CqOa/hZfSoNLg7ZZDYA+ZLrAsSMKj0Y2m/5FhRo8yWTPPYjyNSdw==";
      }}";
    };
  };
}
