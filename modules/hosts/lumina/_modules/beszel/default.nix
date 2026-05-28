{config, ...}: {
  services.beszel.agent = {
    enable = true;
    openFirewall = true;
    smartmon.enable = true;
    environment = {
      KEY = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKCO671Engt+lgxvK6Tagq2Zu2U/WgZTv8Bhvp1mAyr";
      TOKEN_FILE = config.age.secrets."beszel.token".path;
      HUB_URL = "https://uptime.proxied.host";
    };
  };

  age.secrets = {
    "beszel.token" = {
      file = secrets/token.age;
      owner = "beszel-agent";
      group = "beszel-agent";
    };
  };
}
