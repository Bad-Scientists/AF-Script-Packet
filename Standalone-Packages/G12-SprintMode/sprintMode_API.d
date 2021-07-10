const int PC_SprintModeBar_PPosX		= -1;		//If not defined script will put bar right underneath health bar
const int PC_SprintModeBar_PPosY		= -1;		//If not defined script will put bar right underneath health bar

//Virtual positions have higher prio than pixel positions.
const int PC_SprintModeBar_VPosX		= -1;		//if not defined (-1) then PC_SprintModeBar_PPosX will be taken into consideration. Virtual coordinates
const int PC_SprintModeBar_VPosY		= -1;		//if not defined (-1) then PC_SprintModeBar_PPosY will be taken into consideration. Virtual coordinates


const int BAR_TEX_SPRINTMODE_STAMINA		= 0;		//Bar texture for stamina
const int BAR_TEX_SPRINTMODE_TIMEDOVERLAY	= 1;		//Bar texture for timed overlays (potions)

const int BAR_TEX_SPRINTMODE_MAX		= 2;

const string BAR_TEX_SPRINTMODE [BAR_TEX_SPRINTMODE_MAX] = {
	//"Bar_SprintMode_Stamina.tga",
	//"Bar_SprintMode_TimedOverlay.tga",
	"Bar_Misc.tga",						//Default Gothic bar texture (yellow)
	"Bar_SprintMode_TimedOverlay.tga"			//This is my custom texture - you might have to adjust this one !!
};

//Default spint mode overlay
const string PC_SprintModeOverlayName = "HUMANS_SPRINT.MDS";	//HUMANS_SPRINT.MDS

//Don't activate sprint mode if already in sprint mode - or if drunk :)
const int PC_SPRINTMODE_IGNOREWITHOVERLAYS_MAX = 2;

const string PC_SPRINTMODE_IGNOREWITHOVERLAYS [PC_SPRINTMODE_IGNOREWITHOVERLAYS_MAX] = {
	"HUMANS_SPRINT.MDS",
	"HUMANS_DRUNKEN.MDS"
};
