/*
 *	QuickLoot
 *	Allows you to quickly loot items from chests and dead NPCs by pressing Alt key
 */

/*
 *	oCItemContainer handle event
 *		- called when interacting with chest (when cursor is in chest inventory)
 *		- called when interacting with trading containers (traders 'offer' & players 'offer' in the middle of screen, when moving cursor up/down)
 */
func void _eventItemContainerHandleEvent__QuickLoot (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//Left/Right Alt
	if ((key == MEM_GetKey ("keySMove")) || (key == MEM_GetSecondaryKey ("keySMove"))) {

		//Is player interacting with oCMobContainer ?
		var oCNPC her; her = Hlp_GetNPC (hero);
		if (Hlp_Is_oCMobContainer (her.focus_vob)) {
			//Inventory does not have to be closed !

			//We will close it anyway - when player calls quickloot he probably wants to pick items from chest and leave

			//0x00668C10 public: virtual void __thiscall oCItemContainer::Close(void) 
			const int oCItemContainer__Close = 6720528;
			CALL__thiscall (ECX, oCItemContainer__Close);

			//Close players inventory
			oCNPC_CloseInventory (her);

			//Enable custom prints for transferred items
			_MobTransferItemPrint_Event_Enabled = TRUE;

			//Transfer all items
			Mob_TransferItemsToNPC (her.focus_vob, her);

			//Disable custom prints for transferred items
			_MobTransferItemPrint_Event_Enabled = FALSE;

			//Send mob state change (from state S1 to S0) - hero will stop interaction with mob
			if (Hlp_Is_oCMobInter (her.interactMob)) {
				oCMobInter_SendStateChange (her.interactMob, 1, 0);
			};
		};
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

/*
 *	oCStealContainer handle event
 *		- called when interacting with trading inventory (when cursor moves up/down/left/right)
 */
func void _eventStealContainerHandleEvent__QuickLoot (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//... nothing happening here atm

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

/*
 *	oCNpcContainer handle event
 *		- called when interacting with dead NPC
 */
func void _eventNpcContainerHandleEvent__QuickLoot (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//Left/Right Alt
	if (key == KEY_LMENU) || (key == KEY_RMENU) {
		var oCNPC her; her = Hlp_GetNPC (hero);

		//Is player interacting with NPC ?
		if (Hlp_Is_oCNpc (her.focus_vob)) {

			var oCNPC npc; npc = _^ (her.focus_vob);

			if (Hlp_IsValidNPC (npc)) {
				//Inventory has to be closed !! otherwise items would duplicate when NPC_TransferInventory is called

				//... that's okay, if player calls quickloot he probably wants to pick up items and leave

				//Close inventory (oCNpcContainer)
				//0x0066C1E0 public: virtual void __thiscall oCNpcInventory::Close(void) 
				const int oCNpcInventory__Close = 6734304;
				CALL__thiscall (ECX, oCNpcInventory__Close);

				//Close players inventory
				oCNPC_CloseInventory (her);

				//We have to reset focus_vob
				oCNPC_SetFocusVob (her, 0);
				
				//Enable custom prints for transferred items
				_NpcTransferItemPrint_Event_Enabled = TRUE;

				//Transfer all items
				NPC_TransferInventory (npc, her, FALSE, TRUE, TRUE);

				//Disable custom prints for transferred items
				_NpcTransferItemPrint_Event_Enabled = FALSE;
			};
		};
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

/*
 *	oCNpcInventory handle event
 *		- called when interacting with hero's inventory
 */
func void _eventNpcInventoryHandleEvent__QuickLoot (var int dummyVariable) {
	var int key; key = MEM_ReadInt (ESP + 4);
	var int cancel; cancel = FALSE;

	//... nothing happening here atm

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void G1_QuickLoot_Init (){
	//const int once = 0;

	G1_InventoryEvents_Init ();

	//if (!once) {
	//Chests & trade inventory containers
	ItemContainerHandleEvent_AddListener (_eventItemContainerHandleEvent__QuickLoot);

	//Nothing happening here atm
	//StealContainerHandleEvent_AddListener (_eventStealContainerHandleEvent__QuickLoot);

	NpcContainerHandleEvent_AddListener (_eventNpcContainerHandleEvent__QuickLoot);

	//Nothing happening here atm
	//NpcInventoryHandleEvent_AddListener (_eventNpcInventoryHandleEvent__QuickLoot);

	//once = 1;
	//};
};
