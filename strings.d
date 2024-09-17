/*
 *	Copied from Ikarus --> MEM_Error & MEM_Warn calls removed
 *	MEM_Error will eventually cause Gothic to crash in my experience
 */
func string mySTR_SubStr (var string str, var int start, var int count) {
    if (start < 0) || (count < 0) {
        //MEM_Error ("STR_SubStr: start and count may not be negative.");
        return STR_EMPTY;
    };

    /* Hole Adressen von zwei Strings, Source und Destination (für Kopieroperation) */
    var zString zStrSrc;
    var zString zStrDst; var string dstStr; dstStr = STR_EMPTY;

    zStrSrc = _^(_@s(str));
    zStrDst = _^(_@s(dstStr));

    if (zStrSrc.len < start + count) {
        if (zStrSrc.len < start) {
            //MEM_Warn ("STR_SubStr: The desired start of the substring lies beyond the end of the string.");
            return STR_EMPTY;

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
        return STR_EMPTY;
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
        return STR_EMPTY;
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
 *	Converts char to byte value, 'A' to 65, 'a' to 97
 */
func int CtoB (var string s) {
	var int buf; buf = STR_toChar (s);
	var int chr; chr = MEM_ReadInt (buf) & 255;
	return chr;
};

/*
 *	Converts byte back to char, 97 to 'a', 65 to 'A'
 */
func string BtoC (var int i) {
	const int mem = 0;
	if (!mem) { mem = MEM_Alloc (1); };

	MEM_WriteByte (mem, i);
	return STR_FromChar (mem);
};

func string STR_Left (var string s, var int count) {
	if (STR_Len (s) < count) {
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

	return ConcatStrings (s, s1);
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
	var string s; s = ConcatStrings (s1, s2);
	s = ConcatStrings (s, s3);
	return s;
};

func string Concat4Strings (var string s1, var string s2, var string s3, var string s4) {
	var string s; s = ConcatStrings (s1, s2);
	s = ConcatStrings (s, s3);
	s = ConcatStrings (s, s4);
	return s;
};

func string Concat5Strings (var string s1, var string s2, var string s3, var string s4, var string s5) {
	var string s; s = ConcatStrings (s1, s2);
	s = ConcatStrings (s, s3);
	s = ConcatStrings (s, s4);
	s = ConcatStrings (s, s5);
	return s;
};

/*
 *	MEM_StringArray* functions
 */

func void MEM_StringArrayFree (var int arrPtr) {
	if (!arrPtr) { return; };

	var zCArray arr; arr = _^ (arrPtr);

	var int ptr;

	repeat (i, arr.numInArray); var int i;
		ptr = MEM_ArrayRead (arrPtr, i);
		MEM_Free (ptr);
	end;

	MEM_ArrayFree (arrPtr);
};

func void MEM_StringArrayInsert (var int arrPtr, var string s) {
	var int ptr; ptr = MEM_Alloc (sizeof_zString);
	MEM_WriteString (ptr, s);

	MEM_ArrayInsert (arrPtr, ptr);
};

func void MEM_StringArrayRemoveIndex (var int arrPtr, var int index) {
	if (!arrPtr) { return; };
	var zCArray arr; arr = _^ (arrPtr);

	var int ptr; ptr = MEM_ArrayRead (arrPtr, index);
	MEM_Free (ptr);

	MEM_ArrayRemoveIndex (arrPtr, index);
};

func string MEM_StringArrayGetString (var int arrPtr, var int index) {
	if (!arrPtr) { return STR_EMPTY; };

	var zCArray arr; arr = _^ (arrPtr);

	var int ptr;
	var string t;

	ptr = MEM_ArrayRead (arrPtr, index);

	if (ptr) {
		t = MEM_ReadString (ptr);
		return t;
	};

	return STR_EMPTY;
};

func int MEM_StringArrayContains (var int arrPtr, var string s) {
	if (!arrPtr) { return FALSE; };

	var zCArray arr; arr = _^ (arrPtr);

	var int ptr;
	var string t;

	repeat (i, arr.numInArray); var int i;
		ptr = MEM_ArrayRead (arrPtr, i);

		if (ptr) {
			t = MEM_ReadString (ptr);
			if (Hlp_StrCmp (t, s)) {
				return TRUE;
			};
		};
	end;

	return FALSE;
};

/*
 *	STR_FormatLeadingZeros
 */
func string STR_FormatLeadingZeros (var int number, var int total) {
	var string s; s = IntToString(number);
	var int len; len = STR_Len(s);

	while(len < total);
		s = ConcatStrings ("0", s);
		len += 1;
	end;

	return s;
};

func string STR_TrimDecimal(var string s, var int count) {
	var int len; len = STR_Len(s);
	var int buf; buf = STR_toChar(s);

	var int i; i = 0;

	while(i < len);
		var int c; c = MEM_ReadInt(buf + i) & 255;

		//Decimal separator '.'
		if (c == 46) {
			i += 1;

			while ((count > 0) && (i < len));
				count -= 1;
				i += 1;
			end;

			if (i < len) {
				s = STR_Left(s, i);
			};

			return s;
		};

		i += 1;
	end;

	return s;
};

func int STR_GetWords (var string s) {
	var int count; count = STR_SplitCount (s, STR_SPACE);
	return + count;
};

/*
 *	STR_PickWord
 *	 - returns word at selected index (word is here text string separated by space)
 *	 - index starts at 0
 *   0      1    2     3
 *  'insert item right here'
 */
func string STR_PickWord (var string s, var int num) {
	var int count; count = STR_SplitCount (s, STR_SPACE);

	if ((num < 0) || (num > count)) { return STR_EMPTY; };

	return STR_Split (s, STR_SPACE, num);
};

func string STR_RemoveWord (var string s, var int num) {
	var int count; count = STR_SplitCount (s, STR_SPACE);

	if ((num < 0) || (num > count)) { return s; };

	var string s1; s1 = STR_EMPTY;

	repeat (i, count); var int i;
		if (i == num) {
			continue;
		};

		if (STR_Len (s1)) {
			s1 = ConcatStrings (s1, STR_SPACE);
		};

		s1 = ConcatStrings (s1, STR_Split (s, STR_SPACE, i));
	end;

	return s1;
};

func int STR_WildMatch (var string s, var string pattern) {
	//We will allow single wild-card '*'
	var int indexWildcard;
	indexWildcard = STR_IndexOf (pattern, "*");

	if (indexWildcard > -1) {
		var string s1; s1 = mySTR_SubStr (pattern, 0, indexWildcard - 1);
		var string s2; s2 = mySTR_SubStr (pattern, indexWildcard + 1, STR_Len (pattern));

		return + (STR_StartsWith (s, s1) && STR_EndsWith (s, s2));
	};

	return + (Hlp_StrCmp (s, pattern));
};

/*
 *  STR_NotLeft
 *   - Get substring by cutting `count` chars from left
 */
func string STR_NotLeft (var string s, var int count) {
	var int len; len = STR_Len (s);

	if (len <= count) {
		return STR_EMPTY;
	};

	return mySTR_SubStr (s, count, len - count);
};

/*
 *  STR_NotRight
 *   - Get substring by cutting `count` chars from right
 */
func string STR_NotRight (var string s, var int count) {
	var int len; len = STR_Len (s);

	if (len <= count) {
		return STR_EMPTY;
	};

	return mySTR_SubStr (s, 0, len - count);
};

/*
 *  Ikarus equivalent of zParserExtender's `STR_format` function up to 4 %i and %s modifiers
 */
const string STR_format_CONST_S = "%s";
const string STR_format_CONST_I = "%i";

// One modifier functions
// S
func string STR_format_S(var string source, var string arg)
{
    return STR_ReplaceOnce(source, STR_format_CONST_S, arg);
};

// I
func string STR_format_I(var string source, var int arg)
{
    var string arg_i; arg_i = IntToString(arg);

    return STR_ReplaceOnce(source, STR_format_CONST_I, arg_i);
};


// Two modifiers functions
// SS
func string STR_format_SS(var string source, var string arg1, var string arg2)
{
    var string s; s = STR_format_S(source, arg1);

    return STR_format_S(s, arg2);
};

// SI
func string STR_format_SI(var string source, var string arg1, var int arg2)
{
    var string s; s = STR_format_S(source, arg1);

    return STR_format_I(s, arg2);
};

// IS
func string STR_format_IS(var string source, var int arg1, var string arg2)
{
    var string s; s = STR_format_I(source, arg1);

    return STR_format_S(s, arg2);
};

// II
func string STR_format_II(var string source, var int arg1, var int arg2)
{
    var string s; s = STR_format_I(source, arg1);

    return STR_format_I(s, arg2);
};


// Three modifiers functions
// SSS
func string STR_format_SSS(var string source, var string arg1, var string arg2, var string arg3)
{
    var string s; s = STR_format_SS(source, arg1, arg2);

    return STR_format_S(s, arg3);
};

// SSI
func string STR_format_SSI(var string source, var string arg1, var string arg2, var int arg3)
{
    var string s; s = STR_format_SS(source, arg1, arg2);

    return STR_format_I(s, arg3);
};

// SIS
func string STR_format_SIS(var string source, var string arg1, var int arg2, var string arg3)
{
    var string s; s = STR_format_SI(source, arg1, arg2);

    return STR_format_S(s, arg3);
};

// SII
func string STR_format_SII(var string source, var string arg1, var int arg2, var int arg3)
{
    var string s; s = STR_format_SI(source, arg1, arg2);

    return STR_format_I(s, arg3);
};

// ISS
func string STR_format_ISS(var string source, var int arg1, var string arg2, var string arg3)
{
    var string s; s = STR_format_IS(source, arg1, arg2);

    return STR_format_S(s, arg3);
};

// ISI
func string STR_format_ISI(var string source, var int arg1, var string arg2, var int arg3)
{
    var string s; s = STR_format_IS(source, arg1, arg2);

    return STR_format_I(s, arg3);
};

// IIS
func string STR_format_IIS(var string source, var int arg1, var int arg2, var string arg3)
{
    var string s; s = STR_format_II(source, arg1, arg2);

    return STR_format_S(s, arg3);
};

// III
func string STR_format_III(var string source, var int arg1, var int arg2, var int arg3)
{
    var string s; s = STR_format_II(source, arg1, arg2);

    return STR_format_I(s, arg3);
};


// Four modifiers functions
// SSSS
func string STR_format_SSSS(var string source, var string arg1, var string arg2, var string arg3, var string arg4)
{
    var string s; s = STR_format_SSS(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// SSSI
func string STR_format_SSSI(var string source, var string arg1, var string arg2, var string arg3, var int arg4)
{
    var string s; s = STR_format_SSS(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

// SSIS
func string STR_format_SSIS(var string source, var string arg1, var string arg2, var int arg3, var string arg4)
{
    var string s; s = STR_format_SSI(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// SSII
func string STR_format_SSII(var string source, var string arg1, var string arg2, var int arg3, var int arg4)
{
    var string s; s = STR_format_SSI(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

// SISS
func string STR_format_SISS(var string source, var string arg1, var int arg2, var string arg3, var string arg4)
{
    var string s; s = STR_format_SIS(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// SISI
func string STR_format_SISI(var string source, var string arg1, var int arg2, var string arg3, var int arg4)
{
    var string s; s = STR_format_SIS(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

// SIIS
func string STR_format_SIIS(var string source, var string arg1, var int arg2, var int arg3, var string arg4)
{
    var string s; s = STR_format_SII(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// SIII
func string STR_format_SIII(var string source, var string arg1, var int arg2, var int arg3, var int arg4)
{
    var string s; s = STR_format_SII(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

// ISSS
func string STR_format_ISSS(var string source, var int arg1, var string arg2, var string arg3, var string arg4)
{
    var string s; s = STR_format_ISS(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// ISSI
func string STR_format_ISSI(var string source, var int arg1, var string arg2, var string arg3, var int arg4)
{
    var string s; s = STR_format_ISS(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

// ISIS
func string STR_format_ISIS(var string source, var int arg1, var string arg2, var int arg3, var string arg4)
{
    var string s; s = STR_format_ISI(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// ISII
func string STR_format_ISII(var string source, var int arg1, var string arg2, var int arg3, var int arg4)
{
    var string s; s = STR_format_ISI(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

// IISS
func string STR_format_IISS(var string source, var int arg1, var int arg2, var string arg3, var string arg4)
{
    var string s; s = STR_format_IIS(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// IISI
func string STR_format_IISI(var string source, var int arg1, var int arg2, var string arg3, var int arg4)
{
    var string s; s = STR_format_IIS(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

// IIIS
func string STR_format_IIIS(var string source, var int arg1, var int arg2, var int arg3, var string arg4)
{
    var string s; s = STR_format_III(source, arg1, arg2, arg3);

    return STR_format_S(s, arg4);
};

// IIII
func string STR_format_IIII(var string source, var int arg1, var int arg2, var int arg3, var int arg4)
{
    var string s; s = STR_format_III(source, arg1, arg2, arg3);

    return STR_format_I(s, arg4);
};

//--

func int STR_Count (var string s, var string s1) {
	var int len; len = STR_Len (s);
	var int buf; buf = STR_toChar (s);

	var int c; c = STR_toChar (s1);
	c = MEM_ReadInt (c) & 255;

	var int index; index = 0;

	if (!len) { return 0; };

	var int count; count = 0;

	while (index < len);
		var int chr; chr = MEM_ReadInt(buf + index) & 255;

		if (c == chr) {
			count += 1;
		};

		index += 1;
	end;

	return count;
};
