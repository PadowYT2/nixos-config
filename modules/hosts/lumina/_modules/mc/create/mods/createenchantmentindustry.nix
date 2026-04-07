{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createenchantmentindustry.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/JWGBpFUP/versions/o56ltpU3/create-enchantment-industry-2.3.0.jar";
        hash = "sha512-/RbxugtA1H8O0jvJGkNMBpNXFvjEUKEyyV2YPZXEoZr+1MbfczTj+6wjocHDpGTqnzSPf/oLS22bcnIkZpcJtQ==";
      }}";
    };
  };
}
