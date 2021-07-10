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
	//00622730  .text     Debug data           ?GetWalkModeString@oCAniCtrl_Human@@QAE?AVzSTRING@@XZ
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

	if (Hlp_StrCmp (result, "RUN"))		{ 	return NPC_RUN; 	} else
	if (Hlp_StrCmp (result, "WALK"))	{ 	return NPC_WALK;	} else
	if (Hlp_StrCmp (result, "SNEAK"))	{	return NPC_SNEAK;	} else
	if (Hlp_StrCmp (result, ""))		{	return NPC_INWATER;	};
	
	return -1;
};

/*
 *
 */

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

func string NPC_GetRoutineName (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return ""; };

	var int ptr; ptr = _@ (slf);
	
	//var func daily_routine;	//G1	0x0218 int
	//var func daily_routine;	//G2	0x0260 int
	
	var int offset; offset = MEMINT_SwitchG1G2 (536, 608);

	var int symbID; symbID = MEM_ReadInt (ptr + offset);
	
	if (symbID > 0) && (symbID < currSymbolTableLength) {
		var zCPar_symbol symb; symb = _^ (MEM_GetSymbolByIndex (symbID));
		return symb.name;
	};

	return "";
};

func int NPC_IsInRoutineName (var int slfInstance, var string rtnName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);

	var string curRtnName;
	curRtnName = STR_Upper (rtnName);
	curRtnName = ConcatStrings ("RTN_", curRtnName);
	curRtnName = ConcatStrings (curRtnName, "_");
	curRtnName = ConcatStrings (curRtnName, IntToString (slf.ID));
	
	return Hlp_StrCmp (NPC_GetRoutineName (slf), curRtnName);
};

func string NPC_GetAIStateName (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return ""; };

	var int ptr; ptr = _@ (slf);
	
	//var func startAIState;	//G1	0x021C int
	//var func startAIState;	//G2	0x0264 int

	var int offset; offset = MEMINT_SwitchG1G2 (540, 612);

	var int symbID; symbID = MEM_ReadInt (ptr + offset);

	if (symbID > 0) && (symbID < currSymbolTableLength) {
		var zCPar_symbol symb; symb = _^ (MEM_GetSymbolByIndex (symbID));
		return symb.name;
	};

	return "";
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
 *	Function checks if Active spell is scroll (all scrolls should have ITEM_MULTI flag)
 *	G1 does not have this function.
 */
func int NPC_GetActiveSpellIsScroll_G1 (var int slfInstance) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return FALSE; };

	if (slf.fMode != FMODE_MAGIC) { return FALSE; };
	
	if (!slf.mag_book) { return FALSE; };

	var oCMag_Book magBook;
	magBook = _^ (slf.mag_book);

	if (!magBook.spellitems_array) { return FALSE; };

	var int selectedSpell; selectedSpell = MEM_ReadIntArray (magBook.spellitems_array, magBook.spellnr);

	var oCItem spell; spell = _^ (selectedSpell);

	return (spell.flags & ITEM_MULTI);
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
							timedOverlay.mdsOverlayName = "";
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
				timedOverlay.mdsOverlayName = "";
				timedOverlay.timer = FLOATNULL;
			};
		};

		ptr = list.next;
	end;
};

func void NPC_AddBitfield (var int slfInstance, var int addBitfield) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (addBitfield & zCVob_bitfield2_sleepingMode) {
		slf._zCVob_bitfield[2] = (slf._zCVob_bitfield[2] & ~ zCVob_bitfield2_sleepingMode) | 0;
	};
};

func void NPC_RemoveBitfield (var int slfInstance, var int removeBitfield) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (removeBitfield & zCVob_bitfield2_sleepingMode) {
		slf._zCVob_bitfield[2] = (slf._zCVob_bitfield[2] & ~ zCVob_bitfield2_sleepingMode) | 1;
	};
};

/*
 *	Switches torches on - off
 *		return -1 if NPC does not have torch
 *		return 0 if torch was removed
 *		return 1 if torch was used
 */
func int NPC_TorchSwitchOnOff (var int slfinstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };

	//Get pointer to ZS_LEFTHAND
	var int ptr; ptr = oCNpc_GetSlotItem (slf, "ZS_LEFTHAND");
	
	//Is there anything in hand? - put it away
	if (ptr) {
		var oCItem itm; itm = _^ (ptr);

		//Is it ItLsTorchBurning ?
		if ((Hlp_GetinstanceID (itm) == ItLsTorchBurning) || (Hlp_GetinstanceID (itm) == ItLsTorchBurned)) {
			//Use item - will put ItLsTorch back to inventory
			if (oCNpc_UseItem (slf, ptr)) {
				//For some reason we have to remove pointer here
				NPC_RemoveInvItem (slf, ptr);

				if (NPC_HasOverlay (hero, "HUMANS_TORCH.MDS")) {
					Mdl_RemoveOverlayMds (hero, "HUMANS_TORCH.MDS");
					return 0;
				};
			};
		};
	} else {
		//Search for ItLsTorchBurned
		ptr = NPC_GetInvItem (slf, ItLsTorchBurned);
		
		//Search for ItLsTorch
		if (!ptr) {
			ptr = NPC_GetInvItem (slf, ItLsTorch);
		};
		
		//Fill item with pointer to some ItLsTorch in inventory
		if (ptr) {
			//get torch pointer
			ptr = _@ (item);

			//Equip it - puts ItLsTorchBurning in hand
			if (oCNpc_UseItem (slf, ptr)) {
				//For some reason we have to remove pointer here
				NPC_RemoveInvItem (slf, ptr);
				return 1;
			};
		};
	};
	
	return -1;
};

func void NPC_TorchSwitchOff (var int slfinstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	
	//Get pointer to ZS_LEFTHAND
	var int ptr; ptr = oCNpc_GetSlotItem (slf, "ZS_LEFTHAND");
	
	//Is there anything in hand?
	if (ptr) {
		var oCItem itm; itm = _^ (ptr);
		
		//Is it ItLsTorchBurning ?
		if ((Hlp_GetinstanceID (itm) == ItLsTorchBurning) || (Hlp_GetinstanceID (itm) == ItLsTorchBurned)) {
			//Use item - will put ItLsTorch back to inventory
			if (oCNpc_UseItem (slf, ptr)) {
				//For some reason we have to remove pointer here
				NPC_RemoveInvItem (slf, ptr);

				if (NPC_HasOverlay (hero, "HUMANS_TORCH.MDS")) {
					Mdl_RemoveOverlayMds (hero, "HUMANS_TORCH.MDS");
				};
			};
		};
	};
};

func void NPC_TorchSwitchOn (var int slfinstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//Get pointer to ZS_LEFTHAND
	var int ptr; ptr = oCNpc_GetSlotItem (slf, "ZS_LEFTHAND");
	
	//Is there anything in hand?
	if (ptr) {
		var oCItem itm; itm = _^ (ptr);
		
		//Is it ItLsTorchBurned? if yes - remove - script below will but ItLsTorchBurning in hand
		if (Hlp_GetinstanceID (itm) == ItLsTorchBurned) {
			if (oCNpc_UseItem (slf, ptr)) {
				//For some reason we have to remove pointer here
				NPC_RemoveInvItem (slf, ptr);
				ptr = 0;
			};
		};
	};
	
	//Is hand empty?
	if (!ptr) {
		//Search for ItLsTorchBurned - use if possible
		ptr = NPC_GetInvItem (slf, ItLsTorchBurned);
		
		//Search for ItLsTorch
		if (!ptr) {
			ptr = NPC_GetInvItem (slf, ItLsTorch);
		};
		
		if (ptr) {
			//get torch pointer
			ptr = _@ (item);

			//Use it - puts ItLsTorchBurning in hand
			oCNpc_UseItem (slf, ptr);
			
			//For some reason we have to remove pointer here
			NPC_RemoveInvItem (slf, ptr);
		};
	};
};

func int NPC_CarriesTorch (var int slfinstance) {
	var oCNpc slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return FALSE; };
	
	//Get pointer to ZS_LEFTHAND
	var int ptr; ptr = oCNpc_GetSlotItem (slf, "ZS_LEFTHAND");
	
	//Is there anything in hand?
	if (ptr) {
		var oCItem itm; itm = _^ (ptr);
		
		//Is it ItLsTorchBurning / ItLsTorchBurned ?
		if ((Hlp_GetinstanceID (itm) == ItLsTorchBurning) || (Hlp_GetinstanceID (itm) == ItLsTorchBurned)) {
			return TRUE;
		};
	};
	
	return FALSE;
};

/*
 *	Function calls torch exchange & removes overlay when torch is not in ZS_LEFTHAND
 */
func int NPC_DoExchangeTorch (var int slfInstance) {
	if (oCNpc_DoExchangeTorch (slfInstance)) {
		if (!NPC_CarriesTorch (slfInstance)) {
			if (NPC_HasOverlay (slfInstance, "HUMANS_TORCH.MDS")) {
				//No need to validate slf - all functions above do the validation
				var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
				Mdl_RemoveOverlayMds (slf, "HUMANS_TORCH.MDS");
			};
		};

		return TRUE;
	};
	return FALSE;
};

func int NPC_GetNode (var int slfInstance, var string nodeName) {
	//0x00563F80 public: class zCModelNodeInst * __thiscall zCModel::SearchNode(class zSTRING const &)
	const int zCModel__SearchNode_G1 = 5652352;

	//0x0057DFF0 public: class zCModelNodeInst * __thiscall zCModel::SearchNode(class zSTRING const &)
	const int zCModel__SearchNode_G2 = 5758960;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int model; model = oCNPC_GetModel (slfInstance);

	if (!model) { return 0; };

	CALL_zStringPtrParam (nodeName);
	CALL__thiscall (model, MEMINT_SwitchG1G2 (zCModel__SearchNode_G1, zCModel__SearchNode_G2));

	return CALL_RetValAsPtr ();
};

func int NPC_GetNodePositionWorld (var int slfInstance, var string nodeName) {
	//0x0055F8C0 public: class zVEC3 __thiscall zCModel::GetNodePositionWorld(class zCModelNodeInst *)
	const int zCModel__GetNodePositionWorld_G1 = 5634240;

	//0x00579140 public: class zVEC3 __thiscall zCModel::GetNodePositionWorld(class zCModelNodeInst *)
	const int zCModel__GetNodePositionWorld_G2 = 5738816;

	var int model; model = oCNPC_GetModel (slfInstance);
	
	if (!model) { return 0; };
	
	var int node; node = NPC_GetNode (slfInstance, nodeName);
	
	if (!node) { return 0; };

	CALL_RetValIsStruct (12);
	CALL_PtrParam (node);
	CALL__thiscall (model, MEMINT_SwitchG1G2 (zCModel__GetNodePositionWorld_G1, zCModel__GetNodePositionWorld_G2));
	
	return CALL_RetValAsPtr ();
};

/*
 *
 */
func int NPC_GetDistToPos (var int slfInstance, var int posPtr) {
	if (!posPtr) { return -1; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };

	//Backup soundPosition
	var int pos[3];
	MEM_CopyBytes (_@ (slf.soundPosition), _@ (pos[0]), 12);

	slf.soundPosition[0] = MEM_ReadIntArray (posPtr, 0);
	slf.soundPosition[1] = MEM_ReadIntArray (posPtr, 1);
	slf.soundPosition[2] = MEM_ReadIntArray (posPtr, 2);

	//We will exploit this engine function to calculate
	var int dist; dist = Snd_GetDistToSource (slf);

	//Restore soundPosition
	MEM_CopyBytes (_@ (pos[0]), _@ (slf.soundPosition), 12);

	return dist;
};

func int NPC_GetDistToVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return -1; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return -1; };
	
	var zCVob vob; vob = _^(vobPtr);
	
	var int pos[3];
	//TrfToPos (_@(vob.trafoObjToWorld), _@ (pos));
	MEM_WriteIntArray(_@ (pos), 0, MEM_ReadIntArray(_@(vob.trafoObjToWorld),  3));
	MEM_WriteIntArray(_@ (pos), 1, MEM_ReadIntArray(_@(vob.trafoObjToWorld),  7));
	MEM_WriteIntArray(_@ (pos), 2, MEM_ReadIntArray(_@(vob.trafoObjToWorld), 11));
	
	return NPC_GetDistToPos (slf, _@ (pos));
};
