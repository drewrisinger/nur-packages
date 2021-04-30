{ lib
, pythonOlder
, buildPythonPackage
, fetchFromGitHub
, msgpack
, python-rapidjson
, pyzmq
, ruamel_yaml
  # Check Inputs
, pytestCheckHook
, numpy
, pytest-asyncio
, pytestcov
}:

buildPythonPackage rec {
  pname = "rpcq";
  version = "3.9.0";

  disabled = pythonOlder "3.6";

  src = fetchFromGitHub {
    owner = "rigetti";
    repo = pname;
    rev = "v${version}";
    sha256 = "11b2w5ql03j3sa1f2xamp6ivx1imq4b6pglp900q4c7nxjsmzh7b";
  };

  propagatedBuildInputs = [
    msgpack
    python-rapidjson
    pyzmq
    ruamel_yaml
  ];

  postPatch = ''
    substituteInPlace setup.py --replace "msgpack>=0.6,<1.0" "msgpack"
  '';

  dontUseSetuptoolsCheck = true;
  checkInputs = [
    pytestCheckHook
    numpy
    pytest-asyncio
    pytestcov
  ];

  meta = with lib; {
    description = "A library for quantum programming using Quil.";
    homepage = "https://docs.rigetti.com/en/";
    license = licenses.asl20;
    maintainers = with maintainers; [ drewrisinger ];
  };
}
