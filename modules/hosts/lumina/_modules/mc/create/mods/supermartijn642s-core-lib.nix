{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/supermartijn642corelib-1.1.24-neoforge-mc1.21.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/rOUBggPv/versions/81s25oaA/supermartijn642corelib-1.1.24-neoforge-mc1.21.jar";
        hash = "sha512-3zhE9m/vn1irQRGb0shglufKYT7MZG/5EDRKJdiR69PFAme/4gV+GPlt472z/A5K2lrsZNl/4ShltCcA3Ee7lw==";
      }}";
    };
  };
}
