/*
 *	Taken from LeGo Binary Machines.
 *
 *	Tests files within Gothic root folder. For example:

	if (FileExists ("DATA\TEXTURES_BIKINI.VDF")) {
		PrintS ("File exists.");
	} else {
		PrintS ("You naughty !");
	};
*/

func int FileExists (var string filePath) {
	var int b; b = WIN_CreateFile (filePath, GENERIC_READ, FILE_SHARE_READ | FILE_SHARE_WRITE | FILE_SHARE_DELETE, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

	if (b == -1) {
		return FALSE;
	};

	WIN_CloseHandle (b);
	return TRUE;
};
