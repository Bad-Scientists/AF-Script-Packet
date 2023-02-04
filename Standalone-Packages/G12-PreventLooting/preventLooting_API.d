/*
//Copy this function outside of the script packet - define your own states.
//If script-packet is updated in the future - your definition will be unaffected.

func int C_Npc_PreventLooting (var C_NPC slf) {

	//Prevent traders looting
	if (Npc_IsTrader (slf)) {
		return TRUE;
	};

	//Don't prevent looting
	return FALSE;
};
*/
