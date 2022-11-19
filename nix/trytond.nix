# Modified from https://github.com/NixOS/nixpkgs/blob/nixos-22.05/pkgs/development/python-modules/trytond/default.nix

{ modules
, extraDependencies ? []
  # Nixpkgs
, python
, lib
, buildPythonPackage
, fetchPypi
, pythonOlder
  # Python
#, beren # DICOM, images
, caldav
, configparser
, defusedxml
, genshi
, gevent
, html2text
, ldap
, lxml
, magic
, matplotlib
, numpy
, passlib
, pendulum
, pillow
, polib
, progressbar
, psycopg2
, pycountry
, pydot
, python-Levenshtein
, python-barcode
, python-dateutil
, python-sql
, python-stdnum
, pytz
, qrcode
, relatorio
, simpleeval
, six
, unoconv
, vobject
, weasyprint
, werkzeug
, wrapt
}:

let
  version = "6.4.8";

  installModule = {name, path}: ''
    echo "Installing module ${name}..."
    mkdir -p $out/lib/python3.9/site-packages/trytond/modules/${name}
    cp -r ${path}/* $out/lib/python3.9/site-packages/trytond/modules/${name}
  '';
in

buildPythonPackage rec {
  pname = "trytond";
  inherit version;
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-c7THTkYzg5KmYSK/scCMYN1BRrTTUYcrq5/aS0XjWVs=";
  };

  propagatedBuildInputs = [
    #beren
    caldav
    configparser
    defusedxml
    genshi
    gevent
    html2text
    ldap
    lxml
    magic
    matplotlib
    numpy
    passlib
    pendulum
    pillow
    polib
    progressbar
    psycopg2
    pycountry
    pydot
    python-Levenshtein
    python-barcode
    python-dateutil
    python-sql
    (python-stdnum.overrideAttrs (attrs: { installCheckPhase = ":"; }))
    pytz
    qrcode
    relatorio
    simpleeval
    six
    unoconv
    vobject
    weasyprint
    werkzeug
    wrapt
  ] ++ relatorio.optional-dependencies.fodt
    ++ passlib.optional-dependencies.bcrypt
    ++ passlib.optional-dependencies.argon2
    ++ extraDependencies;

	postInstall =
    lib.strings.concatMapStrings installModule modules;

  checkPhase = ''
#    runHook preCheck
#
#    export HOME=$(mktemp -d)
#    export TRYTOND_DATABASE_URI="sqlite://"
#    export DB_NAME=":memory:";
#    ${python.interpreter} -m unittest discover -s trytond.tests
#
#    runHook postCheck
  '';

  meta = with lib; {
    description = "The server of the Tryton application platform";
    longDescription = ''
      The server for Tryton, a three-tier high-level general purpose
      application platform under the license GPL-3 written in Python and using
      PostgreSQL as database engine.

      It is the core base of a complete business solution providing
      modularity, scalability and security.
    '';
    homepage = "http://www.tryton.org/";
    changelog = "https://hg.tryton.org/trytond/file/${version}/CHANGELOG";
    license = licenses.gpl3Plus;
    maintainers = with maintainers; [ udono johbo ];
  };
}
