{config, ...}: {
  services.caddy.virtualHosts = {
    "passwords.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:8000
    '';
  };

  services.vaultwarden = {
    enable = true;

    config = {
      DOMAIN = "https://passwords.proxied.host";

      IP_HEADER = "X-Forwarded-For";

      SMTP_HOST = "mail.proxied.host";
      SMTP_PORT = 587;
      SMTP_SECURITY = "starttls";
      SMTP_USERNAME = "no-reply@proxied.host";
      SMTP_FROM = "no-reply@proxied.host";
      SMTP_FROM_NAME = "proxied.host";
    };

    environmentFile = config.age.secrets."vaultwarden.environment".path;
  };

  age.secrets = {
    "vaultwarden.environment" = {
      file = secrets/environment.age;
      owner = "vaultwarden";
      group = "vaultwarden";
    };
  };
}
