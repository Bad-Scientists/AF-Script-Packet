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
