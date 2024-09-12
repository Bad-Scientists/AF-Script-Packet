/*
 *	Fonts
 *	 - implementation for Font_GetStringWidth --> replacement for Print_GetStringWidth
 *	 - Font_GetStringWidth returns 'pixel perfect' width len for string
 */

func int zCFont_GetLetterDistance (var int fontPtr) {
	//0x006E0250 public: int __thiscall zCFont::GetLetterDistance(void)
	const int zCFont__GetLetterDistance_G1 = 7209552;

	//0x00789530 public: int __thiscall zCFont::GetLetterDistance(void)
	const int zCFont__GetLetterDistance_G2 = 7902512;

	if (!fontPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall(_@ (fontPtr), MEMINT_SwitchG1G2 (zCFont__GetLetterDistance_G1, zCFont__GetLetterDistance_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int zCFont_GetWidth (var int fontPtr, var int c) {
	//0x006E0240 public: int __thiscall zCFont::GetWidth(char)
	const int zCFont__GetWidth_G1 = 7209536;

	//0x00789520 public: int __thiscall zCFont::GetWidth(char)
	const int zCFont__GetWidth_G2 = 7902496;

	if (!fontPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_IntParam (_@ (c));
		CALL__thiscall (_@ (fontPtr), MEMINT_SwitchG1G2 (zCFont__GetWidth_G1, zCFont__GetWidth_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int zCFont_GetFontY (var int fontPtr) {
	//0x006E0200 public: int __thiscall zCFont::GetFontY(void)
	const int zCFont__GetFontY_G1 = 7209472;

	//0x007894E0 public: int __thiscall zCFont::GetFontY(void)
	const int zCFont__GetFontY_G2 = 7902432;

	if (!fontPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (fontPtr), MEMINT_SwitchG1G2 (zCFont__GetFontY_G1, zCFont__GetFontY_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int zCFont_GetFontData (var int fontPtr, var int c, var int widthPtr, var int vecUV0Ptr, var int vecUV1Ptr) {
	//0x006E1070 public: int __thiscall zCFont::GetFontData(unsigned char,int &,class zVEC2 &,class zVEC2 &)
	const int zCFont__GetFontData_G1 = 7213168;

	//0x0078A390 public: int __thiscall zCFont::GetFontData(unsigned char,int &,class zVEC2 &,class zVEC2 &)
	const int zCFont__GetFontData_G2 = 7906192;

	if (!fontPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL_PtrParam (_@ (vecUV1Ptr));
		CALL_PtrParam (_@ (vecUV0Ptr));
		CALL_PtrParam (_@ (widthPtr));
		CALL_IntParam (_@ (c));
		CALL__thiscall(_@ (fontPtr), MEMINT_SwitchG1G2 (zCFont__GetFontData_G1, zCFont__GetFontData_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Font_GetStringWidthPtr
 *	 - returns 'pixel perfect' string width
 */
func int Font_GetStringWidthPtr (var string s, var int fontPtr) {
	if (!fontPtr) { return 0; };

	var int len; len = STR_Len (s);
	if (!len) { return 0; };

	var int letterDist; letterDist = zCFont_GetLetterDistance(fontPtr);
	var int spaceWidth; spaceWidth = zCFont_GetWidth(fontPtr, CHR_SPACE);

	//Recalc width
	var int buf; buf = STR_toChar (s);

	var int c;
	var int charWidth;
	var int width; width = 0;

	repeat (i, len); var int i;
		c = MEM_ReadInt(buf + i) & 255;

		if (c > 32) {
			charWidth = zCFont_GetWidth (fontPtr, c);
			width += (charWidth + letterDist);
		} else {
			width += spaceWidth;
		};
	end;

	return width;
};

/*
 *	Font_GetStringWidth
 *	 - returns 'pixel perfect' string width
 */
func int Font_GetStringWidth (var string s, var string font) {
    return + Font_GetStringWidthPtr(s, Print_GetFontPtr(font));
};
