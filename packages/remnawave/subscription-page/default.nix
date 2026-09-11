{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_24,
  makeWrapper,
}: let
  version = "8.0.0";
  src = fetchFromGitHub {
    owner = "remnawave";
    repo = "subscription-page";
    tag = version;
    hash = "sha256-XSB52aZqfKmdJm+Agixim/gtl7mWMOUmcsh13phpKlA=";
  };

  frontend = buildNpmPackage {
    pname = "remnawave-subscription-page-frontend";
    inherit version src;

    sourceRoot = "source/frontend";

    nodejs = nodejs_24;

    npmBuildScript = "start:build";
    npmDepsHash = "sha256-62wtbgNY1kHs3Gvrzmf9ezdDFASVDhZSoR7x5ZWclG4=";

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      cp -r dist/* $out/
      runHook postInstall
    '';
  };
in
  buildNpmPackage (finalAttrs: {
    pname = "remnawave-subscription-page";
    inherit version src;

    sourceRoot = "${finalAttrs.src.name}/backend";

    nodejs = nodejs_24;

    npmDepsHash = "sha256-aThXsYMeYlwNC65C0QDmeuVEs4uNyo4tFScY6KABESo=";

    nativeBuildInputs = [makeWrapper];

    postPatch = ''
      substituteInPlace src/common/utils/startup-app/get-assets-path.ts \
        --replace-fail "'/opt/app/frontend'" "'$out/share/remnawave-subscription-page/frontend'"
    '';

    installPhase = ''
      runHook preInstall

      mkdir -p $out/{share/remnawave-subscription-page,bin}
      cp -r dist node_modules package.json $out/share/remnawave-subscription-page/
      cp -r ${frontend} $out/share/remnawave-subscription-page/frontend

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

