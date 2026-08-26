{pkgs, ...}: {
  services.minecraft-servers.servers.cinema = {
    symlinks = {
      "mods/lithium-neoforge-0.15.4+mc1.21.1.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/gvQqBUqZ/versions/DDUrRVCA/lithium-neoforge-0.15.4%2Bmc1.21.1.jar";
        hash = "sha512-JzXaIIi4iovc1K0Corb/+/05JVV879T6VLVHffueWC6n9SEwDAYPV9/xMl3SG/8na3MzNjrTNx7WiT496eypzQ==";
      }}";
    };
  };
}
