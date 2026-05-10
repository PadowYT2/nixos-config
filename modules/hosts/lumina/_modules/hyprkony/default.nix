{
  config,
  inputs,
  ...
}: {
  imports = [inputs.hyprkony.nixosModules.default];
  nixpkgs.overlays = [inputs.hyprkony.overlays.default];

  services.caddy.virtualHosts = {
    "api.konyogony.dev".extraConfig = ''
      reverse_proxy http://localhost:8115
    '';
  };

  services.hyprkony = {
    enable = true;
    apiKeyFile = config.age.secrets."hyprkony.key".path;
  };

  age.secrets = {
    "hyprkony.key" = {
      file = secrets/key.age;
      owner = "hyprkony";
      group = "hyprkony";
    };
  };
}
