{ lib
, buildPythonPackage
, fetchFromGitHub
, pythonOlder
, absl-py
, cmake
, cirq-core
, numpy
, pybind11
, typing-extensions
, withCuda ? false
, cudatoolkit
, withCuQuantum ? false
, cuquantum ? null
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "qsim";
  version = "0.12.0";
  format = "setuptools";
  disabled = pythonOlder "3.3";

  src = fetchFromGitHub {
    owner = "quantumlib";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-2/Qgq0WdmUm0FU2b+BCu7WHP+KuxCLSZIQgz6+3Ropo=";
  };
  patches = [
    ./0001-disable-pybind-fetch.patch
  ];

  nativeBuildInputs = [ cmake pybind11 ];

  buildInputs = lib.optionals withCuda [ cudatoolkit ] ++ lib.optionals withCuQuantum [ cuquantum ];

  propagatedBuildInputs = [
    absl-py
    cirq-core
    numpy
    typing-extensions
  ];
  dontUseCmakeConfigure = true; # use python's setup instead

  checkInputs = [ pytestCheckHook ];

  pytestFlagsArray = [
    "--import-mode=append"  # force finding qsimcirq package in system path instead of local (build) path
    "-rfEs"
  ];
  preCheck = ''
    export TESTDIR=$(mktemp -d)
    cp -r qsimcirq_tests $TESTDIR
    pushd $TESTDIR
  '';
  postCheck = ''
    popd
  '';
  # TODO: check cuquantum/cuda are properly working.
  # python -c "import qsimcirq; qsimcirq.QsimSimulator(qsim_options=qsimcirq.QSimOptions(use_gpu=True));" # fails due to importlib issues w/ cirq...


  meta = with lib; {
    description = "Schrödinger and Schrödinger-Feynman simulators for quantum circuits";
    homepage = "https://github.com/quantumlib/qsim";
    maintainers = with maintainers; [ drewrisinger ];
    license = licenses.asl20;
  };
}
