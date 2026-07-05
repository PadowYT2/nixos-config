{config, ...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware = {
    graphics.enable = true;

    nvidia = {
      open = true;
      package = config.boot.kernelPackages.nvidiaPackages.new_feature;
      modesetting.enable = true;
      powerManagement.enable = true;
      nvidiaSettings = false;
    };
  };
}
