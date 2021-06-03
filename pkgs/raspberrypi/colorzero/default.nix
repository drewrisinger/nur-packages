{ buildPythonPackage
, lib
, fetchPypi
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "colorzero";
  version = "1.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "acba47119b5d8555680d3cda9afe6ccc5481385ccc3c00084dd973f7aa184599";
  };

  propagatedBuildInputs = [];

  checkInputs = [ pytestCheckHook ];
  dontUseSetuptoolsCheck = true;  # for nixpkgs < 20.09
  pythonImportsCheck = [ "colorzero" ];
  preCheck = "pushd $TMP/$sourceRoot";
  postCheck = "popd";

  meta = with lib; {
    description = "Yet another python color library";
    homepage = "https://colorzero.readthedocs.io/en/latest/";
    license = licenses.bsd3;
    maintainers = [ maintainers.drewrisinger ];
  };
}
