{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, pkgs
, numpy
, scipy
  # check inputs
, nose
}:

buildPythonPackage rec {
  pname = "ecos";
  version = "2.0.14";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "embotech";
    repo = "ecos-python";
    rev = "v${version}";
    sha256 = "sha256-nfu1FicWr233r+VHxkQf1vqh2y4DGymJRmik8RJYJkA=";
    fetchSubmodules = true;
  };

  propagatedBuildInputs = [
    numpy
    scipy
  ];

  checkInputs = [ nose ];
  checkPhase = ''
    nosetests
  '';
  pythonImportsCheck = [ "ecos" ];

  meta = with lib; {
    description = "Python package for ECOS: Embedded Cone Solver";
    downloadPage = "https://github.com/embotech/ecos-python/releases";
    homepage = pkgs.ecos.meta.homepage;
    license = licenses.asl20;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
