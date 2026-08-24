{
  stdenv,
  fetchFromGitHub,
  cmake,
  ffmpeg,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "ffmpeg-encoder-plugin";
  version = "1.4.0";

  src = fetchFromGitHub {
    owner = "EdvinNilsson";
    repo = "ffmpeg_encoder_plugin";
    tag = "v${finalAttrs.version}";
    hash = "sha256-q37cA1GR2+qPzrJVrAN9uOqEmQ6ehPrmZWt+v4W94OE=";
  };

  nativeBuildInputs = [cmake ffmpeg];
  buildInputs = [ffmpeg];
  runtimeDependencies = [ffmpeg];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
    cp ffmpeg_encoder_plugin.dvcp $out/IOPlugins/ffmpeg_encoder_plugin.dvcp.bundle/Contents/Linux-x86-64/
    runHook postInstall
  '';
})
