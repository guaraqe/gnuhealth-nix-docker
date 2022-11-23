let
  pkgs = import ./nix;
  trytond = import ./release.nix;
  pgstring = (pkgs.lib.importJSON ./secrets.json).pgstring;
  start = pkgs.writeShellScript "start.sh" ''
    set -euo pipefail

    echo "Exporting variables..."
    export TRYTOND_DATABASE__URI=${pgstring}
    export TRYTONPASSFILE=/data/passfile

    echo "Creating the database if necessary..."
    psql $TRYTOND_DATABASE__URI/postgres -tc "SELECT 1 FROM pg_database WHERE datname = 'health'" |
      grep -q 1 ||
      psql $TRYTOND_DATABASE__URI/postgres -c "CREATE DATABASE health"

    echo "Setting up admin..."
    trytond-admin --all --database=health --email=juanrapha@gmail.com --password
    echo "Starting..."
    trytond
  '';

in

pkgs.dockerTools.buildImage {
  name = "gnuhealth-nix";
  tag = "latest";

  contents = [
    pkgs.coreutils
    pkgs.bashInteractive
    pkgs.postgresql
    pkgs.gnugrep
    trytond
  ];

  runAsRoot = ''
    # Password file
    mkdir -p /data
    echo "admin" > /data/passfile

    # Bash
    chmod 777 /bin/bash
    rm /bin/sh
    ln -s /bin/bash /bin/sh
  '';

  config = {
    Env = [
      "FONTCONFIG_FILE=${pkgs.fontconfig.out}/etc/fonts/fonts.conf"
      "PATH=/bin"
    ];
    Cmd = [ start ];
    ExposedPorts = {
      "8000" = {};
    };
  };
}
