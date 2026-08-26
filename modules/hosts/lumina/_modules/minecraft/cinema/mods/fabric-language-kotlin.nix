{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/fabric-language-kotlin-1.13.13+kotlin.2.4.10.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ha28R6CL/versions/bdhiINYC/fabric-language-kotlin-1.13.13%2Bkotlin.2.4.10.jar";
        hash = "sha512-mmPDWlULA2K3sl/wRdk3Ccew2uCMiQdsukIoE/37nl9d0CHtOvrJ+C506VuIwkno9oskBxcVFUDKPojMJ/ucdw==";
      }}";
    };
  };
}
