{config, ...}: {
  services.caddy.virtualHosts = {
    "firefox-sync.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:5000
    '';
  };

  services.firefox-syncserver = {
    enable = true;
    secrets = config.age.secrets."firefox-syncserver.secrets".path;

    settings = {
      syncstorage.database_url = "mysql://${config.services.firefox-syncserver.database.user}@${config.services.firefox-syncserver.database.host}/${config.services.firefox-syncserver.database.name}?socket=%2Frun%2Fmysqld%2Fmysqld.sock";
      tokenserver.database_url = "mysql://${config.services.firefox-syncserver.database.user}@${config.services.firefox-syncserver.database.host}/${config.services.firefox-syncserver.database.name}?socket=%2Frun%2Fmysqld%2Fmysqld.sock";
    };

    singleNode = {
      enable = true;
      hostname = "firefox-sync.proxied.host";
      capacity = 1;
      url = "https://firefox-sync.proxied.host";
    };
  };

  age.secrets = {
    "firefox-syncserver.secrets" = {
      file = secrets/secrets.age;
    };
  };
}
