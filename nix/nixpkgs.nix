let
  hash = "f42a45c015f28ac3beeb0df360e50cdbf495d44b";
  url = "https://github.com/NixOS/nixpkgs/archive/${hash}.tar.gz";
in
  import (fetchTarball url) {}
