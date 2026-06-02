{inputs, ...}: {
  imports = [inputs.nixcord.nixosModules.nixcord];

  programs.nixcord = {
    enable = true;
    user = "padow";

    discord = {
      enable = true;
      branch = "canary";
      vencord.enable = false;
      equicord.enable = true;
    };

    config = {
      enableReactDevtools = true;
      disableMinSize = true;
    };
  };
}
