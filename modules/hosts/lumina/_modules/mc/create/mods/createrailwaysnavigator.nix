{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createrailwaysnavigator.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Dq3STxps/versions/9tbJbgG6/createrailwaysnavigator-neoforge-1.21.1-alpha-0.9.0-C6%2B2.jar";
        hash = "sha512-vkRkoTGn+72x5SGWedTSViXgBaCe5WcaDzLZp0nqaeUzsr9I6/NUDnL1VkTSI+coJrecW4NtWLeopKEe8DZzwA==";
      }}";
    };
  };
}
