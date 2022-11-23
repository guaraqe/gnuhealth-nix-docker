self: pkgs:

{
  bower2nix =
    pkgs.callPackage ./bower2nix.nix {};

  node2nix =
    pkgs.callPackage ./node2nix.nix {};

  tryton-sao =
    pkgs.callPackage ./tryton-sao {};

  trytond = modules:
    self.python39Packages.callPackage ./trytond.nix { inherit modules; };

  trytond-modules =
    pkgs.callPackages ./trytond-modules.nix {};
}
