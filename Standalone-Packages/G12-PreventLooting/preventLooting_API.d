/*

//	You have to define list of all traders here:

func int C_NpcIsTrader (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);

	if (NPC_IsTrader (slf)) {
		return TRUE;
	};

	return FALSE;
};
*/

func int NPC_PreventLooting (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	//--> define conditions here

	//I have defined function C_NpcIsTrader outside of this package - so calling it the safe way
	var int retVal; retVal = 0;

	var int symbID; symbID = MEM_FindParserSymbol ("C_NpcIsTrader");
	if (symbID != -1) {
		MEM_PushInstParam (slf);
		MEM_CallByID (symbID);
		retVal = MEM_PopIntResult ();
	};

	//By default we wont allow looting of traders
	if (retVal) {
		return TRUE;
	};

	//<--
	
	return FALSE;
};
