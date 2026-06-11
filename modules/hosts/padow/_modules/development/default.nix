{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nixd
    bun
    nodejs_24
  ];

  programs = {
    java = {
      enable = true;
      binfmt = true;
      package = pkgs.temurin-bin-25;
    };
  };
}
