#!/bin/bash

pkgs=(build-essential bison yacc gawk coreutils make m4 texinfo)
sudo apt-get -y --ignore-missing install "${pkgs[@]}"
