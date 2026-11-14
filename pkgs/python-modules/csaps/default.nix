{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, numpy
, scipy
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "csaps";
  version = "1.3.3";
  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "espdev";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-1pNJaNExhcRWDjJenEKp1eJ4wZMFXxwWcmepEt6/p0s=";
  };

  propagatedBuildInputs = [ numpy scipy ];

  checkInputs = [ pytestCheckHook ];

  meta = with lib; {
    description = "Cubic spline approximation (smoothing)";
    maintainers = with maintainers; [ drewrisinger ];
    license = licenses.mit;
    homepage = "https://csaps.readthedocs.io/en/latest/";
  };
}
