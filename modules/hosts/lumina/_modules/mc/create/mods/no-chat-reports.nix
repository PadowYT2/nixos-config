{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/NoChatReports-NEOFORGE-1.21.1-v2.9.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/qQyHxfxd/versions/ZV8eL55E/NoChatReports-NEOFORGE-1.21.1-v2.9.1.jar";
        hash = "sha512-KSo2I7Wt2xfp8VaBpPJTRWLpiC74CeUE9J2kd4+vwS4hpxmVtdBVVNQ1IB9AGs4ehq9Q5uJvbOnSA6WJah7OIQ==";
      }}";
    };
  };
}
