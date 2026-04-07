{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createdragonsplus.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/dzb1a5WV/versions/C1pFgdCC/create-dragons-plus-1.8.7.jar";
        hash = "sha512-t7NDxTwPauMH4r9ZZRX5PzN+u+2ORJuTDofluecr5JWvpiC4NQe7Dlm/MNYL4LCncW0r6DGc/0K/fgolN3mwow==";
      }}";
    };
  };
}
