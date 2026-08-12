{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/displaydelight-1.6.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/yXepZhp8/versions/LhcOrDyJ/displaydelight-1.6.0.jar";
        hash = "sha512-IX6oVXlZNpc9f01om5OX5+3B/+oXn7ZIMDfoe2ThKf5lyjsvN4RqBpbR35GFaDfV+yOOJ/LYwP0VBFgWlxYdWg==";
      }}";
    };
  };
}
