{config, ...}: {
  security.acme = {
    acceptTerms = true;
    defaults.email = "postmaster@proxied.host";

    certs."transit.lumina.proxied.host" = {
      domain = "transit.lumina.proxied.host";
      dnsProvider = "cloudflare";
      credentialFiles = {
        CLOUDFLARE_DNS_API_TOKEN_FILE = config.age.secrets."acme.cloudflare".path;
      };
      group = "pterodactyl-wings";
    };
  };

  services.pterodactyl.wings = {
    enable = true;
    rootDir = "/var/lib/pterodactyl";
    logDir = "/var/log/pterodactyl";
    tmpDir = "/var/cache/pterodactyl";
    runDir = "/run/wings";

    secrets = {
      tokenIdFile = config.age.secrets."pterodactyl.wings.token-id".path;
      tokenFile = config.age.secrets."pterodactyl.wings.token".path;
    };

    settings = {
      uuid = "228e4af2-0b0a-41f5-b5a3-b43cf212f4c8";
      remote = "https://manage.proxied.host";
      api = {
        port = 5555;
        upload_limit = 1024;
        ssl = {
          enabled = true;
          cert = "/var/lib/acme/transit.lumina.proxied.host/fullchain.pem";
          key = "/var/lib/acme/transit.lumina.proxied.host/key.pem";
        };
      };
      system.sftp.bind_port = 2222;
      docker.network.network_mtu = 1300;
    };
  };

  users.users.pterodactyl-wings.extraGroups = ["acme"];

  age.secrets = {
    "acme.cloudflare" = {
      file = secrets/cloudflare.age;
      owner = "pterodactyl-wings";
      group = "pterodactyl-wings";
    };

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
