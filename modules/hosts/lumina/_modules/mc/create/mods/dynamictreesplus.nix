{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/dynamictreesplus.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/qaO9Dqpu/versions/LX5fWOvU/DynamicTreesPlus-neoforge-1.21.1-1.3.2.jar";
        hash = "sha512-5czUP7Q8bRQX/MBw+HoVpgbtBiQVvQDnKo+46jCxlfWiP1Yp4XhE4jI2hlPwzSv9SNd7ca7dRv5kqS5+fHMadg==";
      }}";
    };
  };
}
