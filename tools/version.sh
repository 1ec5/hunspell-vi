#!/bin/bash

BLOB=($(git show --pretty='format:%h %at' | head -n 1))
if [ $BLOB ]; then
  REV_DATE=$(date -r ${BLOB[1]} '+%A, %B %e, %Y')
  REV_YEAR=$(date -r ${BLOB[1]} +%Y)
  BLOB=${BLOB[0]}
fi
TAGS=$(git describe $BLOB)
TAGS=(${TAGS//-/ })
if [ $TAGS ]; then
  VERSION=${TAGS[0]/#v/}
  if [ ${TAGS[1]} ]; then
    VERSION=$VERSION.${TAGS[1]}
  fi
fi
