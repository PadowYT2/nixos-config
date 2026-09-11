{
  inputs,
  config,
  ...
}: {
  imports = [(inputs.self.outPath + "/modules/_overlays/remnawave/subscription-page.nix")];
  nixpkgs.overlays = [
    (_final: prev: {
      remnawave.subscription-page = prev.callPackage (inputs.self.outPath + "/packages/remnawave/subscription-page") {};
    })
  ];

  services.caddy.virtualHosts = {
    "surfing.proxied.host".extraConfig = ''
      reverse_proxy http://127.0.0.1:3010
    '';
  };

  services.remnawave.subscription-page = {
    enable = true;
    panelUrl = "https://surf.proxied.host";
    customSubPrefix = "/waves";
    apiTokenFile = config.age.secrets."remnawave.subpage.token".path;
  };

  age.secrets = {
    "remnawave.subpage.token" = {
      file = secrets/token.age;
      owner = "remnawave-subpage";
      group = "remnawave-subpage";
    };
  };
}
