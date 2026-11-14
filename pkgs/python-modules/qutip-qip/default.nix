{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, numpy
, packaging
, qutip
, scipy
  # Test inputs
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "qutip-qip";
  version = "0.4.2";
  format = "pyproject";
  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "qutip";
    repo = "qutip-qip";
    rev = "v${version}";
    sha256 = "sha256-z9LYQYhEnRra91WxRX1nADxs1MxUh1ekeL+XOa46SYo=";
  };

  propagatedBuildInputs = [
    qutip
    numpy
    packaging
    scipy
  ];

  postPatch = ''
    substituteInPlace setup.cfg --replace "numpy>=1.16.6,<=1.21" "numpy"
  '';

  pythonImportsCheck = [ "qutip_qip" ];
  checkInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "QuTiP quantum information processing package";
    homepage = "https://qutip-qip.readthedocs.io/en/stable/";
    downloadPage = "https://github.com/qutip/qutip-qip/releases";
    changelog = "https://qutip-qip.readthedocs.io/en/stable/changelog.html";
    license = licenses.bsd3;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
