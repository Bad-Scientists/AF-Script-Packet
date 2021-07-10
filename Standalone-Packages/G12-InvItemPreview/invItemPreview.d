/*
 *	Item inventory preview
 *	 - this feature updates global variables PC_ItemPreviewMana & PC_ItemPreviewHealth with HP/Mana values read out of item text array.
 */
var int PC_ItemPreviewMana;
var int PC_ItemPreviewHealth;

//[Internal variable]
var int PC_ItemPreviewActive;
var int PC_ItemPreviewCanUpdate;

func void _eventOpenInventory__InvItemPreview (var int dummyVariable) {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNPC slf; slf = _^ (ECX);
	if (!Hlp_IsValidNPC (slf)) { return; };

	//'Activate' item preview
	if (NPC_IsPlayer (slf)) {
		PC_ItemPreviewActive = TRUE;
		PC_ItemPreviewCanUpdate = TRUE;
	};
};

func void _eventCloseInventory__InvItemPreview (var int dummyVariable) {
	//Reset values when inventory is closed
	PC_ItemPreviewHealth = 0;
	PC_ItemPreviewMana = 0;

	PC_ItemPreviewActive = FALSE;
	PC_ItemPreviewCanUpdate = TRUE;
};

func void _eventUseItemToStateStart__InvItemPreview (var int dummyVariable) {
	PC_ItemPreviewCanUpdate = FALSE;
};

func void _eventUseItemToStateUse__InvItemPreview (var int dummyVariable) {
	PC_ItemPreviewCanUpdate = TRUE;
};

//Wrapper function for 'Activate' and 'Handle Event' events
func void GetItemPreviewData__InvItemPreview (var int npcInventoryPtr) {
	if (!npcInventoryPtr) { return; };

	var oCNpcInventory npcInventory; npcInventory = _^ (npcInventoryPtr);
	
	if (Hlp_Is_oCNpc (npcInventory.inventory2_owner)) {
		var oCNPC slf; slf = _^ (npcInventory.inventory2_owner);
		if (NPC_IsPlayer (slf)) {
			PC_ItemPreviewHealth = 0;
			PC_ItemPreviewMana = 0;

			if (npcInventory.inventory2_oCItemContainer_contents) {
				if ((npcInventory.inventory2_oCItemContainer_selectedItem > -1) && List_LengthS (npcInventory.inventory2_oCItemContainer_contents) > 1) {

					var int vobPtr; vobPtr = List_GetS (npcInventory.inventory2_oCItemContainer_contents, npcInventory.inventory2_oCItemContainer_selectedItem + 2);

					if (vobPtr) {
						PC_ItemPreviewHealth = GetItemCountValue (vobPtr, NAME_Bonus_HP);
						PC_ItemPreviewMana = GetItemCountValue (vobPtr, NAME_Bonus_Mana);
					};
				};
			};
		};
	};
};

func void _hook_oCItemContainer_CheckSelectedItem () {
	//Run this piece only in players inventory
	if (Hlp_Is_oCNpcInventory (ECX)) {
		if (oCItemContainer_IsActive (ECX)) {
			//Update public variables only when Item preview is active
			if ((PC_ItemPreviewActive) && (PC_ItemPreviewCanUpdate)) {
				GetItemPreviewData__InvItemPreview (ECX);
			};
		};
	};
};

func void G12_InvItemPreview_Init () {
	G12_OpenInventoryEvent_Init ();
	G12_CloseInventoryEvent_Init ();

	OpenInventoryEvent_AddListener (_eventOpenInventory__InvItemPreview);
	CloseInventoryEvent_AddListener (_eventCloseInventory__InvItemPreview);

	/*
	 * There is a gap between item usage and actual 'consumption' when onstate[0] function is called, during this small gap we don't want to update PC_ItemPreviewHealth, PC_ItemPreviewMana values,
	 * because item is not available in inventory preview bar would temporarily disappear and reappear
	 */
	G12_InterceptNpcEventMessages_Init ();

	PlayerUseItemToStateStartEvent_AddListener (_eventUseItemToStateStart__InvItemPreview);
	PlayerUseItemToStateUseEvent_AddListener (_eventUseItemToStateUse__InvItemPreview);

	const int once = 0;
	if (!once) {
		//0x00669560 protected: virtual void __thiscall oCItemContainer::CheckSelectedItem(void)
		const int oCItemContainer__CheckSelectedItem_G1 = 6722912;
		//0x00709660 protected: virtual void __thiscall oCItemContainer::CheckSelectedItem(void)
		const int oCItemContainer__CheckSelectedItem_G2 = 7378528;
		HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__CheckSelectedItem_G1, oCItemContainer__CheckSelectedItem_G2), 5, "_hook_oCItemContainer_CheckSelectedItem");
		once = 1;
	};
};
