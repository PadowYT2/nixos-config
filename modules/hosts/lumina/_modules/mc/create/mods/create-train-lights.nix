{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/ctl-neoforge-1.1.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/nRC3whhL/versions/suYdvEKP/ctl-neoforge-1.1.1.jar";
        hash = "sha512-4hDwjLdHmHfy8wCCopDV++zU1xrOz2i7ehAhRsEZce3dU2+qCFKvuzXAZyfvYkUJFFERXdmfDnqANX5EkMztQA==";
      }}";
    };
  };
}
