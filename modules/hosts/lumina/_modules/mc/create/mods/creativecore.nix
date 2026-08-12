{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/CreativeCore_NEOFORGE_v2.13.42_mc1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/OsZiaDHq/versions/cv1iRM3A/CreativeCore_NEOFORGE_v2.13.42_mc1.21.1.jar";
        hash = "sha512-3qHwrs2jmYak1wKEPIDPuzt5ptLdHwNt+BnvQLfxiGtgOjGrki5Rt+YWc74bPfA0Vpu4IRF1+yJ18OGOrUYK9A==";
      }}";
    };
  };
}
