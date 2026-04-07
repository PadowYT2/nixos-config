{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/moonlight.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/twkfQtEc/versions/QiGuwr5v/moonlight-1.21-2.29.29-neoforge.jar";
        hash = "sha512-pZqGv6IL+VVMWLeB5rl6vD6V1RzVpHMU7FpIlJHh6Aomda52Z7aDT25A8YlhbLSQIWVYAwz6HDyiGTkweA3h+w==";
      }}";
    };
  };
}
