{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/YungsBetterNetherFortresses-1.21.1-NeoForge-3.1.5.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/Z2mXHnxP/versions/iopJiJQp/YungsBetterNetherFortresses-1.21.1-NeoForge-3.1.5.jar";
        hash = "sha512-GLRhKY098SFfo7TSwMsu8cftdnAdiguxQCd7IZI+MavZOfD9m0AMW9Z21znxzaMcQ7TcdT+RhyUVQiI/NCTTNg==";
      }}";
    };
  };
}
