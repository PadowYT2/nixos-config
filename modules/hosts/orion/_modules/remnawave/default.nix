{
  inputs,
  config,
  pkgs,
  ...
}: {
  imports = [(inputs.self.outPath + "/modules/_overlays/remnawave/node.nix")];
  nixpkgs.overlays = [
    (_final: prev: {
      xray = prev.callPackage (inputs.self.outPath + "/packages/xray") {};
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
        CLOUDFLARE_DNS_API_TOKEN_FILE = config.age.secrets."acme.cloudflare".path;
      };
      group = "remnawave-node";
      reloadServices = ["caddy"];
    };
  };

  services.remnawave.node = {
    enable = true;
    port = 8080;
    secretKeyFile = config.age.secrets."remnawave.node.key".path;
    internalRestTokenFile = config.age.secrets."remnawave.node.token".path;
  };

  services.caddy = {
    enable = true;

    globalConfig = ''
      auto_https off
      servers {
        protocols h1 h2
      }
    '';

    virtualHosts = {
      "orion.proxied.host:8443".extraConfig = ''
        bind 127.0.0.1
        tls /var/lib/acme/orion.proxied.host/fullchain.pem /var/lib/acme/orion.proxied.host/key.pem

        root * ${pkgs.callPackage (inputs.self.outPath + "/packages/decoy") {}}
        file_server
      '';
    };
  };

  networking.firewall = {
    allowedTCPPorts = [443];
    allowedUDPPorts = [443];
    extraInputRules = ''
      iifname "lo" tcp dport 8080 accept
      ip saddr 5.9.109.12 tcp dport 8080 accept
      ip6 saddr 2a01:4f8:162:502e::2 tcp dport 8080 accept
    '';
  };

  users.users = {
    remnawave-node.extraGroups = ["acme"];
    caddy.extraGroups = ["remnawave-node"];
  };

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
