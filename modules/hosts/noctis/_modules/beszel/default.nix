{
  services.caddy.virtualHosts = {
    "uptime.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:8090
    '';
  };

  services.beszel.hub = {
    enable = true;
    environment = {
      APP_URL = "https://uptime.proxied.host";
    };
  };
}
