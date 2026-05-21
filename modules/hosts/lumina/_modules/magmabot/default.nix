{
  config,
  inputs,
  ...
}: {
  imports = [inputs.magmabot.nixosModules.default];
  nixpkgs.overlays = [inputs.magmabot.overlays.default];

  services.magmabot = {
    enable = true;
    clientId = "1025959931762974751";
    guildId = "1020216326381387836";
    discordTokenFile = config.age.secrets."magmabot.discord".path;
  };

  age.secrets = {
    "magmabot.discord" = {
      file = secrets/discord.age;
      owner = "magmabot";
      group = "magmabot";
    };
  };
}
