{ lib
, buildPythonPackage
, pythonOlder
, fetchFromGitHub
, fetchpatch
, google_api_python_client
, matplotlib
, networkx
, numpy
, pandas
, pythonProtobuf  # pythonPackages.protobuf
, requests
, scipy
, sortedcontainers
, sympy
, typing-extensions
  # test inputs
, pytestCheckHook
, pytest-asyncio
, pytest-benchmark
, ply
, pydot
, pyyaml
, pygraphviz
}:

buildPythonPackage rec {
  pname = "cirq";
  version = "0.7.0";

  disabled = pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "quantumlib";
    repo = "cirq";
    rev = "v${version}";
    sha256 = "10hakw87vf5glrc5x4wcnx6v4a8zp0v317mv29al6iihxgr2cglh";
  };

  patches = [
    (fetchpatch {
      name = "unpin-sympy";
      url = "https://github.com/quantumlib/Cirq/commit/28a8aac5b6226e8e0772d9ef0e121d4205b5f9fc.patch";
      sha256 = "00sx0nwjz6gnj8d1wyl14r7c68d44ygygggimjdijp6hy43g9x0w";
    })
    (fetchpatch {
      name = "unpin-networkx";
      url = "https://github.com/quantumlib/Cirq/commit/c54066b55e40d563bcf2d9343553d47214c1c65f.patch";
      sha256 = "1lm1h6513zdcvqy2wpgfz7cmy3ii5h490aya7942bfs931p0mz0g";
    })
  ];

  # Cirq locks protobuf==3.8.0, but tested working with default pythonPackages.protobuf (3.7). This avoids overrides/pythonPackages.protobuf conflicts
  postPatch = ''
    substituteInPlace requirements.txt --replace "protobuf==3.8.0" "protobuf"
  '';

  propagatedBuildInputs = [
    google_api_python_client
    numpy
    matplotlib
    networkx
    pandas
    pythonProtobuf
    requests
    scipy
    sortedcontainers
    sympy
    typing-extensions
  ];

  doCheck = true;
  # pythonImportsCheck = [ "cirq" "cirq.Ciruit" ];  # cirq's importlib hook doesn't work here
  dontUseSetuptoolsCheck = true;
  checkInputs = [
    pytestCheckHook
    pytest-asyncio
    pytest-benchmark
    ply
    pydot
    pyyaml
    pygraphviz
  ];
  # TODO: enable op_serializer_test. Error is type checking, for some reason wants bool instead of numpy.bool_. Not sure if protobuf or internal issue
  pytestFlagsArray = [
    "--ignore=dev_tools"  # Only needed when developing new code, which is out-of-scope
    "--ignore=cirq/google/op_serializer_test.py"  # investigating in https://github.com/quantumlib/Cirq/issues/2727
  ];

  meta = with lib; {
    description = "A framework for creating, editing, and invoking Noisy Intermediate Scale Quantum (NISQ) circuits.";
    homepage = "https://github.com/quantumlib/cirq";
    license = licenses.asl20;
    # maintainers = with maintainers; [ drewrisinger ];
  };
}
