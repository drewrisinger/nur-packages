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
  version = "2.0.8";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "embotech";
    repo = "ecos-python";
    rev = version;
    sha256 = "0sfydwsf549584708brnl1ar86x2bzpp5fgkv61yfwcrqdnnmqnq";
    fetchSubmodules = true;
  };

  prePatch = ''
    echo '__version__ = "${version}"' >> ./src/ecos/version.py
  '';

  propagatedBuildInputs = [
    numpy
    scipy
  ];

  checkInputs = [ nose ];
  checkPhase = ''
    # Run tests
    cd ./src
    nosetests test_interface.py test_interface_bb.py
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
