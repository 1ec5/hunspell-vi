#!/bin/bash
# Build config for build.sh
APP_NAME=vi_dictionary
CHROME_PROVIDERS=
CLEAN_UP=0
ROOT_FILES="CHANGELOG LICENSE gpl.txt"
ROOT_DIRS="../dictionaries"
VAR_FILES="install.rdf install.js CHANGELOG"
#'*CVS*'
PRUNE_DIRS="*.svn*"
BEFORE_BUILD=
AFTER_BUILD=
