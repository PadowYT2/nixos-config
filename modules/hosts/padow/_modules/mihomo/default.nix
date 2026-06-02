{config, ...}: {
  boot.kernel.sysctl = {
    "net.ipv4.conf.mihomo.rp_filter" = 2;
  };

  networking.firewall = {
    trustedInterfaces = ["mihomo"];
    checkReversePath = "loose";
  };

  services.mihomo = {
    enable = true;
    tunMode = true;
    processesInfo = true;
    configFile = config.age.secrets."mihomo.configuration".path;
  };

  age.secrets = {
    "mihomo.configuration" = {
      file = secrets/configuration.age;
    };
  };
}
