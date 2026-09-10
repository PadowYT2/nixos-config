{
  fetchFromGitHub,
  symlinkJoin,
  buildGo127Module,
  makeWrapper,
  v2ray-rules-dat,
  assets ? [
    v2ray-rules-dat
  ],
}:
buildGo127Module (finalAttrs: {
  pname = "xray";
  version = "26.6.27";

  src = fetchFromGitHub {
    owner = "XTLS";
    repo = "Xray-core";
    rev = "v${finalAttrs.version}";
    hash = "sha256-NLxG61mCeMwWoNWjDb0JNjMVG5Blp1OnU00RdAkqIdA=";
  };

  vendorHash = "sha256-BSEoAS4jH/Wyosi0xZC7GqgShVmkj2lS5fQQ7p1cT9s=";

  nativeBuildInputs = [makeWrapper];

  doCheck = false;

  ldflags = [
    "-s"
    "-w"
  ];
  subPackages = ["main"];

  installPhase = ''
    runHook preInstall
    install -Dm555 "$GOPATH"/bin/main $out/bin/xray
    runHook postInstall
  '';

  assetsDrv = symlinkJoin {
    name = "v2ray-assets";
    paths = assets;
  };

  postFixup = ''
    wrapProgram $out/bin/xray \
      --set-default V2RAY_LOCATION_ASSET $assetsDrv/share/v2ray \
      --set-default XRAY_LOCATION_ASSET $assetsDrv/share/v2ray
  '';

  meta.mainProgram = "xray";
})
