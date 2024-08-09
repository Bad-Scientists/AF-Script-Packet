/*
 *	Prevent looting
 *
 *	1. Copy this file outside of script-packet
 *	2. Customize it (define your own logic for when Npc cannot be looted)
 *	3. Link it to Gothic.src
 *	4. Profit
 */

func int C_Npc_PreventLooting(var C_NPC slf) {
	//Prevent looting from traders
	if (Npc_IsTrader(slf)) {
		return TRUE;
	};

	//Don't prevent looting
	return FALSE;
};
