# 🤫️🤫️🤫️
{stdenvNoCC}:
stdenvNoCC.mkDerivation {
  pname = "decoy";
  version = "1.0.0";

  src = ./.;

  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out
    install -m 0644 \
      index.html \
      about.html \
      notes.html \
      style.css \
      robots.txt \
      favicon.svg \
      $out/

    runHook postInstall
  '';
}
