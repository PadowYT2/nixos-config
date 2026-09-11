{
  services.caddy.virtualHosts = {
    "images.proxied.host".extraConfig = ''
      reverse_proxy http://127.0.0.1:2283
    '';
  };

  services.immich = {
    enable = true;
    host = "127.0.0.1";
  };
}
