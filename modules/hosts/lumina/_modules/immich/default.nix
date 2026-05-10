{
  services.caddy.virtualHosts = {
    "images.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:2283
    '';
  };

  services.immich.enable = true;
}
