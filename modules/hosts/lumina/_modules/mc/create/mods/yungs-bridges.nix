{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/YungsBridges-1.21.1-NeoForge-5.1.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Ht4BfYp6/versions/urkCzBf6/YungsBridges-1.21.1-NeoForge-5.1.1.jar";
        hash = "sha512-ILB65MCJdJgPl2vK4y8YzLiFdF1s1Q1KXQFW61xRwp5J+LK/fcKuFg05ti8jMlE72YUO/Fy6E2l+NqKsKEi8Ow==";
      }}";
    };
  };
}
