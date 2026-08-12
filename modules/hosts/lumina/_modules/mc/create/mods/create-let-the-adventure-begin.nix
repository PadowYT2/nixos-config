{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/create_ltab-4.1.0.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fUa6OtBG/versions/dQQazoxf/create_ltab-4.1.0.jar";
        hash = "sha512-BdLG33KPv+jTUi/9iL5JK+XfpvBsgG3B9tlIr/85RV9pWt0e27OP7i7X8ZdmjRO11ykJvGAZLEDZTfP/AEjROA==";
      }}";
    };
  };
}
