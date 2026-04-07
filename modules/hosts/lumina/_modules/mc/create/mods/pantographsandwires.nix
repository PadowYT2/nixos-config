{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/pantographsandwires.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/VzdCnMqW/versions/sVdMYYKZ/pantographsandwires-neoforge-1.21.1-alpha-0.2.0-1-C6%2B2.jar";
        hash = "sha512-qOnWpJUkXTlc6DEcio+JPD7BU3YLJ5sXIzPtsO5mNaH5BzSwWVYxj1SXhQExBHZj5sV2q5eWvfoF+bjr/q+JXg==";
      }}";
    };
  };
}
