// Installation script for SeaMonkey

// Prompt the user to allow the installation of this extension.
var result = initInstall("Vietnamese Dictionary", "dictionary@vi.mozdev.org",
						 "${VERSION}");
if (result != SUCCESS) cancelInstall();

// Place the contents of the enclosed dictionaries/ directory under the program
// installation folder.
var progFolder = getFolder("Program");
result = addDirectory("", "dictionary@vi.mozdev.org", "dictionaries",
					  progFolder, "dictionaries", true);
if (result != SUCCESS) cancelInstall();
performInstall();
