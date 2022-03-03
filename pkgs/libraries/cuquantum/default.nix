{ stdenv
, lib
, fetchzip
}:

stdenv.mkDerivation rec {
  pname = "cuQuantum";
  version = "0.1.0.30";

  # includes C libraries only, not python bindings
  src = fetchzip {
    url = "https://developer.download.nvidia.com/compute/cuquantum/redist/cuquantum/linux-x86_64/${lib.toLower pname}-linux-x86_64-${version}-archive.tar.xz";
    sha256 = "sha256-13cyDWiDsAAGGxvrmu0ipB76OD2eQK49E30ZzHugjPE=";
  };

  dontBuild = true; # consists of pre-compiled libraries (*.so, *.a)
  doCheck = false;  # contains no tests

  installPhase = ''
    mkdir -p $out
    cp ./* $out -r
  '';

  meta = with lib; {
    description = "SDK of optimized libraries and tools for accelerating quantum computing workflows";
    homepage = "https://developer.nvidia.com/cuquantum-sdk";
    platforms = platforms.linux; # ARM, Power, x86_64. Only x86_64 currently supported.
    license = licenses.unfree;
  };
}
