{
  inputs,
  config,
  ...
}: {
  imports = [inputs.yt-cipher.nixosModules.default];
  nixpkgs.overlays = [inputs.yt-cipher.overlays.default];

  services.caddy.virtualHosts = {
    "cipher.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:6969
    '';
  };

  services.yt-cipher = {
    enable = true;
    port = 6969;
    apiTokenFile = config.age.secrets."yt-cipher.token".path;
    environment = ["DISABLE_METRICS=true"];
  };

  age.secrets = {
    "yt-cipher.token" = {
      file = secrets/token.age;
      owner = "yt-cipher";
      group = "yt-cipher";
    };
  };
}
