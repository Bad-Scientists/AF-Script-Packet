/*
 *	Export/Import vob
 *	- allows you to export/import vobs in focus to/from EXPORTED_VOBS.ZEN file
 */

func string CC_ExportFocusVob (var string param) {
	var oCNpc her; her = Hlp_GetNpc (hero);
	if (!her.focus_vob) { return "There is nothing in the focus."; };

	//Remove horcruxes
	if (Hlp_Is_oCItem(her.focus_vob)) {
		zCVob_SetAI(her.focus_vob, 0);
	};

	var string filePath;
	var string fileName; fileName = "EXPORTED_VOBS.ZEN";

	//_work\Data\Worlds\
	filePath = zCOption_GetDirString(MEMINT_SwitchG1G2(DIR_G1_WORLD, DIR_G2_WORLD));
	filePath = ConcatStrings(filePath, fileName);

	Wld_ExportVobPtr(her.focus_vob, filePath, 1);
	return "Done.";
};

func string CC_ImportFocusVob (var string param) {
	var string filePath;
	var string fileName; fileName = "EXPORTED_VOBS.ZEN";

	//_work\Data\Worlds\
	filePath = zCOption_GetDirString(MEMINT_SwitchG1G2(DIR_G1_WORLD, DIR_G2_WORLD));
	filePath = ConcatStrings(filePath, fileName);

	var int arrPtr; arrPtr = Wld_ImportVobPtr(filePath); //function creates an array
	if (!arrPtr) { return "Nothing was imported."; };
	if (arrPtr) { MEM_ArrayFree(arrPtr); arrPtr = 0; };
	return "Done.";
};

func void CC_Focus_ExportImport_Init () {
	CC_Register(CC_ExportFocusVob, "focus export", "Will export object in focus to _work\Data\Worlds\EXPORTED_VOBS.ZEN file.");
	CC_Register(CC_ImportFocusVob, "focus import", "Will import _work\Data\Worlds\EXPORTED_VOBS.ZEN file to the world.");
};
