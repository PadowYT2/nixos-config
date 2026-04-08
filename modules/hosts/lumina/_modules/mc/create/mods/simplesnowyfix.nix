{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/simplesnowyfix.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/3WP3HZRG/versions/9UyLCZ1u/simple_snowy_fix-1.21.1-1.21.11-2.1.9-neoforge.jar";
        hash = "sha512-EgVgRzPMltzqQRRwvMvJZ6RokieMhZu23V7hbafiZhhAI6QdkX/MDfE2PHvG5Y96+F5KUTaqXyI48Ekmqv4ikg==";
      }}";
    };
  };
}
