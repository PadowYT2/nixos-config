{config, ...}: {
  services.strongswan-swanctl = {
    enable = true;
    swanctl = {
      connections.lumina = {
        version = 2;
        keyingtries = 0;
        local_addrs = ["95.135.208.17" "2a12:bec4:1821:61f::a"];
        remote_addrs = ["%any"];
        proposals = ["aes256gcm16-prfsha256-x25519"];

        local.main = {
          auth = "psk";
          id = "2a12:bec4:1821:61f::a";
        };

        remote.main = {
          auth = "psk";
          id = "%any";
        };

        children.tunnel = {
          local_ts = ["0.0.0.0/0" "::/0"];
          remote_ts = ["0.0.0.0/0" "::/0"];
          esp_proposals = ["aes256gcm16-x25519"];
          if_id_in = "42";
          if_id_out = "42";
          start_action = "trap";
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
