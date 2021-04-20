/*
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
	//006257E0  .text     Debug data           ?IsWalking@oCAniCtrl_Human@@QAEHXZ
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
		//Is G2A same ???
		MEM_WriteInt (ptr + 464, f);
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
func int NPC_HasTimedOverlay (var int slfInstance, var string testOverlay)
{
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
