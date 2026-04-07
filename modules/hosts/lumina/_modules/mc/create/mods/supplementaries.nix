{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/supplementaries.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fFEIiSDQ/versions/i5gsy1xF/supplementaries-1.21-3.5.33-neoforge.jar";
        hash = "sha512-K52chExGzCb0+mJJyBHhq1XoC0v0tgDLgbj4S2RG3+z7gK5yPUsP5lDXPhbijik8Ky1OWjkV0donr1+7j2Wnqw==";
      }}";
    };
  };
}
