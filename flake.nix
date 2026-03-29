{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/4.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arion = {
      url = "github:hercules-ci/arion";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flakes = {
      url = "github:PadowYT2/flakes";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yt-cipher = {
      url = "github:PadowYT2/yt-cipher";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pterodactyl = {
      url = "github:PadowYT2/pterodactyl.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quantum = {
      url = "git+ssh://git@github.com/PadowYT2/quantum.nix.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    konytools = {
      url = "github:konyogony/KonyTools";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    remnawave = {
      url = "git+ssh://git@github.com/PadowYT2/remnawave.nix-wip.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [(inputs.import-tree ./modules)];
      systems = ["x86_64-linux"];
    };
}
