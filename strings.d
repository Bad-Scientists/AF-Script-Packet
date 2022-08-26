/*
 *	Copied from Ikarus --> MEM_Error & MEM_Warn calls removed
 *	MEM_Error will eventually cause Gothic to crash in my experience
 */
func string mySTR_SubStr (var string str, var int start, var int count) {
    if (start < 0) || (count < 0) {
        //MEM_Error ("STR_SubStr: start and count may not be negative.");
        return "";
    };

    /* Hole Adressen von zwei Strings, Source und Destination (für Kopieroperation) */
    var zString zStrSrc;
    var zString zStrDst; var string dstStr; dstStr = "";

    zStrSrc = _^(_@s(str));
    zStrDst = _^(_@s(dstStr));

    if (zStrSrc.len < start + count) {
        if (zStrSrc.len < start) {
            //MEM_Warn ("STR_SubStr: The desired start of the substring lies beyond the end of the string.");
            return "";

        } else {
            /* The start is in valid bounds. The End is shitty. */
            /* Careful! MEM_Warn will use STR_SubStr (but will never use it in a way that would produce a warning) */
            var string saveStr; var int saveStart; var int saveCount;
            saveStr = str; saveStart = start; saveCount = count;
            //MEM_Warn ("STR_SubStr: The end of the desired substring exceeds the end of the string.");
            str = saveStr; start = saveStart; count = saveCount;
            count = zStrSrc.len - start;
        };
    };

    zStrDst.ptr = MEM_Alloc (count+2)+1; /* +1 for reference counter byte, +1 for null byte */
    zStrDst.res = count;

    MEM_CopyBytes (zStrSrc.ptr + start, zStrDst.ptr, count);

    zStrDst.len = count;

    return dstStr;
};

/*
 *	Copied from Ikarus --> MEM_Error & MEM_Warn calls removed
 */
func string mySTR_Prefix (var string str, var int len) {
    return mySTR_SubStr(str, 0, len);
};

/*
 *	R  G  B  A
 *	FF FF FF FF
 */
func int HEX2RGBA (var string hex) {
	var int R; R = 255;
	var int G; G = 255;
	var int B; B = 255;
	var int A; A = 255;

	if (STR_Len(hex) > 1) { R = hex2dec (mySTR_SubStr (hex, 0, 2)); };
	if (STR_Len(hex) > 3) { G = hex2dec (mySTR_SubStr (hex, 2, 2)); };
	if (STR_Len(hex) > 5) { B = hex2dec (mySTR_SubStr (hex, 4, 2)); };
	if (STR_Len(hex) > 7) { A = hex2dec (mySTR_SubStr (hex, 6, 2)); };

	return RGBA (R, G, B, A);
};

/*
 *	Original function STR_Trim (author: szapp aka Mud-freak) - split into 2 functions
 */
func string STR_TrimL(var string str, var string tok) {
    var int lenS; lenS = STR_Len(str);
    var int lenT; lenT = STR_Len(tok);

    var string ss;
    var string ts;
    var int cont;
    var int t;

    // Start from the beginning
    var int startP; startP = 0;

    while(startP < lenS);
        ss = STR_Substr(str, startP, 1);
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

        startP += 1;
    end;

    if (startP >= lenS) {
        return "";
    } else {
        return STR_Substr(str, startP, lenS-startP);
    };
};

func string STR_TrimR(var string str, var string tok) {
    var int lenS; lenS = STR_Len(str);
    var int lenT; lenT = STR_Len(tok);

    var string ss;
    var string ts;
    var int cont;
    var int t;

    // Start from the end
    var int endP; endP = lenS-1;

    while(endP >= 0);
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

    if (endP <= 0) {
        return "";
    } else {
        return STR_Substr(str, 0, endP);
    };
};

/*
 *	Copied from Ikarus --> added startFrom
 */
func int STR_IndexOfFrom (var string str, var string tok, var int startFrom) {
    var zString zStr; zStr = _^(_@s(str));
    var zString zTok; zTok = _^(_@s(tok));

    if(zTok.len == 0) {
        return 0;
    };
    if (zStr.len == 0) {
        return -1;
    };

    var int startPos; startPos = zStr.ptr + startFrom;
    var int startMax; startMax = zStr.ptr + zStr.len - zTok.len;

    var int loopPos; loopPos = MEM_StackPos.position;
    if (startPos <= startMax) {
        if (MEM_CompareBytes(startPos, zTok.ptr, zTok.len)) {
            return startPos - zStr.ptr;
        };
        startPos += 1;
        MEM_StackPos.position = loopPos;
    };
    return -1;
};

/*
 *	Converts char to byte value, 'A' to 64, 'a' to 96
 */
func int CtoB (var string s) {
	var int buf; buf = STR_toChar (s);
	var int chr; chr = MEM_ReadInt (buf) & 255;
	return chr;
};

/*
 *	Converts byte back to char, 96 to 'a', 64 to 'A'
 */
func string BtoC (var int i) {
	const int mem = 0;
	if (!mem) { mem = MEM_Alloc (1); };

	MEM_WriteByte (mem, i);
	return STR_FromChar (mem);
};

func string STR_Left (var string s, var int count) {
	var int len; len = STR_Len (s);

	if (len < count) {
		return s;
	};

	return mySTR_SubStr (s, 0, count);
};

func string STR_Right (var string s, var int count) {
	var int len; len = STR_Len (s);

	if (len < count) {
		return s;
	};

	return mySTR_SubStr (s, len - count, count);
};

/*
 *	Just a little wrapper function ... to eliminate unnecessary code
 *	LeGo already has STR_StartsWith, so why not :)
 */
func int STR_EndsWith (var string s, var string s1) {
	return Hlp_StrCmp (STR_Right (s, STR_Len (s1)), s1);
};

/*
 *
 */
func string STR_AddString (var string s, var string s1, var string separator) {
	if (STR_Len (s) > 0) {
		s = ConcatStrings (s, separator);
	};

	s = ConcatStrings (s, s1);

	return s;
};

/*
 *
 *	 - derived from mud-freak's STR_IndexOfFirstNonNumeric function
 */
func int STR_IsNumeric (var string s) {
	var int len; len = STR_Len (s);
	var int buf; buf = STR_toChar (s);

	var int index; index = 0;

	if (!len) { return FALSE; };

	while(index < len);
		var int chr; chr = MEM_ReadInt(buf + index) & 255;

		if (chr >= 48 /* 0 */) && (chr <= 57 /* 9 */) {

		} else if ((chr != 45 /*-*/) && (chr != 43 /*+*/)) && (index == 0) {

		} else {
			return FALSE;
		};

		index += 1;
	end;

	return TRUE;
};

/*
 *	ConcatStrings
 */
func string Concat3Strings (var string s1, var string s2, var string s3) {
	var string s;
	s = ConcatStrings (s1, s2);
	s = ConcatStrings (s, s3);
	return s;
};

func string Concat4Strings (var string s1, var string s2, var string s3, var string s4) {
	var string s;
	s = ConcatStrings (s1, s2);
	s = ConcatStrings (s, s3);
	s = ConcatStrings (s, s4);
	return s;
};

func string Concat5Strings (var string s1, var string s2, var string s3, var string s4, var string s5) {
	var string s;
	s = ConcatStrings (s1, s2);
	s = ConcatStrings (s, s3);
	s = ConcatStrings (s, s4);
	s = ConcatStrings (s, s5);
	return s;
};
