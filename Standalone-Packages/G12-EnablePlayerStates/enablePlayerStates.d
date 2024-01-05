/*
As per conversation with NicoDE player AI states are hardcoded in engine:
https://forum.worldofplayers.de/forum/threads/1533803-G1-AI_StartState-hardcoded-ZS-states-for-Player?p=26034737&viewfull=1#post26034737

G1
const int NPC_PLAYER_STATES_ENABLED_MAX = 8;

const zSTRING strPlayerStatesEnabled[NPC_PLAYER_STATES_ENABLED_MAX] = {
	"ZS_ASSESSMAGIC",
	"ZS_ASSESSSTOPMAGIC",
	"ZS_MAGICFREEZE",
	"ZS_SHORTZAPPED",
	"ZS_ZAPPED",
	"ZS_PYRO",
	"ZS_MAGICSLEEP",
	"ZS_MAGICFEAR"
};

//G2A
const int NPC_PLAYER_STATES_ENABLED_MAX = 9;

const zSTRING strPlayerStatesEnabled[NPC_PLAYER_STATES_ENABLED_MAX] = {
	"ZS_ASSESSMAGIC",
	"ZS_ASSESSSTOPMAGIC",
	"ZS_MAGICFREEZE",
	"ZS_WHIRLWIND",
	"ZS_SHORTZAPPED",
	"ZS_ZAPPED",
	"ZS_PYRO",
	"ZS_MAGICSLEEP"
//	NULL
};
*/

func int CanPlayerUseAIState (var string AIStateName) {
	const int symbID = 0;

	if (!symbID) {
		symbID = MEM_FindParserSymbol ("C_CanPlayerUseAIState");
	};

	var int retVal; retVal = 0;

	if (symbID != -1) {
		MEM_PushStringParam (AIStateName);
		MEM_CallByID (symbID);
		retVal = MEM_PopIntResult ();
	};

	return + retVal;
};

func void _hook_oCNpc_States_DoAIState_CanPlayerUseAIState () {
	//Return 1 if player can't use state
	EAX = 1;

	if (!EBP) { return; };
	var oCNpc_States npcStates; npcStates = _^ (EBP);

	//Return 0 if player can use state
	if (CanPlayerUseAIState (npcStates.nextState_name)) {
		EAX = 0;
	};
};

func void G12_EnablePlayerStates_Init () {
	const int once = 0;

	if (!once) {
		var int addr;

		//006C5F00
		const int oCNpc_States__DoAIState_CheckStates_G1 = 7102208;

		//0076d440
		const int oCNpc_States__DoAIState_CheckStates_G2 = 7787584;

		addr = MEMINT_SwitchG1G2 (oCNpc_States__DoAIState_CheckStates_G1, oCNpc_States__DoAIState_CheckStates_G2);
		MEM_WriteNOP (addr, 10);

		HookEngine (addr, 5, "_hook_oCNpc_States_DoAIState_CanPlayerUseAIState");

		//85 C0 test EAX, EAX
		MEM_WriteByte (addr + 8, 133);
		MEM_WriteByte (addr + 9, 192);

		//Nuke loop
		const int oCNpc_States__DoAIState_CheckStatesLoop_G1 = 7102224;

		const int oCNpc_States__DoAIState_CheckStatesLoop_G2 = 7787600;

		addr = MEMINT_SwitchG1G2 (oCNpc_States__DoAIState_CheckStatesLoop_G1, oCNpc_States__DoAIState_CheckStatesLoop_G2);
		MEM_WriteNOP (addr, 10);

		once = 1;
	};
};
