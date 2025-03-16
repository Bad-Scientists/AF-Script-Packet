/*
 *	Dependencies:
 *	EngineClasses_G1\oNpc.d, anims_engine.d, functions_oCNpc_engine.d
 */

/*
 *	NPC_GetWalkMode
 *	Author: Dalai Zoll
 *	Original post: https://forum.worldofplayers.de/forum/threads/1090721-Testschleichen?p=17909902&viewfull=1#post17909902
 */

//Standard Gothic walk modes:
//const int NPC_RUN = 0;
//const int NPC_WALK = 1;
//const int NPC_SNEAK = 2;
const int NPC_INWATER = 3;

func int NPC_GetWalkMode (var int slfInstance) {
	//0x00622730 public: class zSTRING __thiscall oCAniCtrl_Human::GetWalkModeString(void)
	const int oCAniCtrl_Human__GetWalkModeString_G1 = 6432560;

	//0x006AAE40 public: class zSTRING __thiscall oCAniCtrl_Human::GetWalkModeString(void)
	const int oCAniCtrl_Human__GetWalkModeString_G2 = 6991424;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };
	if (!slf.AniCtrl) { return -1; };

	CALL_RetValIszString();
	CALL__thiscall(slf.AniCtrl, MEMINT_SwitchG1G2 (oCAniCtrl_Human__GetWalkModeString_G1, oCAniCtrl_Human__GetWalkModeString_G2));

	var string result;
	result = CALL_RetValAszstring ();

	if (Hlp_StrCmp (result, "RUN")) { return NPC_RUN; };
	if (Hlp_StrCmp (result, "WALK")) { return NPC_WALK; };
	if (Hlp_StrCmp (result, "SNEAK")) { return NPC_SNEAK; };
	if (Hlp_StrCmp (result, STR_EMPTY)) { return NPC_INWATER; };

	return -1;
};

/*
 *
 */

func int NPC_IsStanding (var int slfInstance) {
	//0x006255E0 public: int __thiscall oCAniCtrl_Human::IsStanding(void)
	const int oCAniCtrl_Human__IsStanding_G1 = 6444512;

	//0x006ADEE0 public: int __thiscall oCAniCtrl_Human::IsStanding(void)
	const int oCAniCtrl_Human__IsStanding_G2 = 7003872;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	if (!slf.aniCtrl) { return FALSE; };

	var int aniCtrlPtr; aniCtrlPtr = slf.aniCtrl;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall(_@(aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__IsStanding_G1, oCAniCtrl_Human__IsStanding_G2));
		call = CALL_End();
	};

	return + retVal;
};

func int NPC_IsWalking (var int slfInstance) {
	//0x006257E0 public: int __thiscall oCAniCtrl_Human::IsWalking(void)
	const int oCAniCtrl_Human__IsWalking_G1 = 6445024;

	//0x006AE0E0 public: int __thiscall oCAniCtrl_Human::IsWalking(void)
	const int oCAniCtrl_Human__IsWalking_G2 = 7004384;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (!slf.AniCtrl) { return FALSE; };

	CALL__thiscall(slf.AniCtrl, MEMINT_SwitchG1G2 (oCAniCtrl_Human__IsWalking_G1, oCAniCtrl_Human__IsWalking_G2));

	return CALL_RetValAsInt ();
};

//https://forum.worldofplayers.de/forum/threads/859436-Slow-Motion-in-Gothic-1?p=25955246&viewfull=1#post25955246
//HIGHLANDER: focus->GetModel()->SetTimeScale(3.0f);
/*
https://forum.worldofplayers.de/forum/threads/859436-Slow-Motion-in-Gothic-1?p=25957924&viewfull=1#post25957924

.text:004313B0 @h@LERKS:
.text:004313B0                 cmp     edi, 68160
.text:004313B6                 jnz     short @@EOWYN
.text:004313B8                 test    esi, esi
.text:004313BA                 mov     zCTimer ztimer, 0.40000001
.text:004313C4                 jz      loc_00432171
.text:004313CA                 lea     ecx, [esp+0CCh+var_B9]
.text:004313CE                 push    ecx
.text:004313CF                 push    offset `string' ; "CLERKS"
.text:004313D4                 lea     ecx, [esp+0D4h+var_B4]
.text:004313D8                 call    std::string::string(char const *, Std::allocator<char> const &)
.text:004313DD                 mov     [esp+0CCh+var_B8], ebp
.text:004313E1                 mov     byte ptr [esp+0CCh+var_4], 30h
.text:004313E9                 jmp     @@view_PrintTimed
.text:004313EE @@EOWYN:
.text:004313EE                 cmp     edi, 50112
.text:004313F4                 jnz     @@HIGHLANDER
.text:004313FA                 mov     ecx, [esp+0CCh+focus]
.text:004313FE                 test    ecx, ecx
.text:00431400                 jz      loc_00432171
.text:00431406                 call    oCNPC::GetModel(void)
.text:0043140B                 test    esi, esi
.text:0043140D                 mov     dword ptr [eax+1D0h], 0.40000001
*/

func void NPC_SetTimeScale (var int slfInstance, var int f) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return; };

	var int ptr; ptr = oCNPC_GetModel (slf);

	//1D0h = 464
	if (ptr) {
		//var int timeScale;	//G1	464	float timeScale;
		//var int timeScale;	//G2A	508	float timeScale;
		MEM_WriteInt (ptr + MEMINT_SwitchG1G2 (464, 508), f);
	};
};

func int NPC_GetNPCState (var int slfInstance) {
	//Here we have inconsistency with class declaration in G1/G2A - different naming, so we have to work with offset instead
	//oCNpc.state_vfptr	// 0x0470
	//oCNpc.state_vtbl	// 0x0588

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int offset; offset = MEMINT_SwitchG1G2 (1136, 1416);

	return (_@ (slf) + offset);
};

func string NPC_GetRoutineName (var int slfInstance) {
//	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
//	if (!Hlp_IsValidNPC (slf)) { return STR_EMPTY; };
//
//	var int ptr; ptr = _@ (slf);
//
//	//var func daily_routine;	//G1	0x0218 int
//	//var func daily_routine;	//G2	0x0260 int
//
//	var int offset; offset = MEMINT_SwitchG1G2 (536, 608);
//
//	var int symbID; symbID = MEM_ReadInt (ptr + offset);
//
//	if (symbID > 0) && (symbID < currSymbolTableLength) {
//		var zCPar_symbol symb; symb = _^ (MEM_GetSymbolByIndex (symbID));
//		return symb.name;
//	};
//
//	return STR_EMPTY;

	//0x006C6C10 public: class zSTRING __thiscall oCNpc_States::GetRoutineName(void)
	const int oCNpc_States__GetRoutineName_G1 = 7105552;

	//0x0076E180 public: class zSTRING __thiscall oCNpc_States::GetRoutineName(void)
	const int oCNpc_States__GetRoutineName_G2 = 7790976;

	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return STR_EMPTY; };

	CALL_RetValIszString ();
	CALL__thiscall (statePtr, MEMINT_SwitchG1G2 (oCNpc_States__GetRoutineName_G1, oCNpc_States__GetRoutineName_G2));
	return CALL_RetValAszstring ();
};

/*
 *  Get routine name without prefix and suffix
 */
func string Npc_GetRoutineBaseName (var int slfInstance)
{
	var string rtnName; rtnName = NPC_GetRoutineName (slfInstance);

	//Double-check just in case
	if (STR_StartsWith (rtnName, "RTN_")) {
		//Remove prefix
		rtnName = STR_Right (rtnName, STR_Len (rtnName) - 4);
	};

	//Double-check just in case
    var C_NPC slf; slf = Hlp_GetNpc(slfInstance);
	var string suffix; suffix = ConcatStrings ("_", IntToString (slf.ID));
	if (STR_EndsWith (rtnName, suffix)) {
		//Remove suffix
		rtnName = STR_Left (rtnName, STR_Len (rtnName) - STR_Len (suffix));
	};
    
    return rtnName;
};

func int NPC_IsInRoutineName (var int slfInstance, var string rtnName) {
	rtnName = STR_Upper (rtnName);

	//RTN_ rtnName _ID
	var string curRtnName; curRtnName = Npc_GetRoutineBaseName(slfInstance);
	return + (STR_WildMatch(rtnName, curRtnName));
};

func string NPC_GetStartAIStateName (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return STR_EMPTY; };

	var int ptr; ptr = _@ (slf);

	//var func startAIState;	//G1	0x021C int
	//var func startAIState;	//G2	0x0264 int

	var int offset; offset = MEMINT_SwitchG1G2 (540, 612);
	var int symbID; symbID = MEM_ReadInt (ptr + offset);

	if (symbID > 0) && (symbID < currSymbolTableLength) {
		var zCPar_symbol symb; symb = _^ (MEM_GetSymbolByIndex (symbID));
		return symb.name;
	};

	return STR_EMPTY;
};

func string NPC_GetCurrentAIStateName (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return STR_EMPTY; };

	return slf.state_curState_name;
};

func int NPC_IsInActiveVobList (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int ptr;
	var int slfPtr; slfPtr = _@ (slf);

	var int i; i = 0;
	var int loop; loop = MEM_World.activeVobList_numInArray;

	while (i < loop);
		ptr = MEM_ReadIntArray(MEM_World.activeVobList_array, i);

		if (slfPtr == ptr) {
			return TRUE;
		};

		i += 1;
	end;

	return FALSE;
};

/*
 *	Function loops through activeOverlays_array and checks if one of them is testOverlay
 * 		usage:	if (NPC_HasOverlay (hero, "HUMANS_DRUNKEN.MDS")) { ...
 */
func int NPC_HasOverlay (var int slfInstance, var string testOverlay)
{
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var string overlay;

	var int i; i = 0;
	var int loop; loop = slf.activeOverlays_numInArray;

	while (i < loop);

		overlay = MEM_ReadStringArray (slf.activeOverlays_array, i);

		if (Hlp_StrCmp (overlay, testOverlay)) {
			return TRUE;
		};

		i += 1;
	end;

	return FALSE;
};

/*
 *	Function loops through timedOverlays_next and checks if one of them is testOverlay
 *		usage:	if (NPC_HasTimedOverlay (hero, "HUMANS_SPRINT.MDS")) { ...
 */
func int NPC_HasTimedOverlay (var int slfInstance, var string testOverlay) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	//zCList<oCNpcTimedOverlay> timedOverlays {
	//var int        timedOverlays_data;                         // 0x0444 oCNpcTimedOverlay*
	//var int        timedOverlays_next;                         // 0x0448 zCList<oCNpcTimedOverlay>*

	var int ptr;
	var zCList list;
	var int timedOverlayPtr;

	ptr = slf.timedOverlays_next;

	while (ptr);
		list = _^ (ptr);

		timedOverlayPtr = list.data;

		if (timedOverlayPtr) {
			var oCNpcTimedOverlay timedOverlay;
			timedOverlay = _^ (timedOverlayPtr);

			if (Hlp_StrCmp (timedOverlay.mdsOverlayName, testOverlay)) {
				return TRUE;
			};
		};

		ptr = list.next;
	end;

	return FALSE;
};

/*
 *	Function loops through timedOverlays_next and gets remaining time testOverlay
 *		usage:	if (NPC_GetTimedOverlayTimer (hero, "HUMANS_SPRINT.MDS")) { ...
 */
func int NPC_GetTimedOverlayTimer (var int slfInstance, var string testOverlay) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return FLOATNULL; };

	//zCList<oCNpcTimedOverlay> timedOverlays {
	//var int        timedOverlays_data;                         // 0x0444 oCNpcTimedOverlay*
	//var int        timedOverlays_next;                         // 0x0448 zCList<oCNpcTimedOverlay>*

	var int ptr;
	var zCList list;
	var int timedOverlayPtr;

	ptr = slf.timedOverlays_next;

	while (ptr);
		list = _^ (ptr);

		timedOverlayPtr = list.data;

		if (timedOverlayPtr) {
			var oCNpcTimedOverlay timedOverlay;
			timedOverlay = _^ (timedOverlayPtr);

			if (Hlp_StrCmp (timedOverlay.mdsOverlayName, testOverlay)) {
				return timedOverlay.timer;
			};
		};

		ptr = list.next;
	end;

	return FLOATNULL;
};

/*
 *	In G1 if NPC drinks speed potions with different times, overlays will be added separately to the list
 *		oCNpcTimedOverlay time #1
 *		oCNpcTimedOverlay time #2
 *
 *	As soon as time #1 expires overlay is removed ... even though overlay with time #2 is still 'active' ...
 *
 *	This function loops through timedOverlays_next and removes duplicated timed overlays
 *		sumValues parameter defines behaviour:
 *			set it to 0 if you want script to get MAX value from all timers
 *			set it to 1 if you want script to SUM all timers
 *
 *		usage:	if (NPC_RemoveDuplicatedTimedOverlays (hero, "HUMANS_SPRINT.MDS"), 0) { ...	//gets only max timer value
 *		usage:	if (NPC_RemoveDuplicatedTimedOverlays (hero, "HUMANS_SPRINT.MDS"), 1) { ...	//sums up all timers
 */
func void NPC_RemoveDuplicatedTimedOverlays (var int slfInstance, var string testOverlay, var int sumValues)
{
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return; };

	//zCList<oCNpcTimedOverlay> timedOverlays {
	//var int        timedOverlays_data;                         // 0x0444 oCNpcTimedOverlay*
	//var int        timedOverlays_next;                         // 0x0448 zCList<oCNpcTimedOverlay>*

	var int ptr;
	var zCList list;
	var int timedOverlayPtr;

	var oCNpcTimedOverlay timedOverlay;

	ptr = slf.timedOverlays_next;

	var int i; i = 0;
	var int f; f = FLOATNULL;

	while (ptr);
		list = _^ (ptr);

		timedOverlayPtr = list.data;

		if (timedOverlayPtr) {
			timedOverlay = _^ (timedOverlayPtr);

			if (Hlp_StrCmp (timedOverlay.mdsOverlayName, testOverlay)) {
				//Sum all timers
				if (sumValues) {
					f = addf (f, timedOverlay.timer);
				} else {
					//Get max timer value
					if (gf (timedOverlay.timer, f)) {
						f = timedOverlay.timer;
					};
				};

				//count how many timed overlays do we have
				i += 1;
			};
		};

		ptr = list.next;
	end;

	//Is there more than 1 timed overlay ?
	if (i > 1) {

		i = 0;

		var int j; j = 0;

		if (gf (f, FLOATNULL)) {
			ptr = slf.timedOverlays_next;

			while (ptr);
				list = _^ (ptr);

				timedOverlayPtr = list.data;

				if (timedOverlayPtr) {
					timedOverlay = _^ (timedOverlayPtr);

					if (Hlp_StrCmp (timedOverlay.mdsOverlayName, testOverlay)) {
						//Update first value with total number
						if (i == 0) {
							timedOverlay.timer = f;
						} else {
							//Remove overlay name - this way overlay wont be removed from NPC
							timedOverlay.mdsOverlayName = STR_EMPTY;
							timedOverlay.timer = FLOATNULL;
						};

						i += 1;
					};
				};

				j += 1;
				ptr = list.next;
			end;
		};
	};
};

/*
 *	Function loops through timedOverlays_next and removes them
 *		usage:	if (NPC_RemoveTimedOverlay (hero, "HUMANS_SPRINT.MDS")) { ...
 */
func void NPC_RemoveTimedOverlay (var int slfInstance, var string testOverlay) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return; };

	//zCList<oCNpcTimedOverlay> timedOverlays {
	//var int        timedOverlays_data;                         // 0x0444 oCNpcTimedOverlay*
	//var int        timedOverlays_next;                         // 0x0448 zCList<oCNpcTimedOverlay>*

	var int ptr;
	var zCList list;
	var int timedOverlayPtr;

	ptr = slf.timedOverlays_next;

	while (ptr);
		list = _^ (ptr);

		timedOverlayPtr = list.data;

		if (timedOverlayPtr) {
			var oCNpcTimedOverlay timedOverlay;
			timedOverlay = _^ (timedOverlayPtr);

			if (Hlp_StrCmp (timedOverlay.mdsOverlayName, testOverlay)) {
				//Remove overlay name - this way overlay wont be removed from NPC
				timedOverlay.mdsOverlayName = STR_EMPTY;
				timedOverlay.timer = FLOATNULL;
			};
		};

		ptr = list.next;
	end;
};

func int NPC_GetBitfield (var int slfInstance, var int bitfield) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Simple true/false values
	if (bitfield == oCNpc_bitfield0_showaidebug)
	|| (bitfield == oCNpc_bitfield0_showNews)
	|| (bitfield == oCNpc_bitfield0_csAllowedAsRole)
	|| (bitfield == oCNpc_bitfield0_isSummoned)
	|| (bitfield == oCNpc_bitfield0_respawnOn)
	|| (bitfield == oCNpc_bitfield0_movlock)
	|| (bitfield == oCNpc_bitfield0_drunk)
	|| (bitfield == oCNpc_bitfield0_mad)
	|| (bitfield == oCNpc_bitfield0_overlay_wounded)
	|| (bitfield == oCNpc_bitfield0_inOnDamage)
	|| (bitfield == oCNpc_bitfield0_autoremoveweapon)
	|| (bitfield == oCNpc_bitfield0_openinventory)
	|| (bitfield == oCNpc_bitfield0_askroutine)
	|| (bitfield == oCNpc_bitfield0_spawnInRange)
	|| (bitfield == oCNpc_bitfield0_body_TexVarNr)
	{
		return (slf.bitfield[0] & bitfield);
	};

	if (bitfield == oCNpc_bitfield1_body_TexColorNr) //65535
	|| (bitfield == oCNpc_bitfield1_head_TexVarNr) //4294901760
	{
		return (slf.bitfield[1] & bitfield);
	};

	if (bitfield == oCNpc_bitfield2_teeth_TexVarNr)
	|| (bitfield == oCNpc_bitfield2_guildTrue)
	|| (bitfield == oCNpc_bitfield2_drunk_heal)
	{
		return (slf.bitfield[2] & bitfield);
	};

	if (bitfield == oCNpc_bitfield3_mad_heal)
	|| (bitfield == oCNpc_bitfield3_spells)
	{
		return (slf.bitfield[3] & bitfield);
	};

	if (bitfield == oCNpc_bitfield4_bodyState)
	{
		return (slf.bitfield[4] & bitfield);
	};

	return 0;
};

func void NPC_SetBitfield (var int slfInstance, var int bitfield, var int value) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//Basically true/false values
	if (bitfield == oCNpc_bitfield0_showaidebug)
	|| (bitfield == oCNpc_bitfield0_showNews)
	|| (bitfield == oCNpc_bitfield0_csAllowedAsRole)
	|| (bitfield == oCNpc_bitfield0_isSummoned)
	|| (bitfield == oCNpc_bitfield0_respawnOn)
	|| (bitfield == oCNpc_bitfield0_movlock)
	|| (bitfield == oCNpc_bitfield0_drunk)
	|| (bitfield == oCNpc_bitfield0_mad)
	|| (bitfield == oCNpc_bitfield0_overlay_wounded)
	|| (bitfield == oCNpc_bitfield0_inOnDamage)
	|| (bitfield == oCNpc_bitfield0_autoremoveweapon)
	|| (bitfield == oCNpc_bitfield0_openinventory)
	|| (bitfield == oCNpc_bitfield0_askroutine)
	|| (bitfield == oCNpc_bitfield0_spawnInRange)
	|| (bitfield == oCNpc_bitfield0_body_TexVarNr)
	{
		if ((value == 0) || (value == 1)) {
			value = bitfield * value;
		};

		slf.bitfield[0] = (slf.bitfield[0] & ~ bitfield) | value;
		return;
	};

	if (bitfield == oCNpc_bitfield1_body_TexColorNr)
	|| (bitfield == oCNpc_bitfield1_head_TexVarNr)
	{
		slf.bitfield[1] = (slf.bitfield[1] & ~ bitfield) | value;
		return;
	};

	if (bitfield == oCNpc_bitfield2_teeth_TexVarNr)
	|| (bitfield == oCNpc_bitfield2_guildTrue)
	|| (bitfield == oCNpc_bitfield2_drunk_heal)
	{
		slf.bitfield[2] = (slf.bitfield[2] & ~ bitfield) | value;
		return;
	};

	if (bitfield == oCNpc_bitfield3_mad_heal)
	|| (bitfield == oCNpc_bitfield3_spells)
	{
		slf.bitfield[3] = (slf.bitfield[3] & ~ bitfield) | value;
		return;
	};

	if (bitfield == oCNpc_bitfield4_bodyState)
	{
		slf.bitfield[4] = (slf.bitfield[4] & ~ bitfield) | value;
		return;
	};
};

/*
 *	Npc_HasVisualBody
 *	 - checks if visual body name starts with specified string
 */
func int Npc_HasVisualBody(var int slfInstance, var string visualBodyPrefix) {
	var string visualBody; visualBody = oCNpc_GetVisualBody(slfInstance);

	visualBody = STR_Upper(visualBody);
	visualBodyPrefix = STR_Upper(visualBodyPrefix);

	if (STR_StartsWith(visualBody, visualBodyPrefix)) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	Npc_CarriesTorch
 *	 - returns true if Npc is carrying torch (checks both hands)
 *	 - updates global variable item with torch in hand
 */
func int Npc_CarriesTorch (var int slfinstance){
	var oCNpc slf; slf = Hlp_GetNpc(slfinstance);
	if (!Hlp_IsValidNPC(slf)) { return FALSE; };

	var int ptr;
	var oCItem itm;

	//Get pointer to ZS_LEFTHAND
	ptr = oCNpc_GetSlotItem(slf, NPC_NODE_LEFTHAND);

	//Is there anything in hand?
	if (ptr) {
		itm = _^ (ptr);

		//Is it ItLsTorchBurning / ItLsTorchBurned ?
		if ((Hlp_GetinstanceID(itm) == ItLsTorchBurning) || (Hlp_GetinstanceID(itm) == ItLsTorchBurned)) {
			item = _^(ptr);
			return TRUE;
		};
	};

	//Get pointer to ZS_RIGHTHAND
	ptr = oCNpc_GetSlotItem(slf, NPC_NODE_RIGHTHAND);

	//Is there anything in hand?
	if (ptr) {
		itm = _^ (ptr);

		//Is it ItLsTorchBurning / ItLsTorchBurned ?
		if ((Hlp_GetinstanceID(itm) == ItLsTorchBurning) || (Hlp_GetinstanceID(itm) == ItLsTorchBurned)) {
			item = _^(ptr);
			return TRUE;
		};
	};

	return FALSE;
};

/*
 *	Function calls torch exchange & removes overlay when torch is not in ZS_LEFTHAND
 */
func int Npc_DoExchangeTorch (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNpc(slfInstance);
	if (!Hlp_IsValidNpc(slf)) { return FALSE; };

	if (!Npc_IsInFightMode(slf, FMODE_NONE)) {
		return FALSE;
	};

	if (oCNpc_DoExchangeTorch(slfInstance)) {
		if (!Npc_CarriesTorch(slfInstance)) {
			if (Npc_HasVisualBody(slf, VISBODY_PREFIX_HUM)) {
				if (Npc_HasOverlay(slfInstance, MDS_HUMANS_TORCH)) {
					Mdl_RemoveOverlayMds(slf, MDS_HUMANS_TORCH);
				};
			} else
			if (Npc_HasVisualBody(slf, VISBODY_PREFIX_ORC)) {
				if (Npc_HasOverlay(slfInstance, MDS_ORC_TORCH)) {
					Mdl_RemoveOverlayMds(slf, MDS_ORC_TORCH);
				};
			};
		};

		return TRUE;
	};
	return FALSE;
};

/*
 *	Npc_TorchSwitchOff
 */
func void Npc_TorchSwitchOff (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC(slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//Is there anything in hand?
	if (Npc_CarriesTorch(slf)) {
		//if in right hand then perform DoExchangeTorch to get it back to left hand
		var int ptr; ptr = oCNpc_GetSlotItem(slf, NPC_NODE_RIGHTHAND);
		if (ptr == _@(item)) {
			var int retVal; retVal = oCNpc_DoExchangeTorch(slf);
		};

		//Use item - will put ItLsTorch back to inventory
		oCNpc_EquipPtr(slf, _@(item));

		if (Npc_HasVisualBody(slf, VISBODY_PREFIX_HUM)) {
			if (Npc_HasOverlay(slfInstance, MDS_HUMANS_TORCH)) {
				Mdl_RemoveOverlayMds(slf, MDS_HUMANS_TORCH);
			};
		} else
		if (Npc_HasVisualBody(slf, VISBODY_PREFIX_ORC)) {
			if (Npc_HasOverlay(slfInstance, MDS_ORC_TORCH)) {
				Mdl_RemoveOverlayMds(slf, MDS_ORC_TORCH);
			};
		};
	};
};

/*
 *	NPC_TorchSwitchOn
 */
func void NPC_TorchSwitchOn (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC(slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int ptr;

	//Check fight mode!
	if (!Npc_IsInFightMode(slf, FMODE_NONE)) {
		//Exception for FMODE_MELEE - check talent
		if (!Npc_IsInFightMode(slf, FMODE_MELEE)) {
			return;
		};

		//Get weapon pointer - we will allow torch in case of 1H lvl > 0
		ptr = oCNpc_GetSlotItem(slf, NPC_NODE_RIGHTHAND);
		var int is1H; is1H = oCItem_IsOneHanded(ptr);

		if (!is1H) {
			return;
 		};

		//Don't allow torches on lvl 0
		if (is1H && Npc_GetTalentSkill(slf, NPC_TALENT_1H) == 0) {
			return;
		};
	};

	//Get pointer to ZS_LEFTHAND
	ptr = oCNpc_GetSlotItem(slf, NPC_NODE_LEFTHAND);

	//Is hand empty?
	if (!ptr) {
		//Search for torches ItLsTorchBurning, ItLsTorchBurned, ItLsTorch
		if (!NPC_GetInvItem(slf, ItLsTorchBurning)) {
			if (!NPC_GetInvItem(slf, ItLsTorchBurned)) {
				if (!NPC_GetInvItem(slf, ItLsTorch)) {
					return;
				};
			};
		};

		oCNpc_EquipPtr(slf, _@(item));

		//Apply overlay
		if (Npc_HasVisualBody(slf, VISBODY_PREFIX_HUM)) {
			if (!Npc_HasOverlay(slfInstance, MDS_HUMANS_TORCH)) {
				Mdl_ApplyOverlayMds(slf, MDS_HUMANS_TORCH);
			};
		} else
		if (Npc_HasVisualBody(slf, VISBODY_PREFIX_ORC)) {
			if (!Npc_HasOverlay(slfInstance, MDS_ORC_TORCH)) {
				Mdl_ApplyOverlayMds(slf, MDS_ORC_TORCH);
			};
		};
	};
};

/*
 *	Switches torches on - off
 *		return -1 if NPC does not have torch
 *		return 0 if torch was removed
 *		return 1 if torch was put in hand
 */
func int NPC_TorchSwitchOnOff(var int slfinstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };

	if (Npc_CarriesTorch(slf)) {
		Npc_TorchSwitchOff(slf);
		return 0;
	} else {
		Npc_TorchSwitchOn(slf);
		if (Npc_CarriesTorch(slf)) {
			return 1;
		};
	};

	return -1;
};

func int NPC_GetNode (var int slfInstance, var string nodeName) {
	//0x00563F80 public: class zCModelNodeInst * __thiscall zCModel::SearchNode(class zSTRING const &)
	const int zCModel__SearchNode_G1 = 5652352;

	//0x0057DFF0 public: class zCModelNodeInst * __thiscall zCModel::SearchNode(class zSTRING const &)
	const int zCModel__SearchNode_G2 = 5758960;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	if (!modelPtr) { return 0; };

	var int retVal;

	CALL_PutRetValTo(_@(retVal));
	CALL_zStringPtrParam (nodeName);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__SearchNode_G1, zCModel__SearchNode_G2));
	return + retVal;
};

func int NPC_GetNodePositionWorld (var int slfInstance, var string nodeName) {
	//0x0055F8C0 public: class zVEC3 __thiscall zCModel::GetNodePositionWorld(class zCModelNodeInst *)
	const int zCModel__GetNodePositionWorld_G1 = 5634240;

	//0x00579140 public: class zVEC3 __thiscall zCModel::GetNodePositionWorld(class zCModelNodeInst *)
	const int zCModel__GetNodePositionWorld_G2 = 5738816;

	var int modelPtr; modelPtr = oCNPC_GetModel (slfInstance);
	if (!modelPtr) { return 0; };

	var int nodePtr; nodePtr = NPC_GetNode (slfInstance, nodeName);
	if (!nodePtr) { return 0; };

	CALL_RetValIsStruct (12);
	CALL_PtrParam (nodePtr);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__GetNodePositionWorld_G1, zCModel__GetNodePositionWorld_G2));
	return CALL_RetValAsPtr ();
};

func int Npc_GetNodePositionWorldToPos (var int slfInstance, var string nodeName, var int posPtr) {
	var int nodePosPtr; nodePosPtr = NPC_GetNodePositionWorld (slfInstance, nodeName);

	if (nodePosPtr) {
		MEM_CopyBytes(nodePosPtr, posPtr, 12);
		MEM_Free(nodePosPtr);
		return TRUE;
	};

	return FALSE;
};

/*
 *	NPC_GetDistToPos // int
 */
func int NPC_GetDistToPos (var int slfInstance, var int posPtr) {
	if (!posPtr) { return -1; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };

	var int pos[3];
	pos[0] = slf._zCVob_trafoObjToWorld [03];
	pos[1] = slf._zCVob_trafoObjToWorld [07];
	pos[2] = slf._zCVob_trafoObjToWorld [11];

	var int dir[3];
	SubVectors (_@ (dir), _@ (pos), posPtr);

	return roundf (zVEC3_LengthApprox (_@ (dir)));
};

/*
 *	NPC_GetDistToVobPtr //int
 */
func int NPC_GetDistToVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return -1; };

	var zCVob vob; vob = _^ (vobPtr);

	var int pos[3];
	pos[0] = vob.trafoObjToWorld [03];
	pos[1] = vob.trafoObjToWorld [07];
	pos[2] = vob.trafoObjToWorld [11];

	return + NPC_GetDistToPos (slfInstance, _@ (pos));
};

func int NPC_GetShowAI (var int slfInstance) {
	//0x00616080 public: int __thiscall oCAIHuman::GetShowAI(void)
	const int oCAIHuman__GetShowAI_G1 = 6381696;

	//0x0069D880 public: int __thiscall oCAIHuman::GetShowAI(void)
	const int oCAIHuman__GetShowAI_G2 = 6936704;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	if (!slf.human_ai) { return 0; };

	var int human_aiPtr; human_aiPtr = slf.human_ai;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall(_@(human_aiPtr), MEMINT_SwitchG1G2 (oCAIHuman__GetShowAI_G1, oCAIHuman__GetShowAI_G2));
		call = CALL_End();
	};

	return + retVal;
};

func void NPC_SetShowAI (var int slfInstance, var int enable) {
	//0x00616060 public: void __thiscall oCAIHuman::SetShowAI(int)
	const int oCAIHuman__SetShowAI_G1 = 6381664;

	//0x0069D860 public: void __thiscall oCAIHuman::SetShowAI(int)
	const int oCAIHuman__SetShowAI_G2 = 6936672;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	if (!slf.human_ai) { return; };

	var int human_aiPtr; human_aiPtr = slf.human_ai;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@ (enable));
		CALL__thiscall(_@(human_aiPtr), MEMINT_SwitchG1G2 (oCAIHuman__SetShowAI_G1, oCAIHuman__SetShowAI_G2));
		call = CALL_End();
	};
};

func void NPC_MobSetIdealPosition (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!slf.interactMob) { return; };

	//oCMobInter_ScanIdealPositions (slf.interactMob);

	var oCMobInter mob; mob = _^ (slf.interactMob);

	if (mob.optimalPosList_next) {
		var int i; i = 0;

		var int ptr;
		var zCList list;

		ptr = mob.optimalPosList_next;

		while (ptr);
			list = _^ (ptr);
			ptr = list.data;

			if (ptr) {
				//TMobOptPos.trafo is at offset 0, so we can read trafo directly from ptr

				//AlignVobAt (_@ (slf), ptr); --> copying whole function here - in order to have this file 'standalone'

				var int trfPtr; trfPtr = ptr;
				var int vobPtr; vobPtr = _@ (slf);

				//0x005EE760 public: void __thiscall zCVob::SetTrafoObjToWorld(class zMAT4 const &)
				const int zCVob__SetTrafoObjToWorld_G1 = 6219616;

				//0x0061BC80 public: void __thiscall zCVob::SetTrafoObjToWorld(class zMAT4 const &)
				const int zCVob__SetTrafoObjToWorld_G2 = 6405248;

				// Lift collision
				var zCVob vob; vob = _^ (vobPtr);
				var int bits; bits = vob.bitfield[0];
				vob.bitfield[0] = vob.bitfield[0] & ~zCVob_bitfield0_collDetectionStatic & ~zCVob_bitfield0_collDetectionDynamic;

				const int call = 0;
				if (CALL_Begin(call)) {
					CALL_PtrParam(_@(trfPtr));
					CALL__thiscall(_@(vobPtr), MEMINT_SwitchG1G2(zCVob__SetTrafoObjToWorld_G1, zCVob__SetTrafoObjToWorld_G2));
					call = CALL_End();
				};

				// Restore bits
				vob.bitfield[0] = bits;
				//<--
				return;
			};

			ptr = list.next;
		end;
	};
};

func int NPC_IsInStateName (var int slfInstance, var string stateName) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	if (!STR_Len (stateName)) { return TRUE; };

	stateName = STR_Upper (stateName);
	return + (STR_WildMatch(slf.state_curState_name, stateName) && (slf.state_curState_valid));
};

func int NPC_WasInStateName (var int slfInstance, var string stateName) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	stateName = STR_Upper (stateName);

	if (slf.state_lastAIState < 0) { return 0; };

	var string lastStateName;
	lastStateName = GetSymbolName (slf.state_lastAIState);
	return + (STR_WildMatch(lastStateName, stateName));
};

func int NPC_GetDailyRoutineFuncID (var int slfInstance) {
	//var func daily_routine;	//G1	0x0218 int
	//var func daily_routine;	//G2	0x0260 int

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int ptr; ptr = _@ (slf);

	var int offset; offset = MEMINT_SwitchG1G2 (536, 608);

	var int symbID; symbID = MEM_ReadInt (ptr + offset);

	if (symbID > 0) && (symbID < currSymbolTableLength) {
		return symbID;
	};

	return 0;
};

func void NPC_ChangeRoutine (var int slfInstance, var int funcID) {
	//0x006C69F0 public: void __thiscall oCNpc_States::ChangeRoutine(int)
	const int oCNpc_States__ChangeRoutine_G1 = 7105008;

	//0x0076DF60 public: void __thiscall oCNpc_States::ChangeRoutine(int)
	const int oCNpc_States__ChangeRoutine_G2 = 7790432;

	if (funcID < 1) { return; };

	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);

	if (!statePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (funcID));
		CALL__thiscall (_@ (statePtr), MEMINT_SwitchG1G2 (oCNpc_States__ChangeRoutine_G1, oCNpc_States__ChangeRoutine_G2));
		call = CALL_End ();
	};
};

/*
 *	Npc_GetHeightDiffToPos // int
 */
func int Npc_GetHeightDiffToPos (var int slfInstance, var int posPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	var int Y; Y = MEM_ReadIntArray (posPtr, 1);
	return roundf (subf (Y, slf._zCVob_trafoObjToWorld[7]));
};

/*
 *	Npc_GetHeightToVobPtr // int
 */
func int Npc_GetHeightToVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return 0; };

//func int zCVob_GetPositionWorld (var int vobPtr) {
	//0x0051B3C0 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
	const int zCVob__GetPositionWorld_G1 = 5354432;

	//0x0052DC90 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
	const int zCVob__GetPositionWorld_G2 = 5430416;

	CALL_RetValIsStruct (12);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetPositionWorld_G1, zCVob__GetPositionWorld_G2));
	var int vobPosPtr; vobPosPtr = CALL_RetValAsPtr ();
//};

	var int pos[3];
	MEM_CopyBytes (vobPosPtr, _@ (pos), 12);
	MEM_Free (vobPosPtr);

	return +(Npc_GetHeightDiffToPos (slfInstance, _@ (pos)));
};

func int NPC_GetNearestMobOptPosition (var int slfInstance, var int mobPtr) {

//func void oCMobInter_ScanIdealPositions (var int mobPtr) {
	//0x0067C9C0 protected: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G1 = 6801856;

	//0x0071DC30 public: void __thiscall oCMobInter::ScanIdealPositions(void)
	const int oCMobInter__ScanIdealPositions_G2 = 7461936;

	if (!Hlp_Is_oCMobInter (mobPtr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMobInter__ScanIdealPositions_G1, oCMobInter__ScanIdealPositions_G2));
		call = CALL_End();
	};
//};

	var int dist;
	var int maxDist; maxDist = 999999;

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var oCMobInter mob; mob = _^ (mobPtr);

	var int ptr;
	var zCList list;
	ptr = mob.optimalPosList_next;

	while (ptr);
		list = _^ (ptr);
		ptr = list.data;

		if (ptr) {
			var TMobOptPos mobOptPos; mobOptPos = _^ (ptr);

			var int pos[3];
			pos[0] = mobOptPos.trafo[03];
			pos[1] = mobOptPos.trafo[07];
			pos[2] = mobOptPos.trafo[11];

			if (!firstPtr) { firstPtr = ptr; };

			dist = NPC_GetDistToPos (slfInstance, _@ (pos)); //int
			if (dist < maxDist) {
				nearestPtr = ptr;
				maxDist = dist;
			};
		};

		ptr = list.next;
	end;

	if (nearestPtr) { return nearestPtr; };

	return firstPtr;
};

func string NPC_GetNearestMobNodeName (var int slfInstance, var int mobPtr) {
	var int ptr; ptr = NPC_GetNearestMobOptPosition (slfInstance, mobPtr);

	if (!ptr) { return STR_EMPTY; };

	var TMobOptPos mobOptPos; mobOptPos = _^ (ptr);
	return mobOptPos.nodeName;
};

func void NPC_SetWalkMode (var int slfInstance, var int walkMode) {
	//0x006211E0 public: void __thiscall oCAniCtrl_Human::SetWalkMode(int)
	const int oCAniCtrl_Human__SetWalkMode_G1 = 6427104;

	//0x006A9820 public: void __thiscall oCAniCtrl_Human::SetWalkMode(int)
	const int oCAniCtrl_Human__SetWalkMode_G2 = 6985760;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!slf.aniCtrl) { return; };

	var int aniCtrl; aniCtrl = slf.aniCtrl;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (walkMode));
		CALL__thiscall (_@ (aniCtrl), MEMINT_SwitchG1G2 (oCAniCtrl_Human__SetWalkMode_G1, oCAniCtrl_Human__SetWalkMode_G2));
		call = CALL_End();
	};
};

/*
 *	There are several body-states with which we should not change overlays (to sprint mode, or equip torch) ... all hopefully listed here
 */
func int NPC_CanChangeOverlay (var int slfInstance) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);

	if (Npc_GetBitfield(slf, oCNpc_bitfield0_movlock)) { return FALSE; };

	//[C_BodyStateContains (hero, BS_JUMP)]
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_JUMP & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_FALL & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_DEAD & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_UNCONSCIOUS & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_SWIM & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_DIVE & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_LIE & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_SIT & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_INVENTORY & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_MOBINTERACT & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };
	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (BS_MOBINTERACT_INTERRUPT & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) { return FALSE; };

	return TRUE;
};

/*
 *	Function removes specified focus vob pointer
 */
func void NPC_RemoveFromFocus (var int slfInstance, var int vobPtr) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (slf.focus_vob == vobPtr) {
		oCNpc_SetFocusVob (slf, 0);
	};
};

func void Npc_ClearAIState (var int slfInstance) {
	//0x006C61A0 public: void __thiscall oCNpc_States::ClearAIState(void)
	const int oCNpc_States__ClearAIState_G1 = 7102880;

	//0x0076D6E0 public: void __thiscall oCNpc_States::ClearAIState(void)
	const int oCNpc_States__ClearAIState_G2 = 7788256;

	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (statePtr), MEMINT_SwitchG1G2 (oCNpc_States__ClearAIState_G1, oCNpc_States__ClearAIState_G2));
		call = CALL_End();
	};
};

func void Npc_EndCurrentState (var int slfInstance) {
	//0x006C6340 public: void __thiscall oCNpc_States::EndCurrentState(void)
	const int oCNpc_States__EndCurrentState_G1 = 7103296;

	//0x0076D880 public: void __thiscall oCNpc_States::EndCurrentState(void)
	const int oCNpc_States__EndCurrentState_G2 = 7788672;

	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (statePtr), MEMINT_SwitchG1G2 (oCNpc_States__EndCurrentState_G1, oCNpc_States__EndCurrentState_G2));
		call = CALL_End();
	};
};

/*
 *	Npc_InitAIStateDriven
 *	 - updates oCNpc.state_aiStatePosition to specified position and oCNpc.wp to nearest waypoint
 */
func void Npc_InitAIStateDriven (var int slfInstance, var int posPtr) {
	//0x006C7350 public: void __thiscall oCNpc_States::InitAIStateDriven(class zVEC3 const &)
	const int oCNpc_States__InitAIStateDriven_G1 = 7107408;

	//0x0076E8E0 public: void __thiscall oCNpc_States::InitAIStateDriven(class zVEC3 const &)
	const int oCNpc_States__InitAIStateDriven_G2 = 7792864;

	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (posPtr));
		CALL__thiscall (_@ (statePtr), MEMINT_SwitchG1G2 (oCNpc_States__InitAIStateDriven_G1, oCNpc_States__InitAIStateDriven_G2));
		call = CALL_End();
	};
};

/*
 *	Npc_StartAIState
 *	!updates global variable self!
 */
func int Npc_StartAIState(var int slfInstance, var string stateName, var int endOldState, var int timeBehaviour, var int timedF, var int isRtnState) {
	//0x006C5350 public: int __thiscall oCNpc_States::StartAIState(class zSTRING const &,int,int,float,int)
	const int oCNpc_States__StartAIState_G1 = 7099216;

	//0x0076C700 public: int __thiscall oCNpc_States::StartAIState(class zSTRING const &,int,int,float,int)
	const int oCNpc_States__StartAIState_G2 = 7784192;

	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return FALSE; };

	CALL_IntParam (isRtnState);
	CALL_FloatParam (timedF);
	CALL_IntParam (timeBehaviour);
	CALL_IntParam (endOldState);
	CALL_zStringPtrParam (stateName);
	CALL__thiscall (statePtr, MEMINT_SwitchG1G2 (oCNpc_States__StartAIState_G1, oCNpc_States__StartAIState_G2));

	return CALL_RetValAsInt ();
};

/*
 *
 */
func void NPC_SetSoundVobPtr (var int slfInstance, var int vobPtr) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	slf.soundVob = vobPtr;
};

func int NPC_GetSoundVobPtr (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };
	return slf.soundVob;
};

/*
 *	Npc_BeamToKeepQueue
 *	 - updates 'physical' position of Npc
 */
func void Npc_BeamToKeepQueue (var int slfInstance, var string vobName) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int pos[3];

	//Is this vob?
	var int vobPtr; vobPtr = MEM_SearchVobByName (vobName);
	if (vobPtr) {
		if (zCVob_GetPositionWorldToPos (vobPtr, _@ (pos))) {
		};
	} else {
		//Is this waypooint?
		var int wpPtr; wpPtr = SearchWaypointByName (vobName);
		if (wpPtr) {
			var zCWaypoint wp; wp = _^ (wpPtr);
			MEM_CopyBytes (_@ (wp.pos), _@ (pos), 12);
		} else {
			//What do we do here?
		};
	};

	//Update Npc's position
	slf._zCVob_trafoObjToWorld[3] = pos[0];
	slf._zCVob_trafoObjToWorld[7] = pos[1];
	slf._zCVob_trafoObjToWorld[11] = pos[2];

	zCVob_PositionUpdated (_@ (slf));
};

/*
 *	Npc_HasAni
 *	 - function loops through EM and checks if aniName is in AI queue
 *	 - function returns number of EM messages with specified aniName
 */
func int Npc_HasAni (var int slfInstance, var string aniName) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	aniName = STR_Upper (aniName);

	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return FALSE; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);
	var int count; count = 0;

	//Loop through Event Messages
	repeat (i, eventTotal); var int i;
		var int eMsg; eMsg = zCEventManager_GetEventMessage (eMgr, i);

		if (Hlp_Is_oCMsgConversation (eMsg)) {
			if (zCEventMessage_GetSubType (eMsg) == EV_PLAYANI_NOOVERLAY) {
				var oCMsgConversation msg; msg = _^ (eMsg);

				if (Hlp_StrCmp (msg.name, aniName)) {
					count += 1;
				};
			};
		};
	end;

	if (Npc_IsAniActive_ByAniName(slf, aniName)) {
		count += 1;
	};

	return count;
};

/*
 *	Npc_TurnToVob
 *	 - turns to vob
 */
func void oCAniCtrl_Human_TurnDegrees (var int aniCtrlPtr, var int degreesF, var int startTurnAnis) {
	//0x00625FB0 public: void __thiscall oCAniCtrl_Human::TurnDegrees(float,int)
	const int oCAniCtrl_Human__TurnDegrees_G1 = 6447024;

	//0x006AEB10 public: void __thiscall oCAniCtrl_Human::TurnDegrees(float,int)
	const int oCAniCtrl_Human__TurnDegrees_G2 = 7006992;

	//Safety check
	if (!aniCtrlPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (startTurnAnis));
		CALL_FloatParam (_@ (degreesF));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__TurnDegrees_G1, oCAniCtrl_Human__TurnDegrees_G2));
		call = CALL_End ();
	};
};

func void Npc_TurnToVob (var int slfInstance, var int vobPtr, var int startTurnAnis) {
	var int fAzimuth; fAzimuth = FLOATNULL;
	var int fElevation; fElevation = FLOATNULL;

	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	oCNpc_GetAnglesVob (slfInstance, vobPtr, _@ (fAzimuth), _@ (fElevation));

	oCAniCtrl_Human_TurnDegrees (slf.aniCtrl, fAzimuth, startTurnAnis);
};

func void Npc_TurnDegrees (var int slfInstance, var int degreesF, var int startTurnAnis) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };
	oCAniCtrl_Human_TurnDegrees (slf.aniCtrl, degreesF, startTurnAnis);
};

func int Npc_GetAIState(var int slfInstance) {
	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return -1; };

	var oCNPC_States state; state = _^ (statePtr);

	if (state.curState_prgIndex < -1) {
		return state.curState_prgIndex;
	};

	return state.curState_index;
};

func void Npc_SetAIState_ByIndex (var int slfInstance, var int index) {
	var int statePtr; statePtr = NPC_GetNPCState (slfInstance);
	if (!statePtr) { return; };

	var oCNPC_States state; state = _^ (statePtr);

	state.curState_valid = TRUE;
	state.curState_index = index;

	state.curState_name = GetSymbolName(index);

	//Special logic for by engine recognized ZS states
	if (index < -1) {
		state.curState_prgIndex = index;

		var string stateName; stateName = STR_EMPTY;

		if (index == -2) { stateName = "ZS_ANSWER"; };
		if (index == -3) { stateName = "ZS_DEAD"; };
		if (index == -4) { stateName = "ZS_UNCONSCIOUS"; };
		if (index == -5) { stateName = "ZS_FADEAWAY"; };
		if (index == -6) { stateName = "ZS_FOLLOW"; };

		state.curState_name = stateName;
		state.curState_loop = MEM_FindParserSymbol(ConcatStrings (stateName, "_LOOP"));
		state.curState_end = MEM_FindParserSymbol(ConcatStrings (stateName, "_END"));
	};
};

/*
 *	Npc_SetAIState
 *	 - function overrides curState.index (#hacker)
 */
func void Npc_SetAIState (var int slfInstance, var string stateName) {
	var int index; index = MEM_FindParserSymbol (stateName);

	//Special logic for by engine recognized ZS states
	if (Hlp_StrCmp(stateName, "ZS_ANSWER")) { index = -2; } else
	if (Hlp_StrCmp(stateName, "ZS_DEAD")) { index = -3; } else
	if (Hlp_StrCmp(stateName, "ZS_UNCONSCIOUS")) { index = -4; } else
	if (Hlp_StrCmp(stateName, "ZS_FADEAWAY")) { index = -5; } else
	if (Hlp_StrCmp(stateName, "ZS_FOLLOW")) { index = -6; };

	Npc_SetAIState_ByIndex(slfInstance, index);
};

func string Npc_GetInteractMobName (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return STR_EMPTY; };

	if (!Hlp_Is_oCMobInter (slf.interactMob)) { return STR_EMPTY; };

	var oCMobInter mobInter; mobInter = _^ (slf.interactMob);
	return mobInter._zCObject_objectName;
};

func int Npc_IsFlying (var int slfInstance) {
	var int modelPtr; modelPtr = oCNpc_GetModel (slfInstance);
	if (!modelPtr) { return FALSE; };
	var zCModel model; model = _^ (modelPtr);

	const int zCModel_bitfield_isFlying = 2;
	return + (model.zCModel_bitfield & zCModel_bitfield_isFlying);
};

func void Npc_StopLookAt (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	var int count; count = NPC_EM_GetEventCount (slf);

	//Delete all EV_LOOKAT messages from EM
	repeat (i, count); var int i;
		var int eventMessage; eventMessage = zCEventManager_GetEventMessage (eMgr, i);

		if (Hlp_Is_oCMsgConversation (eventMessage)) {
			//TODO: can EV_WAITTILLEND wait for EV_LOOKAT message? (if it can - will it freeze AI?)
			if (zCEventMessage_GetSubType (eventMessage) == EV_LOOKAT) {
				//zCEventMessage_Delete (eventMessage);
				zCEventManager_Delete (eMgr, eventMessage);
				i -= 1;
			};
		};
	end;

	//We **have to remove** pointer - as message was certainly deleted by above loop
	slf.lastLookMsg = 0;

	//Stop look at animations
	oCAniCtrl_Human_StopLookAtTarget (slf.aniCtrl);

	//TODO: do we want to remove targetVob?
	//oCAniCtrl_Human_SetLookAtTarget (slf.aniCtrl, 0);
};

func int Npc_IsControlled (var int slfInstance) {
	return + oCNpc_HasBodyStateModifier (slfInstance, BS_MOD_CONTROLLED);
};

func int NPC_IsTransformed (var int slfInstance) {
	return + oCNPC_HasBodyStateModifier (slfInstance, BS_MOD_TRANSFORMED);
};

/*
 *	Npc_HasAnyOU
 *	 - function loops through EM and checks if there are any EV_OUTPUT event messages in AI queue
 */
func int Npc_HasAnyOU (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return FALSE; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);
	var int count; count = 0;

	//Loop through Event Messages
	repeat (i, eventTotal); var int i;
		var int eMsg; eMsg = zCEventManager_GetEventMessage (eMgr, i);

		if (Hlp_Is_oCMsgConversation (eMsg)) {
			var int subType; subType = zCEventMessage_GetSubType (eMsg);
			if (subType == EV_OUTPUT)
			|| (subType == EV_OUTPUTSVM)
			|| (subType == EV_OUTPUTSVM_OVERLAY)
			{
				count += 1;
			};
		};
	end;

	return count;
};

/*
 *	Npc_HasOU
 *	 - function loops through EM and checks if there are any EV_OUTPUT event messages in AI queue
 */
func int Npc_HasOU (var int slfInstance, var int ou) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return FALSE; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);
	var int count; count = 0;

	//Loop through Event Messages
	repeat (i, eventTotal); var int i;
		var int eMsg; eMsg = zCEventManager_GetEventMessage (eMgr, i);

		if (Hlp_Is_oCMsgConversation (eMsg)) {
			var int subType; subType = zCEventMessage_GetSubType (eMsg);
			if (subType == EV_OUTPUT)
			|| (subType == EV_OUTPUTSVM)
			|| (subType == EV_OUTPUTSVM_OVERLAY)
			{
				var oCMsgConversation msg; msg = _^ (eMsg);

				var string name; name = msg.name;

				var int index; index = STR_IndexOf (name, ".");
				if (index > -1) {
					name = mySTR_SubStr (name, 0, index);
				};

				zSpy_Info (slf.Name);
				zSpy_Info (name);

				if (zCCSManager_LibValidateOU_ByName (name) == ou) {
					return TRUE;
				};
			};
		};
	end;

	return FALSE;
};

/*
 *
 */
func int Npc_BarrierIsWarning(var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	return (slf.magFrontier_bitfield & oCMagFrontier_bitfield_isWarning);
};
