/*
 *	Display time for subtitles (min / max time in ms)
 *	 - this simple 'patch' allows us to update min and max display time in-game
 */

/*
Usage - call from Init_Global after Ikarus initialization

func void Init_Global () {
	//Ikarus initialization
	MEM_InitAll();

	//Update display dialogue min / max time
	G12_SetDisplayDialogueTime (1500, 30000);
};

*/

func void G12_SetDisplayDialogueTime (var int minTime, var int maxtime) {
	//Default 1000 ms
	const int NPC_TALK_TIME_MIN_addr_G1 = 8707632;
	const int NPC_TALK_TIME_MIN_addr_G2 = 9142536;

	//Default 8000 ms
	const int NPC_TALK_TIME_MAX_addr_G1 = 8707636;
	const int NPC_TALK_TIME_MAX_addr_G2 = 9142540;

	MEM_WriteInt (MEMINT_SwitchG1G2 (NPC_TALK_TIME_MIN_addr_G1, NPC_TALK_TIME_MIN_addr_G2), mkf(minTime));
	MEM_WriteInt (MEMINT_SwitchG1G2 (NPC_TALK_TIME_MAX_addr_G1, NPC_TALK_TIME_MAX_addr_G2), mkf(maxtime));
};
