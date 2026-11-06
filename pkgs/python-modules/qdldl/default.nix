{ lib
, buildPythonPackage
, fetchFromGitHub
, cmake
, pybind11
, numpy
, scipy
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "qdldl";
  version = "0.1.9.post1";

  src = fetchFromGitHub {
    owner = "oxfordcontrol";
    repo = "qdldl-python";
    rev = "v${version}";
    sha256 = "sha256-lTMfWyhnpq3oJ+JV8/tU/MNHT/hhR1vYnrin7FixqDk=";
    fetchSubmodules = true;
  };

  dontUseCmakeConfigure = true;
  nativeBuildInputs = [ cmake ];

  buildInputs = [ pybind11 ];

  propagatedBuildInputs = [
    numpy
    scipy
  ];

  pythonImportsCheck = [ "qdldl" ];

  checkInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "A free LDL factorization routine";
    homepage = "https://github.com/oxfordcontrol/qdldl";
    downloadPage = "https://github.com/oxfordcontrol/qdldl-python";
    license = licenses.asl20;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
