/*
 *	oCMobLockable_CheckLockValidity
 *	 - checks validity of a key instance for oCMobLockable objects
 *	 - you can call this function from Init_Global () function to validate all locks
 */
func void oCMobLockable_CheckLockValidity () {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	var string msg;

	MEM_Info ("oCMobLockable_CheckLockValidity -->");
	msg = oCWorld_GetWorldFilename ();
	msg = ConcatStrings (" - world: ", msg);
	MEM_Info (msg);

	if (!SearchVobsByClass ("oCMobLockable", vobListPtr)) {
		MEM_ArrayFree (vobListPtr);
		MEM_Info (" - no oCMobLockable objects found.");
		MEM_Info ("oCMobLockable_CheckLockValidity <--");
		return;
	};

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i; i = 0;

	var int count; count = vobList.numInArray;

	var int issueCounter; issueCounter = 0;
	var string mobPortalRoom;

	var oCMobLockable mob;

	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (Hlp_Is_oCMobLockable (vobPtr)) {
			mob = _^ (vobPtr);
			msg = "";

			var int pickLockStrValid; pickLockStrValid = TRUE;
			var int keyIsValid; keyIsValid = TRUE;

			//Check if pickLockStr is valid (only combination of L and R)
			if (STR_Len (mob.pickLockStr)) {
				var string pickLockStr; pickLockStr = mob.pickLockStr;
				pickLockStr = STR_ReplaceAll (pickLockStr, "L", "");
				pickLockStr = STR_ReplaceAll (pickLockStr, "R", "");

				pickLockStr = STR_Trim (pickLockStr, " ");

				pickLockStrValid = (STR_Len (pickLockStr) == 0);
			};

			//Check if key is valid
			if (STR_Len (mob.keyInstance)) {
				keyIsValid = MEM_FindParserSymbol (mob.keyInstance);
			};

			if ((keyIsValid == -1) || (pickLockStrValid == FALSE)) {
				issueCounter += 1;

				//Get name
				msg = ConcatStrings (" - mob: '", mob._oCMob_name);
				msg = ConcatStrings (msg, "'");

				//Get key
				msg = ConcatStrings (msg, ", key: '");
				msg = ConcatStrings (msg, mob.keyInstance);
				msg = ConcatStrings (msg, "'");

				//Get picklock combination
				msg = ConcatStrings (msg, ", pickLockStr: '");
				msg = ConcatStrings (msg, mob.pickLockStr);
				msg = ConcatStrings (msg, "'");

				//Get portal room
				mobPortalRoom = Vob_GetPortalName (vobPtr);

				msg = ConcatStrings (msg, ", portalroom: '");
				msg = ConcatStrings (msg, mobPortalRoom);
				msg = ConcatStrings (msg, "'");

				//Get position
				var int pos[3];
				if (zCVob_GetPositionWorldToPos (vobPtr, _@ (pos))) {

					var int x; x = roundF (pos[0]);
					var int y; y = roundF (pos[1]) + 250; //add just enough for player to be able to teleport to location
					var int z; z = roundF (pos[2]);

					msg = ConcatStrings (msg, ", pos: ");
					msg = ConcatStrings (msg, IntToString (x));
					msg = ConcatStrings (msg, " ");

					msg = ConcatStrings (msg, IntToString (y));
					msg = ConcatStrings (msg, " ");

					msg = ConcatStrings (msg, IntToString (z));
				};

				if (keyIsValid == -1) {
					//Key does not exits
					msg = ConcatStrings (msg, " has an invalid key - item does not exist!");
				};

				if (pickLockStrValid == FALSE) {
					//Key does not exits
					msg = ConcatStrings (msg, " has an invalid pickLockStr!");
				};

				MEM_Info (msg);
			};
		};

		i += 1;
	end;

	MEM_ArrayFree (vobListPtr);

	if (issueCounter == 0) {
		MEM_Info (" - no issues detected.");
	};

	MEM_Info ("oCMobLockable_CheckLockValidity <--");
};
