let
  keys = import ./_keys.nix;

  publicKeys = {
    # padow
    vpn = [keys.vpn keys.padow];

    # konyogony
    sol = [keys.sol keys.konyogony keys.padow];

    # flop4ik
    flopux = [keys.flopux keys.flop4ik];

    # proxied infra
    lumina = [keys.lumina keys.padow];
    transit = [keys.transit keys.padow];
    solara = [keys.solara keys.padow];
    helius = [keys.helius keys.padow];
  };

  walk = host: dir: relative: let
    entries = builtins.readDir dir;
  in
    builtins.foldl' (
      acc: name:
        if entries.${name} == "regular" && builtins.match ".*\\.age" name != null
        then acc // {"${relative}${name}".publicKeys = publicKeys.${host};}
        else if entries.${name} == "directory"
        then acc // walk host (dir + "/${name}") "${relative}${name}/"
        else acc
    ) {} (builtins.attrNames entries);
in
  builtins.foldl' (
    acc: host: acc // walk host (./hosts + "/${host}") "hosts/${host}/"
  ) {} (builtins.attrNames (builtins.readDir ./hosts))
