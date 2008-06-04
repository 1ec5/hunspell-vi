#!/bin/bash
# Build config for build.sh
APP_NAME=vi_dictionary
CHROME_PROVIDERS=
CLEAN_UP=1
ROOT_FILES="CHANGELOG LICENSE"
ROOT_DIRS="dictionaries"
VAR_FILES="install.rdf CHANGELOG"
VERSION="1.0.0.$REV_NUM"
#'*CVS*'
PRUNE_DIRS="*.svn*"
BEFORE_BUILD=
AFTER_BUILD=
