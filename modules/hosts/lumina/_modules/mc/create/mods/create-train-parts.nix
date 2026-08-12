{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_train_parts-0.5.2-1.21.1-6.0.10-281.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/h0bu4oDk/versions/wSuDZsee/create_train_parts-0.5.2-1.21.1-6.0.10-281.jar";
        hash = "sha512-c7Sq7m2UQxgR3Jgm46qgZl85OmdToGN5taBjP4pvEHDQxUQXzY5KITRjTHMvyO3+TZHL0iW6dj6mNQD4Sj4tug==";
      }}";
    };
  };
}
