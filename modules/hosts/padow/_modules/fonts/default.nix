{
  inputs,
  pkgs,
  ...
}: {
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [libpinyin];
  };

  fonts = {
    packages = with pkgs; [
      (pkgs.callPackage (inputs.self.outPath + "/packages/monocraft") {})
      twemoji-color-font
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Monocraft"];
        sansSerif = ["Monocraft"];
        monospace = ["Monocraft"];
        emoji = ["Twitter Color Emoji"];
      };
    };
  };
}
