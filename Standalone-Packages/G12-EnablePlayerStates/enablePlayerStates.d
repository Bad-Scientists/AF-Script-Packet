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

/*
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
*/

func void EnablePlayerState (var int index) {
	//We will no longer exploit ZS_ASSESSMAGIC state - but instead we will overwrite index in playerStatesEnabled[0]
	//G1 addres for playerStatesEnabled is from NicoDe:
	//https://forum.worldofplayers.de/forum/threads/1533803-G1-AI_StartState-hardcoded-ZS-states-for-Player?p=26035114&viewfull=1#post26035114

	//.data:0085081C ; int playerStatesEnabled[8]
	const int playerStatesEnabled_G1 = 8718364;

	//G2A address is from Auronen :)
	//0x008ba67c
	const int playerStatesEnabled_G2 = 9152124;

	MEM_WriteInt (MEMINT_SwitchG1G2 (playerStatesEnabled_G1, playerStatesEnabled_G2), index);
};

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

//
func void _hook_oCNPC_States_DoAIState () {
	if (!ECX) { return; };

	var oCNPC_States state; state = _^ (ECX);

	if (!Hlp_Is_oCNpc (state.npc)) { return; };

	var oCNPC npc; npc = _^ (state.npc);

	if (Hlp_IsValidNPC (npc)) {
		if (NPC_IsPlayer (npc)) {
			if (state.nextState_index > 0) {
				if (state.nextState_valid) {
					if (CanPlayerUseAIState (state.nextState_name)) {
						//Overwrite nextState_index - this will point to function ZS_ASSESSMAGIC
						//npc.state_nextState_name will still contain string "ZS_WHIRLWIND")
						//npc.state_nextState_index = MEM_FindParserSymbol ("ZS_ASSESSMAGIC");

						/*
							My previous method with switching to ZS state ZS_ASSESSMAGIC and updating ZS state in that function was not perfect.
							Function NPC_IsInState would not work with player!
							This method overrides 1st value of an array playerStatesEnabled[] with state that we want to enable - this way all functions should work properly.
						*/
						EnablePlayerState (MEM_FindParserSymbol (state.nextState_name));
					};
				};
			};
		};
	};
};

func void _hook_oCNpc_States_CanPlayerUseAIState () {
	var oCNpc_States state; state = _^ (ECX);

	if (state.curState_index > 0) {
		if (state.curState_valid) {
			if (CanPlayerUseAIState (state.curState_name)) {
				EnablePlayerState (MEM_FindParserSymbol (state.curState_name));
			};
		};
	};
};

//0x0076CFC0 public: int __thiscall oCNpc_States::CanPlayerUseAIState(struct TNpcAIState const &)
func void _hook_oCNpc_States_CanPlayerUseAIState2 () {
	var oCNpc_States state; state = _^ (MEM_ReadInt (ESP + 4));

	if (state.curState_index > 0) {
		if (state.curState_valid) {
			if (CanPlayerUseAIState (state.curState_name)) {
				EnablePlayerState (MEM_FindParserSymbol (state.curState_name));
			};
		};
	};
};

func void G12_EnablePlayerStates_Init () {
	const int once = 0;

	if (!once) {
		HookEngine (oCNPC_States__DoAIState, 6, "_hook_oCNPC_States_DoAIState");

		//0x006C5AD0 public: int __thiscall oCNpc_States::CanPlayerUseAIState(void)
		const int oCNpc_States__CanPlayerUseAIState_G1 = 7101136;

		//0x0076D010 public: int __thiscall oCNpc_States::CanPlayerUseAIState(void)
		const int oCNpc_States__CanPlayerUseAIState_G2 = 7786512;

		//G2A HookLen 6
		HookEngine (MEMINT_SwitchG1G2 (oCNpc_States__CanPlayerUseAIState_G1, oCNpc_States__CanPlayerUseAIState_G2), MEMINT_SwitchG1G2 (9, 6), "_hook_oCNpc_States_CanPlayerUseAIState");

		//G1 does not have this function
		if (MEMINT_SwitchG1G2 (0, 1)) {
			//0x0076CFC0 public: int __thiscall oCNpc_States::CanPlayerUseAIState(struct TNpcAIState const &)
			const int oCNpc_States__CanPlayerUseAIState2_G2 = 7786432;

			HookEngine (oCNpc_States__CanPlayerUseAIState2_G2, 7, "_hook_oCNpc_States_CanPlayerUseAIState2");
		};

		once = 1;
	};
};
