/*
 *	Picklock helper
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (translate to your own language, define your own rules for traders)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

//Toggle option - should last failed attempt be displayed?
const int PICKLOCKHELPER_SHOWFAILEDATTEMPT = 1;

const string PICKLOCKHELPER_FONTNAME = "FONT_OLD_10_WHITE.TGA";
const string PICKLOCKHELPER_FRAMETEX = "DLG_NOISE.TGA";
const int PICKLOCKHELPER_ALPHA = 192;

//Localization
const string PICKLOCKHELPER_LEFTKEY = "L";
const string PICKLOCKHELPER_RIGHTKEY = "R";

//PickLockHelper position
//X position, if not defined (-1) then it will be in a middle of screen on X axis
const int PICKLOCKHELPER_PPOSX = 0;
//Y position, if not defined (-1) then it will be in a middle of screen on Y axis
const int PICKLOCKHELPER_PPOSY = -1;

//Virtual positions have higher prio than pixel positions.
//if not defined (-1) then pickLockHelper_PPosX will be taken into consideration. Virtual coordinates
const int PICKLOCKHELPER_VPOSX = -1;
//if not defined (-1) then pickLockHelper_PPosY will be taken into consideration. Virtual coordinates
const int PICKLOCKHELPER_VPOSY = -1;

//Should picklockhelper view align automatically with inventory category view? (once inventory opens)
const int PICKLOCKHELPER_ALINGWITHINVCATVIEW = 1;

//default Width in pixels
const int PICKLOCKHELPER_WIDTHPXL = 160;

