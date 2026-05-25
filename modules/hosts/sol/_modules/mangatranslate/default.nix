{
  config,
  inputs,
  ...
}: {
  imports = [inputs.mangatranslate.nixosModules.default];
  nixpkgs.overlays = [inputs.mangatranslate.overlays.default];

  services.caddy.virtualHosts = {
    "api.japimg.com".extraConfig = ''
      reverse_proxy http://localhost:5050
    '';
  };

  services.mangatranslate = {
    enable = true;
    flaskSecretKeyFile = config.age.secrets."mangatranslate.secret".path;
    geminiKeyFile = config.age.secrets."mangatranslate.key".path;
    chromeExtensionIdFile = config.age.secrets."mangatranslate.id".path;
  };

  age.secrets = {
    "mangatranslate.id" = {
      file = secrets/id.age;
      owner = "mangatranslate";
      group = "mangatranslate";
    };

    "mangatranslate.key" = {
      file = secrets/key.age;
      owner = "mangatranslate";
      group = "mangatranslate";
    };

    "mangatranslate.secret" = {
      file = secrets/secret.age;
      owner = "mangatranslate";
      group = "mangatranslate";
    };
  };
}
