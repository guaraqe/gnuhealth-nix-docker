with import ./nix;

mkShell {
  buildInputs = [
    nodePackages.npm
    node2nix
    bower2nix
    just
    flyctl
  ];
}
