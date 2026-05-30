{
  imports = [
    ./remnawave/node.nix
    ./ziit.nix
  ];

  nixpkgs.overlays = [
    (_final: prev: {
      remnawave.node = prev.callPackage ../../packages/remnawave/node {};
      ziit = prev.callPackage ../../packages/ziit {};
    })
  ];
}
