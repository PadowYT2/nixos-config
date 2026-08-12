{
  inputs,
  pkgs,
  ...
}: {
  fonts = {
    packages = with pkgs; [
      (pkgs.callPackage (inputs.self.outPath + "/packages/monocraft") {})
      twemoji-color-font
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
