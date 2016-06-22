#!/bin/bash
# build.sh -- builds JAR and XPI files for mozilla extensions
#   by Nickolay Ponomarev <asqueella@gmail.com>
#   (original version based on Nathan Yergler's build script)
# Most recent version is at <http://kb.mozillazine.org/Bash_build_script>

# This script assumes the following directory structure:
# ./
#   chrome.manifest (optional - for newer extensions)
#   install.js
#   install.rdf
#   (other files listed in $ROOT_FILES)
#
#   content/    |
#   locale/     |} these can be named arbitrary and listed in $CHROME_PROVIDERS
#   skin/       |
#
#   defaults/   |
#   components/ |} these must be listed in $ROOT_DIRS in order to be packaged
#   ...         |
#
# It uses a temporary directory ./build when building; don't use that!
# Script's output is:
# ./$APP_NAME.xpi
# ./$APP_NAME.jar  (only if $KEEP_JAR=1)
# ./files -- the list of packaged files
#
# Note: It modifies chrome.manifest when packaging so that it points to 
#       chrome/$APP_NAME.jar!/*

#
# default configuration file is ./config_build.sh, unless another file is 
# specified in command-line. Available config variables:
APP_NAME=          # short-name, jar and xpi files name. Must be lowercase with no spaces
CHROME_PROVIDERS=  # which chrome providers we have (space-separated list)
CLEAN_UP=          # delete the jar / "files" when done?       (1/0)
ROOT_FILES=        # put these files in root of xpi (space separated list of leaf filenames)
ROOT_DIRS=         # ...and these directories       (space separated list)
VAR_FILES=         # files that need variable substitution (space separated list)
PRUNE_DIRS=	       # exclude files with these directories in their paths (space separated list)
BEFORE_BUILD=      # run this before building       (bash command)
AFTER_BUILD=       # ...and this after the build    (bash command)

if [ -z $1 ]; then
  . ./config_build.sh
else
  . $1
fi

if [ -z $APP_NAME ]; then
  echo "You need to create build config file first!"
  echo "Read comments at the beginning of this script for more info."
  exit;
fi

. ../tools/version.sh

ROOT_DIR=`pwd`
TMP_DIR=build

#uncomment to debug
#set -x

# remove any left-over files from previous build
rm -f $APP_NAME.jar $APP_NAME.xpi files
rm -rf $TMP_DIR

$BEFORE_BUILD

mkdir -pv $TMP_DIR/

# generate the JAR file, excluding CVS and temporary files
JAR_FILE=$TMP_DIR/chrome/$APP_NAME.jar
echo "Generating $JAR_FILE..."
for CHROME_SUBDIR in $CHROME_PROVIDERS; do
  find $CHROME_SUBDIR -path $PRUNE_DIRS -prune -o -type f -print | grep -v \~ >> files
done

# zip -0 -r $JAR_FILE `cat files`
# The following statement should be used instead if you don't wish to use the JAR file
#cp --verbose --parents `cat files` $TMP_DIR/chrome

# prepare components and defaults
echo "Copying various files to $TMP_DIR folder..."
for DIR in $ROOT_DIRS; do
  cp -rpv $DIR $TMP_DIR/
  rm -rf `find $TMP_DIR/ \( -name ".git" -type d \) -o \( -name ".svn" -type d \) -o \( -name ".DS_Store" -type f \)`
#  mkdir $TMP_DIR/$DIR
#  FILES="`find $DIR -path '*CVS*' -prune -o -type f -print | grep -v \~`"
#  echo $FILES >> files
#  cp --verbose --parents $FILES $TMP_DIR
done

# Copy other files to the root of future XPI.
for ROOT_FILE in $ROOT_FILES install.rdf install.js chrome.manifest; do
  cp -v $ROOT_FILE $TMP_DIR
  if [ -f $ROOT_FILE ]; then
    echo $ROOT_FILE >> files
  fi
done

cd $TMP_DIR

if [ -n "$VAR_FILES" ]; then
  echo "Substituting variables for version $VERSION, commit $BLOB on \
$REV_DATE..."
  for VAR_FILE in $VAR_FILES; do
    if [ -f $VAR_FILE ]; then
      perl -pi -e "s/\x24\x7BBlob\x7D/$BLOB/" $VAR_FILE
      perl -pi -e "s/\x24\x7BVersion\x7D/$VERSION/" $VAR_FILE
      perl -pi -e "s/\x24\x7BDate\x7D/$REV_DATE/" $VAR_FILE
      perl -pi -e "s/\x24\x7BYear\x7D/$REV_YEAR/" $VAR_FILE
    fi
  done
fi

if [ -f "chrome.manifest" ]; then
  echo "Preprocessing chrome.manifest..."
  # You think this is scary?
  #s/^(content\s+\S*\s+)(\S*\/)$/\1jar:chrome\/$APP_NAME\.jar!\/\2/
  #s/^(skin|locale)(\s+\S*\s+\S*\s+)(.*\/)$/\1\2jar:chrome\/$APP_NAME\.jar!\/\3/
  #
  # Then try this! (Same, but with characters escaped for bash :)
#  sed -i -r s/^\(content\\s+\\S*\\s+\)\(\\S*\\/\)$/\\1jar:chrome\\/$APP_NAME\\.jar!\\/\\2/ chrome.manifest
#  sed -i -r s/^\(skin\|locale\)\(\\s+\\S*\\s+\\S*\\s+\)\(.*\\/\)$/\\1\\2jar:chrome\\/$APP_NAME\\.jar!\\/\\3/ chrome.manifest
  perl -pi -e "s/^(content\s+\S*\s+)(\S*\/)$/\1jar:chrome\/$APP_NAME\.jar\!\/\2/" chrome.manifest
  perl -pi -e "s/^(skin|locale)(\s+\S*\s+\S*\s+)(.*\/)$/\1\2jar:chrome\/$APP_NAME\.jar!\/\3/" chrome.manifest

  # (it simply adds jar:chrome/whatever.jar!/ at appropriate positions of chrome.manifest)
fi

# generate the XPI file
echo "Generating $APP_NAME.xpi..."
zip -r ../$APP_NAME.xpi *

cd "$ROOT_DIR"

echo "Cleanup..."
if [ $CLEAN_UP = 0 ]; then
  # save the jar file
#  mv $TMP_DIR/chrome/$APP_NAME.jar .
  echo
else
  rm ./files
fi

if [ $CLEAN_UP = 0 ]; then
  echo
else
  echo "Cleanup..."
  # remove the working files
  rm -rf $TMP_DIR
fi
echo "Done!"

$AFTER_BUILD
