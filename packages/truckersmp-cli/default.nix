{
  fetchFromGitHub,
  python312Packages,
  SDL2,
  steamcmd,
  pkgsCross,
}:
python312Packages.buildPythonApplication (finalAttrs: {
  pname = "truckersmp-cli";
  version = "0.10.2.1";

  src = fetchFromGitHub {
    repo = "truckersmp-cli";
    owner = "truckersmp-cli";
    tag = finalAttrs.version;
    hash = "sha256-BeSPmcbK5GTUWlT3Fhm0MDfA0Go8JlCxl/PHgUN3sX0=";
  };

  pyproject = true;
  build-system = [python312Packages.setuptools];
  nativeBuildInputs = [pkgsCross.mingwW64.buildPackages.gcc];
  buildInputs = [SDL2 steamcmd];
  propagatedBuildInputs = with python312Packages; [vdf];

  postPatch = ''
    substituteInPlace truckersmp_cli/variables.py --replace \
      'libSDL2-2.0.so.0' '${SDL2}/lib/libSDL2.so'

    substituteInPlace truckersmp_cli/steamcmd.py --replace \
      'steamcmd_path = os.path.join(Dir.steamcmddir, "steamcmd.sh")' \
      'steamcmd_path = "${steamcmd}/bin/steamcmd"'

    substituteInPlace truckersmp_cli/utils.py --replace \
      '"""Download files."""' 'print(files_to_download)'

    substituteInPlace truckersmp_cli/utils.py --replace \
      '[(newpath, dest, md5), ]' \
      '[(newpath, dest["abspath"], md5), ]'

    ${pkgsCross.mingwW64.buildPackages.gcc}/bin/x86_64-w64-mingw32-gcc truckersmp-cli.c -o truckersmp_cli/truckersmp-cli.exe
  '';

  meta.mainProgram = "truckersmp-cli";
})
