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
  };

  age.secrets = {
    "konytools.discord" = {
      file = secrets/discord.age;
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
