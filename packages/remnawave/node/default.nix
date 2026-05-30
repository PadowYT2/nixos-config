{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_24,
  xray,
  makeWrapper,
  user ? "remnawave-node",
}:
buildNpmPackage (finalAttrs: {
  pname = "remnawave-node";
  version = "2.7.0";

  src = fetchFromGitHub {
    owner = "remnawave";
    repo = "node";
    tag = finalAttrs.version;
    hash = "sha256-aU83xhwiHkppzogzoJk7YMBfztF2Iv4CeNBmOoAl1L0=";
  };

  nodejs = nodejs_24;

  npmDepsHash = "sha256-Ub0+2QV8fkQ8nml+YVjyCRwUCuW42gI5BZD8HXJSrBo=";

  nativeBuildInputs = [makeWrapper];

  postPatch = ''
    sed -i "s|this.xrayPath = '/usr/local/bin/xray';|this.xrayPath = '${xray}/bin/xray';|" \
      src/modules/xray-core/xray.service.ts

    sed -i \
      -e 's|user=root|user=${user}|' \
      -e 's|/var/log/supervisor|/var/log/remnawave-node|g' \
      -e 's|/usr/local/bin/rw-core|${xray}/bin/xray|g' \
      supervisord.conf
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/{share/remnawave-node,bin}
    cp -r dist libs node_modules package.json supervisord.conf $out/share/remnawave-node/

    makeWrapper ${nodejs_24}/bin/node $out/bin/remnawave-node \
      --add-flags "--max-http-header-size=65536" \
      --add-flags "$out/share/remnawave-node/dist/src/main.js"

    makeWrapper ${nodejs_24}/bin/node $out/bin/remnawave-node-cli \
      --add-flags "$out/share/remnawave-node/dist/src/bin/cli/cli.js"

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
