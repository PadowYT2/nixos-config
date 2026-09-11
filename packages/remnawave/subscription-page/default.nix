{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_24,
  makeWrapper,
}:
buildNpmPackage (finalAttrs: {
  pname = "remnawave-subscription-page";
  version = "8.0.0";

  src = fetchFromGitHub {
    owner = "remnawave";
    repo = "subscription-page";
    tag = finalAttrs.version;
    hash = "";
  };

  sourceRoot = "${finalAttrs.src.name}/backend";

  nodejs = nodejs_24;

  npmDepsHash = "";

  nativeBuildInputs = [makeWrapper];

  postPatch = ''
    substituteInPlace src/common/utils/startup-app/get-assets-path.ts \
      --replace-fail "'/opt/app/frontend'" "process.env.FRONTEND_ASSETS_PATH || '$out/share/remnawave-subscription-page/frontend'"
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{share/remnawave-subscription-page,bin}
    cp -r dist node_modules package.json $out/share/remnawave-subscription-page/
    cp -r ../frontend $out/share/remnawave-subscription-page/frontend

    makeWrapper ${nodejs_24}/bin/node $out/bin/remnawave-subscription-page \
      --add-flags "$out/share/remnawave-subscription-page/dist/main.js"

    runHook postInstall
  '';

  meta = {
    description = "Subscription page component for Remnawave";
    homepage = "https://docs.rw";
    changelog = "https://github.com/remnawave/subscription-page/releases/tag/${finalAttrs.version}";
    license = lib.licenses.agpl3Only;
    mainProgram = "remnawave-subscription-page";
    platforms = lib.platforms.linux;
  };
})
