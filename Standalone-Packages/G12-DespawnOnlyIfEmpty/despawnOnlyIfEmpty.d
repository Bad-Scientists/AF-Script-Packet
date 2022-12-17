/*
 *	Super simple feature that will prevent dead bodies from despawning.
 *	 - we are replacing engine function oCNpc::HasMissionItem (this function is called when engine tries to despawn dead bodies) with our own version that returns TRUE whenever there is anything in the inventory of NPC
 *	 - I know, G2A has this already as an option that can be turned on in .ini ... but I like to have an option to do things from scripts :)
 *
 *	Warnings:
 *	 - since we are replacing engine function oCNpc::HasMissionItem - obviously it cannot be used anymore to check whether NPC has mission items ... use NPC_HasMissionItem instead!
 *	 - do not use with spawn time set to 0 - this will cause huge lag spikes if you have a lot of dead bodies in your world!
 */

/*
 *	Simple feature preventing despawn of dead NPCs, if they have anything in their inventory
 */
func void _hook_oCNpc_HasMissionItem () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNpc slf; slf = _^ (ECX);

	if (!NPC_InventoryIsEmpty (slf, ITEM_ACTIVE_LEGO, 0, TRUE)) {
		//Inventory is not empty - pretend that NPC has mission items ... this will prevent NPC from despawning
		//Return TRUE
		EAX = 1;
		return;
	};

	//Return FALSE;
	EAX = 0;
};

func void G12_DespawnOnlyIfEmpty_Init () {
	const int once = 0;
	if (!once) {
		//0x006A4D90 public: int __thiscall oCNpc::HasMissionItem(void)
		const int oCNpc__HasMissionItem_G1 = 6966672;

		//0x00749110 public: int __thiscall oCNpc::HasMissionItem(void)
		const int oCNpc__HasMissionItem_G2 = 7639312;

		//Replace engine function with our own version
		ReplaceEngineFunc (MEMINT_SwitchG1G2 (oCNpc__HasMissionItem_G1, oCNpc__HasMissionItem_G2), 0, "_hook_oCNpc_HasMissionItem");

		once = 1;
	};
};
