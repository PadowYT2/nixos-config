{
  inputs,
  config,
  ...
}: {
  imports = [(inputs.self.outPath + "/modules/_overlays/remnawave/node.nix")];
  nixpkgs.overlays = [
    (_final: prev: {
      remnawave.node = prev.callPackage (inputs.self.outPath + "/packages/remnawave/node") {};
    })
  ];

  security.acme = {
    acceptTerms = true;
    defaults.email = "postmaster@proxied.host";

    certs."orion.proxied.host" = {
      domain = "orion.proxied.host";
      dnsProvider = "cloudflare";
      credentialFiles = {
        CF_API_KEY_FILE = config.age.secrets."acme.cloudflare".path;
      };
      group = "remnawave-node";
    };
  };

  services.remnawave.node = {
    enable = true;
    openFirewall = true;
    port = 8080;
    secretKeyFile = config.age.secrets."remnawave.node.key".path;
    internalRestTokenFile = config.age.secrets."remnawave.node.token".path;
  };

  networking.firewall.allowedTCPPorts = [443];
  networking.firewall.allowedUDPPorts = [443];

  users.users.remnawave-node.extraGroups = ["acme"];

  age.secrets = {
    "acme.cloudflare" = {
      file = secrets/cloudflare.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };

    "remnawave.node.key" = {
      file = secrets/key.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };

    "remnawave.node.token" = {
      file = secrets/token.age;
      owner = "remnawave-node";
      group = "remnawave-node";
    };
  };
}
