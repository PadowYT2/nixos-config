{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createltab.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/fUa6OtBG/versions/hcAQXLu1/create_ltab-3.8.6.jar";
        hash = "sha512-uWLttUOdx0kFNQ3/pui1HsbFasjyyMMNOv3CWY6yG+My/j97Wdpsx2rQW7FDkMwCNDPx3nC46Zu7jYBwtwbjoA==";
      }}";
    };
  };
}
