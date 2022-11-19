let
  pkgsHash = "f42a45c015f28ac3beeb0df360e50cdbf495d44b";
  pkgsSrc = fetchTarball "https://github.com/NixOS/nixpkgs/archive/${pkgsHash}.tar.gz";
  pkgs = import pkgsSrc {};
in

with import ./nix/modules.nix;

pkgs.python39Packages.callPackage ./nix/trytond.nix {
  modules = map mkBaseModule [
    {
      name = "account";
      version = "6.4.4";
    }
    {
      name = "company";
      version = "6.4.1";
    }
    {
      name = "country";
      version = "6.4.2";
    }
    {
      name = "currency";
      version = "6.4.2";
    }
    {
      name = "party";
      version = "6.4.2";
    }
  ];
}
