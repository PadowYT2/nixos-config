{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/soundphysicsremastered.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/qyVF9oeo/versions/Dd2tmpsk/sound-physics-remastered-neoforge-1.21.1-1.5.1.jar";
        hash = "sha512-/36fC5aO6yug6DMyihIoE8rQQ0z+LVw9UnwcDVZFBPE6c3/AXyLT/qViovhlaNMblSEr9TR90Q2jbNSa1WFDpg==";
      }}";
    };
  };
}
