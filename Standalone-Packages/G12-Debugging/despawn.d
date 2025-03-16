/*
 *	Despawn
 *	- will 'despawn' npc in focus
 */

func string CC_Despawn (var string param) {
	var oCNpc her; her = Hlp_GetNpc (hero);
	var int slfPtr; slfPtr = her.focus_vob;

	if (!Hlp_Is_oCNpc(slfPtr)) {
		return "Focus_vob is not an NPC.";
	};

	var oCNpc slf; slf = _^(slfPtr);
	var string s; s = ConcatStrings(GetSymbolName(Hlp_GetInstanceID(slf)), " despawned.");

	Wld_DespawnNpc(slf);

	return s;
};

func void CC_Despawn_Init () {
	CC_Register(CC_Despawn, "despawn", "Will despawn Npc in focus.");
};
