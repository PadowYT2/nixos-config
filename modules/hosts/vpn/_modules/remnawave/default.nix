{
  config,
  inputs,
  ...
}: {
  imports = [inputs.remnawave.nixosModules.default];
  nixpkgs.overlays = [inputs.remnawave.overlays.default];

  services.remnawave.node = {
    enable = true;
    openFirewall = true;
    secretKeyFile = config.age.secrets."remnawave.key".path;
  };

  networking.firewall.allowedTCPPorts = [443 8443];

  age.secrets = {
    "remnawave.key" = {
      file = secrets/key.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };
  };
}
