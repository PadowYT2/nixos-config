{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/jupiter-2.3.7-1.21.1-neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/XbiLGMMU/versions/Jpcw76rq/jupiter-2.3.7-1.21.1-neoforge.jar";
        hash = "sha512-uRZloOfnTXv9w5A6KXvJdHf97qScQ+A/HeAAy7CUIr810GpvZ6aMNgKb4jzTW3U3cDVJZ/JbjwlHNlTqhUc+4A==";
      }}";
    };
  };
}
