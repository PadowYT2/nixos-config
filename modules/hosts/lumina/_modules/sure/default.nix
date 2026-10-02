{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [(inputs.nixpkgs-sure + "/nixos/modules/services/web-apps/sure.nix")];

  services.caddy.virtualHosts = {
    "finance.proxied.host".extraConfig = ''
      reverse_proxy http://127.0.0.1:3004
    '';
  };

  services.sure = {
    enable = true;
    package = pkgs.callPackage (inputs.self.outPath + "/packages/sure") {};
    localDomain = "finance.proxied.host";
    configureNginx = false;
    forceSSL = true;
    webPort = 3004;

    environment = {
      EXCHANGE_RATE_PROVIDER = "frankfurter";
      SMTP_ADDRESS = "mail.proxied.host";
      SMTP_PORT = "587";
      SMTP_USERNAME = "no-reply@proxied.host";
      SMTP_TLS_ENABLED = "true";
    };

    environmentFiles = [config.age.secrets."sure.environment".path];
  };

  age.secrets = {
    "sure.environment" = {
      file = secrets/environment.age;
      owner = "sure";
      group = "sure";
    };
  };
}
