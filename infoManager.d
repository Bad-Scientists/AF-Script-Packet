/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC
 */
func int oCInfoManager_InfoInstanceCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Convert to instance ID
	slfInstance = Hlp_GetInstanceID (slf);

	var int count; count = 0;

	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);
		if (dlgInstance.npc == slfInstance) {
			count += 1;
		};

		infoPtr = list.next;
	end;
	
	return count;
};

/*
 *	Function will loop through all dialog instances and count number of dialogues which are assigned to NPC and were not yet told
 */
func int oCInfoManager_InfoInstanceUntoldCount (var int slfInstance) {
	//Convert to NPC
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Convert to instance ID
	slfInstance = Hlp_GetInstanceID (slf);

	var int count; count = 0;

	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);
		if (dlgInstance.npc == slfInstance) {
			if (dlgInstance.told == 0) {
				count += 1;
			};
		};

		infoPtr = list.next;
	end;
	
	return count;
};

