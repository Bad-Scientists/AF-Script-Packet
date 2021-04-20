func int NPC_PreventLooting (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	//--> define conditions here

	//At this point function C_NpcIsTrader is not yet parsed, so we have to call it using MEM_Call
	MEM_PushInstParam(slf);
	MEM_Call(C_NpcIsTrader); //C_NpcIsTrader (slf);
	var int npcIsTrader; npcIsTrader = MEM_PopIntResult(); 

	if (npcIsTrader) {
		return TRUE;
	};

	//<--
	
	return FALSE;
};
