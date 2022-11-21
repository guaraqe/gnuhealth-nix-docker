{ pkgs }:
let
  src = pkgs.fetchFromGitHub {
    owner = "guaraqe";
    repo = "bower2nix";
    rev = "5ddf92ff9346df87a7955545b6faaa473d4ce842";
    hash = "sha256-9KQESlyFolvpQgkI+cxclOb1MhibPF8SPk/VahQduW8=";
  };
in
  import "${src}/release.nix" { inherit pkgs; }
