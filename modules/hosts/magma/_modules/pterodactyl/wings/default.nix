{
  config,
  pkgs,
  lib,
  ...
}: let
  setupScript = pkgs.writeShellApplication {
    name = "pterodactyl-wings-cert-setup";
    runtimeInputs = with pkgs; [coreutils];
    text = ''
      install -Dm600 -o ${config.services.pterodactyl.wings.user} -g ${config.services.pterodactyl.wings.group} \
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/meow.magmamc.org/meow.magmamc.org.crt ${config.services.pterodactyl.wings.rootDir}/meow.magmamc.org.crt

      install -Dm600 -o ${config.services.pterodactyl.wings.user} -g ${config.services.pterodactyl.wings.group} \
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/meow.magmamc.org/meow.magmamc.org.key ${config.services.pterodactyl.wings.rootDir}/meow.magmamc.org.key
    '';
  };
in {
  services.caddy.virtualHosts = {
    "meow.magmamc.org".extraConfig = ''
      respond "ok"
    '';
  };

  systemd = {
    services.pterodactyl-wings = {
      after = ["pterodactyl-wings-cert-install.service"];
      requires = ["pterodactyl-wings-cert-install.service"];
    };

    services.pterodactyl-wings-cert-install = {
      description = "Pterodactyl Wings cert install";
      after = ["caddy.service"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        User = "root";
        Group = "root";
        ExecStart = lib.getExe setupScript;
      };
    };

    services.pterodactyl-wings-cert-sync = {
      description = "Pterodactyl Wings cert sync";

      serviceConfig = {
        Type = "oneshot";
        User = "root";
        Group = "root";
        ExecStart = lib.getExe setupScript;
        ExecStartPost = "${pkgs.systemd}/bin/systemctl --no-block restart pterodactyl-wings.service";
      };
    };

    paths.pterodactyl-wings-cert-sync = {
      wantedBy = ["multi-user.target"];
      pathConfig = {
        PathModified = "/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/meow.magmamc.org";
        Unit = "pterodactyl-wings-cert-sync.service";
      };
    };
  };

  services.pterodactyl.wings = {
    enable = true;
    rootDir = "/var/lib/pterodactyl";
    logDir = "/var/log/pterodactyl";
    tmpDir = "/var/cache/pterodactyl";
    runDir = "/run/wings";
    uuid = "20b841ff-2ccb-46b4-a150-ec2c5c0c9617";
    remote = "https://panel.magmamc.org";
    tokenIdFile = config.age.secrets."pterodactyl.wings.token-id".path;
    tokenFile = config.age.secrets."pterodactyl.wings.token".path;
    api = {
      port = 5555;
      uploadLimit = 1024;
      ssl = {
        enable = true;
        certFile = "${config.services.pterodactyl.wings.rootDir}/meow.magmamc.org.crt";
        keyFile = "${config.services.pterodactyl.wings.rootDir}/meow.magmamc.org.key";
      };
    };
    system.sftp.port = 2222;
  };

  age.secrets = {
    "pterodactyl.wings.token-id" = {
      file = secrets/token-id.age;
      owner = "pterodactyl-wings";
      group = "pterodactyl-wings";
    };

    "pterodactyl.wings.token" = {
      file = secrets/token.age;
      owner = "pterodactyl-wings";
      group = "pterodactyl-wings";
    };
  };
}
