/*
 *	Copied from Ikarus --> MEM_Error & MEM_Warn calls removed
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

    // Start from the beginning
    var int endP; endP = lenS-1;

    // Start from the end
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



