{config, ...}: {
  services.murmur = {
    enable = true;
    password = "$PASSWORD";
    environmentFile = config.age.secrets."murmur.environment".path;
  };

  age.secrets = {
    "murmur.environment" = {
      file = secrets/environment.age;
      owner = "murmur";
      group = "murmur";
    };
  };
}
