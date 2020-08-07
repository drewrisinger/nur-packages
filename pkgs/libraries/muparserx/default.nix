{ stdenv
, fetchFromGitHub
, cmake
  # Check Inputs
, python
}:

stdenv.mkDerivation rec {
  pname = "muparserx";
  version = "4.0.8";

  src = fetchFromGitHub {
    owner = "beltoforion";
    repo = "muparserx";
    rev = "v${version}";
    sha256 = "097pkdffv0phr0345hy06mjm5pfy259z13plsvbxvcmds80wl48v";
  };

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  nativeBuildInputs = [ cmake ];

  meta = with stdenv.lib; {
    description = "A C++ Library for Parsing Expressions with Strings, Complex Numbers, Vectors, Matrices and more.";
    homepage = "https://beltoforion.de/en/muparserx/";
    license = licenses.bsd2;
    maintainers = with maintainers; [ drewrisinger ];
  };
}