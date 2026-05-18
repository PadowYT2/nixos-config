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
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/transit.lumina.proxied.host/transit.lumina.proxied.host.crt ${config.services.pterodactyl.wings.rootDir}/transit.lumina.proxied.host.crt

      install -Dm600 -o ${config.services.pterodactyl.wings.user} -g ${config.services.pterodactyl.wings.group} \
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/transit.lumina.proxied.host/transit.lumina.proxied.host.key ${config.services.pterodactyl.wings.rootDir}/transit.lumina.proxied.host.key
    '';
  };
in {
  services.caddy.virtualHosts = {
    "transit.lumina.proxied.host".extraConfig = ''
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
        PathModified = "/var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/transit.lumina.proxied.host";
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
    uuid = "228e4af2-0b0a-41f5-b5a3-b43cf212f4c8";
    remote = "https://manage.proxied.host";
    tokenIdFile = config.age.secrets."pterodactyl.wings.token-id".path;
    tokenFile = config.age.secrets."pterodactyl.wings.token".path;
    api = {
      port = 5555;
      uploadLimit = 1024;
      ssl = {
        enable = true;
        certFile = "${config.services.pterodactyl.wings.rootDir}/transit.lumina.proxied.host.crt";
        keyFile = "${config.services.pterodactyl.wings.rootDir}/transit.lumina.proxied.host.key";
      };
    };
    system.sftp.port = 2222;
    extraConfig = {
      docker.network.network_mtu = 1300;
    };
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
