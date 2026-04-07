{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/bclib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/7bdKEtKC/versions/sH6onskf/bclib-21.0.20.jar";
        hash = "sha512-+2n0+MLNTMhuYR+PqDhWNR7dUH2ciZj7hPTq1Hivvq6sSkWwTzbu/NFhF86Yf2HZCmxNZvOI62JqR25WgrapcA==";
      }}";
    };
  };
}
