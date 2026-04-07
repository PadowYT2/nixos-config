{pkgs, ...}: {
  services.minecraft-servers.servers.create = {
    symlinks = {
      "mods/createmanofmanyplanes.jar" = "${pkgs.fetchurl {
        url = "https://cdn.modrinth.com/data/F4Rdk2PX/versions/7nmQy8tH/create-man-of-many-planes-1.1.jar";
        hash = "sha512-QRf75td45wLWHgk9ArEjbas0Ho7Zc6nitNSJM551wg0QZC9zT9xwBkPJv1CJPUqDfVldab05EhHRt3Y5d7fsig==";
      }}";
    };
  };
}
