{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
  # Python Inputs
, qiskit-aer
, qiskit-aqua
, qiskit-ibmq-provider
, qiskit-ignis
, qiskit-terra
  # Check Inputs
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "qiskit";
  # NOTE: This version denotes a specific set of subpackages. See https://qiskit.org/documentation/release_notes.html#version-history
  version = "0.20.0";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "Qiskit";
    repo = "qiskit";
    rev = version;
    sha256 = "1r23pjnql49gczf4k4m6ir5rr95gqdxjrks60p8a93d243mxx3c9";
  };

  propagatedBuildInputs = [
    qiskit-aer
    qiskit-aqua
    qiskit-ibmq-provider
    qiskit-ignis
    qiskit-terra
  ];

  checkInputs = [ pytestCheckHook ];
  dontUseSetuptoolsCheck = true;

  # following doesn't work b/c they are distributed across different nix sitePackages dirs. Tested with pytest though.
  pythonImportsCheck = [
    "qiskit"
    "qiskit.aqua"
    "qiskit.circuit"
    "qiskit.ignis"
    "qiskit.providers.aer"
  ];
  preCheck = "pushd $TMP/$sourceRoot";
  postCheck = "popd";

  meta = {
    description = "Software for developing quantum computing programs";
    homepage = "https://qiskit.org";
    downloadPage = "https://github.com/QISKit/qiskit/releases";
    changelog = "https://qiskit.org/documentation/release_notes.html";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ drewrisinger pandaman ];
  };
}
