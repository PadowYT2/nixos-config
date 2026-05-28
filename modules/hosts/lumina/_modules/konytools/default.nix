{
  config,
  inputs,
  ...
}: {
  imports = [inputs.konytools.nixosModules.default];
  nixpkgs.overlays = [inputs.konytools.overlays.default];

  services.konytools = {
    enable = true;
    clientId = "1258371284858044456";
    discordTokenFile = config.age.secrets."konytools.discord".path;
    geminiKeyFile = config.age.secrets."konytools.gemini".path;
    cloudflareAccountId = "20c1841ca5455cea9d680f9e6f138f24";
    cloudflareKeyFile = config.age.secrets."konytools.cloudflare".path;
  };

  age.secrets = {
    "konytools.discord" = {
      file = secrets/discord.age;
      owner = "konytools";
      group = "konytools";
    };

    "konytools.cloudflare" = {
      file = secrets/cloudflare.age;
      owner = "konytools";
      group = "konytools";
    };

    "konytools.gemini" = {
      file = secrets/gemini.age;
      owner = "konytools";
      group = "konytools";
    };
  };
}
