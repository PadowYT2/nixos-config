{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_24,
  xray,
  s6,
  makeWrapper,
  libnftnl,
  libmnl,
}:
buildNpmPackage (finalAttrs: {
  pname = "remnawave-node";
  version = "3.4.1";

  src = fetchFromGitHub {
    owner = "remnawave";
    repo = "node";
    tag = finalAttrs.version;
    hash = "sha256-TSSfsjfkfsq2s+i8gVy7yW6zZrA2gQd+pIGNxYGCQXQ=";
  };

  nodejs = nodejs_24;

  npmDepsHash = "sha256-/FAURUg5piGEF0F7Sop2sOLTU5QwLOC9p9XXBBozuEE=";

  nativeBuildInputs = [makeWrapper];

  postPatch = ''
    substituteInPlace src/modules/xray-core/xray.service.ts \
      --replace-fail "this.xrayPath = '/usr/local/bin/rw-core';" "this.xrayPath = '${xray}/bin/xray';"

    substituteInPlace src/modules/xray-core/xray-process.service.ts \
      --replace-fail "S6_SVC = '/command/s6-svc';" "S6_SVC = '${s6}/bin/s6-svc';" \
      --replace-fail "S6_SVSTAT = '/command/s6-svstat';" "S6_SVSTAT = '${s6}/bin/s6-svstat';" \
      --replace-fail "CORE_LINK = '/usr/local/bin/rw-core';" "CORE_LINK = '${xray}/bin/xray';"
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{share/remnawave-node,bin}
    cp -r dist libs node_modules package.json $out/share/remnawave-node/

    makeWrapper ${nodejs_24}/bin/node $out/bin/remnawave-node \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [libnftnl libmnl]}" \
      --add-flags "--max-http-header-size=65536" \
      --add-flags "$out/share/remnawave-node/dist/main.js"

    runHook postInstall
  '';

  meta = {
    description = "Node component for Remnawave";
    homepage = "https://docs.rw";
    changelog = "https://github.com/remnawave/node/releases/tag/${finalAttrs.version}";
    license = lib.licenses.agpl3Only;
    mainProgram = "remnawave-node";
    platforms = lib.platforms.linux;
  };
})
