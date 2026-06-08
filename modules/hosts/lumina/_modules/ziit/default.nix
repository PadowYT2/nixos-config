{config, ...}: {
  imports = [../../../../_overlays/ziit.nix];
  nixpkgs.overlays = [
    (_final: prev: {
      remnawave.node = prev.callPackage ../../../../../packages/ziit {};
    })
  ];

  services.caddy.virtualHosts = {
    "wakatime.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:3002
    '';
  };

  services.ziit = {
    enable = true;
    port = 3002;
    baseUrl = "https://wakatime.proxied.host";
    pasetoKeyFile = config.age.secrets."ziit.paseto".path;
    adminKeyFile = config.age.secrets."ziit.admin".path;
    github = {
      clientId = "Ov23liZllhqKnFsq1WSU";
      clientSecretFile = config.age.secrets."ziit.github".path;
    };
    disableRegistration = true;
  };

  age.secrets = {
    "ziit.admin" = {
      file = secrets/admin.age;
      owner = "ziit";
      group = "ziit";
    };

    "ziit.paseto" = {
      file = secrets/paseto.age;
      owner = "ziit";
      group = "ziit";
    };

    "ziit.github" = {
      file = secrets/github.age;
      owner = "ziit";
      group = "ziit";
    };
  };
}
