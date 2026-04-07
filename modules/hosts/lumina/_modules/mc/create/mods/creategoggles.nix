{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/creategoggles.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/L1RT5SJc/versions/Co24W2FL/creategoggles-1.21.1-6.1.1-%5BNEOFORGE%5D.jar";
        hash = "sha512-vyxBZ/3uZMP0MpjG/S2eNHlR0vuPwS4sK7r8SG6NaQzX6/1TZQfROmtMKHI2cT+NeWwEjfI1b+2jZULPW0hK/A==";
      }}";
    };
  };
}
