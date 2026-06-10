{config, ...}: {
  services.restic.backups.magma = {
    repository = "s3:https://s3.buckets.ru/vds";
    passwordFile = config.age.secrets."restic.password".path;
    environmentFile = config.age.secrets."restic.environment".path;

    paths = [
      "/var/lib/pterodactyl"
      "/var/lib/mysql"
      "/etc"
      "/root"
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

  age.secrets = {
    "restic.environment" = {
      file = secrets/environment.age;
    };

    "restic.password" = {
      file = secrets/password.age;
    };
  };
}
