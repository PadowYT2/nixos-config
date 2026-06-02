{pkgs, ...}: {
  fonts = {
    packages = with pkgs; [
      (stdenvNoCC.mkDerivation (finalAttrs: {
        pname = "monocraft";
        version = "4.2.1";

        src = fetchurl {
          url = "https://github.com/IdreesInc/Monocraft/releases/download/v${finalAttrs.version}/Monocraft-no-ligatures.ttc";
          hash = "sha256-k+55umK30KZT39kNXFGflJ461k7EgwRrQX8sxpQ4MdA=";
        };

        dontUnpack = true;

        installPhase = ''
          runHook preInstall

          install -Dm644 $src $out/share/fonts/truetype/Monocraft.ttc

          runHook postInstall
        '';
      }))
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
