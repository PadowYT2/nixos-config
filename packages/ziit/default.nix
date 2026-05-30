{
  lib,
  stdenv,
  stdenvNoCC,
  fetchFromGitHub,
  bun,
  nodejs_24,
  makeBinaryWrapper,
  writableTmpDirAsHomeHook,
  openssl,
  prisma-engines_6,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ziit";
  version = "1.1.1";

  src = fetchFromGitHub {
    owner = "0PandaDEV";
    repo = "Ziit";
    tag = "v${finalAttrs.version}";
    hash = "sha256-DNaXX9YFksmbMBcVHhwfRZfxS0fHEnkLSMj9cWVE0QI=";
  };

  node_modules = stdenvNoCC.mkDerivation {
    pname = "ziit-node_modules";
    version = finalAttrs.version;

    src = finalAttrs.src;

    impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ ["GIT_PROXY_COMMAND" "SOCKS_SERVER"];

    nativeBuildInputs = [bun writableTmpDirAsHomeHook];

    dontConfigure = true;

    buildPhase = ''
      runHook preBuild

      export BUN_INSTALL_CACHE_DIR=$(mktemp -d)

      bun install --force --frozen-lockfile --ignore-scripts --no-progress

      bun node_modules/prisma/build/index.js generate

      runHook postBuild
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/node_modules
      cp -R ./node_modules $out

      runHook postInstall
    '';

    dontFixup = true;

    outputHash = "sha256-Kz1JKzfY7m31rjYsmIMT66UlobPsjpfDOBkgF1AH7uY=";
    outputHashAlgo = "sha256";
    outputHashMode = "recursive";
  };

  nativeBuildInputs = [bun nodejs_24 makeBinaryWrapper openssl];

  env = {
    NUXT_TELEMETRY_DISABLED = "1";
  };

  configurePhase = ''
    runHook preConfigure

    cp -R ${finalAttrs.node_modules}/. .
    chmod -R +w node_modules

    rm -r node_modules/sass-embedded*

    patchShebangs node_modules

    runHook postConfigure
  '';

  buildPhase = ''
    runHook preBuild

    bun --bun run build

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/ziit
    cp -R .output/server/* $out/share/ziit/
    cp -R .output/public $out/share/
    cp -R prisma $out/share/ziit/

    mkdir -p $out/share/ziit/node_modules/.prisma
    cp -R node_modules/.prisma/client $out/share/ziit/node_modules/.prisma/

    mkdir -p $out/bin
    makeWrapper ${bun}/bin/bun $out/bin/ziit \
      --add-flags "run $out/share/ziit/index.mjs" \
      --set PRISMA_QUERY_ENGINE_LIBRARY "${prisma-engines_6}/lib/libquery_engine.node" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [stdenv.cc.cc.lib openssl]}"

    makeWrapper ${bun}/bin/bun $out/bin/ziit-migrate \
      --add-flags "${finalAttrs.node_modules}/node_modules/prisma/build/index.js migrate deploy --schema=$out/share/ziit/prisma/schema.prisma" \
      --set PRISMA_QUERY_ENGINE_LIBRARY "${prisma-engines_6}/lib/libquery_engine.node" \
      --set PRISMA_SCHEMA_ENGINE_BINARY "${prisma-engines_6}/bin/schema-engine" \
      --set PRISMA_MIGRATION_ENGINE_BINARY "${prisma-engines_6}/bin/migration-engine" \
      --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath [stdenv.cc.cc.lib openssl]}"

    runHook postInstall
  '';

  meta = {
    description = "The Swiss army knife of code time tracking";
    homepage = "https://github.com/0PandaDEV/Ziit";
    changelog = "https://github.com/0PandaDEV/Ziit/releases/tag/v${finalAttrs.version}";
    license = lib.licenses.agpl3Only;
    mainProgram = "ziit";
  };
})
