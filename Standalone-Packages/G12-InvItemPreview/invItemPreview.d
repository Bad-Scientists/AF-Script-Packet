/*
 *	Item inventory preview
 *	 - this feature updates global variables PC_ItemPreviewMana & PC_ItemPreviewHealth with HP/Mana values read out of item text array.
 */
var int PC_ItemPreviewMana;
var int PC_ItemPreviewHealth;

//[Internal variables]
var int PC_ItemPreviewActive;
var int PC_ItemPreviewCanUpdate;

func void _eventOpenInventory__InvItemPreview (var int dummyVariable) {
	PC_ItemPreviewActive = TRUE;
	PC_ItemPreviewCanUpdate = TRUE;
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

	var oCItemContainer itemContainer; itemContainer = _^ (npcInventoryPtr);

	if (!itemContainer.inventory2_oCItemContainer_passive) {
		PC_ItemPreviewHealth = 0;
		PC_ItemPreviewMana = 0;

		if (itemContainer.inventory2_oCItemContainer_contents) {
			if (itemContainer.inventory2_oCItemContainer_selectedItem > -1) {
				//if (List_LengthS (itemContainer.inventory2_oCItemContainer_contents) > 1) {

				//Here we don't need to get length - all we need to know is whether list is empty :)
				var zCListSort l; l = _^ (itemContainer.inventory2_oCItemContainer_contents);
				if (l.next) {
					const int lastVobPtr = 0;
					const int lastHealth = 0;
					const int lastMana = 0;

					var int vobPtr; vobPtr = List_GetS (itemContainer.inventory2_oCItemContainer_contents, itemContainer.inventory2_oCItemContainer_selectedItem + 2);

					if ((vobPtr) && (vobPtr != lastVobPtr)) {
						PC_ItemPreviewHealth = GetItemCountValue (vobPtr, NAME_Bonus_HP);
						PC_ItemPreviewMana = GetItemCountValue (vobPtr, NAME_Bonus_Mana);

						lastHealth = PC_ItemPreviewHealth;
						lastMana = PC_ItemPreviewMana;
						lastVobPtr = vobPtr;
					} else {
						PC_ItemPreviewHealth = lastHealth;
						PC_ItemPreviewMana = lastMana;
					};
				};
			};
		};
	};
};

func void _hook_oCItemContainer_Draw () {
	if (oCItemContainer_IsActive (ECX)) {
		//Update public variables only when Item preview is active
		if ((PC_ItemPreviewActive) && (PC_ItemPreviewCanUpdate)) {
			GetItemPreviewData__InvItemPreview (ECX);
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
		//const int oCItemContainer__CheckSelectedItem_G1 = 6722912;
		//0x00709660 protected: virtual void __thiscall oCItemContainer::CheckSelectedItem(void)
		//const int oCItemContainer__CheckSelectedItem_G2 = 7378528;

		//Performance heavy - seems like this function is called constantly (whenever any item is inserted into inventory, with huge inventories this is causing lags)
		//HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__CheckSelectedItem_G1, oCItemContainer__CheckSelectedItem_G2), 5, "_hook_oCItemContainer_CheckSelectedItem");

		//0x00667660 protected: virtual void __thiscall oCItemContainer::Draw(void)
		const int oCItemContainer__Draw_G1 = 6714976;
		//0x007076B0 protected: virtual void __thiscall oCItemContainer::Draw(void)
		const int oCItemContainer__Draw_G2 = 7370416;

		HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__Draw_G1, oCItemContainer__Draw_G2), 6, "_hook_oCItemContainer_Draw");

		once = 1;
	};
};
