#!/usr/bin/env python
# -*- coding: utf-8 -*-

# If the plain text file kieu.txt contains the Vietnamese epic poem Tale of
# Kieu, you can generate letter frequencies on that file with the following
# command:
#   python normalize.py -f kieu.txt -i -w | sed 's/./&~/g' | tr '~' '\012' | \
#       sort -n | uniq -c | sort -n | tail -r -50

import sys, re

REPLS = {u"[àảãáạăằẳẵắặâầẩẫấậ]": "a",   u"[ÀẢÃÁẠĂẰẲẴẮẶÂẦẨẪẤẬ]": "A",
         u"đ": "d",                     u"Đ": "D",
         u"[èẻẽéẹêềểễếệ]": "e",         u"[ÈẺẼÉẸÊỀỂỄẾỆ]": "E",
         u"[ìỉĩíị]": "i",               u"[ÌỈĨÍỊ]": "I",
         u"[òỏõóọôồổỗốộơờởỡớợ]": "o",   u"[ÒỎÕÓỌÔỒỔỖỐỘƠỜỞỠỚỢ]": "O",
         u"[ùủũúụưừửữứự]": "u",         u"[ÙỦŨÚỤƯỪỬỮỨỰ]": "U",
         u"[ỳỷỹýỵ]": "y",               u"[ỲỶỸÝỴ]": "Y"}

def print_help():
    """Prints help information to the command line."""
    print """\
Usage: python normalize.py [OPTIONS]
Remove diacritical marks from Vietnamese text.

Available options:
      --charset CHARSET     Decode all following input with the specified
                            character encoding.
  -f, --file FILE           Insert the contents of the specified plain text
                            file.
  -h, --help                Display this help message.
  -w, --letters,
      --letters-only        Remove all numbers, whitespace, and other characters
                            not in the Vietnamese alphabet.
  -i, --lower,
      --lowercase,
      --lower-case          Force all input to lowercase.

Example: If the plain text file INPUT.txt contains Vietnamese text, you can
generate letter frequencies on that file using the following sequence:
  python normalize.py -f INPUT.txt -i -w | sed 's/./&~/g' | tr '~' '\\012' | \\
    sort -n | uniq -c | sort -n | tail -r\
"""

def main():
    src = ""
    charset = "utf8"
    ignore_case = False
    skip_punct = False
    
    is_file = False
    is_charset = False
    for arg in sys.argv[1:]:
        if arg in ["-f", "--file"]:
            is_file = True
            continue
        if is_file:
            is_file = False
            f = file(arg, "r")
            src += unicode("\n".join(f.readlines()), charset)
            f.close()
            continue
        
        # Character encoding
        if arg in ["--charset"]:
            is_charset = True
            continue
        if is_charset:
            charset = arg
            continue
        
        # Case insensitive
        if arg in ["-i", "--lower", "--lowercase", "--lower-case"]:
            ignore_case = True
            continue
        
        # Ignore all numbers and other non-letters
        if arg in ["-w", "--letters", "--letters-only"]:
            skip_punct = True
            continue
        
        # Print help message
        if arg in ["-h", "--help"]:
            print_help()
            continue
        
        src += unicode(arg, charset) + " "
    
    for repl in REPLS.iteritems():
        src = re.sub(repl[0], repl[1], src)
    if ignore_case:
        src = src.lower()
    if skip_punct:
        src = re.sub("[\W\d]+", "", src)
    print src

if __name__ == "__main__":
    main()
