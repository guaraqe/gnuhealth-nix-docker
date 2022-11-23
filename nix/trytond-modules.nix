{ lib }:

let
  # Base modules are packaged one by one
  trytonUrl = "https://downloads-cdn.tryton.org";

  toShortVersion = version:
    let
      parts = lib.strings.splitString "." version;
    in
      "${builtins.elemAt parts 0}.${builtins.elemAt parts 1}";

  mkBaseModule = {name, version}: {
    name = name;
    path = fetchTarball "${trytonUrl}/${toShortVersion version}/trytond_${name}-${version}.tar.gz";
  };

  # GNUHealth modules are found together in the same tarball
  healthUrl = "https://ftp.gnu.org/gnu/health";

  healthSrc = version: fetchTarball "${healthUrl}/gnuhealth-${version}.tar.gz";

  mkHealthModule = version: name: {
    name = name;
    path = "${healthSrc version}/${name}";
  };

in

{ inherit mkBaseModule mkHealthModule; }
