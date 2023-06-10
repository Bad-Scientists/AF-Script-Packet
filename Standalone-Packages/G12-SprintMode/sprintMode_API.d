/*
//Copy these constants outside of the script packet - define your own values.
//If script-packet is updated in the future - your definition will be unaffected.

const int PC_SPRINTMODEBAR_PPOSX = -1;		//If not defined script will put bar right underneath health bar
const int PC_SPRINTMODEBAR_PPOSY = -1;		//If not defined script will put bar right underneath health bar

//Virtual positions have higher prio than pixel positions.
const int PC_SPRINTMODEBAR_VPOSX = -1;		//if not defined (-1) then PC_SprintModeBar_PPosX will be taken into consideration. Virtual coordinates
const int PC_SPRINTMODEBAR_VPOSY = -1;		//if not defined (-1) then PC_SprintModeBar_PPosY will be taken into consideration. Virtual coordinates


const int BAR_TEX_SPRINTMODE_STAMINA = 0;	//Bar texture for stamina
const int BAR_TEX_SPRINTMODE_TIMEDOVERLAY = 1;	//Bar texture for timed overlays (potions)

const string PC_SPRINTMODEBAR_TEX = "BAR_MISC.TGA";
const string PC_SPRINTMODEBAR_TIMED_TEX = "BAR_SPRINTMODE_TIMEDOVERLAY.TGA";

//Default spint mode overlay
const string PC_SPRINTMODEOVERLAYNAME = "HUMANS_SPRINT.MDS";	//HUMANS_SPRINT.MDS

//Don't activate sprint mode if already in sprint mode - or if drunk :)
const int PC_SPRINTMODE_IGNOREWITHOVERLAYS_COUNT = 2;

const string PC_SPRINTMODE_IGNOREWITHOVERLAYS0 = "HUMANS_SPRINT.MDS";
const string PC_SPRINTMODE_IGNOREWITHOVERLAYS1 = "HUMANS_DRUNKEN.MDS";

//When removing duplicate timed overlays script can either sum up all timers or get max value
//0 get max value
//1 sum up all timers
const int PC_SPRINTMODEBAR_TIMEDOVERLAY_STACKING = 0;

//Initial stamina
const int PC_SPRINTMODE_STAMINAMAX_DEFAULT = 80;
const int PC_SPRINTMODE_CONSUMESTAMINA_DEFAULT = TRUE;

//const int ALPHA_FUNC_MAT_DEFAULT	= 0;
//const int ALPHA_FUNC_NONE		= 1;
//const int ALPHA_FUNC_BLEND	= 2;
//const int ALPHA_FUNC_ADD		= 3;
//const int ALPHA_FUNC_SUB		= 4;
//const int ALPHA_FUNC_MUL		= 5;
//const int ALPHA_FUNC_MUL2		= 6;
//const int ALPHA_FUNC_TEST		= 7;

const int SPRINTBAR_DISPLAYMETHOD = BarDisplay_DynamicUpdate;
const int SPRINTBAR_PREVIEWEFFECT = BarPreviewEffect_FadeInOut;

const int SPRINTBAR_DISPLAYVALUES = 1;
const int SPRINTBAR_VIEW_ALPHAFUNC = 2; //ALPHA_FUNC_BLEND
const string SPRINTBAR_DISPLAYVALUES_COLOR = "FFFFFF";
*/
