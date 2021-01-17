//https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page3?p=25717007&viewfull=1#post25717007

/*
 * convert.d
 *
 * Number conversion functions
 *
 * - Requires Ikarus, strings.d
 * - Compatible with Gothic 1 and Gothic 2
 *
 *
 *  func string dec2hex(int    dec)
 *  func int    hex2dec(string hex)
 *
 *  func string dec2bin(int    dec)
 *  func int    bin2dec(string bin)
 *
 *  func string hex2bin(string hex)
 *  func string bin2hex(string bin)
 *
 *  func int    h(string hex)       Shorter alias for hex2dec
 *  func int    b(string bin)       Shorter alias for bin2dec
 */


/*
 * Fix function from Ikarus: Based on MEMINT_ByteToKeyHex
 */
func string byte2hex(var int byte) {
    const int ASCII_0 = 48;
    const int ASCII_A = 65;
    byte = byte & 255;

    // Fix ASCII characters (A to F)
    var int c1; c1 = (byte >> 4);
    if (c1 >= 10) {
        c1 += ASCII_A-ASCII_0-10;
    };
    var int c2; c2 = (byte & 15);
    if (c2 >= 10) {
        c2 += ASCII_A-ASCII_0-10;
    };

    const int mem = 0;
    if (!mem) { mem = MEM_Alloc(3); };

    MEM_WriteByte(mem    , c1 + ASCII_0);
    MEM_WriteByte(mem + 1, c2 + ASCII_0);
    return STR_FromChar(mem);
};


/*
 * Convert decimal to hexadecimal (big endian)
 */
func string dec2hex(var int dec) {
    var string hex; hex = "";
    hex = ConcatStrings(hex, byte2hex(dec >> 24));
    hex = ConcatStrings(hex, byte2hex(dec >> 16));
    hex = ConcatStrings(hex, byte2hex(dec >> 8));
    hex = ConcatStrings(hex, byte2hex(dec));
    return hex;
};


/*
 * Convert hexadecimal to decimal (big endian)
 */
func int hex2dec(var string hex) {
    var zString zStr; zStr = _^(_@s(hex));
    if (!zStr.len) {
        return 0;
    };

    // Remove 0x prefix and h postfix
    hex = STR_Lower(hex);
    if (Hlp_StrCmp(STR_Prefix(hex, 2), "0x")) {
        hex = STR_SubStr(hex, 2, zStr.len-2);
    } else if (MEM_ReadByte(zStr.ptr+zStr.len-1) == /*h*/ 104) {
        hex = STR_Prefix(hex, zStr.len-1);
    };

    // Remove any spaces
    hex = STR_ReplaceAll(hex, " ", "");

    // Check length
    if (zStr.len > 8) {
        MEM_Error("hex2dec: Hexadecimal number to big. Considering the last 4 bytes only.");
        hex = STR_Postfix(hex, zStr.len-8);
    };

    // Iterate over all characters (from back to front)
    var int dec; dec = 0;
    repeat(i, zStr.len); var int i;
        dec += MEMINT_HexCharToInt(MEM_ReadByte(zStr.ptr+(zStr.len-1)-i)) << 4*i;
    end;

    return dec;
};
func int h(var string hex) {
    return hex2dec(hex);
};


/*
 * Convert decimal to binary
 */
func string dec2bin(var int dec) {
    var string bin; bin = "";
    repeat(i, 32); var int i;
        if (dec & (1 << i)) {
            bin = ConcatStrings("1", bin);
        } else {
            bin = ConcatStrings("0", bin);
        };
    end;
    return bin;
};


/*
 * Convert hexadecimal to binary
 */
func string hex2bin(var string hex) {
    return dec2bin(hex2dec(hex));
};


/*
 * Convert binary to decimal
 */
func int bin2dec(var string bin) {
    var zString zStr; zStr = _^(_@s(bin));
    if (!zStr.len) {
        return 0;
    };

    // Remove any spaces
    bin = STR_ReplaceAll(bin, " ", "");

    // Check length
    if (zStr.len > 32) {
        MEM_Error("bin2dec: Binary number to big. Considering the last 32 bits only.");
        bin = STR_Postfix(bin, zStr.len-32);
    };

    // Iterate over all characters (from back to front)
    const int ASCII_0 = 48;
    const int ASCII_1 = 49;
    var int dec; dec = 0;
    repeat(i, zStr.len); var int i;
        var int c; c = MEM_ReadByte(zStr.ptr+(zStr.len-1)-i);
        if (c < ASCII_0) || (c > ASCII_1) {
            MEM_Error(ConcatStrings("bin2dec: Invalid binary char: ", STR_FromChar(_@(c))));
            return 0;
        };

        dec += (c - ASCII_0) << i;
    end;

    return dec;
};
func int b(var string bin) {
    return bin2dec(bin);
};


/*
 * Convert binary to hexadecimal
 */
func string bin2hex(var string bin) {
    return dec2hex(bin2dec(bin));
};