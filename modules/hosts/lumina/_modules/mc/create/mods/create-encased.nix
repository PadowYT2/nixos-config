{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/Create Encased-1.21.1-1.9.0-ht3.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/hSSqdyU1/versions/t6MATlU9/Create%20Encased-1.21.1-1.9.0-ht3.jar";
        hash = "sha512-7Sf2QLKzBUarLl2NVuYpG1Wa52sf5IsVIcC58QwjgoKnOkTleBxx/FgIjmyFJq1cAc9e9U+t9WQNEYrlPYpn1A==";
      }}";
    };
  };
}
