{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/resourcefullib.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/G1hIVOrD/versions/x99nCLTm/resourcefullib-neoforge-1.21-3.0.12.jar";
        hash = "sha512-qdIONF+qm8spe9layVJCBYNIBNG7E1GDl91Pf2KzUrCMMznuf3hw02aQeM7rM9XDHqUnrszksx1i7B/32LViyA==";
      }}";
    };
  };
}
