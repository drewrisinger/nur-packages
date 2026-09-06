{ lib
, buildPythonPackage
, fetchFromGitHub
  # test inputs
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pubchempy";
  version = "1.0.5";

  src = fetchFromGitHub {
    owner = "mcs07";
    repo = "pubchempy";
    rev = "v${version}";
    sha256 = "sha256-/gMvn222LXs2iRGo3f64oU8oQLWCd3gPmyFghryzmIE=";
  };

  doCheck = false;  # ALL tests require network access

  pythonImportsCheck = [ "pubchempy" ];
  checkInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "Python wrapper for the PubChem PUG REST API";
    homepage = "https://pubchempy.readthedocs.io";
    license = licenses.mit;
    # maintainers = with maintainers; [ drewrisinger ];
  };
}
