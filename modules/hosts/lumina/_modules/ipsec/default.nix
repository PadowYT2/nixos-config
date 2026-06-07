{
  config,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [strongswan];

  services.strongswan-swanctl = {
    enable = true;
    swanctl = {
      connections.transit = {
        version = 2;
        keyingtries = 0;
        local_addrs = ["5.9.109.12" "2a01:4f8:162:502e::2"];
        remote_addrs = ["95.135.208.17" "2a12:bec4:1821:61f::a"];
        proposals = ["aes256gcm16-prfsha256-x25519"];

        local.main = {
          auth = "psk";
          id = "2a01:4f8:162:502e::2";
        };

        remote.main = {
          auth = "psk";
          id = "2a12:bec4:1821:61f::a";
        };

        children.tunnel = {
          local_ts = ["0.0.0.0/0" "::/0"];
          remote_ts = ["0.0.0.0/0" "::/0"];
          esp_proposals = ["aes256gcm16-x25519"];
          if_id_in = "42";
          if_id_out = "42";
          start_action = "start";
          dpd_action = "restart";
        };
      };
    };

    includes = [config.age.secrets."ipsec.psk".path];
  };

  age.secrets = {
    "ipsec.psk" = {
      file = secrets/psk.age;
      mode = "0400";
    };
  };
}
