var int oCDocumentManager_LastMapInstance;

//Remember which map was opened last time
//Called on Doc_CreateMap
func void _hook_oCDocumentManager_CreateMap () {
	//item - last used
	if (Hlp_IsValidItem (item)) {
		//One more check - is this MAP ?
		if (item.mainflag & ITEM_KAT_DOCS) && (Hlp_StrCmp (item.scemeName, "MAP")) {
			oCDocumentManager_LastMapInstance = Hlp_GetInstanceID (item);
		};
	};
};

func void _hook_oCNPC_OpenScreen_Map () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };

	var oCNPC slf; slf = _^ (ECX);

	if (NPC_IsPlayer (slf)) {
		//Is there any specific map that player should open ?
		var int mapInstanceName; mapInstanceName = GetPlayerMapInstance ();
	
		//Get item
		if (NPC_GetInvItem (slf, mapInstanceName)) {
			//t_MAP_Stand_2_S0
			AI_UseItemToState (slf, item, -1);
			AI_UseItemToState (slf, item, 0);
			return;
		};
	
		//Reopen last map
		//Get item
		if (NPC_GetInvItem (slf, oCDocumentManager_LastMapInstance)) {
			//t_MAP_Stand_2_S0
			AI_UseItemToState (slf, item, -1);
			AI_UseItemToState (slf, item, 0);
			return;
		};

		//Original behavior for ITWRWORLDMAP_ORC & ITWRWORLDMAP
		//Get map from players inventory
		//1. prio ITWRWORLDMAP_ORC
		if (NPC_HasItemInstanceName (slf, "ITWRWORLDMAP_ORC")) {
			//t_MAP_Stand_2_S0
			AI_UseItemToState (slf, item, -1);
			AI_UseItemToState (slf, item, 0);
			return;
		};

		//2. prio ITWRWORLDMAP
		if (NPC_HasItemInstanceName (slf, "ITWRWORLDMAP")) {
			//t_MAP_Stand_2_S0
			AI_UseItemToState (slf, item, -1);
			AI_UseItemToState (slf, item, 0);
			return;
		};

		//3. ... get first available map from inventory
		var int itmSlot; itmSlot = 0;
		var int count;

		count = NPC_GetInvItemBySlot (slf, INV_DOC, itmSlot);
		
		while (count);
			if (Hlp_StrCmp (item.scemeName, "MAP")) {
				//t_MAP_Stand_2_S0
				AI_UseItemToState (slf, item, -1);
				AI_UseItemToState (slf, item, 0);
				break;
			};

			itmSlot += 1;
			count = NPC_GetInvItemBySlot (slf, INV_DOC, itmSlot);
		end;
	};
};

func void G1_PlayerMap_Init () {
	const int once = 0;

	if (!once) {
		//Add hook which will recognize latest map
		HookEngine (oCDocumentManager__CreateMap, 6, "_hook_oCDocumentManager_CreateMap");

		//Replace original function
		ReplaceEngineFunc (oCNPC__OpenScreen_Map, 0, "_hook_oCNPC_OpenScreen_Map");
	};
};
