#!/bin/bash

kinit -kt /entry/jierans.keytab jierans@FNAL.GOV
kx509
voms-proxy-init -rfc -noregen -voms dune:/dune/Role=Analysis -valid 24:00
echo "done"
source /entry/bashrc
exec "$@"