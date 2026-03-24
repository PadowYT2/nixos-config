{
  pkgs,
  config,
  ...
}: {
  services.restic = {
    server = {
      enable = true;
      listenAddress = "8200";
      dataDir = "/srv/backups";
      appendOnly = true;
      privateRepos = true;
      htpasswd-file = config.age.secrets."restic.htpasswd".path;
    };

    backups.lumina = {
      repository = "rest:http://localhost:8200/lumina";
      passwordFile = config.age.secrets."restic.password".path;
      environmentFile = config.age.secrets."restic.environment".path;

      paths = [
        "/var/lib"
        "/srv/minecraft"
        "/srv/storage"
        "/etc"
        "/root"
      ];

      exclude = [
        "/var/lib/jenkins/.gradle/caches/**"
        "/var/lib/jenkins/.gradle/daemon/**"
        "/var/lib/jenkins/.gradle/wrapper/**"
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

      backupPrepareCommand = ''
        ${pkgs.systemd}/bin/systemctl restart storage-box-route.service
      '';

      backupCleanupCommand = ''
        ${pkgs.rclone}/bin/rclone sync /srv/backups /mnt/storage-box --progress
      '';
    };
  };

  age.secrets = {
    "restic.environment" = {
      file = secrets/environment.age;
    };

    "restic.htpasswd" = {
      file = secrets/htpasswd.age;
      owner = "restic";
      group = "restic";
    };

    "restic.password" = {
      file = secrets/password.age;
    };
  };
}
