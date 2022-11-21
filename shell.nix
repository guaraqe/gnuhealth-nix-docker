with import ./nix/nixpkgs.nix;

mkShell {
  buildInputs = [
    nodePackages.npm
    #nodePackages.bower2nix XXX
    #node2nix XXX
  ];
}
