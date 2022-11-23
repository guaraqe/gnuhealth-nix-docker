{ pkgs }:

let
  node2nixSrc = pkgs.fetchFromGitHub {
    owner = "svanderburg";
    repo = "node2nix";
    rev = "a6041f67b8d4a300c6f8d097289fe5addbc5edf8";
    hash = "sha256-361KP3ys806YgwVIeXw6CrQmdV2ldJ3u95rcZUbI5vY=";
  };
in
  (pkgs.callPackage node2nixSrc {}).package
