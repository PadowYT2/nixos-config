{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/uranus-2.4.1-1.21.1-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/3Acxy864/versions/1YdU56pR/uranus-2.4.1-1.21.1-neoforge.jar";
        hash = "sha512-u3EZ/BjtNgldqo3Ayv/VxcM1f/G64P/OTturll2KV6D7fGO34HwceQ/6RHekz8diWwsjIUuex8XPoQt/DKqJtw==";
      }}";
    };
  };
}
