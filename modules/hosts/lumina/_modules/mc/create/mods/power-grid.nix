{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/powergrid-mc1.21.1-0.5.5.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/eWiBLJ9R/versions/8EtGIOFr/powergrid-mc1.21.1-0.5.5.1.jar";
        hash = "sha512-Da/oJDgUMnCnYvm//zSDxW6FpdsLs4LboVMCttb2qIbyUt7kL8oI+0bHp265QB+QQw1BmUsgEz6cAJ1bh2uLtQ==";
      }}";
    };
  };
}
