{
  stdenv,
  fetchFromGitHub,
  cmake,
  ffmpeg,
}:
stdenv.mkDerivation (finalAttrs: {
  pname = "ffmpeg-encoder-plugin";
  version = "1.3.3";

  src = fetchFromGitHub {
    owner = "EdvinNilsson";
    repo = "ffmpeg_encoder_plugin";
    tag = "v${finalAttrs.version}";
    hash = "sha256-G677EnV9cob0VyLzuyMeKzrDLZB7NrzmBVBRQ2kN/Gc=";
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
