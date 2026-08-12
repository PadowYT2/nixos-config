{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcw-bridges-3.1.2-mc1.21.1neoforge.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/GURcjz8O/versions/aQ7rY7ng/mcw-bridges-3.1.2-mc1.21.1neoforge.jar";
        hash = "sha512-6Y5HYyQilWQTIojwpZv8yJfP9M2n0S/iGFY8pI04LYgGYjdWh8adG0YZFEJirgnL7xMPQzBHTY6s03oh6OmvtA==";
      }}";
    };
  };
}
