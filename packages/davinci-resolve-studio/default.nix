{
  lib,
  pkgs,
  ...
}: let
  plugins = {
    aac-codec = pkgs.callPackage ./plugins/aac-codec.nix {};
    ffmpeg-encoder = pkgs.callPackage ./plugins/ffmpeg-encoder.nix {};
  };

  ioPluginsMerged = pkgs.symlinkJoin {
    name = "davinci-resolve-ioplugins";
    paths = [plugins.aac-codec plugins.ffmpeg-encoder];
  };

  asoundConfig = pkgs.writeText "asoundrc" ''
    pcm.!default {
      type pulse
    }
    ctl.!default {
      type pulse
    }
  '';
in
  pkgs.davinci-resolve-studio.override (oldArgs: {
    buildFHSEnv = fhsArgs: let
      davinci-patched = fhsArgs.passthru.davinci.overrideAttrs (old: {
        postInstall = ''
          ${old.postInstall or ""}

          ${lib.getExe pkgs.perl} -pi -e 's/\x74\x11\xe8\x21\x23\x00\x00/\xeb\x11\xe8\x21\x23\x00\x00/g' $out/bin/resolve
          ${lib.getExe pkgs.perl} -pi -e 's/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\x74\x11\x48\x8B\x45\xC8\x8B/\x03\x00\x89\x45\xFC\x83\x7D\xFC\x00\xEB\x11\x48\x8B\x45\xC8\x8B/' $out/bin/resolve
          ${lib.getExe pkgs.perl} -pi -e 's/\x74\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/\xEB\x11\x48\x8B\x45\xC8\x8B\x55\xFC\x89\x50\x58\xB8\x00\x00\x00/' $out/bin/resolve
          ${lib.getExe pkgs.perl} -pi -e 's/\x41\xb6\x01\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/\x41\xb6\x00\x84\xc0\x0f\x84\xb0\x00\x00\x00\x48\x85\xdb\x74\x08\x45\x31\xf6\xe9\xa3\x00\x00\x00/' $out/bin/resolve

          touch $out/.license/blackmagic.lic
          echo -e "LICENSE blackmagic davinciresolvestudio 999999 permanent uncounted\n  hostid=ANY issuer=CGP customer=CGP issued=28-dec-2023\n  akey=0000-0000-0000-0000 _ck=00 sig=\"00\"" > $out/.license/blackmagic.lic

          mkdir -p $out/IOPlugins
        '';
      });

      replacePaths = str: builtins.replaceStrings ["${fhsArgs.passthru.davinci}"] ["${davinci-patched}"] str;
    in
      pkgs.buildFHSEnv (fhsArgs
        // {
          inherit (davinci-patched) pname version;

          targetPkgs = pkgs: let
            origDeps = fhsArgs.targetPkgs pkgs;
            filteredDeps = builtins.filter (drv: drv != fhsArgs.passthru.davinci) origDeps;
            pluginRuntimeDeps = lib.concatLists (map (drv: drv.runtimeDependencies or []) [plugins.aac-codec plugins.ffmpeg-encoder]);
          in
            filteredDeps
            ++ [
              davinci-patched
              pkgs.alsa-plugins
              pkgs.alsa-utils
              pkgs.ffmpeg
            ]
            ++ pluginRuntimeDeps;

          extraBwrapArgs = let
            replaced = map replacePaths fhsArgs.extraBwrapArgs;
            withoutLicenseBind = builtins.filter (arg: !(lib.hasInfix ".license" arg)) replaced;
          in
            withoutLicenseBind
            ++ ["--ro-bind ${ioPluginsMerged}/IOPlugins ${davinci-patched}/IOPlugins" "--ro-bind ${asoundConfig} /etc/asound.conf"];

          runScript = "${pkgs.bash}/bin/bash ${pkgs.writeText "davinci-wrapper" ''
            export QT_XKB_CONFIG_ROOT="${pkgs.xkeyboard_config}/share/X11/xkb"
            export QT_PLUGIN_PATH="${davinci-patched}/libs/plugins:$QT_PLUGIN_PATH"
            export ALSA_PLUGIN_DIR="${pkgs.alsa-plugins}/lib/alsa-lib"
            export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib:/usr/lib32:${davinci-patched}/libs:${pkgs.ffmpeg}/lib
            if [ $# -gt 0 ]; then
              exec "$@"
            else
              exec ${davinci-patched}/bin/resolve
            fi
          ''}";

          extraInstallCommands = replacePaths fhsArgs.extraInstallCommands;

          passthru =
            (fhsArgs.passthru or {})
            // {
              davinci = davinci-patched;
              inherit (plugins) aac-codec ffmpeg-encoder;
            };
        });
  })
