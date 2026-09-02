{
  description = "NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stalwart.url = "github:0x57e11a/nixpkgs/master"; # TODO: remove once merged

    import-tree.url = "github:vic/import-tree";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ragenix = {
      url = "github:yaxitech/ragenix";
    };

    arion = {
      url = "github:hercules-ci/arion";
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

    konytools = {
      url = "github:konyogony/KonyTools";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprkony = {
      url = "github:konyogony/hypr.konyogony.dev";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    magmabot = {
      url = "git+ssh://git@github.com/magmaorg/bot.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mangatranslate = {
      url = "git+ssh://git@github.com/konyogony/MangaTranslate.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    millennium.url = "github:SteamClientHomebrew/Millennium?dir=packages/nix";

    flatpaks.url = "github:in-a-dil-emma/declarative-flatpak";

    nixcord = {
      url = "github:4evy/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [(inputs.import-tree ./modules)];
      systems = ["x86_64-linux" "aarch64-linux"];
    };
}
