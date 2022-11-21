{ pkgs }:
let
  # Actually hosted on Mercurial
  src = pkgs.fetchFromGitHub {
    owner = "guaraqe";
    repo = "sao";
    rev = "f8f03f51beaa899dfaa3a38ef53a0dc3a3f381a4";
    hash = "sha256-6x8OWOb/4Q2ezG5RORaocu2VbEvtegJ9zBTstNPx7QE=";
  };

  name = "tryton-sao";

  nodeDependencies = (pkgs.callPackage src {}).nodeDependencies;

  bowerComponents = pkgs.buildBowerComponents {
    inherit name src;
    generated = ./bower-packages.nix;
  };

  tryton-sao = pkgs.stdenv.mkDerivation {
    inherit name src;
    buildInputs = [pkgs.nodejs];
    buildPhase = ''
      ln -s ${nodeDependencies}/lib/node_modules ./node_modules
      export PATH="${nodeDependencies}/bin:$PATH"
      cp --reflink=auto --no-preserve=mode -R ${bowerComponents}/bower_components .
      npx grunt
    '';
    installPhase = ''
      mkdir -p $out
      cp -r bower_components $out
      cp -r dist $out
      cp -r images $out
      cp index.html $out
    '';
  };

in
  tryton-sao
