{ lib
, buildPythonApplication
, pythonOlder
, fetchPypi
  # test inputs
, pytestCheckHook
}:

buildPythonApplication rec {
  pname = "tuna";
  version = "0.5.6";
  format = "pyproject";

  disabled = pythonOlder "3.6";

  # Use PyPi b/c some Javascript files aren't included in GitHub checkout
  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-H/i0Jr5Lw4nzXk0j/u3Yht3Z/35FeXBL7/SSswQodTM=";
  };

  dontUseSetuptoolsCheck = true;
  checkInputs = [ pytestCheckHook ];
  preCheck = "export PATH=$out/bin:$PATH";

  meta = with lib; {
    description = "Python profile viewer";
    homepage = "https://github.com/nschloe/tuna";
    changelog = "https://github.com/nschloe/tuna/releases/tag/v${version}";
    license = licenses.gpl3;   # gpl3Only
    maintainers = with maintainers; [ drewrisinger ];
  };
}
