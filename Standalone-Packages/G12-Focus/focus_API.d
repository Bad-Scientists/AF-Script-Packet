/*
 *	Focus
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it
 *	3. Link it to Gothic.src
 *	4. Profit
 */

const string MOBNAME_CRATE_EMPTY = "Empty box";
const string MOBNAME_CHEST_EMPTY = "Empty chest";

//Possible options:
//PC_CHANGEFOCUS_LOCKABLE - locks
//PC_CHANGEFOCUS_NPCATTITUDE - attitude
//PC_CHANGEFOCUS_RENAMEEMPTYCHESTS - renames empty chests
const int PC_CHANGEFOCUS_FLAGS = PC_CHANGEFOCUS_LOCKABLE | PC_CHANGEFOCUS_RENAMEEMPTYCHESTS;

const string PC_CHANGEFOCUS_COLOR_DEFAULT = "FFFFFF"; //White
const string PC_CHANGEFOCUS_COLOR_LOCKEDKEY = "FF8000"; //Orange
const string PC_CHANGEFOCUS_COLOR_LOCKEDPICKLOCKS = "FFFF00"; //Yellow
const string PC_CHANGEFOCUS_COLOR_LOCKEDKEYPICKLOCKS = "FFFF00"; //Yellow
const string PC_CHANGEFOCUS_COLOR_LOCKEDHASKEY = "FFFF00"; //Yellow

//--

const string PC_CHANGEFOCUS_COLOR_CONTAINERUNLOCKED = "66FFB2"; //Green
const string PC_CHANGEFOCUS_COLOR_CONTAINERUNLOCKEDEMPTY = "FFFFFF"; //White

//--

const string PC_CHANGEFOCUS_COLOR_FRIENDLY = "66FFB2"; //Green
const string PC_CHANGEFOCUS_COLOR_NEUTRAL = "FFFFFF"; //White
const string PC_CHANGEFOCUS_COLOR_ANGRY = "FF8000"; //Orange
const string PC_CHANGEFOCUS_COLOR_HOSTILE = "FF4646"; //Red

//API function
//This is where you can define your own logic for determining focus color
func int C_Npc_GetFocusColor(var C_NPC oth) {
	var int att; att = Npc_GetPermAttitude(hero, oth);

	if (((att == ATT_NEUTRAL) && (oth.npcType == NpcType_Friend))
	|| ((att == ATT_FRIENDLY)))
	{
		return RGBA(102, 255, 178, 255); //66FFB2 green
	};

	if ((att == ATT_ANGRY)))
	{
		return RGBA(255, 128, 000, 255); //FF8000 orange
	};

	if ((att == ATT_HOSTILE)))
	{
		return RGBA(255, 070, 070, 255); //FF4646 red
	};

	//Default - white
	return RGBA(255, 255, 255, 255);
};
