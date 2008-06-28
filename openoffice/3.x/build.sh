#!/bin/bash

ROOT_DIR=`pwd`
TMP_DIR=build
REV_NUM=`svnversion -n | cat`
VERSION=1.$REV_NUM
APP_NAME=vi_spellchecker_OOo3
ROOT_DIRS="../../dictionaries META-INF"
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
#  mkdir $TMP_DIR/$DIR
#  FILES="`find $DIR -path '*CVS*' -prune -o -type f -print | grep -v \~`"
#  echo $FILES >> files
#  cp --verbose --parents $FILES $TMP_DIR
done

# Copy other files to the root of future XPI.
for ROOT_FILE in $ROOT_FILES ; do
  cp -v $ROOT_FILE $TMP_DIR
  if [ -f $ROOT_FILE ]; then
    echo $ROOT_FILE >> files
  fi
done

cd $TMP_DIR

if [ -n "$VAR_FILES" ]; then
  REV_DATE=`date -u '+%A, %B %e, %Y'`
  REV_YEAR=`date -u '+%Y'`
  echo "Substituting variables for version $VERSION, build r$REV_NUM on \
$REV_DATE..."
  for VAR_FILE in $VAR_FILES; do
    if [ -f $VAR_FILE ]; then
      #perl -pi -e "s/\x24\x7BRev\x7D/$REV_NUM/" $VAR_FILE
      perl -pi -e "s/SPELLCHECKERVERSION/$VERSION/" $VAR_FILE
      #perl -pi -e "s/\x24\x7BDate\x7D/$REV_DATE/" $VAR_FILE
      #perl -pi -e "s/\x24\x7BYear\x7D/$REV_YEAR/" $VAR_FILE
    fi
  done
fi

# generate the OXT  file
echo "Generating $APP_NAME.oxt..."
zip -r ../$APP_NAME.oxt *

cd "$ROOT_DIR"

# remove the working files
rm -rf $TMP_DIR
echo "Done!"

