/*
 *	Multi-teleport spell book [WIP]
 *
 *	This simple feature will create new separate spell book for all teleport runes in players inventory
 *	by pressing KEY_3 spell book will open and will allow you to select desired teleportation spell
 */

//-- Internal variables

var int _multiTeleportModeActive;

var int _multiTeleportMagBook;
var int _multiTeleportMagBookBackup;

var int _multiTeleportSpellNr;
var int _multiTeleportSpellID;

/*
 *	Close spell book
 */
func void DoCloseMagBook__MultiTeleport() {
	//Safety checks
	if (!_multiTeleportMagBook) { return; };

	//Save spell-index and spell ID for magbook rebuilding (we will keep track of spell that player selected last time)
	_multiTeleportSpellNr = oCMag_Book_GetSelectedSpellNr(_multiTeleportMagBook);
	_multiTeleportSpellID = oCMag_Book_GetSelectedSpellID(_multiTeleportMagBook);

	//Close mag book
	var oCMag_Book magBook; magBook = _^(_multiTeleportMagBook);

	if (magBook.open) {
		magBook.in_movement = TRUE;
		magBook.action = 3;
		magBook.t1 = FLOATNULL;
		magBook.remove_all = TRUE;
	} else {
		oCMag_Book_SetShowHandSymbol(_multiTeleportMagBook, FALSE);
	};

	//Disable multi-teleport mode - just in case
	_multiTeleportModeActive = FALSE;
};

/*
 *	Hook called when magbook closes
 */
func void _hook_oCMag_Book_Close__MultiTeleport () {
	if (ECX != _multiTeleportMagBook) { return; };
	//Close multi-teleport magbook
	DoCloseMagBook__MultiTeleport();
};

/*
 *	This hooked function overrides check for pressed key
 */
func void _hook_oCAIHuman_WeaponChoose_KeyWeapon__MultiTeleport () {

	//Pressed
	//EAX 1
	//ECX 135396768

	//ECX 0x007D2A0C const zCInput_Win32::`vftable'
	//0x004C8310 public: virtual float __thiscall zCInput_Win32::GetState(unsigned short)

	//Not pressed
	//EAX 138529216
	//ECX 1

	if (EAX != 1) {
		EAX = 0;
	} else {
		EAX = 1;
	};

	//If in multi-teleport mode - check controls
	//Up, Action and Spacebar will select spell
	//Down will cancel NPC_WEAPON_MAG mode - will cancel selection
	//Left/Right is handled by engine
	if (_multiTeleportModeActive)
	{
		var int keySpace; keySpace = MEM_KeyState(KEY_SPACE);

		var int keyUp; keyUp = MEM_GetKey("keyUp"); keyUp = MEM_KeyState(keyUp);
		var int keyUpSecondary; keyUpSecondary = MEM_GetSecondaryKey("keyUp"); keyUpSecondary = MEM_KeyState(keyUpSecondary);

		var int keyDown; keyDown = MEM_GetKey("keyDown"); keyDown = MEM_KeyState(keyDown);
		var int keyDownSecondary; keyDownSecondary = MEM_GetSecondaryKey("keyDown"); keyDownSecondary = MEM_KeyState(keyDownSecondary);

		var int keyAction; keyAction = MEM_GetKey("keyAction"); keyAction = MEM_KeyState(keyAction);
		var int keyActionSecondary; keyActionSecondary = MEM_GetSecondaryKey("keyAction"); keyActionSecondary = MEM_KeyState(keyActionSecondary);

		//Select spell
		if ((keyUp == KEY_PRESSED) || (keyUp == KEY_HOLD))
		|| ((keyUpSecondary == KEY_PRESSED) || (keyUpSecondary == KEY_HOLD))
		|| ((keySpace == KEY_PRESSED) || (keySpace == KEY_HOLD))
		|| ((keyAction == KEY_PRESSED) || (keyAction == KEY_HOLD))
		|| ((keyActionSecondary == KEY_PRESSED) || (keyActionSecondary == KEY_HOLD))
		{
			//Select spell
			_multiTeleportModeActive = FALSE;
			EAX = 0;
			return;
		};

		//Cancel selection
		if ((keyDown == KEY_PRESSED) || (keyDown == KEY_HOLD))
		|| ((keyDownSecondary == KEY_PRESSED) || (keyDownSecondary == KEY_HOLD))
		{
			var oCNpc her; her = Hlp_GetNpc(hero);
			if(her.aniCtrl)
			{
				var oCAniCtrl_Human aniCtrl; aniCtrl = _^(her.aniCtrl);

				//Stop changeweapon and 'disable' _multiTeleportModeActive
				aniCtrl.wmode_last = NPC_WEAPON_MAG;
				aniCtrl.wmode_selected = NPC_WEAPON_MAG;
				aniCtrl.changeweapon = FALSE;
			};

			_multiTeleportModeActive = FALSE;
			EAX = 0;
			return;
		};
	};

	//If multi-teleport is active - override condition (it will behave as if player holds keyWeapon)
	if (_multiTeleportModeActive) {
		EAX = 1;
	};
};

/*
 *	Frame function
 */
func void _hook_oCNpc_DoSpellBook__MultiTeleport () {
	if (!_multiTeleportMagBook) { return; };

	if (!Hlp_Is_oCNpc(ECX)) { return; };
	var oCNpc npc; npc = _^(ECX);
	if (!Npc_IsPlayer(npc)) { return; };

	//Do engine stuff
	oCMag_Book_DoPerFrame(_multiTeleportMagBook);

	//Exit if still active
	if (_multiTeleportModeActive) {
		return;
	};

	var oCMag_Book magBook; magBook = _^ (_multiTeleportMagBook);

	if (magBook.open) {
		//If not closing already - close
		if (magBook.action != 3) {
			DoCloseMagBook__MultiTeleport();
		};
	} else
	{
		//Exit if still in NPC_WEAPON_MAG
		var oCNpc her; her = Hlp_GetNpc(npc);
		if(her.aniCtrl) {
			const int WMODE_CHOOSE = 2;
			const int ANI_ACTION_CHOOSEWEAPON = 7;

			var oCAniCtrl_Human aniCtrl; aniCtrl = _^(her.aniCtrl);

			//If weapon is removed while *running* then wmode_selected, changeweapon and wmode have all three incorrect values ... (basically an engine bug?)
			//wmode_selected is therefore not 100% reliable as it remains wmode_selected == NPC_WEAPON_MAG
			//the only workaround which seems to be working for now is to check if we are still in action mode ANI_ACTION_CHOOSEWEAPON
			//if no then it means we shall use oCNpc_GetWeaponMode(npc) instead of wmode_selected

			var int wm; wm = aniCtrl.wmode_selected;

			if ((aniCtrl.wmode_selected == NPC_WEAPON_MAG) && (aniCtrl.changeweapon) && (aniCtrl.wmode == WMODE_CHOOSE) && (oCNpc_GetWeaponMode(npc) == NPC_WEAPON_NONE))
			{
				if (aniCtrl.actionMode != ANI_ACTION_CHOOSEWEAPON)
				{
					wm = NPC_WEAPON_NONE;
				};
			};

			if (wm == NPC_WEAPON_MAG) {
				return;
			};
		};

		//Destroy if closed

		//If spell book closed - destroy it
		npc.mag_book = _multiTeleportMagBook;
		oCNpc_DestroySpellBook(npc);

		//Restore backed up mag book
		npc.mag_book = _multiTeleportMagBookBackup;

		//Reset pointers
		_multiTeleportMagBookBackup = 0;
		_multiTeleportMagBook = 0;

		_multiTeleportModeActive = FALSE;
	};
};

/*
 *	Key press listener
 */
func void _eventGameHandleEvent__MultiTeleport (var int key) {
	//var int cancel; cancel = FALSE;
	//var int key; key = MEM_ReadInt (ESP + 4);

	var oCNpc her;

	//Ignore events where key <> KEY_3
	if (key != KEY_3) { return; };

	//If mag book exists already - either select spell or exit function
	// - if spell book opens - pressing KEY_3 again will select spell
	// - if player spam-clicks KEY_3, spell book might not open completely, frame function _hook_oCNpc_DoSpellBook__MultiTeleport will close & destroy spell book if _multiTeleportModeActive is FALSE
	if (_multiTeleportMagBook) {
		//Cancel multi-teleport mode
		_multiTeleportModeActive = FALSE;

		//If in NPC_WEAPON_MAG - exit and do not cancel input - engine will unready spell
		if (oCNpc_GetWeaponMode(hero) == NPC_WEAPON_MAG) {
			return;
		};

		//Cancel key input
		//EDI has to be also nulled
		zCInputCallback_SetKey(0);

		return;
	};

	//If player can't draw weapon - exit
	if (!oCNpc_CanDrawWeapon(hero)) { return; };

	//If already in any weapon mode - exit
	if (oCNpc_GetWeaponMode(hero) != NPC_WEAPON_NONE) { return; };

	//If walking - exit
	if (Npc_IsWalking(hero)) { return; };

	//Close inventory
	Npc_CloseInventory(hero);

	//Close multi-teleport spell book
	//This call in theory should not be needed - but keeping it as a safety net
	DoCloseMagBook__MultiTeleport();

	//Backup original mag_book
	her = Hlp_GetNpc(hero);
	_multiTeleportMagBookBackup = her.mag_book;

	//Create new custom spell book
	her.mag_book = 0;
	oCNpc_MakeSpellBook(hero);

	//Get pointer to new spell book
	_multiTeleportMagBook = her.mag_book;

	//Register all teleportation spells
	var int retVal;
	var int playerHasTeleportationSpell; playerHasTeleportationSpell = FALSE;

	//Loop through all items
	var int amount;
	var int itmSlot; itmSlot = 0;

	amount = Npc_GetInvItemBySlot (hero, INV_RUNE, itmSlot);
	while (amount > 0);
		//G2 does not have separate inventories for items - Npc_GetInvItemBySlot goes through whole inventory
		//we have to check invCat one more time here!
		if (Npc_ItemGetCategory(hero, _@(item)) != INV_RUNE) {
			itmSlot += 1;
			amount = Npc_GetInvItemBySlot(hero, INV_RUNE, itmSlot);
			continue;
		};

		//Check spell instance name
		var string instanceName;
		instanceName = Spell_GetInstanceName(item.spell);
		instanceName = STR_Upper(instanceName);

		//If spell starts with TELEPORT - then player has teleportation spells :)
		//Register this spell in custom spell book
		if (STR_StartsWith(instanceName, "TELEPORT")) {
			playerHasTeleportationSpell = TRUE;
			retVal = oCMag_Book_RegisterByItemPtr_NoHotkey(her.mag_book, _@(item), 1);
		};

		itmSlot = itmSlot + 1;
		amount = Npc_GetInvItemBySlot(hero, INV_RUNE, itmSlot);
	end;

	//If player does not have any teleportation spells ... exit
	if (!playerHasTeleportationSpell) {
		DoCloseMagBook__MultiTeleport();
		return;
	};

	//Safety check
	if (!her.mag_book) { return; };

	//Try to select last spellNr / spellID
	//prio: spellNr & spellID match ... if spellNr does not match we are still okay will spellID
	var oCMag_Book magBook; magBook = _^ (her.mag_book);

	if (oCMag_Book_GetSpellID_ByIndex(her.mag_book, _multiTeleportSpellNr) == _multiTeleportSpellID) {
		magBook.spellNr = _multiTeleportSpellNr;
	} else {
		repeat(i, magBook.spellItems_numInArray); var int i;
			if (oCMag_Book_GetSpellID_ByIndex(her.mag_book, i) == _multiTeleportSpellID) {
				magBook.spellNr = i;
				break;
			};
		end;
	};

	//zCVob_EndMovement(_@(hero), FALSE);

	//Draw NPC_WEAPON_MAG and show spell circle
	AI_DrawWeapon1(hero, NPC_WEAPON_MAG, 0, 1);

	_multiTeleportModeActive = TRUE;

	//Cancel key input
	zCInputCallback_SetKey(0);
};

/*
 *	Game state listener
 */
func void _eventGameState__MultiTeleport(var int eventType) {
	if (!_multiTeleportMagBook) { return; };

	//Reset pointers on new game and game load
	if ((eventType == Gamestate_NewGame)
	|| (eventType == Gamestate_Loaded))
	{
		_multiTeleportMagBook = 0;
		_multiTeleportMagBookBackup = 0;
		_multiTeleportModeActive = FALSE;
		return;
	};

	var oCNpc npc; npc = Hlp_GetNpc(hero);

	//Restore mag book pointer prior saving (so old mag book gets saved into save file properly)
	if (eventType == Gamestate_PreSaveGameProcessing) {
		npc.mag_Book = _multiTeleportMagBookBackup;
		return;
	};

	//Update mag book pointer post saving (so we continue playing like nothing has changed)
	if (eventType == Gamestate_PostSaveGameProcessing) {
		npc.mag_Book = _multiTeleportMagBook;
		return;
	};
};

func void G12_MultiTeleport_Init () {
	const int once = 0;

	//Add listener for key-pressing

	G12_GameHandleEvent_Init();
	GameHandleEvent_AddListener (_eventGameHandleEvent__MultiTeleport);

	//Add listener for game states

	G12_GameState_Extended_Init();

	if (_LeGo_Flags & LeGo_Gamestate) {
		GameState_AddListener(_eventGameState__MultiTeleport);
	} else {
		zSpy_Info("G12_MultiTeleport_Init: warning this feature required LeGo_Gamestate flag to be enabled!");
	};

	if (!once) {
/*
        00610181 8b  01           MOV        EAX ,dword ptr [this ]
        00610183 57               PUSH       EDI
        00610184 6a  08           PUSH       0x8
        00610186 ff  50  04       CALL       dword ptr [EAX  + 0x4 ]
        00610189 e8  ca  73       CALL       __ftol                                           undefined __ftol()
                 16  00
        0061018e 85  c0           TEST       EAX ,EAX

        00695ab1 8b  01           MOV        EAX ,dword ptr [this ]
        00695ab3 57               PUSH       EDI
        00695ab4 6a  08           PUSH       0x8
        00695ab6 ff  50  04       CALL       dword ptr [EAX  + 0x4 ]
        00695ab9 e8  8a  b4       CALL       __ftol                                           undefined __ftol()
                 13  00
        00695abe 85  c0           TEST       EAX ,EAX
*/

		//Hook checking whether player is holding keyWeapon (spacebar)
		//Normally mag book would show up only if player is holding spacebar
		//We however want to display mag book all the time - up until player selects spell

		//00610189
		const int oCAIHuman__WeaponChoose_keyWeapon_G1 = 6357385;

		//00695AB9
		const int oCAIHuman__WeaponChoose_keyWeapon_G2 = 6904505;

		var int addr; addr = MEMINT_SwitchG1G2(oCAIHuman__WeaponChoose_keyWeapon_G1, oCAIHuman__WeaponChoose_keyWeapon_G2);
		MEM_WriteNop(addr, 5);
		HookEngine(addr, 5, "_hook_oCAIHuman_WeaponChoose_KeyWeapon__MultiTeleport");

		//Hook 'listener' for spell book closing event
		//0x004705B0 public: void __thiscall oCMag_Book::Close(int)
		const int oCMag_Book__Close_G1 = 4654512;

		//0x00477270 public: void __thiscall oCMag_Book::Close(int)
		const int oCMag_Book__Close_G2 = 4682352;

		HookEngine (MEMINT_SwitchG1G2 (oCMag_Book__Close_G1, oCMag_Book__Close_G2), 7, "_hook_oCMag_Book_Close__MultiTeleport");

		//Frame-function
		//0x0069B340 public: void __thiscall oCNpc::DoSpellBook(void)
		const int oCNpc__DoSpellBook_G1 = 6927168;

		//0x0073E980 public: void __thiscall oCNpc::DoSpellBook(void)
		const int oCNpc__DoSpellBook_G2 = 7596416;

		HookEngine (MEMINT_SwitchG1G2 (oCNpc__DoSpellBook_G1, oCNpc__DoSpellBook_G2), 6, "_hook_oCNpc_DoSpellBook__MultiTeleport");

		once = 1;
	};
};
