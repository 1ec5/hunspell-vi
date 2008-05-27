var err = initInstall("Vietnamese Dictionary", "dictionary@vi.mozdev.org", "1.0");
if (err != SUCCESS) cancelInstall();

var fProgram = getFolder("Program");
err = addDirectory("", "dictionary@vi.mozdev.org", "dictionaries", fProgram,
				   "dictionaries", true);
if (err != SUCCESS) cancelInstall();

performInstall();
