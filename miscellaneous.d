/*
 *	Miscellaneous functions
 *	 - these functions are very useful, but I felt they should not be in same files as other more 'generic' functions.
 */

/*
 *	Function traverses through all oCMobInter objects and updates onStateFunc, conditionFunc and useWithItem for all objects, which do have specified visual name.
 *	Usage:
 *
 *	oCMobInter_SetupAllMobsByVisual ("ORE_GROUND.ASC", "MINING", "", "ITMWPICKAXE");
 */
func void oCMobInter_SetupAllMobsByVisual (var string searchVisual, var string onStateFunc, var string conditionFunc, var string useWithItem) {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	if (!SearchVobsByClass ("oCMobInter", vobListPtr)) {
		MEM_ArrayFree (vobListPtr);
		MEM_Info ("oCMobInter_SetupAllMobsByVisual: No oCMobInter objects found.");
		return;
	};

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i; i = 0;

	var int count; count = vobList.numInArray;

	var string mobVisualName;

	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		//Get visual name
		mobVisualName = Vob_GetVisualName (vobPtr);

		if (Hlp_StrCmp (mobVisualName, searchVisual)) {
			oCMobInter_SetOnStateFuncName (vobPtr, onStateFunc);
			oCMobInter_SetConditionFunc (vobPtr, conditionFunc);
			oCMobInter_SetUseWithItem (vobPtr, useWithItem);
		};

		i += 1;
	end;

	MEM_ArrayFree (vobListPtr);
};

/*
 *	oCMobContainer_SearchByPortalRoom
 *	 - function returns first pointer to chest with searchVisual located in portal room searchPortalRoom
 */
func int oCMobContainer_SearchByPortalRoom (var string searchVisual, var string searchPortalRoom) {
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	if (!SearchVobsByClass ("oCMobContainer", vobListPtr)) {
		MEM_ArrayFree (vobListPtr);
		MEM_Info ("oCMobContainer_SearchByPortalRoom: No oCMobContainer objects found.");
		return 0;
	};

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i; i = 0;

	var int count; count = vobList.numInArray;

	var string mobVisualName;
	var string mobPortalRoom;

	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		//Get visual name
		mobVisualName = Vob_GetVisualName (vobPtr);

		if (Hlp_StrCmp (mobVisualName, searchVisual)) {
			mobPortalRoom = Vob_GetPortalName (vobPtr);

			if (Hlp_StrCmp (mobPortalRoom, searchPortalRoom)) {
				MEM_ArrayFree (vobListPtr);
				return vobPtr;
			};
		};

		i += 1;
	end;

	MEM_ArrayFree (vobListPtr);
	return 0;
};

func void test_G2A_InsertItemsToChestsInOldCampCastle () {
	var int chestPtr;

	chestPtr = oCMobContainer_SearchByPortalRoom ("CHESTBIG_OCCHESTLARGELOCKED.MDS", "KI1");

	if (chestPtr) {
		FillMobContainer (chestPtr, "ItMi_Nugget:10");
	};

	chestPtr = oCMobContainer_SearchByPortalRoom ("CHESTBIG_OCCHESTLARGE.MDS", "KI3");

	if (chestPtr) {
		FillMobContainer (chestPtr, "ItMi_Nugget:12");
	};
};

/*
 *
 *	Vob list functions
 *
 */

/*
 *	NPC_VobListDetectScemeName
 *	 - function returns pointer to *nearest* available mob with specified scemeName with specified state within specified verticalDist
 *	 - you can only search for mobs that NPC can see by using canSeeCheck == true
 *	 - vob list has to be generated prior calling this function (oCNpc_ClearVobList (self); oCNpc_CreateVobList (self, rangeF);)
 */
func int NPC_VobListDetectScemeName (var int slfInstance, var string scemeName, var int state, var int canSeeCheck, var int verticalDist) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int dist;
	var int maxDist; maxDist = mkf (999999);

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var int canSee;

	var int vobPtr;
	var int i; i = 0;

	while (i < slf.vobList_numInArray);
		vobPtr = MEM_ReadIntArray (slf.vobList_array, i);
		//if (Hlp_Is_oCMobInter (vobPtr)) {
		if (oCMobInter_IsAvailable (vobPtr, slf)) {
			if (canSeeCheck) {
				canSee = oCNPC_CanSee (slfInstance, vobPtr, 1);
			} else {
				canSee = TRUE;
			};

			if (canSee) {
				if (abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalDist) {
					var oCMobInter mob;
					mob = _^ (vobPtr);
					//if (Hlp_StrCmp (mob.sceme, scemeName)) {
					if (STR_StartsWith (oCMobInter_GetScemeName (vobPtr), scemeName)) {
						if (mob.state == state) {
							if (!firstPtr) { firstPtr = vobPtr; };

							dist = NPC_GetDistToVobPtr (slfInstance, vobPtr);
							if (lf (dist, maxDist)) {
								nearestPtr = vobPtr;
								maxDist = dist;
							};
						};
					};
				};
			};
		};
		i += 1;
	end;

	if (nearestPtr) { return nearestPtr; };

	return firstPtr;
};

/*
 *	NPC_VobListDetectVisual
 *	 - function returns pointer to *nearest* vob with specified searchVisualName within specified verticalDist
 *	 - you can only search for vobs that NPC can see by using canSeeCheck == true
 *	 - vob list has to be generated prior calling this function (oCNpc_ClearVobList (self); oCNpc_CreateVobList (self, rangeF);)
 */
func int NPC_VobListDetectVisual (var int slfInstance, var string searchVisualName, var int canSeeCheck, var int verticalDist) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int dist;
	var int maxDist; maxDist = mkf (999999);

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var string visualName;

	var int canSee;

	var int vobPtr;
	var int i; i = 0;

	while (i < slf.vobList_numInArray);
		vobPtr = MEM_ReadIntArray (slf.vobList_array, i);

		if (canSeeCheck) {
			canSee = oCNPC_CanSee (slfInstance, vobPtr, 1);
		} else {
			canSee = TRUE;
		};

		if (canSee) {
			if (abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalDist) {
				visualName = Vob_GetVisualName (vobPtr);

				if (Hlp_StrCmp (visualName, searchVisualName)) {

					if (!firstPtr) { firstPtr = vobPtr; };

					dist = NPC_GetDistToVobPtr (slfInstance, vobPtr);

					if (lf (dist, maxDist)) {
						nearestPtr = vobPtr;
						maxDist = dist;
					};
				};
			};
		};

		i += 1;
	end;

	if (nearestPtr) { return nearestPtr; };

	return firstPtr;
};

/*
 *	NPC_VobListDetectItem
 *	 - function returns pointer to *nearest* item with specified mainflag and flags within specified verticalDist
 *	 - you can only search for vobs that NPC can see by using canSeeCheck == true
 *	 - vob list has to be generated prior calling this function (oCNpc_ClearVobList (self); oCNpc_CreateVobList (self, rangeF);)
 */
func int NPC_VobListDetectItem (var int slfInstance, var int mainflag, var int flags, var int canSeeCheck, var int verticalDist) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var int dist;
	var int maxDist; maxDist = mkf (999999);

	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	var oCItem itm;

	var int canSee;

	var int vobPtr;
	var int i; i = 0;

	while (i < slf.vobList_numInArray);
		vobPtr = MEM_ReadIntArray (slf.vobList_array, i);
		if (Hlp_Is_oCItem (vobPtr)) {

			if (canSeeCheck) {
				canSee = oCNPC_CanSee (slfInstance, vobPtr, 1);
			} else {
				canSee = TRUE;
			};

			if (canSee) {
				if (abs (NPC_GetHeightToVobPtr (slf, vobPtr)) < verticalDist) {
					itm = _^ (vobPtr);
					if (Hlp_IsValidItem (itm)) {
						if (itm.mainflag == mainflag) {
							if (itm.flags & flags) {
								if (!firstPtr) { firstPtr = vobPtr; };

								dist = NPC_GetDistToVobPtr (slfInstance, vobPtr);

								if (lf (dist, maxDist)) {
									nearestPtr = vobPtr;
									maxDist = dist;
								};
							};
						};
					};
				};
			};
		};
		i += 1;
	end;

	if (nearestPtr) { return nearestPtr; };

	return firstPtr;
};
