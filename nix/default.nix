let
  hash = "f42a45c015f28ac3beeb0df360e50cdbf495d44b";
  url = "https://github.com/NixOS/nixpkgs/archive/${hash}.tar.gz";
  overlay = import ./overlay.nix;
in
  import (fetchTarball url) {
    overlays = [overlay];
  }
