{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createcompatiblestorage.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/5ofroZ5W/versions/bkpH554y/create_compatible_storage-2.10.0-neoforge.jar";
        hash = "sha512-yEGFVF91C+9zimK64YsnG4gutZaQ7bBi6iga95JP4hLBqPDPCakd4lt5DzXGz2YWHxxLRHku2O++EQYu3Pc6KA==";
      }}";
    };
  };
}
