{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/designndecor.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/x49wilh8/versions/m6PCLHcp/Design-n-Decor-1.21.1-2.1.0.jar";
        hash = "sha512-Su2x46P+Z7ORtch34JTGy7XrOVtPMXO4YMkOLqToA9E2f9ZZO7N4GErUaZHPLVxlZETmDt6+z5iH4FPynp5anw==";
      }}";
    };
  };
}
