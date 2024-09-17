/*
 *	Log dialogues
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it
 *	3. Link it to Gothic.src
 *	4. Profit
 */

//const int LOG_MISSION = 0;
//const int LOG_NOTE = 1;

const int LOG_SECTIONFORDIALOGUES = 1; //log to notes by default

//Define conditions for log name here
//For example: we don't need dialogues with ambient NPCs ...
//return STR_EMPTY blank string if you don't want to log dialogue, otherwise return log name (by default, we return NPC name)

func string GetLogTopicName__LogDialogs(var C_NPC npc, var C_NPC her) {
	if (MEMINT_SwitchG1G2(1, 0)) {
		//G1
		//const int npctype_ambient = 0;
		//const int Npctype_MINE_Ambient = 4;
		//const int NPCTYPE_OW_AMBIENT = 6;
		if ((npc.npcType == 0) || (npc.npcType == 4) || (npc.npcType == 6)) {
			return STR_EMPTY;
		};
	} else {
		//G2A
		//const int NPCTYPE_AMBIENT = 0;
		//const int NPCTYPE_OCAMBIENT = 3;
		//const int NPCTYPE_BL_AMBIENT = 5;//Addon
		//const int NPCTYPE_TAL_AMBIENT = 6;//Addon
		if ((npc.npcType == 0) || (npc.npcType == 3) || (npc.npcType == 5) || (npc.npcType == 6)) {
			return STR_EMPTY;
		};
	};

	return npc.Name;
};
