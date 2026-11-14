{ lib
, buildPythonPackage
, fetchPypi
, gprof2dot
, graphviz  # TODO: remove once https://github.com/NixOS/nixpkgs/pull/143220 gets to stable branch
, pytest
, setuptools-git
  # Check Inputs
, pytestCheckHook
, pytest-virtualenv
}:

buildPythonPackage rec {
  pname = "pytest-profiling";
  version = "1.8.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-Pxcfpp1cgvqaq3bWar1fWdppE1w31q5b91V/GxVMsI0=";
  };

  nativeBuildInputs = [ setuptools-git ];
  propagatedBuildInputs = [
    gprof2dot
    pytest
    graphviz
  ];

  checkInputs = [ pytestCheckHook pytest-virtualenv ];
  pytestFlagsArray = [
    "--ignore=tests/integration/test_profile_integration.py"  # fails, virtualenv isn't working
  ];

  meta = with lib; {
    description = "Profiling plugin for py.test";
    homepage = "https://github.com/man-group/pytest-plugins";
    license = licenses.mit;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
