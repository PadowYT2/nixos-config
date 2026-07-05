let
  keys = import ./_keys.nix;

  publicKeys = with keys; {
    # padow
    padow = [padow];
    vespera = [padow];

    # konyogony
    sol = [sol konyogony];

    # flop4ik
    flopux = [flopux flop4ik];

    # proxied infra
    lumina = [lumina padow];
    transit = [transit padow];
    solara = [solara padow];
    helius = [helius padow];
    noctis = [noctis padow];

    # magmamc infra
    magma = [magma padow];
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
