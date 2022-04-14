{ lib
, buildPythonPackage
, fetchFromGitHub
, tket
}:

buildPythonPackage rec {
  pname = "pytket";
  inherit (tket) version src;

  sourceRoot = "pytket";

  propagatedBuildInputs = [ ];
}
