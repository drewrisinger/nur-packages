{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, pytest
, matplotlib
  # Check inputs
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pytest-plt";
  version = "1.1.1";
  format = "pyproject";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "nengo";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-BbnxOHClADOpRfrI/6p2XEnrQrAzCmPfcrn5ECfQ7lA=";
  };

  propagatedBuildInputs = [
    matplotlib
    pytest
  ];

  checkInputs = [ pytestCheckHook ];
  pythonImportsCheck = [ "pytest_plt" ];

  meta = with lib; {
    description = "Create Matplotlib plots easily for visual inspection of complicated tests";
    homepage = "https://www.nengo.ai/pytest-plt/";
    changelog = "https://github.com/nengo/pytest-plt/releases/tag/v${version}";
    license = licenses.mit;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
