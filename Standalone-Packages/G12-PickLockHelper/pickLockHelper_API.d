const string pickLockHelper_FontName		= "font_old_10_white.tga";	//font
const string pickLockHelper_FrameTex		= "DLG_NOISE.TGA";		//frame texture
const int pickLockHelper_Alpha			= 192;				//Alpha

const int pickLockHelper_ShowFailedAttempt	= 1;				//Toggle option - should last failed attempt be displayed?

//Localization
const string pickLockHelper_LeftKey		= "L";
const string pickLockHelper_RightKey		= "R";

//PickLockHelper position
const int pickLockHelper_PPosX			= 0;				//X position, if not defined (-1) then it will be in a middle of screen on X axis
const int pickLockHelper_PPosY			= -1;				//Y position, if not defined (-1) then it will be in a middle of screen on Y axis
//Virtual positions have higher prio than pixel positions.
const int pickLockHelper_VPosX			= -1;				//if not defined (-1) then pickLockHelper_PPosX will be taken into consideration. Virtual coordinates
const int pickLockHelper_VPosY			= -1;				//if not defined (-1) then pickLockHelper_PPosY will be taken into consideration. Virtual coordinates

const int pickLockHelper_WidthPxl		= 320;				//default Width in pixels

//Internal constants and variables

const int pickLockHelper_LastMob = 0;
