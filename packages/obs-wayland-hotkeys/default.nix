{
  stdenv,
  fetchFromGitHub,
  cmake,
  obs-studio,
  pkg-config,
  qtbase,
}:
stdenv.mkDerivation (finalAttr: {
  pname = "obs-wayland-hotkeys";
  version = "1.1.0";

  src = fetchFromGitHub {
    owner = "leia-uwu";
    repo = "obs-wayland-hotkeys";
    tag = "v${finalAttr.version}";
    hash = "sha256-vOQfOEAnxn5vCaWpwDED1C107BB/d7T10kmKTXJ4k8k=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
    obs-studio
    qtbase
  ];

  dontWrapQtApps = true;
})
