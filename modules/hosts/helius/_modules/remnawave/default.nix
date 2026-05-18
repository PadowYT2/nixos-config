{
  config,
  inputs,
  ...
}: {
  imports = [inputs.flakes.nixosModules.default];
  nixpkgs.overlays = [inputs.flakes.overlays.default];

  services.remnawave.node = {
    enable = true;
    openFirewall = true;
    port = 11443;
    secretKeyFile = config.age.secrets."remnawave.node.key".path;
    supervisordUserFile = config.age.secrets."remnawave.node.user".path;
    supervisordPasswordFile = config.age.secrets."remnawave.node.password".path;
    internalRestTokenFile = config.age.secrets."remnawave.node.token".path;
  };

  networking.firewall.allowedTCPPorts = [443 8443];

  age.secrets = {
    "remnawave.node.key" = {
      file = secrets/key.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };

    "remnawave.node.password" = {
      file = secrets/password.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };

    "remnawave.node.token" = {
      file = secrets/token.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };

    "remnawave.node.user" = {
      file = secrets/user.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };
  };
}
