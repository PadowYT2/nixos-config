{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sophisticatedcore-1.21.1-1.4.85.2251.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nmoqTijg/versions/QSYJALVl/sophisticatedcore-1.21.1-1.4.85.2251.jar";
        hash = "sha512-HKKziFASs1uMuLQRebVSnLPZDqtb0ED/EL5P+0F8oX50FQqROvImk2t/Ydkb03mte92xoGOvxZAUmEsYAfqbHA==";
      }}";
    };
  };
}
