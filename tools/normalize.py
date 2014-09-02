#!/usr/bin/env python
# -*- coding: utf-8 -*-

# If the plain text file kieu.txt contains the Vietnamese epic poem Tale of
# Kieu, you can generate letter frequencies on that file with the following
# command:
#   python normalize.py -f kieu.txt -i -w | sed 's/./&~/g' | tr '~' '\012' | \
#       sort -n | uniq -c | sort -n | tail -r -50

import sys, re

ASCII_REPLS = {u"[àảãáạăằẳẵắặâầẩẫấậ]": "a", u"[ÀẢÃÁẠĂẰẲẴẮẶÂẦẨẪẤẬ]": "A",
               u"đ": "d",                   u"Đ": "D",
               u"[èẻẽéẹêềểễếệ]": "e",       u"[ÈẺẼÉẸÊỀỂỄẾỆ]": "E",
               u"[ìỉĩíị]": "i",             u"[ÌỈĨÍỊ]": "I",
               u"[òỏõóọôồổỗốộơờởỡớợ]": "o", u"[ÒỎÕÓỌÔỒỔỖỐỘƠỜỞỠỚỢ]": "O",
               u"[ùủũúụưừửữứự]": "u",       u"[ÙỦŨÚỤƯỪỬỮỨỰ]": "U",
               u"[ỳỷỹýỵ]": "y",             u"[ỲỶỸÝỴ]": "Y"}
VIET_REPLS = {u"[àảãáạ]": u"a",     u"[ÀẢÃÁẠ]": u"A",
              u"[ăằẳẵắặ]": u"ă",    u"[ĂẰẲẴẮẶ]": u"Ă",
              u"[âầẩẫấậ]": u"â",    u"[ÂẦẨẪẤẬ]": u"Â",
              u"[èẻẽéẹ]": u"e",     u"[ÈẺẼÉẸ]": u"E",
              u"[êềểễếệ]": u"ê",    u"[ÊỀỂỄẾỆ]": u"Ê",
              u"[ìỉĩíị]": u"i",     u"[ÌỈĨÍỊ]": u"I",
              u"[òỏõóọ]": u"o",     u"[ÒỎÕÓỌ]": u"O",
              u"[ôồổỗốộ]": u"ô",    u"[ÔỒỔỖỐỘ]": u"Ô",
              u"[ơờởỡớợ]": u"ơ",    u"[ƠỜỞỠỚỢ]": u"Ơ",
              u"[ùủũúụ]": u"u",     u"[ÙỦŨÚỤ]": u"U",
              u"[ưừửữứự]": u"ư",    u"[ƯỪỬỮỨỰ]": u"Ư",
              u"[ỳỷỹýỵ]": u"y",     u"[ỲỶỸÝỴ]": u"Y"}

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
  -a, --ascii               Remove all diacritics from the text, not just tone
                            marks.
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
    src = []
    charset = "utf8"
    ignore_case = False
    skip_punct = False
    is_ascii = False
    
    is_file = False
    is_charset = False
    for arg in sys.argv[1:]:
        if arg in ["-f", "--file"]:
            is_file = True
            continue
        if is_file:
            is_file = False
            f = file(arg, "r")
            lines = [unicode(line, charset) for line in f.readlines()]
            src.extend(lines)
            f.close()
            continue
        
        # Input character encoding
        if arg in ["--charset"]:
            is_charset = True
            continue
        if is_charset:
            charset = arg
            continue
        
        # Output character encoding
        if arg in ["-a", "--ascii"]:
            is_ascii = True
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
        
        src.append(unicode(arg, charset))
    
    repls = ASCII_REPLS if is_ascii else VIET_REPLS
    for regex, repl in repls.iteritems():
        src = [re.sub(regex, repl, line, flags=re.U) for line in src]
    if ignore_case:
        src = [line.lower() for line in src]
    if skip_punct:
        src = [re.sub(r"[\W\d]+", "", line, flags=re.U) for line in src]
        sys.stdout.write("".join(src).encode("utf-8") + "\n")
    else:
        for line in src:
            print line.encode("utf-8"),

if __name__ == "__main__":
    main()
