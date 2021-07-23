{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
  # Python Inputs
, decorator
, docplex
, networkx
, numpy
, qiskit-terra
, scipy
  # Check Inputs
, pytestCheckHook
, ddt
, pylatexenc
, qiskit-aer
}:

buildPythonPackage rec {
  pname = "qiskit-optimization";
  version = "0.2.0";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = pname;
    rev = version;
    sha256 = "sha256-oIPfyntrmWkPmABdFapqaOcTD54TCPzYsbcf+usNtgA=";
  };

  propagatedBuildInputs = [
    docplex
    decorator
    networkx
    numpy
    qiskit-terra
    scipy
  ];

  checkInputs = [
    pytestCheckHook
    ddt
    pylatexenc
    qiskit-aer
  ];
  dontUseSetuptoolsCheck = true;

  pythonImportsCheck = [ "qiskit_optimization" ];
  preCheck = "pushd $TMP/$sourceRoot";
  postCheck = "popd";

  meta = with lib; {
    description = "Software for developing quantum computing programs";
    homepage = "https://qiskit.org";
    downloadPage = "https://github.com/QISKit/qiskit-optimization/releases";
    changelog = "https://qiskit.org/documentation/release_notes.html";
    license = licenses.asl20;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
