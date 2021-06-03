{ lib
, buildPythonPackage
, fetchFromGitHub
, pytestCheckHook
}:

buildPythonPackage rec {
  pname = "pyvisa";
  version = "1.11.3";

  src = fetchFromGitHub {
    owner = "pyvisa";
    repo = "pyvisa";
    rev = version;
    sha256 = "sha256-Qe7W1zPI1aedLDnhkLTDPTa/lsNnCGik5Hu+jLn+meA=";
  };

  checkInputs = [ pytestCheckHook ];
  dontUseSetuptoolsCheck = true;

  meta = with lib; {
    description = "A python library with bindings to the VISA library.";
    longDescription = ''
      A Python package with bindings to the "Virtual Instrument Software Architecture" VISA library,
      in order to control measurement devices and test equipment via GPIB, RS232, or USB.
    '';
    homepage = "https://pyvisa.readthedocs.io";
    downloadPage = "https://github.com/pyvisa/pyvisa/releases";
    license = licenses.mit;
    maintainers = maintainers.drewrisinger;
  };
}

