{config, ...}: {
  services.restic = {
    backups.lumina = {
      repository = "/mnt/storage-box/lumina";
      passwordFile = config.age.secrets."restic.password".path;
      environmentFile = config.age.secrets."restic.environment".path;

      paths = [
        "/var/lib"
        "/srv/storage"
        "/etc"
        "/root"
      ];

      exclude = [
        "/var/lib/docker/overlay2/**"
        "/var/lib/docker/image/**"
        "/var/lib/docker/buildkit/**"
        "/var/lib/docker/containers/**"
        "/var/lib/docker/runtimes/**"
        "/var/lib/systemd/**"
        "/root/repos/**"
      ];

      initialize = true;
      timerConfig = {
        OnCalendar = "01:00";
        Persistent = true;
      };

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 6"
      ];
    };
  };

  systemd.services."restic-backups-lumina" = {
    requires = ["mnt-storage\\x2dbox.mount"];
    after = ["mnt-storage\\x2dbox.mount"];
  };

  age.secrets = {
    "restic.environment" = {
      file = secrets/environment.age;
    };

    "restic.password" = {
      file = secrets/password.age;
    };
  };
}
