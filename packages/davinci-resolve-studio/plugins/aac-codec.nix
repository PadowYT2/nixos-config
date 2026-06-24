{
  stdenv,
  fetchFromGitHub,
  cmake,
  clang,
  ffmpeg,
  libcxx,
  autoPatchelfHook,
}:
stdenv.mkDerivation {
  pname = "davinci-linux-aac-codec";
  version = "unstable-2026-08-13";

  src = fetchFromGitHub {
    owner = "Toxblh";
    repo = "davinci-linux-aac-codec";
    rev = "f985bb348b8127534225e7806526112a1de472c6";
    hash = "sha256-NVNxmUFNwZ3hzlyi3QVENXhfPICAAP3M4s6QEgWsP/g=";
  };

  nativeBuildInputs = [cmake clang autoPatchelfHook];
  buildInputs = [ffmpeg libcxx];
  runtimeDependencies = [ffmpeg];

  dontUnpack = true;
  dontConfigure = true;

  buildPhase = ''
    cp -r --no-preserve=mode,ownership,timestamps $src $TMPDIR/src
    cd src
    make
  '';

  installPhase = ''
    BUNDLE_DIR="aac_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64"
    PLUGIN_NAME="aac_encoder_plugin.dvcp"
    mkdir -p $out/IOPlugins/$BUNDLE_DIR
    cp $TMPDIR/src/bin/$PLUGIN_NAME $out/IOPlugins/$BUNDLE_DIR
    chmod -R 755 $out/IOPlugins
    chmod +x $out/IOPlugins/$BUNDLE_DIR/$PLUGIN_NAME
  '';
}
