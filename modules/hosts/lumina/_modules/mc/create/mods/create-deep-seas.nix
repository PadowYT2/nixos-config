{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_submarine-2.2.4.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/mva5q4qZ/versions/UcXaPVeD/create_submarine-2.2.4.jar";
        hash = "sha512-a4fXLxA2SJxEzQMxcKvhD4tSEO+CZYI/Kc1RUxRE54OEhjyjIbfNzCOSSUAWEiYyerd0z9HZHV4uqLpZmw6uMQ==";
      }}";
    };
  };
}
