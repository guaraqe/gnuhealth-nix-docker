let
  trytonShortVersion = "6.4";

  trytonUrl = "https://downloads-cdn.tryton.org/${trytonShortVersion}";

  mkBaseModule = {name, version}: {
    name = name;
    path = fetchTarball "${trytonUrl}/trytond_${name}-${version}.tar.gz";
  };

in

{ inherit mkBaseModule; }
