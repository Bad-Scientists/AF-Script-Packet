//obsluha klaves pri truhlici (napravo)
//obsluha klaves pri obchodovani (obchodnikov kontainer vstrede pohyb dole, hore)
//obsluha klaves pri obchodovani (hracov kontainer vstrede pohyb dole, hore)
func void _eventItemContainerHandleEvent__QuickLoot (var int dummyVariable) {
	//B_Msg_Add ("_hook_oCItemContainer_HandleEvent");

	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//Left/Right Alt
	if (key == KEY_LMENU) || (key == KEY_RMENU) {
		var oCNPC her; her = Hlp_GetNPC (hero);
		
		if (Hlp_Is_oCMobContainer (her.focus_vob)) {
			//Inventory does not have to be closed !

			//0x00668C10 public: virtual void __thiscall oCItemContainer::Close(void) 
			const int oCItemContainer__Close = 6720528;
			CALL__thiscall (ECX, oCItemContainer__Close);

			//Close players inventory
			oCNPC_CloseInventory (her);

			//Transfer all items
			Mob_TransferItemsToNPC (her.focus_vob, her);
			
			//0x00667EB0 public: virtual void __thiscall oCItemContainer::Open(int,int,enum oCItemContainer::oTItemListMode) 
		};
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

//obsluha klaves pri obchodovani (nalavo, pohyb dole, hore)
func void _eventStealContainerHandleEvent__QuickLoot (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//...

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

//obsluha klaves pri mrtvom NPC (inventar nalavo)
func void _eventNpcContainerHandleEvent__QuickLoot (var int dummyVariable) {
	//B_Msg_Add ("_hook_oCNpcContainer_HandleEvent");

	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//Left/Right Alt
	if (key == KEY_LMENU) || (key == KEY_RMENU) {
		var oCNPC her; her = Hlp_GetNPC (hero);
		var oCNPC npc;
		
		if (Hlp_Is_oCNpc (her.focus_vob)) {
			npc = _^ (her.focus_vob);
			if (Hlp_IsValidNPC (npc)) {
				//Inventory has to be closed !!

				//Close inventory (oCNpcContainer)
				//0x0066C1E0 public: virtual void __thiscall oCNpcInventory::Close(void) 
				const int oCNpcInventory__Close = 6734304;
				CALL__thiscall (ECX, oCNpcInventory__Close);

				//Close players inventory
				oCNPC_CloseInventory (her);

				//Transfer all items
				NPC_TransferInventory (npc, her, FALSE, TRUE, TRUE);

				//Reopen inventory
				//oCNPC_OpenDeadNpc (her);
				
				//Reopen inventory
				//oCNPC_OpenInventory (her, 0);

				//0x0066BDE0 public: void __thiscall oCNpcInventory::Open(int,int) 
				//const int oCNpcInventory__Open = 6733280;
				//CALL_IntParam (0);
				//CALL_IntParam (0);
				//CALL__thiscall (ECX, oCNpcInventory__Open);

				//crash
				//var int itemPtr; itemPtr = oCNpcInventory_GetItem (ECX, 0, 0);
				//var oCNpcContainer container; container = _^ (ECX);

				//var int itemPtr; itemPtr = List_GetS (container.inventory2_oCItemContainer_contents, container.inventory2_oCItemContainer_selectedItem + 2);

				//var oCItem itm; itm = _^ (itemPtr);
				
				//B_Msg_Add (itm.Name);

				//crash
				//oCNpcContainer_Remove (ECX, itemPtr);
			};
		};
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

//Obsluha klaves pri hracovom inventari (napravo)
func void _eventNpcInventoryHandleEvent__QuickLoot (var int dummyVariable) {
	//B_Msg_Add ("_hook_oCNpcInventory_HandleEvent");

	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//...

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void G1_QuickLoot_Init (){
	const int once = 0;

	G1_InventoryEvents_Init ();

	if (!once){
		//Chests & trade inventory containers
		ItemContainerHandleEvent_AddListener (_eventItemContainerHandleEvent__QuickLoot);

		StealContainerHandleEvent_AddListener (_eventStealContainerHandleEvent__QuickLoot);

		NpcContainerHandleEvent_AddListener (_eventNpcContainerHandleEvent__QuickLoot);

		NpcInventoryHandleEvent_AddListener (_eventNpcInventoryHandleEvent__QuickLoot);

		once = 1;
	};
};
