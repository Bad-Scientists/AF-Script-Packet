//https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page3?p=25717007&viewfull=1#post25717007

/*
 * strings.d
 *
 * Miscellaneous string functions
 *
 * - Requires Ikarus
 * - Compatible with Gothic 1 and Gothic 2
 *
 *
 *  func string STR_Lower(string str)
 *
 *  func string STR_ReplaceOnce(string haystack, string needle, string replace)
 *  func string STR_ReplaceAll (string haystack, string needle, string replace)
 *
 *  func string STR_Postfix(string str, int off)
 *  func string STR_Trim(string str, string tok)
 *  func string STR_TrimChar(string str, int chr)
 *
 *  func int    STR_ToFloat(string str)
 *
 *  func int    STR_IndexOfFirstNonNumeric(string str)
 */


/*
 * Complement to STR_Upper in Ikarus
 */
 
/*
Introduced with Ikarus 1.2.2
func string STR_Lower(var string str) {
    const int zSTRING__Lower_G1 = 4608640; //0x465280
    const int zSTRING__Lower_G2 = 4631024; //0x46A9F0

    var int ptr; ptr = _@s(str);

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PutRetValTo(0);
        CALL__thiscall(_@(ptr), MEMINT_SwitchG1G2(zSTRING__Lower_G1, zSTRING__Lower_G2));

        call = CALL_End();
    };

    return str;
};
*/


/*
 * Replace first occurrence of needle in haystack and replace it
 */
func string STR_ReplaceOnce(var string haystack, var string needle, var string replace) {
    var zString zSh; zSh = _^(_@s(haystack));
    var zString zSn; zSn = _^(_@s(needle));
    if (!zSh.len) || (!zSn.len) {
        return haystack;
    };

    var int startPos; startPos = STR_IndexOf(haystack, needle);
    if (startPos == -1) {
        return haystack;
    };

    var string destStr; destStr = "";

    destStr = STR_Prefix(haystack, startPos);
    destStr = ConcatStrings(destStr, replace);
    destStr = ConcatStrings(destStr, STR_Substr(haystack, startPos+zSn.len, zSh.len-(startPos+zSn.len)));

    return destStr;
};


/*
 * Replace all occurrences of needle in haystack and replace them
 */
func string STR_ReplaceAll(var string haystack, var string needle, var string replace) {
    var string before; before = "";
    while(!Hlp_StrCmp(haystack, before));
        before = haystack;
        haystack = STR_ReplaceOnce(before, needle, replace);
    end;
    return haystack;
};


/*
 * Complement to STR_Prefix in Ikarus
 */
func string STR_Postfix(var string str, var int off) {
    return STR_SubStr(str, off, STR_Len(str)-off);
};


/*
 * Retrieve the string position (starting at 0) of the first non-numeric character
 */
func int STR_IndexOfFirstNonNumeric(var string str) {
    var int len; len = STR_Len(str);
    var int buf; buf = STR_toChar(str);

    var int valid; valid = FALSE;

    var int index; index = 0;

    while(index < len);
        var int chr; chr = MEM_ReadInt(buf + index) & 255;

        if (chr >= 48 /* 0 */) && (chr <= 57 /* 9 */) {
            valid = TRUE;
        } else if ((chr != 45 /*-*/) && (chr != 43 /*+*/)) || (index != 0) {
            // Allow leading plus/minus, e.g. -5
            break;
        };

        index += 1;
    end;

    // "-" is not a number
    if (!valid) {
        index = 0;
    };

    return index;
};


/*
 * Retrieve a string trimmed from left and right by all characters in tok
 * E.g. (" .. hello .. ", ". ") -> "hello"
 */
func string STR_Trim(var string str, var string tok) {
    var int lenS; lenS = STR_Len(str);
    var int lenT; lenT = STR_Len(tok);

    // Start from the beginning
    var int startP; startP = 0;
    while(startP < lenS);
        var string ss; ss = STR_Substr(str, startP, 1);
        var int cont; cont = FALSE;

        var int t; t = 0;
        while(t < lenT);
            var string ts; ts = STR_Substr(tok, t, 1);

            if (Hlp_StrCmp(ss, ts)) {
                cont = TRUE;
                break;
            };

            t += 1;
        end;

        if (!cont) {
            break;
        };

        startP += 1;
    end;

    // Start from the end
    var int endP; endP = lenS-1;
    while(endP >= startP);
        ss = STR_Substr(str, endP, 1);
        cont = FALSE;

        t = 0;
        while(t < lenT);
            ts = STR_Substr(tok, t, 1);

            if (Hlp_StrCmp(ss, ts)) {
                cont = TRUE;
                break;
            };

            t += 1;
        end;

        if (!cont) {
            break;
        };

        endP -= 1;
    end;

    // Convert offset to length (0 -> 1, 1 -> 2, ...)
    endP += 1;

    if (startP >= endP) {
        return "";
    } else {
        return STR_Substr(str, startP, endP-startP);
    };
};


/*
 * Trim string from left and right of a certain char
 */
func string STR_TrimChar(var string str, var int chr) {
    var int sPtr; sPtr = _@s(str);

    const int zSTRING__TrimLeft_G1 = 4617312; //0x467460
    const int zSTRING__TrimLeft_G2 = 4638256; //0x46C630

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_IntParam(_@(chr));
        CALL__thiscall(_@(sPtr), MEMINT_SwitchG1G2(zSTRING__TrimLeft_G1, zSTRING__TrimLeft_G2));
        call = CALL_End();
    };

    const int zSTRING__TrimRight_G1 = 4617632; //0x4675A0
    const int zSTRING__TrimRight_G2 = 4638576; //0x46C770

    const int call1 = 0;
    if (CALL_Begin(call1)) {
        CALL_IntParam(_@(chr));
        CALL__thiscall(_@(sPtr), MEMINT_SwitchG1G2(zSTRING__TrimRight_G1, zSTRING__TrimRight_G2));
        call1 = CALL_End();
    };

    return str;
};


/*
 * Convert string to IEEE754 32-bit float
 */
func int STR_ToFloat(var string str) {
    var zString zStr; zStr = _^(_@s(str));
    var int ptr; ptr = zStr.ptr;
    var int f;
    var int fPtr; fPtr = _@(f);

    const int _atoflt_G1 = 7876596; //0x782FF4
    const int _atoflt_G2 = 8243410; //0x7DC8D2

    const int call = 0;
    if (CALL_Begin(call)) {
        CALL_PtrParam(_@(ptr));
        CALL_PtrParam(_@(fPtr));
        CALL_PutRetValTo(0);
        CALL__cdecl(MEMINT_SwitchG1G2(_atoflt_G1, _atoflt_G2));
        call = CALL_End();
    };

    return f;
};