/*
 *	Define conditions for log name here
 *	For example: we don't need dialogues with ambient NPCs ...
 *	return "" blank string if you don't want to log dialogue, otherwise return log name (by default, we return NPC name)
 */

func string GetLogTopicName__LogDialogs (var int npcInstance, var int playerInstance) {
	var C_NPC npc;
	var C_NPC her;

	npc = Hlp_GetNPC (npcInstance);
	if (!Hlp_IsValidNPC (npc)) { return ""; };

	her = Hlp_GetNPC (playerInstance);
	if (!Hlp_IsValidNPC (her)) { return ""; };

	if (MEMINT_SwitchG1G2 (1, 0)) {
		//G1
		//const int npctype_ambient = 0;
		//const int Npctype_MINE_Ambient = 4;
		//const int NPCTYPE_OW_AMBIENT = 6;
		if ((npc.npcType == 0) || (npc.npcType == 4) || (npc.npcType == 6)) {
			return "";
		};
	} else {
		//G2A
		//const int NPCTYPE_AMBIENT = 0;
		//const int NPCTYPE_OCAMBIENT = 3;
		//const int NPCTYPE_BL_AMBIENT = 5;//Addon
		//const int NPCTYPE_TAL_AMBIENT = 6;//Addon
		if ((npc.npcType == 0) || (npc.npcType == 3) || (npc.npcType == 5) || (npc.npcType == 6)) {
			return "";
		};
	};

	return npc.Name;
};
