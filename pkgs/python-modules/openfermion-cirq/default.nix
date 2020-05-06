{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, cirq
, deprecation
, numpy
, openfermion
, pandas
, scipy
, sympy
  # test inputs
, pytestCheckHook
, nbformat
}:

buildPythonPackage rec {
  pname = "openfermion-cirq";
  version = "0.4.0";
  disabled = pythonOlder "3.6.5";

  src = fetchFromGitHub {
    owner = "quantumlib";
    repo = "openfermion-cirq";
    rev = "v${version}";
    sha256 = "05jf85a2zcr1vbra763mm1dj7i3f4fdr103r70ag49rkb9dgk1xj";
  };

  propagatedBuildInputs = [
    cirq
    deprecation
    numpy
    openfermion
    pandas
    scipy
    sympy
  ];

  postPatch = ''
    substituteInPlace requirements.txt --replace "openfermion==0.11.0" "openfermion"
  '';

  dontUseSetuptoolsCheck = true;
  checkInputs = [ pytestCheckHook nbformat ];
  disabledTests = [
    "test_deprecated_test"
  ];
  pytestFlagsArray = [
    "--ignore=dev_tools"
  ];

  meta = with lib; {
    description = "Quantum circuits for simulations of quantum chemistry and materials.";
    homepage = "https://github.com/quantumlib/openfermion-cirq";
    license = licenses.asl20;
    # maintainers = with maintainers; [ drewrisinger ];
  };
}