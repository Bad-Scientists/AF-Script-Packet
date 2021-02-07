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

Hooked function below works around this limitation and allows you to add as many AI states for player as you need.
*/
 
/*
 *	ZS_ASSESSMAGIC is allowed state for player, but it is not used in Gothic -> we can exploit it :)
 *	When this function will be called from _HOOK_NPC_STATES_DOAISTATE for player - it will:
 *		call npc.state_nextState_name (intended function)
 *		overwrite npc.state_nextState_loop with npc.state_nextState_name_LOOP
 *		overwrite npc.state_nextState_end with npc.state_nextState_name_END
 */
func void ZS_ASSESSMAGIC () {
	var oCNPC npc; npc = Hlp_GetNPC (self);
	
	//Disable further calls
	npc.state_nextState_index = -1;
	
	//Call npc.state_nextState_name (ZS_WHIRLWIND or others, if specified in CanPlayerUseAIState)
	MEM_CallByString (npc.state_nextState_name);
	
	//Overwrite npc.state_nextState_loop with npc.state_nextState_name_LOOP
	var string fNameLoop; fNameLoop = ConcatStrings (npc.state_nextState_name, "_LOOP");
	npc.state_nextState_loop = MEM_FindParserSymbol (fNameLoop);
	
	//Overwrite npc.state_nextState_end with npc.state_nextState_name_END
	var string fNameEnd; fNameEnd = ConcatStrings (npc.state_nextState_name, "_END");
	npc.state_nextState_end = MEM_FindParserSymbol (fNameEnd);
};

//Just dummy functions
func int ZS_ASSESSMAGIC_LOOP ()	{};
func void ZS_ASSESSMAGIC_END ()	{};

//
func void _hook_oCNPC_States_DoAIState () {
	if (!ECX) { return; };

	var oCNPC_States state; state = _^ (ECX);

	if (!state.npc) { return; };

	var oCNPC npc; npc = _^ (state.npc);
	
	if (Hlp_IsValidNPC (npc)) {
		if (NPC_IsPlayer (npc))
		{
			if (state.nextState_index != 0)
			&& (state.nextState_index != -1)
			{
				if (CanPlayerUseAIState (state.nextState_name))
				{
					//Overwrite nextState_index - this will point to function ZS_ASSESSMAGIC
					//npc.state_nextState_name will still contain string "ZS_WHIRLWIND")
					npc.state_nextState_index = MEM_FindParserSymbol ("ZS_ASSESSMAGIC");
				};
			};
		};
	};
};

func void G12_EnablePlayerStates_Init () {
	const int once = 0;

	if (!once) {
		HookEngine (oCNPC_States__DoAIState, 6, "_hook_oCNPC_States_DoAIState");
		once = 1;
	};
};