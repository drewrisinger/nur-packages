{ buildPythonPackage
, lib
, fetchFromGitHub
, nose
}:

buildPythonPackage rec {
  pname = "smbus2";
  version = "0.6.1";

  src = fetchFromGitHub {
    owner = "kplindegaard";
    repo = pname;
    rev = version;
    sha256 = "sha256-CWcRlbZTLiB45DaV6rbhvlk8cTaEJgPAq/JDmbxD7H4=";
  };

  propagatedBuildInputs = [ ];

  checkInputs = [ nose ];
  pythonImportsCheck = [ "smbus2" ];
  checkPhase = "nosetests";

  meta = with lib; {
    description = "Yet another python color library";
    homepage = "https://smbus2.readthedocs.io/en/latest/";
    license = licenses.mit;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
