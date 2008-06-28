#!/bin/bash

ROOT_DIR=`pwd`
TMP_DIR=build
REV_NUM=`svn info -R|grep '^Last Changed Rev'|sort -nr|head -1|cut -f 4 -d" "`
VERSION=1.$REV_NUM
APP_NAME=vi_spellchecker_OOo3
ROOT_DIRS=" META-INF"
ROOT_FILES="description.xml dictionaries.xcu LICENCES-vi.txt LICENSES-en.txt "
VAR_FILES=description.xml
#uncomment to debug
#set -x

# remove any left-over files from previous build
rm -f $APP_NAME.xpi
rm -rf $TMP_DIR

# prepare components and defaults
echo "Copying various files to $TMP_DIR folder..."
for DIR in $ROOT_DIRS; do
  cp -rpv $DIR $TMP_DIR/
  rm -rf `find $TMP_DIR/ \( -name ".svn" -type d \) -o \( -name ".DS_Store" -type f \)`
done

# Copy other files to the root of future XPI.
for ROOT_FILE in $ROOT_FILES ; do
  cp -v $ROOT_FILE $TMP_DIR
done

mkdir $TMP_DIR/dictionaries

cp ../../dictionaries/vi-x-New.dic $TMP_DIR/dictionaries/vi_VN.dic 
cp ../../dictionaries/vi-x-New.aff  $TMP_DIR/dictionaries/vi_VN.aff 
cp ../../dictionaries/CHANGELOG  $TMP_DIR/dictionaries/CHANGELOG

cd $TMP_DIR

if [ -n "$VAR_FILES" ]; then
  REV_DATE=`date -u '+%A, %B %e, %Y'`
  REV_YEAR=`date -u '+%Y'`
  echo "Substituting variables for version $VERSION, build r$REV_NUM on \
$REV_DATE..."
  for VAR_FILE in $VAR_FILES; do
    if [ -f $VAR_FILE ]; then
      perl -pi -e "s/SPELLCHECKERVERSION/$VERSION/" $VAR_FILE
    fi
  done
fi

# generate the OXT  file
echo "Generating $APP_NAME.oxt..."
rm ../$APP_NAME.oxt
zip -r ../$APP_NAME.oxt *

cd "$ROOT_DIR"

# remove the working files
rm -rf $TMP_DIR
echo "Done!"

