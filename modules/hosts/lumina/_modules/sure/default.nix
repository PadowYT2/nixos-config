{
  config,
  inputs,
  ...
}: {
  imports = [inputs.flakes.nixosModules.default];
  nixpkgs.overlays = [inputs.flakes.overlays.default];

  services.caddy.virtualHosts = {
    "finance.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:3001
    '';
  };

  services.sure = {
    enable = true;
    onboardingState = "invite_only";
    secretKeyBaseFile = config.age.secrets."sure.key".path;
    appDomain = "finance.proxied.host";
    brandName = "finance.proxied.host";
    port = 3001;
    exchangeRateProvider = "yahoo_finance";
    securitiesProvider = "yahoo_finance";
    smtp = {
      address = "mail.proxied.host";
      port = 587;
      username = "no-reply@proxied.host";
      passwordFile = config.age.secrets."sure.smtp".path;
      tlsEnabled = true;
      emailSender = "no-reply@proxied.host";
    };
  };

  age.secrets = {
    "sure.key" = {
      file = secrets/key.age;
      owner = "sure";
      group = "sure";
    };

    "sure.smtp" = {
      file = secrets/smtp.age;
      owner = "sure";
      group = "sure";
    };
  };
}
