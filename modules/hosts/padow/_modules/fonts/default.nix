{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      (pkgs.callPackage ../../../../../packages/monocraft {})
      twemoji-color-font
    ];

    fontconfig = {
      defaultFonts = {
        serif = ["Monocraft"];
        sansSerif = ["Monocraft"];
        monospace = ["Monocraft"];
        emoji = ["Twemoji"];
      };
    };
  };
}
