{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/bits_n_bobs-2.2.3.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/T8bvmqVZ/versions/h55UvVFD/bits_n_bobs-2.2.3.jar";
        hash = "sha512-iD5N+NK3g4+nhhYVR5OQWbMJkPOiWb4i93fsdj5PLJj2dXe7/MmaGt/MZeS14EEt8Ss2G9BSguXPaFD8lfp05w==";
      }}";
    };
  };
}
