{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/mcwmcwwindows.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/C7I0BCni/versions/rQUE4LCz/mcw-mcwwindows-2.4.2-mc1.21.1neoforge.jar";
        hash = "sha512-diiqOQpomiEQE+WFbMocaVcpsfqn4g2hb6H4o4ItW1aWMYKekSIsqo8bJ8Sn0oq0kRBQJVFVEhbeL7RxtvJUnw==";
      }}";
    };
  };
}
