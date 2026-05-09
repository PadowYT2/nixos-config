{config, ...}: {
  services.caddy.virtualHosts = {
    "matrix.proxied.host".extraConfig = ''
      reverse_proxy http://localhost:6167
    '';
  };

  services.matrix-tuwunel = {
    enable = true;
    settings.global = {
      server_name = "matrix";
      new_user_displayname_suffix = "";
      max_request_size = 1048576000;
      allow_registration = true;
      registration_token_file = config.age.secrets."matrix-tuwunel.token".path;
    };
  };

  age.secrets = {
    "matrix-tuwunel.token" = {
      file = secrets/token.age;
      owner = "tuwunel";
      group = "tuwunel";
    };
  };
}
