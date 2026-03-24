{
  config,
  pkgs,
  ...
}: {
  fileSystems."/mnt/storage-box" = {
    device = "//u488452-sub1.your-storagebox.de/u488452-sub1";
    fsType = "cifs";
    options = [
      "seal"
      "credentials=${config.age.secrets."storage-box.credentials".path}"
      "noserverino"
      "_netdev"
      "x-systemd.automount"
    ];
  };

  systemd = {
    services.storage-box-route = {
      description = "route storage box directly";
      after = ["network-online.target"];
      wants = ["network-online.target"];

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = false;
      };

      script = ''
        IPV4=$(${pkgs.dig}/bin/dig +short u488452-sub1.your-storagebox.de A | head -n1)
        IPV6=$(${pkgs.dig}/bin/dig +short u488452-sub1.your-storagebox.de AAAA | head -n1)

        if [ -n "$IPV4" ]; then
          ${pkgs.nftables}/bin/nft flush set inet storage-box storage_box_ipv4
          ${pkgs.nftables}/bin/nft add element inet storage-box storage_box_ipv4 { $IPV4 }
        fi

        if [ -n "$IPV6" ]; then
          ${pkgs.nftables}/bin/nft flush set inet storage-box storage_box_ipv6
          ${pkgs.nftables}/bin/nft add element inet storage-box storage_box_ipv6 { $IPV6 }
        fi
      '';
    };

    timers.storage-box-route = {
      wantedBy = ["timers.target"];
      timerConfig = {
        OnBootSec = "30s";
        OnUnitActiveSec = "5m";
        Unit = "storage-box-route.service";
      };
    };
  };

  age.secrets = {
    "storage-box.credentials" = {
      file = secrets/credentials.age;
    };
  };
}
