#!/usr/bin/env sh

# This script is used for testing using Travis-CI
# It is intended to work on their VM set up: Ubuntu 16.04 LTS
# As such, the nature of the system is hard-coded
# A minimal current TL is installed adding only the packages that are
# required

# See if there is a cached version of TL available
export PATH=/tmp/texlive/bin/x86_64-linux:$PATH
if ! command -v texlua > /dev/null; then
  # Obtain TeX Live
  wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
  tar -xzf install-tl-unx.tar.gz
  cd install-tl-20*

  # Install a minimal system
  ./install-tl --profile=../texlive.profile

  cd ..
fi

# Keep no backups (not required, simply makes cache bigger)
tlmgr option -- autobackup 0

# Update tlmgr itself then all installed packages
tlmgr update --self --all --no-auto-install

# l3build itself
tlmgr install l3build

# Required to build plain and LaTeX formats:
# TeX90 plain for unpacking
tlmgr install latex-bin tex xetex

# Metafont
tlmgr install metafont mfware

# Required for typsesetting docs
tlmgr install \
  alphalph  \
  amsfonts  \
  amsmath   \
  booktabs  \
  colortbl  \
  csquotes  \
  ec        \
  enumitem  \
  fancyvrb  \
  hologo    \
  hyperref  \
  makeindex \
  oberdiek  \
  psnfss    \
  tools     \
  underscore
