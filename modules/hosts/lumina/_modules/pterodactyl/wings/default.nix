{config, ...}: {
  services.caddy.virtualHosts = {
    "transit.lumina.proxied.host".extraConfig = ''
      respond "ok"
    '';
  };

  systemd.services.pterodactyl-wings-cert-setup = {
    description = "Pterodactyl Wings cert setup";
    before = ["pterodactyl-wings.service"];
    requiredBy = ["pterodactyl-wings.service"];
    after = ["caddy.service"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      User = "root";
      Group = "root";
      StateDirectory = "pterodactyl";
    };

    script = ''
      set -eu

      install -D -m 0600 -o ${config.services.pterodactyl.wings.user} -g ${config.services.pterodactyl.wings.group} \
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/transit.lumina.proxied.host/transit.lumina.proxied.host.crt \
        ${config.services.pterodactyl.wings.rootDir}/transit.lumina.proxied.host.crt

      install -D -m 0600 -o ${config.services.pterodactyl.wings.user} -g ${config.services.pterodactyl.wings.group} \
        /var/lib/caddy/.local/share/caddy/certificates/acme-v02.api.letsencrypt.org-directory/transit.lumina.proxied.host/transit.lumina.proxied.host.key \
        ${config.services.pterodactyl.wings.rootDir}/transit.lumina.proxied.host.key
    '';
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

  virtualisation.docker = {
    enable = true;
    daemon.settings = {
      mtu = 1300;
      default-cgroupns-mode = "private";
      exec-opts = ["native.cgroupdriver=systemd"];
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
