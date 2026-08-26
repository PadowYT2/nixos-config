{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/KotlinLangForge-2.12.2-k2.4.10-3.0+neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/1vrSzlao/versions/318K66ba/KotlinLangForge-2.12.2-k2.4.10-3.0%2Bneoforge.jar";
        hash = "sha512-ID+G07SD1Wo5KZFu3ViwW6sMWKZ+BimeVRHsWiQCoqNU1EVoekgQdsDVKyIdc3ZnOpVnLkufk80g9AHiRMbgJQ==";
      }}";
    };
  };
}
