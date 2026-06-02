{pkgs, ...}: {
  services.transmission = {
    enable = true;
    settings = {
      dht-enabled = false;
      pex-enabled = false;
      lpd-enabled = false;
      port-forwarding-enabled = false;
      utp-enabled = false;
      seed-ratio-limited = true;
      seed-ratio-limit = 0;
    };
  };

  environment.systemPackages = with pkgs; [fragments];
}
