#!/bin/bash

# raco pollen render style.css.pp
# raco pollen render index.html.p
pushd ymer/brage/
rm -rfv index.html
racket make-page-tree.rkt
raco pollen render index.ptree
raco pollen render *.pm
popd
raco pollen publish ymer docs
