{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/sophisticatedbackpacks-1.21.1-3.25.76.2067.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/TyCTlI4b/versions/9cpdQJlx/sophisticatedbackpacks-1.21.1-3.25.76.2067.jar";
        hash = "sha512-BS/CzKJ7xvwiqKEYt5PPIUU5QsiWIQBhIDo7+UC7Gzv/5a87iC5Fri76ISCEgjCfG+U2XPG5n2NpwJmHp2ieZQ==";
      }}";
    };
  };
}
