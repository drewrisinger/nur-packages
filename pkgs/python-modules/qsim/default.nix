{ lib
, buildPythonPackage
, fetchFromGitHub
, fetchpatch
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
, cuquantum
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
    # following 2 patches from https://github.com/quantumlib/qsim/pull/512/
    (fetchpatch {
      name = "remove-test-requirements-from-install.patch";
      url = "https://github.com/quantumlib/qsim/commit/55d59b3f51b882ee1d72f969868c0391143ae281.patch";
      sha256 = "sha256-an/pjWyPvs4Us3bFIzRBChMWoQ6PFZ4RtnNS+SBdKVc=";
    })
    (fetchpatch {
      name = "use-system-pybind11-library.patch";
      url = "https://github.com/quantumlib/qsim/commit/6dbc82f3140271364d4e5b9172b41d6cf6a568ae.patch";
      sha256 = "sha256-BX8CJs5tpOVfBtPvl4IVISH2kFj1SNJ1qnGJgYJyfLo=";
    })
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
