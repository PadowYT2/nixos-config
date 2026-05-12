{
  config,
  pkgs,
  lib,
  ...
}: let
  mtprotoproxyConfiguration = pkgs.writeShellApplication {
    name = "mtprotoproxy-configuration";
    text = ''
      cat > /run/mtprotoproxy/config.py <<EOF
      PORT = 8443
      USERS = {"main": "$(cat "$CREDENTIALS_DIRECTORY/secret")"}
      TLS = True
      TLS_DOMAIN = "cloudflare.com"
      BUFFER_SIZE = 262144
      CLIENT_KEEPALIVE = 3600
      USE_UVLOOP = True
      EOF
    '';
  };
in {
  systemd.services.mtprotoproxy = {
    description = "MTProto Proxy for Telegram";
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      DynamicUser = true;
      RuntimeDirectory = "mtprotoproxy";
      LoadCredential = "secret:${config.age.secrets."mtprotoproxy.password".path}";
      ExecStartPre = lib.getExe mtprotoproxyConfiguration;
      ExecStart = "${pkgs.mtprotoproxy}/bin/mtprotoproxy /run/mtprotoproxy/config.py";
      Restart = "on-failure";
      RestartSec = "5s";
    };
  };

  networking.firewall.allowedTCPPorts = [8443];

  age.secrets = {
    "mtprotoproxy.password" = {
      file = secrets/password.age;
    };
  };
}
