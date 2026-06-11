{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      font-family = "Monocraft";
      theme = "tokyonight-dark";
      bell-features = false;
      term = "xterm-256color";
    };

    themes.tokyonight-dark = {
      background = "08080b";
      cursor-color = "c0caf5";
      cursor-text = "08080b";
      foreground = "a9b1d6";
      palette = [
        "0=#363b54"
        "1=#f7768e"
        "2=#41a6b5"
        "3=#e0af68"
        "4=#7aa2f7"
        "5=#bb9af7"
        "6=#7dcfff"
        "7=#787c99"
        "8=#363b54"
        "9=#f7768e"
        "10=#41a6b5"
        "11=#e0af68"
        "12=#7aa2f7"
        "13=#bb9af7"
        "14=#7dcfff"
        "15=#acb0d0"
      ];
      selection-background = "515c7e";
      selection-foreground = "a9b1d6";
    };
  };
}
