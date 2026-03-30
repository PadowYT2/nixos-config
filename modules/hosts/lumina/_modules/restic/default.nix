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
      privateRepos = true;
      htpasswd-file = config.age.secrets."restic.htpasswd".path;
    };

    backups = {
      lumina-local = {
        repository = "rest:http://localhost:8200/lumina";
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
          OnCalendar = "00:00";
          Persistent = true;
        };

        pruneOpts = [
          "--keep-daily 3"
        ];
      };

      lumina-remote = {
        repository = "sftp:u488452-sub1@u488452-sub1.your-storagebox.de:/restic/lumina";
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
