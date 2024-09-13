//Default dialog colors
//G1 standard dialog - white color FFFFFF
const string InfoManagerDefaultDialogColorSelected = "FFFFFF";
//G1 standard dialog - grey color C8C8C8
const string InfoManagerDefaultColorDialogGrey = "C8C8C8";

//Default font for selected dialog choice (if blank default Gothic version will be used)
const string InfoManagerDefaultFontDialogSelected = STR_EMPTY;
//Default font for greyed (if blank default Gothic version will be used)
const string InfoManagerDefaultFontDialogGrey = STR_EMPTY;

//Disabled color - selected
const string InfoManagerDisabledDialogColorSelected = "808080";
//Disabled color - grey
const string InfoManagerDisabledColorDialogGrey = "666666";

//Default text alignment
//ALIGN_CENTER, ALIGN_LEFT, ALIGN_RIGHT defined in LeGo
const int InfoManagerDefaultDialogAlignment = ALIGN_LEFT;

//Default color for 'answer' and 'spinner' indicator - if empty it will be same as underlying dialog
const string InfoManagerIndicatorColorDefault = "C8C8C8";
//Default alpha value for 'answer' and 'spinner' indicator
const int InfoManagerIndicatorAlpha = 196;

//Default spinner indicator (non animated)
const string InfoManagerSpinnerIndicatorString = "<-- -->";
//Default answer/input field indicator
const string InfoManagerAnswerIndicatorString = "...";

//Set to TRUE if you want animated spinner
const int InfoManagerSpinnerIndicatorAnimation = 1;
const int InfoManagerAnswerAnimation = 1;

//Dialog 'NumKey' controls [WIP]
//Set to TRUE if you want to enable num key support for dialogs
const int InfoManagerNumKeysControls = 1;
//Set to TRUE if you want to add dialog numbers next to each dialog (formatted in function InfoManagerNumKeyString)
const int InfoManagerNumKeysNumbers = 0;

//const int ALPHA_FUNC_MAT_DEFAULT = 0;
//const int ALPHA_FUNC_NONE = 1;
//const int ALPHA_FUNC_BLEND = 2;
//const int ALPHA_FUNC_ADD = 3;
//const int ALPHA_FUNC_SUB = 4;
//const int ALPHA_FUNC_MUL = 5;
//const int ALPHA_FUNC_MUL2 = 6;
//const int ALPHA_FUNC_TEST = 7;

//ALPHA_FUNC_NONE (is Gothic default), ALPHA_FUNC_ADD (is kinda nicer :) )
const int InfoManagerAlphaBlendFunc = 3;

//const int cIM_RememberSelectedChoice_None = 0; //Does nothing (default vanilla behaviour)
//const int cIM_RememberSelectedChoice_All = 1; //Moves cursor to last selected choice
//const int cIM_RememberSelectedChoice_Spinners = 2; //Moves cursor to last selected choice only when used with spinners
const int InfoManagerRememberSelectedChoice = cIM_RememberSelectedChoice_Spinners;
