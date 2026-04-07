{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/toughasnails.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/ge1sOdFH/versions/mboAbksk/ToughAsNails-neoforge-1.21.1-10.1.0.13.jar";
        hash = "sha512-7mmEtrl/mk7gMQPqPKqus3O7057KXkvSaPYsIePjZcP/kacHqw8VszUtAFLUTXiQP6sgrm2dJZpLGfHrSZVGWQ==";
      }}";
    };
  };
}
