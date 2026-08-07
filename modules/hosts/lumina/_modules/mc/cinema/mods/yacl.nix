{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/yet_another_config_lib_v3-3.8.2+1.21.1-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/1eAoo2KR/versions/7TVdVtxF/yet_another_config_lib_v3-3.8.2%2B1.21.1-neoforge.jar";
        hash = "sha512-WD3hm5J86AUMK31eYLdazMaeMl5arIXCeZTIKp3sLk4Hg0P6HUw6ENS9fg5STgs7JGoYzwPbAeNjoeb4Za3PSA==";
      }}";
    };
  };
}
