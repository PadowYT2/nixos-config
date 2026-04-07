{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createstructuresarise.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/9enMEvoc/versions/BqB1xPS9/create_structures_arise-174.47.46%20Release-neoforge-1.21.1.jar";
        hash = "sha512-a1B4s1fwIerU/yafwnmvhvaCgcLqD0S2gQmdS7hA3yiT57AoyT1L6j96M+gxwwKYTQvtQYDL7egBpWF5IS2lFw==";
      }}";
    };
  };
}
