/*
 *	marvin command: compile tex filename.tga
 */
func string CC_CompileTex (var string param) {
	param = STR_TrimChar(param, CHR_SPACE);

	var string fileName;

	var int count; count = STR_SplitCount(param, STR_SPACE);
	if (count > 0) {
		fileName = STR_Split(param, STR_SPACE, 0);
	} else {
		return "You have to specify texture name.";
	};

	var int retVal;

	//0x005CAA20 private: static int __cdecl zCTexture::ConvertTexture(class zSTRING const &)
	const int zCTexture__ConvertTexture_G1 = 6072864;

	//0x005F59F0 private: static int __cdecl zCTexture::ConvertTexture(class zSTRING const &)
	const int zCTexture__ConvertTexture_G2 = 6248944;

	CALL_PutRetValTo(_@(retVal));
    CALL_zStringPtrParam(fileName);
    CALL__cdecl(MEMINT_SwitchG1G2(zCTexture__ConvertTexture_G1, zCTexture__ConvertTexture_G2));

	if (!retVal) {
		return "Not successfull - please check if file exists.";
	};

	return "Success!";
};

func void CC_CompileTex_Init () {
	CC_Register (CC_CompileTex, "compile tex", "compiles texture.");
};
