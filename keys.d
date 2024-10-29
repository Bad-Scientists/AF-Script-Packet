func string GetKeyName (var int key) {
	if (key == KEY_ESCAPE) { return "Escape"; };
	if (key == KEY_1) { return "1"; };
	if (key == KEY_2) { return "2"; };
	if (key == KEY_3) { return "3"; };
	if (key == KEY_4) { return "4"; };
	if (key == KEY_5) { return "5"; };
	if (key == KEY_6) { return "6"; };
	if (key == KEY_7) { return "7"; };
	if (key == KEY_8) { return "8"; };
	if (key == KEY_9) { return "9"; };
	if (key == KEY_0) { return "0"; };
	if (key == KEY_MINUS) { return "-"; };
	if (key == KEY_EQUALS) { return "="; };
	if (key == KEY_BACK) { return "Backspace"; };
	if (key == KEY_TAB) { return "Tab"; };
	if (key == KEY_Q) { return "Q"; };
	if (key == KEY_W) { return "W"; };
	if (key == KEY_E) { return "E"; };
	if (key == KEY_R) { return "R"; };
	if (key == KEY_T) { return "T"; };
	if (key == KEY_Y) { return "Y"; };
	if (key == KEY_U) { return "U"; };
	if (key == KEY_I) { return "I"; };
	if (key == KEY_O) { return "O"; };
	if (key == KEY_P) { return "P"; };
	if (key == KEY_LBRACKET) { return "["; };
	if (key == KEY_RBRACKET) { return "]"; };
	if (key == KEY_RETURN) { return "Enter"; };
	if (key == KEY_LCONTROL) { return "Left Ctrl"; };
	if (key == KEY_A) { return "A"; };
	if (key == KEY_S) { return "S"; };
	if (key == KEY_D) { return "D"; };
	if (key == KEY_F) { return "F"; };
	if (key == KEY_G) { return "G"; };
	if (key == KEY_H) { return "H"; };
	if (key == KEY_J) { return "J"; };
	if (key == KEY_K) { return "K"; };
	if (key == KEY_L) { return "L"; };
	if (key == KEY_SEMICOLON) { return ";"; };
	if (key == KEY_APOSTROPHE) { return "'"; };
	if (key == KEY_GRAVE) { return "`"; };
	if (key == KEY_LSHIFT) { return "Left Shift"; };
	if (key == KEY_BACKSLASH) { return BtoC (92); };
	if (key == KEY_Z) { return "Z"; };
	if (key == KEY_X) { return "X"; };
	if (key == KEY_C) { return "C"; };
	if (key == KEY_V) { return "V"; };
	if (key == KEY_B) { return "B"; };
	if (key == KEY_N) { return "N"; };
	if (key == KEY_M) { return "M"; };
	if (key == KEY_COMMA) { return ","; };
	if (key == KEY_PERIOD) { return "."; };
	if (key == KEY_SLASH) { return "/"; };
	if (key == KEY_RSHIFT) { return "Right Shift"; };
	if (key == KEY_MULTIPLY) { return "*"; };
	if (key == KEY_LMENU) { return "Left Alt"; };
	if (key == KEY_SPACE) { return "Spacebar"; };
//	if (key == KEY_CAPITAL) { return "Escape"; }; ?
	if (key == KEY_F1) { return "F1"; };
	if (key == KEY_F2) { return "F2"; };
	if (key == KEY_F3) { return "F3"; };
	if (key == KEY_F4) { return "F4"; };
	if (key == KEY_F5) { return "F5"; };
	if (key == KEY_F6) { return "F6"; };
	if (key == KEY_F7) { return "F7"; };
	if (key == KEY_F8) { return "F8"; };
	if (key == KEY_F9) { return "F9"; };
	if (key == KEY_F10) { return "F10"; };
	if (key == KEY_NUMLOCK) { return "Num Lock"; };
	if (key == KEY_SCROLL) { return "Scroll Lock"; };
	if (key == KEY_NUMPAD7) { return "Num 7"; };
	if (key == KEY_NUMPAD8) { return "Num 8"; };
	if (key == KEY_NUMPAD9) { return "Num 9"; };
	if (key == KEY_SUBTRACT) { return "Num -"; };
	if (key == KEY_NUMPAD4) { return "Num 4"; };
	if (key == KEY_NUMPAD5) { return "Num 5"; };
	if (key == KEY_NUMPAD6) { return "Num 6"; };
	if (key == KEY_ADD) { return "Num +"; };
	if (key == KEY_NUMPAD1) { return "Num 1"; };
	if (key == KEY_NUMPAD2) { return "Num 2"; };
	if (key == KEY_NUMPAD3) { return "Num 3"; };
	if (key == KEY_NUMPAD0) { return "Num 0"; };
	if (key == KEY_DECIMAL) { return "Num ."; };
//	if (key == KEY_OEM_102) { return "Escape"; }; ?
	if (key == KEY_F11) { return "F11"; };
	if (key == KEY_F12) { return "F12"; };
/*
	if (key == KEY_F13) { return "F13"; };
	if (key == KEY_F14) { return "Escape"; };
	if (key == KEY_F15) { return "Escape"; };
	if (key == KEY_KANA) { return "Escape"; };
	if (key == KEY_ABNT_C1) { return "Escape"; };
	if (key == KEY_CONVERT) { return "Escape"; };
	if (key == KEY_NOCONVERT) { return "Escape"; };
	if (key == KEY_YEN) { return "Escape"; };
	if (key == KEY_ABNT_C2) { return "Escape"; };
	if (key == KEY_NUMPADEQUALS) { return "Escape"; };
	if (key == KEY_PREVTRACK) { return "Escape"; };
	if (key == KEY_AT) { return "Escape"; };
	if (key == KEY_COLON) { return "Escape"; };
	if (key == KEY_UNDERLINE) { return "Escape"; };
	if (key == KEY_KANJI) { return "Escape"; };
	if (key == KEY_STOP) { return "Escape"; };
	if (key == KEY_AX) { return "Escape"; };
	if (key == KEY_UNLABELED) { return "Escape"; };
	if (key == KEY_NEXTTRACK) { return "Escape"; };
*/
	if (key == KEY_NUMPADENTER) { return "Num Enter"; };
	if (key == KEY_RCONTROL) { return "Right Control"; };
/*
	if (key == KEY_MUTE) { return "Escape"; };
	if (key == KEY_CALCULATOR) { return "Escape"; };
	if (key == KEY_PLAYPAUSE) { return "Escape"; };
	if (key == KEY_MEDIASTOP) { return "Escape"; };
	if (key == KEY_VOLUMEDOWN) { return "Escape"; };
	if (key == KEY_VOLUMEUP) { return "Escape"; };
	if (key == KEY_WEBHOME) { return "Escape"; };
	if (key == KEY_NUMPADCOMMA) { return "Escape"; };
*/
	if (key == KEY_DIVIDE) { return "/"; };
//	if (key == KEY_SYSRQ) { return "Escape"; }; ?
	if (key == KEY_RMENU) { return "Right Alt"; };
//	if (key == KEY_PAUSE) { return "Escape"; }; ?
	if (key == KEY_HOME) { return "Home"; };
	if (key == KEY_UPARROW) { return "Up Arrow"; };
	if (key == KEY_PRIOR) { return "Page Up"; };
	if (key == KEY_LEFTARROW) { return "Left Arrow"; };
	if (key == KEY_RIGHTARROW) { return "Right Arrow"; };
	if (key == KEY_END) { return "End"; };
	if (key == KEY_DOWNARROW) { return "Down Arrow"; };
	if (key == KEY_NEXT) { return "Page Down"; };
	if (key == KEY_INSERT) { return "Insert"; };
	if (key == KEY_DELETE) { return "Delete"; };
	if (key == KEY_LWIN) { return "Left Win"; };
	if (key == KEY_RWIN) { return "Right Win"; };
/*
	if (key == KEY_APPS) { return "Escape"; };
	if (key == KEY_POWER) { return "Escape"; };
	if (key == KEY_SLEEP) { return "Escape"; };
	if (key == KEY_WAKE) { return "Escape"; };
	if (key == KEY_WEBSEARCH) { return "Escape"; };
	if (key == KEY_WEBFAVORITES) { return "Escape"; };
	if (key == KEY_WEBREFRESH) { return "Escape"; };
	if (key == KEY_WEBSTOP) { return "Escape"; };
	if (key == KEY_WEBFORWARD) { return "Escape"; };
	if (key == KEY_WEBBACK) { return "Escape"; };
	if (key == KEY_MYCOMPUTER) { return "Escape"; };
	if (key == KEY_MAIL) { return "Escape"; };
	if (key == KEY_MEDIASELECT) { return "Escape"; };
*/
	return "n/a";
};

func string GetKeyChar (var int key) {
	if (key == KEY_ESCAPE) { return STR_EMPTY; };
	if (key == KEY_1) { return "1"; };
	if (key == KEY_2) { return "2"; };
	if (key == KEY_3) { return "3"; };
	if (key == KEY_4) { return "4"; };
	if (key == KEY_5) { return "5"; };
	if (key == KEY_6) { return "6"; };
	if (key == KEY_7) { return "7"; };
	if (key == KEY_8) { return "8"; };
	if (key == KEY_9) { return "9"; };
	if (key == KEY_0) { return "0"; };
	if (key == KEY_MINUS) { return "-"; };
	if (key == KEY_EQUALS) { return "="; };
	if (key == KEY_BACK) { return STR_EMPTY; };
	if (key == KEY_TAB) { return BtoC (9); };
	if (key == KEY_Q) { return "Q"; };
	if (key == KEY_W) { return "W"; };
	if (key == KEY_E) { return "E"; };
	if (key == KEY_R) { return "R"; };
	if (key == KEY_T) { return "T"; };
	if (key == KEY_Y) { return "Y"; };
	if (key == KEY_U) { return "U"; };
	if (key == KEY_I) { return "I"; };
	if (key == KEY_O) { return "O"; };
	if (key == KEY_P) { return "P"; };
	if (key == KEY_LBRACKET) { return "["; };
	if (key == KEY_RBRACKET) { return "]"; };
	if (key == KEY_RETURN) { return BtoC (10); };
	if (key == KEY_LCONTROL) { return STR_EMPTY; };
	if (key == KEY_A) { return "A"; };
	if (key == KEY_S) { return "S"; };
	if (key == KEY_D) { return "D"; };
	if (key == KEY_F) { return "F"; };
	if (key == KEY_G) { return "G"; };
	if (key == KEY_H) { return "H"; };
	if (key == KEY_J) { return "J"; };
	if (key == KEY_K) { return "K"; };
	if (key == KEY_L) { return "L"; };
	if (key == KEY_SEMICOLON) { return ";"; };
	if (key == KEY_APOSTROPHE) { return "'"; };
	if (key == KEY_GRAVE) { return "`"; };
	if (key == KEY_LSHIFT) { return STR_EMPTY; };
	if (key == KEY_BACKSLASH) { return BtoC (92); };
	if (key == KEY_Z) { return "Z"; };
	if (key == KEY_X) { return "X"; };
	if (key == KEY_C) { return "C"; };
	if (key == KEY_V) { return "V"; };
	if (key == KEY_B) { return "B"; };
	if (key == KEY_N) { return "N"; };
	if (key == KEY_M) { return "M"; };
	if (key == KEY_COMMA) { return ","; };
	if (key == KEY_PERIOD) { return "."; };
	if (key == KEY_SLASH) { return "/"; };
	if (key == KEY_RSHIFT) { return STR_EMPTY; };
	if (key == KEY_MULTIPLY) { return "*"; };
	if (key == KEY_LMENU) { return STR_EMPTY; };
	if (key == KEY_SPACE) { return STR_SPACE; };
//	if (key == KEY_CAPITAL) { return STR_EMPTY; }; ?
	if (key == KEY_F1) { return STR_EMPTY; };
	if (key == KEY_F2) { return STR_EMPTY; };
	if (key == KEY_F3) { return STR_EMPTY; };
	if (key == KEY_F4) { return STR_EMPTY; };
	if (key == KEY_F5) { return STR_EMPTY; };
	if (key == KEY_F6) { return STR_EMPTY; };
	if (key == KEY_F7) { return STR_EMPTY; };
	if (key == KEY_F8) { return STR_EMPTY; };
	if (key == KEY_F9) { return STR_EMPTY; };
	if (key == KEY_F10) { return STR_EMPTY; };
	if (key == KEY_NUMLOCK) { return STR_EMPTY; };
	if (key == KEY_SCROLL) { return STR_EMPTY; };
	if (key == KEY_NUMPAD7) { return "7"; };
	if (key == KEY_NUMPAD8) { return "8"; };
	if (key == KEY_NUMPAD9) { return "9"; };
	if (key == KEY_SUBTRACT) { return "-"; };
	if (key == KEY_NUMPAD4) { return "4"; };
	if (key == KEY_NUMPAD5) { return "5"; };
	if (key == KEY_NUMPAD6) { return "6"; };
	if (key == KEY_ADD) { return "+"; };
	if (key == KEY_NUMPAD1) { return "1"; };
	if (key == KEY_NUMPAD2) { return "2"; };
	if (key == KEY_NUMPAD3) { return "3"; };
	if (key == KEY_NUMPAD0) { return "0"; };
	if (key == KEY_DECIMAL) { return "."; };
//	if (key == KEY_OEM_102) { return "Escape"; }; ?
	if (key == KEY_F11) { return STR_EMPTY; };
	if (key == KEY_F12) { return STR_EMPTY; };
/*
	if (key == KEY_F13) { return "F13"; };
	if (key == KEY_F14) { return "Escape"; };
	if (key == KEY_F15) { return "Escape"; };
	if (key == KEY_KANA) { return "Escape"; };
	if (key == KEY_ABNT_C1) { return "Escape"; };
	if (key == KEY_CONVERT) { return "Escape"; };
	if (key == KEY_NOCONVERT) { return "Escape"; };
	if (key == KEY_YEN) { return "Escape"; };
	if (key == KEY_ABNT_C2) { return "Escape"; };
	if (key == KEY_NUMPADEQUALS) { return "Escape"; };
	if (key == KEY_PREVTRACK) { return "Escape"; };
	if (key == KEY_AT) { return "Escape"; };
	if (key == KEY_COLON) { return "Escape"; };
	if (key == KEY_UNDERLINE) { return "Escape"; };
	if (key == KEY_KANJI) { return "Escape"; };
	if (key == KEY_STOP) { return "Escape"; };
	if (key == KEY_AX) { return "Escape"; };
	if (key == KEY_UNLABELED) { return "Escape"; };
	if (key == KEY_NEXTTRACK) { return "Escape"; };
*/
	if (key == KEY_NUMPADENTER) { return BtoC (10); };
	if (key == KEY_RCONTROL) { return STR_EMPTY; };
/*
	if (key == KEY_MUTE) { return "Escape"; };
	if (key == KEY_CALCULATOR) { return "Escape"; };
	if (key == KEY_PLAYPAUSE) { return "Escape"; };
	if (key == KEY_MEDIASTOP) { return "Escape"; };
	if (key == KEY_VOLUMEDOWN) { return "Escape"; };
	if (key == KEY_VOLUMEUP) { return "Escape"; };
	if (key == KEY_WEBHOME) { return "Escape"; };
	if (key == KEY_NUMPADCOMMA) { return "Escape"; };
*/
	if (key == KEY_DIVIDE) { return "/"; };
//	if (key == KEY_SYSRQ) { return "Escape"; }; ?
	if (key == KEY_RMENU) { return STR_EMPTY; };
//	if (key == KEY_PAUSE) { return "Escape"; }; ?
	if (key == KEY_HOME) { return STR_EMPTY; };
	if (key == KEY_UPARROW) { return STR_EMPTY; };
	if (key == KEY_PRIOR) { return STR_EMPTY; };
	if (key == KEY_LEFTARROW) { return STR_EMPTY; };
	if (key == KEY_RIGHTARROW) { return STR_EMPTY; };
	if (key == KEY_END) { return STR_EMPTY; };
	if (key == KEY_DOWNARROW) { return STR_EMPTY; };
	if (key == KEY_NEXT) { return STR_EMPTY; };
	if (key == KEY_INSERT) { return STR_EMPTY; };
	if (key == KEY_DELETE) { return STR_EMPTY; };
	if (key == KEY_LWIN) { return STR_EMPTY; };
	if (key == KEY_RWIN) { return STR_EMPTY; };
/*
	if (key == KEY_APPS) { return "Escape"; };
	if (key == KEY_POWER) { return "Escape"; };
	if (key == KEY_SLEEP) { return "Escape"; };
	if (key == KEY_WAKE) { return "Escape"; };
	if (key == KEY_WEBSEARCH) { return "Escape"; };
	if (key == KEY_WEBFAVORITES) { return "Escape"; };
	if (key == KEY_WEBREFRESH) { return "Escape"; };
	if (key == KEY_WEBSTOP) { return "Escape"; };
	if (key == KEY_WEBFORWARD) { return "Escape"; };
	if (key == KEY_WEBBACK) { return "Escape"; };
	if (key == KEY_MYCOMPUTER) { return "Escape"; };
	if (key == KEY_MAIL) { return "Escape"; };
	if (key == KEY_MEDIASELECT) { return "Escape"; };
*/
	return STR_EMPTY;
};

/*
 *	FindUserDllFunction
 */
func int FindUserDllFunction(var string name) {
    const int USER32DLL = 0;
    if (!USER32DLL) {
        USER32DLL = LoadLibrary("USER32.DLL");
    };

    return GetProcAddress(USER32DLL, name);
};

/*
//https://learn.microsoft.com/en-us/windows/win32/api/winuser/nf-winuser-getkeyboardlayoutnamea
BOOL GetKeyboardLayoutNameA(
  [out] LPSTR pwszKLID
);
*/

func string GetKeyboardLayoutNameA() {
	const int addr = 0;

	if (!addr) {
		addr = FindUserDllFunction("GetKeyboardLayoutNameA");
	};

	if (!addr) { return ""; };

	//Allocate memory
	const int len = 8;
	const int lpBuffer = 0;

	if (!lpBuffer) {
		lpBuffer = MEM_Alloc(len);
	};

	CALL_PtrParam(lpBuffer);
	CALL__stdcall(addr);

	var int retVal; retVal = CALL_RetValAsInt();

	//Allocate memory for string
	var string layoutName; layoutName = "00000000";

	var zString zstr; zstr = _^(_@s(layoutName));
	MEM_CopyBytes(lpBuffer, zstr.ptr, len);
	zstr.len = len;
	zstr.res = len;

    return layoutName;
};

//Keyboard layouts
//https://learn.microsoft.com/en-us/windows-hardware/manufacture/desktop/windows-language-pack-default-values

// US

//Default, thus we don't need to validate values (if language is not German or Czech-o-Slovakian, then we consider it US...
//(includes support for Polish characters)

//German

const string KBD_Layout_German = "00000407"; //qwertz
const string KBD_Layout_German_IBM = "00010407";

//Czech

const string KBD_Layout_Czech = "00000405"; //qwertz
const string KBD_Layout_Czech_QWERTY = "00010405"; //qwerty
const string KBD_Layout_Czech_Programmers = "00020405"; //qwerty

const string KBD_Layout_Slovak = "0000041B"; //qwertz
const string KBD_Layout_Slovak_QWERTY = "0001041B"; //qwerty
//? Slovakia does not have programmers layout? smh

//-- [Internal variables & constants]

var int _keyBoardLayout;
	const int KEYBOARD_LAYOUT_MAX = 2;
	const int KEYBOARD_LAYOUT_US = 0; //Default US
	const int KEYBOARD_LAYOUT_DE = 1; //Deutch
	const int KEYBOARD_LAYOUT_CZ = 2; //Czech

var int _keyBoardInputModifier;
	const int KEYBOARD_MODIFIER_DEGREESIGN = 1;			//°
	const int KEYBOARD_MODIFIER_CARON = 2;				//ˇ
	const int KEYBOARD_MODIFIER_ACUTE_ACCENT = 3;		//´
	const int KEYBOARD_MODIFIER_CIRCUMFLEX_ACCENT = 4;	//^
	const int KEYBOARD_MODIFIER_GRAVE_ACCENT = 5;		//`
	const int KEYBOARD_MODIFIER_DIAERESIS = 6;			//¨

var int _keyBoardQwertz;

/*
 *	Setter for 'internal' keyboard layout
 */
func void SetInternalKeyBoardLayout(var int k) {
	var int l; l = _keyBoardLayout;

	_keyBoardLayout = k;

	if (_keyBoardLayout > KEYBOARD_LAYOUT_MAX) {
		_keyBoardLayout = 0;
	};

	if (_keyBoardLayout != l) {
		//Give player some basic feedback
		if (_keyBoardLayout == KEYBOARD_LAYOUT_US) { PrintS("Keyboard: US"); };
		if (_keyBoardLayout == KEYBOARD_LAYOUT_DE) { PrintS("Keyboard: DE"); };
		if (_keyBoardLayout == KEYBOARD_LAYOUT_CZ) { PrintS("Keyboard: CZ"); };
	};

	if (_keyBoardLayout == KEYBOARD_LAYOUT_DE)
	|| (_keyBoardLayout == KEYBOARD_LAYOUT_CZ)
	{
		_keyBoardQwertz = TRUE;
	};
};

/*
 *	GetKeyLocalized
 *
 *	Function returns pressed key based on selected Windows language.
 *
 *	Alt Gr not implemented, I never used it, thus it's redundat :-P
 *
 *	Keyboard 'localization' taken into consideration:
 *		Default: US layout / PL layout (qwerty)
 *		https://en.wikipedia.org/wiki/British_and_American_keyboards#/media/File:KB_United_States-NoAltGr.svg
 *			- Polish localization is available by default... since this is Polish game :)
 *				- Alt + [keys] will bring special Polish letters (ąćęłńóśźż)
 *
 *		DE layout (qwertz)
 *		https://en.wikipedia.org/wiki/German_keyboard_layout#/media/File:KB_Germany.svg
 *			- Alt + [keys] will bring special characters äöüß
 *
 *		CZ layout (qwertz)
 *		https://en.wikipedia.org/wiki/QWERTZ#/media/File:Keyboard_layout_Czech.svg
 *			- Alt + [keys] will bring special characters ýžáčďéíňóřšťú
 *			- Ctrl + Alt + [keys] will bring special characters ěů
 *			- dead key support for accented characters
 */
func string GetKeyLocalized(var int key) {
	var string c; c = STR_EMPTY;
	var int k;

	//Default qwerty (qwerty / qwertz is a plague... localization in programming is always a disaster)
	_keyBoardQwertz = FALSE;

	//Detect keyboard layout
	var string kbdLayoutName; kbdLayoutName = GetKeyboardLayoutNameA();

	//If layout could not be detected... then allow 'internal' keyboard layout switching
	if (Hlp_StrCmp(kbdLayoutName, STR_EMPTY)) {
		//Set default values
		SetInternalKeyBoardLayout(_keyBoardLayout);

		//Change internal keyboard layout if player tried to change it via Alt + Shift keys
		if ((key == KEY_LSHIFT) && (keyStateAlt) && (keyStateShift)) {
			//Change to another 'internal' layout
			SetInternalKeyBoardLayout(_keyBoardLayout + 1);
			return c;
		};
	} else {
		//Default: US
		_keyBoardLayout = KEYBOARD_LAYOUT_US;

		//DE
		if (Hlp_StrCmp(kbdLayoutName, KBD_Layout_German))
		|| (Hlp_StrCmp(kbdLayoutName, KBD_Layout_German_IBM))
		{
			_keyBoardLayout = KEYBOARD_LAYOUT_DE;
			_keyBoardQwertz = TRUE;
		};

		//CZ
		if (Hlp_StrCmp(kbdLayoutName, KBD_Layout_Czech))
		|| (Hlp_StrCmp(kbdLayoutName, KBD_Layout_Czech_QWERTY))
		|| (Hlp_StrCmp(kbdLayoutName, KBD_Layout_Czech_Programmers))

		|| (Hlp_StrCmp(kbdLayoutName, KBD_Layout_Slovak))
		|| (Hlp_StrCmp(kbdLayoutName, KBD_Layout_Slovak_QWERTY))
		{
			_keyBoardLayout = KEYBOARD_LAYOUT_CZ;
		};

		if (Hlp_StrCmp(kbdLayoutName, KBD_Layout_Czech))
		|| (Hlp_StrCmp(kbdLayoutName, KBD_Layout_Slovak))
		{
			_keyBoardQwertz = TRUE;
		};
	};

	var int keyStateLShift; keyStateLShift = MEM_KeyState(KEY_LSHIFT);
	var int keyStateRShift; keyStateRShift = MEM_KeyState(KEY_RSHIFT);
	var int keyStateShift; keyStateShift = ((keyStateLShift == KEY_PRESSED) | (keyStateLShift == KEY_HOLD) | (keyStateRShift == KEY_PRESSED) | (keyStateRShift == KEY_HOLD));

	var int keyStateLAlt; keyStateLAlt = MEM_KeyState(KEY_LMENU);
	var int keyStateRAlt; keyStateRAlt = MEM_KeyState(KEY_RMENU);
	var int keyStateAlt; keyStateAlt = ((keyStateLAlt == KEY_PRESSED) | (keyStateLAlt == KEY_HOLD) | (keyStateRAlt == KEY_PRESSED) | (keyStateRAlt == KEY_HOLD));

	var int keyStateLCtrl; keyStateLCtrl = MEM_KeyState(KEY_LCONTROL);
	var int keyStateRCtrl; keyStateRCtrl = MEM_KeyState(KEY_RCONTROL);
	var int keyStateCtrl; keyStateCtrl = ((keyStateLCtrl == KEY_PRESSED) | (keyStateLCtrl == KEY_HOLD) | (keyStateRCtrl == KEY_PRESSED) | (keyStateRCtrl == KEY_HOLD));

	//Spacebar
	if (key == KEY_SPACE) { c = STR_SPACE; };

	//Numpad
	if (key == KEY_NUMPAD0) { c = "0"; };
	if (key == KEY_NUMPAD1) { c = "1"; };
	if (key == KEY_NUMPAD2) { c = "2"; };
	if (key == KEY_NUMPAD3) { c = "3"; };
	if (key == KEY_NUMPAD4) { c = "4"; };
	if (key == KEY_NUMPAD5) { c = "5"; };
	if (key == KEY_NUMPAD6) { c = "6"; };
	if (key == KEY_NUMPAD7) { c = "7"; };
	if (key == KEY_NUMPAD8) { c = "8"; };
	if (key == KEY_NUMPAD9) { c = "9"; };

	if (key == KEY_MULTIPLY) { c = "*"; };
	if (key == KEY_SUBTRACT) { c = "-"; };
	if (key == KEY_ADD) { c = "+"; };
	if (key == KEY_DECIMAL) { c = "."; };

	//US keyboard layout by default
	if (_keyBoardLayout == KEYBOARD_LAYOUT_US) {
		if (key == KEY_GRAVE) { if (keyStateShift) { c = "~"; } else { c = "`"; }; };
		if (key == KEY_1) { if (keyStateShift) { c = "!"; } else { c = "1"; }; };
		if (key == KEY_2) { if (keyStateShift) { c = "@"; } else { c = "2"; }; };
		if (key == KEY_3) { if (keyStateShift) { c = "#"; } else { c = "3"; }; };
		if (key == KEY_4) { if (keyStateShift) { c = "$"; } else { c = "4"; }; };
		if (key == KEY_5) { if (keyStateShift) { c = "%"; } else { c = "5"; }; };
		if (key == KEY_6) { if (keyStateShift) { c = "^"; } else { c = "6"; }; };
		if (key == KEY_7) { if (keyStateShift) { c = "&"; } else { c = "7"; }; };
		if (key == KEY_8) { if (keyStateShift) { c = "*"; } else { c = "8"; }; };
		if (key == KEY_9) { if (keyStateShift) { c = "("; } else { c = "9"; }; };
		if (key == KEY_0) { if (keyStateShift) { c = ")"; } else { c = "0"; }; };

		if (key == KEY_MINUS) { if (keyStateShift) { c = "-"; } else { c = "_"; }; };
		if (key == KEY_EQUALS) { if (keyStateShift) { c = "+"; } else { c = "="; }; };

		if (key == KEY_LBRACKET) { if (keyStateShift) { c = "{"; } else { c = "["; }; };
		if (key == KEY_RBRACKET) { if (keyStateShift) { c = "}"; } else { c = "]"; }; };

		//I left backslash commented out, because it is escape character that caused my N++ to format rest of the code 'incorrectly' :)
		//So this way we will have both nice code format as well as an option to write backslash :)
		if (key == KEY_BACKSLASH) {
			if (keyStateShift) {
				c = STR_PIPE;
			} else {
				//Backslash
				c = BtoC(92);
			};
		};

		if (key == KEY_SEMICOLON) { if (keyStateShift) { c = ":"; } else { c = ";"; }; };
		if (key == KEY_APOSTROPHE) {
			if (keyStateShift) {
				//Double quote
				c = BtoC(34);
			} else {
				c = "'";
			};
		};

		if (key == KEY_COMMA) { if (keyStateShift) { c = "<"; } else { c = ","; }; };
		if (key == KEY_PERIOD) { if (keyStateShift) { c = ">"; } else { c = "."; }; };
		if (key == KEY_SLASH) { if (keyStateShift) { c = "?"; } else { c = "/"; }; };

		//A..Z a..z
		if (!STR_Len(c)) {
			k = GetCharFromDIK(key, keyStateShift * KEY_LSHIFT, keyStateAlt);

			//Gothic default keyboard layout: qwerty

			if ((k >= 65 && k <= 90) || (k >= 97 && k <= 122)) {
				c = BtoC(k);

				//Support for Polish characters (Alt + key)
				if (keyStateAlt) {
					if (k == 065) { c = BtoC(165); }; //A - Ą
					if (k == 097) { c = BtoC(185); }; //A - ą

					if (k == 067) { c = BtoC(198); }; //C - Ć
					if (k == 099) { c = BtoC(230); }; //c - ć

					if (k == 069) { c = BtoC(202); }; //E - Ę
					if (k == 101) { c = BtoC(234); }; //e - ę

					if (k == 076) { c = BtoC(163); }; //L - Ł
					if (k == 108) { c = BtoC(179); }; //l - ł

					if (k == 078) { c = BtoC(209); }; //N - Ń
					if (k == 110) { c = BtoC(241); }; //n - ń

					if (k == 079) { c = BtoC(211); }; //O - Ó
					if (k == 111) { c = BtoC(243); }; //o - ó

					if (k == 083) { c = BtoC(140); }; //S - Ś
					if (k == 115) { c = BtoC(146); }; //s - ś

					if (k == 090) { c = BtoC(175); }; //Z - Ż
					if (k == 122) { c = BtoC(191); }; //z - ż

					if (k == 088) { c = BtoC(143); }; //X - Ź
					if (k == 120) { c = BtoC(159); }; //x - ź
				};
			};
		};
	} else

	//German
	if (_keyBoardLayout == KEYBOARD_LAYOUT_DE) {

		if (key == KEY_GRAVE) {
			if (keyStateShift) {
				c = "°";
			} else {
				_keyBoardInputModifier = KEYBOARD_MODIFIER_CIRCUMFLEX_ACCENT;
			};
		};

		if (key == KEY_1) { if (keyStateShift) { c = "!"; } else { c = "1"; }; };
		if (key == KEY_2) {
			if (keyStateShift) {
				//Double quote
				c = BtoC(34);
			} else {
				c = "2"; };
			};
		if (key == KEY_3) { if (keyStateShift) { c = "§"; } else { c = "3"; }; };
		if (key == KEY_4) { if (keyStateShift) { c = "$"; } else { c = "4"; }; };
		if (key == KEY_5) { if (keyStateShift) { c = "%"; } else { c = "5"; }; };
		if (key == KEY_6) { if (keyStateShift) { c = "&"; } else { c = "6"; }; };
		if (key == KEY_7) { if (keyStateShift) { c = "/"; } else { c = "7"; }; };
		if (key == KEY_8) { if (keyStateShift) { c = "("; } else { c = "8"; }; };
		if (key == KEY_9) { if (keyStateShift) { c = ")"; } else { c = "9"; }; };
		if (key == KEY_0) { if (keyStateShift) { c = "="; } else { c = "0"; }; };

		if (key == KEY_MINUS) {
			if (keyStateShift) {
				c = "?";
			} else {
				c = BtoC(223);
			};
		}; //ß

		if (key == KEY_LBRACKET) {
			if (keyStateShift) {
				c = BtoC(220); //Ü
			} else {
				c = BtoC(252); //ü
			};
		};

		if (key == KEY_RBRACKET) { if (keyStateShift) { c = "*"; } else { c = "+"; }; };
		if (key == KEY_BACKSLASH) { if (keyStateShift) { c = "'"; } else { c = "#"; }; };

		if (key == KEY_SEMICOLON) {
			if (keyStateShift) {
				c = BtoC(214); //Ö
			} else {
				c = BtoC(246); //ö
			};
		};

		if (key == KEY_APOSTROPHE) {
			if (keyStateShift) {
				c = BtoC(196); //Ä
			} else {
				c = BtoC(228); //ä
			};
		};

		if (key == KEY_COMMA) { if (keyStateShift) { c = ";"; } else { c = ","; }; };
		if (key == KEY_PERIOD) { if (keyStateShift) { c = ":"; } else { c = "."; }; };
		if (key == KEY_SLASH) { if (keyStateShift) { c = "_"; } else { c = "-"; }; };

		//A..Z a..z
		if (!STR_Len(c)) {
			k = GetCharFromDIK(key, keyStateShift * KEY_LSHIFT, keyStateAlt);

			//Switch z-y
			//Gothic default keyboard layout: qwerty
			if (_keyBoardQwertz) {
				if ((k == 122) || (k == 90)) {
					k -= 1;
				} else
				if ((k == 121) || (k == 89)) {
					k += 1;
				};
			};

			if ((k >= 65 && k <= 90) || (k >= 97 && k <= 122)) {
				//No modifiers
				if (_keyBoardInputModifier == 0) {
					c = BtoC(k);

					//Support for special German characters (Alt + key)
					if (keyStateAlt) {
						if (k == 065) { c = BtoC(196); }; //A - Ä
						if (k == 097) { c = BtoC(228); }; //A - ä

						if (k == 079) { c = BtoC(214); }; //O - Ö
						if (k == 111) { c = BtoC(246); }; //o - ö

						if (k == 085) { c = BtoC(220); }; //U - Ü
						if (k == 117) { c = BtoC(252); }; //u - ü

						if (k == 083) { c = BtoC(223); }; //S - ß
						if (k == 115) { c = BtoC(223); }; //s - ß
					};
				} else
				//^
				if (_keyBoardInputModifier == KEYBOARD_MODIFIER_CIRCUMFLEX_ACCENT) {
					if (k == 065) { c = BtoC(194); }; //A - Â
					if (k == 097) { c = BtoC(226); }; //a - â

					//if (k == 069) { c = BtoC(?); }; //E - E
					//if (k == 101) { c = BtoC(?); }; //e - e

					if (k == 073) { c = BtoC(206); }; //I - Î
					if (k == 105) { c = BtoC(238); }; //i - î

					if (k == 079) { c = BtoC(212); }; //O - Ô
					if (k == 111) { c = BtoC(244); }; //o - ô

					//if (k == 085) { c = BtoC(?); }; //U - U
					//if (k == 117) { c = BtoC(?); }; //u - u
				} else
				//´ acute accent
				if (_keyBoardInputModifier == KEYBOARD_MODIFIER_ACUTE_ACCENT) {
					if (k == 065) { c = BtoC(193); }; //A - Á
					if (k == 097) { c = BtoC(225); }; //a - á

					if (k == 069) { c = BtoC(201); }; //E - É
					if (k == 101) { c = BtoC(233); }; //e - é

					if (k == 073) { c = BtoC(205); }; //I - Í
					if (k == 105) { c = BtoC(237); }; //i - í

					if (k == 079) { c = BtoC(211); }; //O - Ó
					if (k == 111) { c = BtoC(243); }; //o - ó

					if (k == 085) { c = BtoC(218); }; //U - Ú
					if (k == 117) { c = BtoC(250); }; //u - ú

					if (k == 089) { c = BtoC(221); }; //Y - Ý
					if (k == 121) { c = BtoC(253); }; //y - ý
				} else
				//` grave accent
				if (_keyBoardInputModifier == KEYBOARD_MODIFIER_GRAVE_ACCENT) {
					//if (k == 065) { c = BtoC(?); }; //A - A
					//if (k == 097) { c = BtoC(?); }; //a - a

					//if (k == 069) { c = BtoC(?); }; //E - E
					//if (k == 101) { c = BtoC(?); }; //e - e

					//if (k == 073) { c = BtoC(?); }; //I - I
					//if (k == 105) { c = BtoC(?); }; //i - i

					//if (k == 079) { c = BtoC(?); }; //O - O
					//if (k == 111) { c = BtoC(?); }; //o - o

					//if (k == 085) { c = BtoC(?); }; //U - U
					//if (k == 117) { c = BtoC(?); }; //u - u
				};

				_keyBoardInputModifier = 0;
			};
		};

		if (key == KEY_EQUALS) {
			if (keyStateShift) {
				_keyBoardInputModifier = KEYBOARD_MODIFIER_CIRCUMFLEX_ACCENT;
			} else {
				_keyBoardInputModifier = KEYBOARD_MODIFIER_ACUTE_ACCENT;
			};
		};
	} else

	//Czech
	if (_keyBoardLayout == KEYBOARD_LAYOUT_CZ) {

		if (key == KEY_GRAVE) {
			if (keyStateShift) {
				//° degree sign
				_keyBoardInputModifier = KEYBOARD_MODIFIER_DEGREESIGN;
			} else {
				c = ";";
			};
		};

		if (key == KEY_1) { if (keyStateShift) { c = "1"; } else { c = "+"; }; };
		if (key == KEY_2) { if (keyStateShift) { c = "2"; } else { c = BtoC(236); }; }; //ě
		if (key == KEY_3) { if (keyStateShift) { c = "3"; } else { c = BtoC(154); }; }; //š
		if (key == KEY_4) { if (keyStateShift) { c = "4"; } else { c = BtoC(232); }; }; //č
		if (key == KEY_5) { if (keyStateShift) { c = "5"; } else { c = BtoC(248); }; }; //ř
		if (key == KEY_6) { if (keyStateShift) { c = "6"; } else { c = BtoC(158); }; }; //ž
		if (key == KEY_7) { if (keyStateShift) { c = "7"; } else { c = BtoC(253); }; }; //ý
		if (key == KEY_8) { if (keyStateShift) { c = "8"; } else { c = BtoC(225); }; }; //á
		if (key == KEY_9) { if (keyStateShift) { c = "9"; } else { c = BtoC(237); }; }; //í
		if (key == KEY_0) { if (keyStateShift) { c = "0"; } else { c = BtoC(233); }; }; //é

		if (key == KEY_MINUS) { if (keyStateShift) { c = "%"; } else { c = "="; }; };

		if (key == KEY_LBRACKET) { if (keyStateShift) { c = "/"; } else { c = BtoC(250); }; }; //ú
		if (key == KEY_RBRACKET) { if (keyStateShift) { c = "("; } else { c = ")"; }; };

		//I left backslash commented out, because it is escape character that caused my N++ to format rest of the code 'incorrectly' :)
		//So this way we will have both nice code format as well as an option to write backslash :)
		if (key == KEY_BACKSLASH) {
			if (keyStateShift) {
				c = "'";
			} else {
				//¨ diaeresis
				_keyBoardInputModifier = KEYBOARD_MODIFIER_DIAERESIS;
			};
		};

		if (key == KEY_SEMICOLON) {
			if (keyStateShift) {
				//Double quote
				c = BtoC(34);
			} else {
				c = "ů";
			};
		};

		if (key == KEY_APOSTROPHE) {
			if (keyStateShift) {
				c = "!";
			} else {
				c = "§";
			};
		};

		if (key == KEY_COMMA) { if (keyStateShift) { c = "?"; } else { c = ","; }; };
		if (key == KEY_PERIOD) { if (keyStateShift) { c = ":"; } else { c = "."; }; };
		if (key == KEY_SLASH) { if (keyStateShift) { c = "_"; } else { c = "-"; }; };

		//A..Z a..z
		if (!STR_Len(c)) {
			k = GetCharFromDIK(key, keyStateShift * KEY_LSHIFT, keyStateAlt);

			//Switch z-y
			//Gothic default keyboard layout: qwerty
			if (_keyBoardQwertz) {
				if ((k == 122) || (k == 90)) {
					k -= 1;
				} else
				if ((k == 121) || (k == 89)) {
					k += 1;
				};
			};

			if ((k >= 65 && k <= 90) || (k >= 97 && k <= 122)) {
				//No modifiers
				if (_keyBoardInputModifier == 0) {
					c = BtoC(k);

					//Support for Czech characters (Alt + key)
					if (keyStateAlt) {
						if (k == 065) { c = BtoC(193); }; //A - Á
						if (k == 097) { c = BtoC(225); }; //a - á

						if (k == 069) { c = BtoC(201); }; //E - É
						if (k == 101) { c = BtoC(233); }; //e - é

						if (k == 073) { c = BtoC(205); }; //I - Í
						if (k == 105) { c = BtoC(237); }; //i - í

						if (k == 079) { c = BtoC(211); }; //O - Ó
						if (k == 111) { c = BtoC(243); }; //o - ó

						if (k == 085) { c = BtoC(218); }; //U - Ú
						if (k == 117) { c = BtoC(250); }; //u - ú

						if (keyStateCtrl) {
							if (k == 085) { c = BtoC(217); }; //U - Ů
							if (k == 117) { c = BtoC(249); }; //u - ů
						};

						if (k == 089) { c = BtoC(221); }; //Y - Ý
						if (k == 121) { c = BtoC(253); }; //y - ý

						if (k == 067) { c = BtoC(200); }; //C - Č
						if (k == 099) { c = BtoC(232); }; //c - č

						if (k == 068) { c = BtoC(207); }; //D - Ď
						if (k == 100) { c = BtoC(239); }; //d - ď

						if (keyStateCtrl) {
							if (k == 069) { c = BtoC(204); }; //E - Ě
							if (k == 101) { c = BtoC(236); }; //e - ě
						};

						if (k == 078) { c = BtoC(210); }; //N - Ň
						if (k == 110) { c = BtoC(242); }; //n - ň

						if (k == 082) { c = BtoC(216); }; //R - Ř
						if (k == 114) { c = BtoC(248); }; //r - ř

						if (k == 083) { c = BtoC(138); }; //S - Š
						if (k == 115) { c = BtoC(154); }; //s - š

						if (k == 084) { c = BtoC(141); }; //T - Ť
						if (k == 116) { c = BtoC(157); }; //t - ť

						if (k == 090) { c = BtoC(142); }; //Z - Ž
						if (k == 122) { c = BtoC(158); }; //z - ž
					};
				} else
				//° Degree sign
				if (_keyBoardInputModifier == KEYBOARD_MODIFIER_DEGREESIGN) {
					if (k == 085) { c = BtoC(217); }; //U - Ů
					if (k == 117) { c = BtoC(249); }; //u - ů
				} else
				//ˇ Caron
				if (_keyBoardInputModifier == KEYBOARD_MODIFIER_CARON) {
					if (k == 067) { c = BtoC(200); }; //C - Č
					if (k == 099) { c = BtoC(232); }; //c - č

					if (k == 068) { c = BtoC(207); }; //D - Ď
					if (k == 100) { c = BtoC(239); }; //d - ď

					if (k == 069) { c = BtoC(204); }; //E - Ě
					if (k == 101) { c = BtoC(236); }; //e - ě

					if (k == 078) { c = BtoC(210); }; //N - Ň
					if (k == 110) { c = BtoC(242); }; //n - ň

					if (k == 082) { c = BtoC(216); }; //R - Ř
					if (k == 114) { c = BtoC(248); }; //r - ř

					if (k == 083) { c = BtoC(138); }; //S - Š
					if (k == 115) { c = BtoC(154); }; //s - š

					if (k == 084) { c = BtoC(141); }; //T - Ť
					if (k == 116) { c = BtoC(157); }; //t - ť

					if (k == 090) { c = BtoC(142); }; //Z - Ž
					if (k == 122) { c = BtoC(158); }; //z - ž
				} else
				//´ acute accent
				if (_keyBoardInputModifier == KEYBOARD_MODIFIER_ACUTE_ACCENT) {
					if (k == 065) { c = BtoC(193); }; //A - Á
					if (k == 097) { c = BtoC(225); }; //a - á

					if (k == 069) { c = BtoC(201); }; //E - É
					if (k == 101) { c = BtoC(233); }; //e - é

					if (k == 073) { c = BtoC(205); }; //I - Í
					if (k == 105) { c = BtoC(237); }; //i - í

					if (k == 079) { c = BtoC(211); }; //O - Ó
					if (k == 111) { c = BtoC(243); }; //o - ó

					if (k == 085) { c = BtoC(218); }; //U - Ú
					if (k == 117) { c = BtoC(250); }; //u - ú

					if (k == 089) { c = BtoC(221); }; //Y - Ý
					if (k == 121) { c = BtoC(253); }; //y - ý
				} else
				//¨ diaeresis
				if (_keyBoardInputModifier == KEYBOARD_MODIFIER_DIAERESIS) {
					if (k == 065) { c = BtoC(196); }; //A - Ä
					if (k == 097) { c = BtoC(228); }; //a - ä

					if (k == 069) { c = BtoC(203); }; //E - Ë
					if (k == 101) { c = BtoC(235); }; //e - ë

					//if (k == 073) { c = BtoC(?); }; //I - I
					//if (k == 105) { c = BtoC(?); }; //i - i

					if (k == 079) { c = BtoC(214); }; //O - Ö
					if (k == 111) { c = BtoC(246); }; //o - ö

					if (k == 085) { c = BtoC(220); }; //U - Ü
					if (k == 117) { c = BtoC(252); }; //u - ü

					//if (k == 089) { c = BtoC(?); }; //Y - Y
					//if (k == 121) { c = BtoC(?); }; //y - y
				};

				_keyBoardInputModifier = 0;
			};
		};

		if (key == KEY_EQUALS) {
			if (keyStateShift) {
				_keyBoardInputModifier = KEYBOARD_MODIFIER_CARON; //ˇ
			} else {
				_keyBoardInputModifier = KEYBOARD_MODIFIER_ACUTE_ACCENT; //´
			};
		};
	};

	return c;
};
