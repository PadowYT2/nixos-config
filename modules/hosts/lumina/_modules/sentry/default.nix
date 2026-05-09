{pkgs, ...}: {
  services.caddy.virtualHosts = {
    "sentry.proxied.host".extraConfig = ''
      reverse_proxy http://127.0.0.1:9000
    '';
  };

  systemd.services.sentry = {
    description = "Sentry self-hosted";
    after = ["docker.service" "network-online.target"];
    requires = ["docker.service"];
    wants = ["network-online.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      WorkingDirectory = "/opt/sentry";
      ExecStart = "${pkgs.docker}/bin/docker compose up --wait --detach";
      ExecStop = "${pkgs.docker}/bin/docker compose down";
      TimeoutStartSec = "1200";
      TimeoutStopSec = "300";
    };
  };
}
