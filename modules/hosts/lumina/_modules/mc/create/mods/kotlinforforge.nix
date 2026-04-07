{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/kotlinforforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ordsPcFz/versions/NrSebcsG/kotlinforforge-5.11.0-all.jar";
        hash = "sha512-sy+qbWFlEa/0+LMhl4d8U7n4vuEDiE7DfGMrXQF7tZpJjslxto2NlHhwQ7DFvmZqMwth0oUDPDQb/4OsKKkJkg==";
      }}";
    };
  };
}
