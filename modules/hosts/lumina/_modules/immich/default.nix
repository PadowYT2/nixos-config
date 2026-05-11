{
  services.caddy.virtualHosts = {
    "images.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:2283
    '';
  };

  services.immich = {
    enable = true;
    host = "127.0.0.1";
  };
}
