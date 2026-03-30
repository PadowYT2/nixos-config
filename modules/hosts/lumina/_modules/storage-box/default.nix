{
  config,
  pkgs,
  ...
}: {
  fileSystems."/mnt/storage-box" = {
    device = "//u488452-sub1.your-storagebox.de/u488452-sub1";
    fsType = "cifs";
    options = [
      "seal"
      "credentials=${config.age.secrets."storage-box.credentials".path}"
      "noserverino"
      "_netdev"
      "x-systemd.automount"
    ];
  };

  age.secrets = {
    "storage-box.credentials" = {
      file = secrets/credentials.age;
    };
  };
}
