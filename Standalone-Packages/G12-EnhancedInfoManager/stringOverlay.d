/*
 *	Author: L-Titan (Gelaos)
 *	https://github.com/Gelaos/G2A-Gelaos-Mod/blob/master/CONTENT/GelaosMod/Functions/StringOverlay.d
 */

// -----------------------------------------------------------------
// -----------------------------------------------------------------
// PaddString()
// pads the source string with padding string (multiple times, if needed) from the start or from the end of source string
// until the resulting string reaches the given length.
//
// EXAMPLES:
// PaddString("abc", 2, "X",       PADD_START)    -->    "abc"
// PaddString("abc", 6, "X",       PADD_START)    --> "XXXabc"
// PaddString("abc", 6, "XY",      PADD_START)    --> "YXYabc"
// PaddString("abc", 6, "ABCDEF",  PADD_START)    --> "DEFabc"
// PaddString("abc", 6, "X",       PADD_END)      -->    "abcXXX"
// PaddString("abc", 6, "XY",      PADD_END)      -->    "abcXYX"
// PaddString("abc", 6, "ABCDEF",  PADD_END)      -->    "abcABC"
//
// -----------------------------------------------------------------
// -----------------------------------------------------------------
const int PADD_START  = 0;
const int PADD_END = 1;
const string PADD_STR_DEFAULT = " ";

func string PaddString(var string sourceStr, var int resultLen, var string padStr, var int padSide) {
    var string resultStr; resultStr = sourceStr;
    var int padLen; padLen = STR_Len(padStr);

    if (STR_Len(sourceStr) >= resultLen) {  return resultStr; };

    // add padding string (multiple times, if needed)
    while ( STR_Len(resultStr) + padLen <= resultLen );
        if (padSide == PADD_START)  { resultStr = ConcatStrings(padStr, resultStr); };
        if (padSide == PADD_END)    { resultStr = ConcatStrings(resultStr, padStr); };
    end;

    // add remaining part of padding string, if necessary (to reach the target length)
    var int remainingChars; remainingChars = resultLen - STR_Len(resultStr);
    if (remainingChars > 0) {
        if (padSide == PADD_START) {
            resultStr = ConcatStrings(STR_SubStr(padStr, padLen - remainingChars, remainingChars), resultStr);
        };
        if (padSide == PADD_END) {
            resultStr = ConcatStrings(resultStr, STR_SubStr(padStr, 0, remainingChars));
        };
    };

    return resultStr;
};

// -----------------------------------------------------------------
func string PaddStringStart(var string sourceStr, var int resultLen) {
    PaddString(sourceStr, resultLen, PADD_STR_DEFAULT, PADD_START);
};
// -----------------------------------------------------------------
func string PaddStringRight(var string sourceStr, var int resultLen) {
    PaddString(sourceStr, resultLen, PADD_STR_DEFAULT, PADD_END);
};

// -----------------------------------------------------------------
// -----------------------------------------------------------------
// StringOverlay
// generates EIM formatted overlay according to user setup
// -----------------------------------------------------------------
// -----------------------------------------------------------------
//
// ----------- SETUP -----------
// StringOverlay_Reset()
//     Clears the formatter settings.
//
// ----------- COLORS -----------
// StringOverlay_Set_Color(hexColor, hexColorSelected)
//     Enables color formatting. Sets colors: 'hexColor' for non-selected dialogue text, 'hexColorSelected' for selected dialogue text.
//     Both colors must be valid 6-digit hexadecimal color code strings without hashtag, i.e. 'FF5733'.
//
// StringOverlay_Set_ColorPreset(preset)
//    Enables color formatting. Sets colors for non-selected dialogue text and for selected text according to predefined color preset.
//    'preset' must be integer for valid preset. If color preset for 'preset' is not defined, default Gothic dialogue text colors are used.
//    The color preset is defined by hexcolors stored in two arrays:
//         StringOverlay_ColorPresets[]           - colors for non-selected dialogue text
//         StringOverlay_ColorSelectedPresets[]   - colors for selected dialogue text
//    When defining new preset, both arrays must be filled with respective colors and the constant 'StringOverlay_ColorPreset_Count' must be incremented.
//
// StringOverlay_Disable_Color()
//    Disables color formatting. It's equivalent to StringOverlay_Disable_ColorPreset().
//
// StringOverlay_Disable_ColorPreset()
//    Disables color formatting. It's equivalent to StringOverlay_Disable_Color().
//
// ----------- TEXT ALIGN -----------
// StringOverlay_Set_TextAlign(align)
//     Enables text-align formatting. Available aligns:
//         StringOverlay_TextAlign_Left   (default)
//         StringOverlay_TextAlign_Center
//         StringOverlay_TextAlign_Right
//
// StringOverlay_Disable_TextAlign()
//     Disables text-align formatting.
//
// ----------- TEXT PADDING -----------
// StringOverlay_Set_Padding(length, side, padStr)
//     Enables text padding formatting. Pads with string 'padStr' (multiple times, if needed)
//     from the start or from the end of source string (defined by 'side') until the resulting string reaches the given length.
//     Available sides:
//         StringOverlay_Padding_Side_Start (default)
//         StringOverlay_Padding_Side_End
//     For more information, see documentation for function 'PaddString()'.
//
// StringOverlay_Set_PaddingStart(length, padStr)
//     Enables text padding formatting. Pads with 'padStr' (multiple times, if needed) from the start of source string
//     until the resulting string reaches the given length.
//
// StringOverlay_Set_PaddingEnd(length, padStr)
//     Enables text padding formatting. Pads with 'padStr' (multiple times, if needed) from the end of source string
//     until the resulting string reaches the given length.
//
// StringOverlay_Disable_Padding()
//     Disables text padding formatting.
//
// ----------- APPLY FORMATTING -----------
// StringOverlay_Generate('sourceStr')
//     Returns overlay string formatted according to formatting settings.

// Modifier  Usage                              Explanation
// f@		'f@font_15_white.tga TEST'			- applies font_15_white.tga to greyed out dialog choice. Has to be separated by space.
// fs@		'fs@font_old_20_white.tga TEST'		- applies font_old_20_white.tga to selected dialog choice. Has to be separated by space.
// h@		'h@00CC66 TEST'					    - applies color in hexcode to greyed out dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
// hs@		'hs@66FFB2 TEST'				    - applies color in hexcode to selected dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
// a@		'a@TEST' 'a@ TEST'				    - enables answering mode. Does not have to be separated by space. (removes space after @ sign if there is any)
// s@		's@spinnerID TEST'				    - enables spinner mode. Has to be separated by space. Requires unique spinnerID after @ sign.
// d@		'd@'						        - disables dialog choice. Player will not be able to select such dialog choice. Does not have to be separated by space.
// al@		'al@'						        - aligns text to left. Does not have to be separated by space.
// ac@		'ac@'						        - aligns text to center. Does not have to be separated by space.
// ar@		'ar@'						        - aligns text to right. Does not have to be separated by space.
// o@		'o@format:TEST~'				    - adds text in between : ~ as an overlay with its own format (unique color or alignment). Don't use with fonts changing text height - this is not supported yet.
//          'o@h@00CC66 hs@66FFB2:TEST~'
//  		'o@ar@ h@00CC66 hs@66FFB2:TEST~'

// StringOverlay basic setup -----------------------------
var int   StringOverlay_Settings;
const int StringOverlay_Settings_ColorEnabled        = 1 << 1;
const int StringOverlay_Settings_TextAlignEnabled    = 1 << 2;
const int StringOverlay_Settings_PaddingEnabled      = 1 << 3;

// dialoge colors --------------------------------------------------
var int    StringOverlay_ColorPreset; // color template (sets colors)
var string StringOverlay_Color; // color for dialogue text not selected
var string StringOverlay_ColorSelected; // color for selected dialogue text

const int StringOverlay_ColorPreset_Count    = 6; // count of available colors
const int StringOverlay_ColorPreset_Default  = 0; // default preset
const int StringOverlay_ColorPreset_Red      = 1;
const int StringOverlay_ColorPreset_Green    = 2;
const int StringOverlay_ColorPreset_Yellow   = 3;
const int StringOverlay_ColorPreset_Blue     = 4;
const int StringOverlay_ColorPreset_Orange   = 5;

// colors for dialogue text not selected
const string StringOverlay_ColorPresets[StringOverlay_ColorPreset_Count] = {
    "C8C8C8", // G1 standard dialog - grey color
    "FF3030", // red
    "00CC66", // green
    "FFF700", // yellow
    "6699FF", // blue
    "FF8000"  // orange
};
// colors for selected dialogue text
const string StringOverlay_ColorSelectedPresets[StringOverlay_ColorPreset_Count] = {
    "FFFFFF", // G1 standard dialog - white color
    "FF4646", // light red
    "66FFB2", // light green
    "FFFB80", // light yellow
    "99CCFF", // light blue
    "FFB266"  // light orange
};

// text align ------------------------------------------------------
var int   StringOverlay_TextAlign; // color set by user
const int StringOverlay_TextAlign_Left = 0;
const int StringOverlay_TextAlign_Center = 1;
const int StringOverlay_TextAlign_Right = 2;

// text padding ----------------------------------------------------
var int    StringOverlay_Padding_Side;
var int    StringOverlay_Padding_ResultLength;
var string StringOverlay_Padding_String;

const int    StringOverlay_Padding_Side_Start    = PADD_START;
const int    StringOverlay_Padding_Side_End      = PADD_END;
const string StringOverlay_Padding_StringDefault = " ";

// -----------------------------------------------------------------
func void StringOverlay_Set_Color(var string hexColor, var string hexColorSelected) {
    // set color enabled flag
    StringOverlay_Settings = (StringOverlay_Settings | StringOverlay_Settings_ColorEnabled);

    StringOverlay_Color = hexColor;
    StringOverlay_ColorSelected = hexColorSelected;
};

func void StringOverlay_Disable_Color() {
    // remove color enabled flag
    StringOverlay_Settings = StringOverlay_Settings - (StringOverlay_Settings & StringOverlay_Settings_ColorEnabled);
};

func void StringOverlay_Disable_ColorPreset() {
    StringOverlay_Disable_Color();
};

func void StringOverlay_Set_ColorPreset(var int colorPreset) {
    var int preset; preset = colorPreset;

    // if given preset is not defined, use default preset
    if (colorPreset < 0 || colorPreset >= StringOverlay_ColorPreset_Count ) {
        preset = StringOverlay_ColorPreset_Default;
    };

    StringOverlay_Set_Color(
        MEM_ReadStatStringArr(StringOverlay_ColorPresets, preset),
        MEM_ReadStatStringArr(StringOverlay_ColorSelectedPresets, preset)
    );
};
// -----------------------------------------------------------------
func void StringOverlay_Set_TextAlign(var int align) {
    // set text align enabled flag
    StringOverlay_Settings = (StringOverlay_Settings | StringOverlay_Settings_TextAlignEnabled);

    StringOverlay_TextAlign = align;

    // if given text align not defined, use default
    if (StringOverlay_TextAlign < 0 || StringOverlay_TextAlign > StringOverlay_TextAlign_Right) {
        StringOverlay_TextAlign = StringOverlay_TextAlign_Left;
    };
};

func void StringOverlay_Disable_TextAlign() {
    // remove text align enabled flag
    StringOverlay_Settings = StringOverlay_Settings - (StringOverlay_Settings & StringOverlay_Settings_TextAlignEnabled);
};
// -----------------------------------------------------------------
func void StringOverlay_Set_Padding(var int resultLen, var int padSide,  var string padStr) {
    // set padding enabled flag
    StringOverlay_Settings = (StringOverlay_Settings | StringOverlay_Settings_PaddingEnabled);

    StringOverlay_Padding_ResultLength = resultLen;
    StringOverlay_Padding_Side = padSide;
    StringOverlay_Padding_String = padStr;

    // if given padding side not defined, use default
    if (padSide < 0 || padSide > StringOverlay_Padding_Side_End) {
        StringOverlay_Padding_Side = StringOverlay_Padding_Side_Start;
    };
};

func void StringOverlay_Disable_Padding() {
    // remove padding enabled flag
    StringOverlay_Settings = StringOverlay_Settings - (StringOverlay_Settings & StringOverlay_Settings_PaddingEnabled);
};

func void StringOverlay_Set_PaddingStart(var int resultLen, var string padStr) {
    StringOverlay_Set_Padding(resultLen, StringOverlay_Padding_Side_Start, padStr);
};

func void StringOverlay_Set_PaddingEnd(var int resultLen, var string padStr) {
    StringOverlay_Set_Padding(resultLen, StringOverlay_Padding_Side_End, padStr);
};
// -----------------------------------------------------------------
func void StringOverlay_Reset() {
    StringOverlay_Settings = 0;
};
// -----------------------------------------------------------------
func string StringOverlay_Generate(var string str) {
    if (STR_Len(str) <= 0) {
        return "";
    };

    // start overlay
    var string overlayStr; overlayStr = "o@";

    // text align
    if (StringOverlay_Settings & StringOverlay_Settings_TextAlignEnabled) {
        var string textAlignModifier; textAlignModifier = "";

        if (StringOverlay_TextAlign == StringOverlay_TextAlign_Left  ) {textAlignModifier = "al@"; };
        if (StringOverlay_TextAlign == StringOverlay_TextAlign_Center) {textAlignModifier = "ac@"; };
        if (StringOverlay_TextAlign == StringOverlay_TextAlign_Right ) {textAlignModifier = "ar@"; };

        overlayStr = ConcatStrings(overlayStr, textAlignModifier);
        overlayStr = ConcatStrings(overlayStr, " ");
    };

    // text color
    if (StringOverlay_Settings & StringOverlay_Settings_ColorEnabled) {
        overlayStr = ConcatStrings(overlayStr, "h@");
        overlayStr = ConcatStrings(overlayStr, StringOverlay_Color);
        overlayStr = ConcatStrings(overlayStr, " hs@");
        overlayStr = ConcatStrings(overlayStr, StringOverlay_ColorSelected);
    };

    // start content
    overlayStr = ConcatStrings(overlayStr, ":");

    // padding
    if (StringOverlay_Settings & StringOverlay_Settings_PaddingEnabled) {
        overlayStr = ConcatStrings(
            overlayStr,
            PaddString(str, StringOverlay_Padding_ResultLength, StringOverlay_Padding_String, StringOverlay_Padding_Side)
        );
    }
    // no padding
    else {
        overlayStr = ConcatStrings(overlayStr, str);
    };

    // end overlay
    overlayStr = ConcatStrings(overlayStr, "~");

    return overlayStr;
};

/*
 *	StringOverlay_UseColorPreset
 */
func string StringOverlay_UseColorPreset (var int colorPreset, var string str) {
	var int backupSetting; backupSetting = StringOverlay_Settings;

	StringOverlay_Reset ();
	StringOverlay_Set_ColorPreset (colorPreset);
	var string s; s = StringOverlay_Generate (str);

	StringOverlay_Settings = backupSetting;

	return s;
};
