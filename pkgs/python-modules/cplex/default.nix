{ lib
, buildPythonPackage
, fetchPypi
, isPy37
# , futures
# , docloud
# , requests
}:

buildPythonPackage rec {
  pname = "cplex";
  version = "12.10.0.1";
  format = "wheel";
  disabled = !isPy37;

  # No source available. Wheel only
  src = fetchPypi {
    inherit pname version format;
    python = "cp37";
    abi = "cp37m";
    platform = "manylinux1_x86_64";
    sha256 = "02lc0c187a912rj6vbw9ywsmf46rlc7px81kl206srn4gfhps69c";
  };

  # propagatedBuildInputs = [
  #   docloud
  #   requests
  # ] ++ lib.optional isPy27 futures;

  doCheck = false;
  pythonImportsCheck = [ "cplex" ];

  meta = with lib; {
    description = "A Python interface to the CPLEX Callable Library, Community Edition";
    homepage = "https://ibm.com/analytics/cplex";
    # license = licenses.unfree; # no license shown on PyPi
    maintainers = with maintainers; [ drewrisinger ];
    broken = true; # fails to build b/c Nix python isn't manylinux1-compatible, so the PyPi wheel doesn't install.
  };
}
