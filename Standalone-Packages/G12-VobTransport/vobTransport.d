/*
 *	Requires following LeGo flags: LeGo_FrameFunctions | LeGo_View
 *
 */

/*
 *	Following objects can be deleted by this feature
 *	NPC can't be deleted (causes crashes, maybe we will add it in future)
 */
func int VobCanBeDeleted__VobTransport (var int vobPtr) {
	//API function (define your rules in API function)
	if (!VobCanBeDeleted__VobTransport_API (vobPtr)) {
		return FALSE;
	};

	if (Hlp_Is_oCMob (vobPtr))
	|| (Hlp_Is_oCMobFire (vobPtr))
	|| (Hlp_Is_oCMobLockable (vobPtr))
	|| (Hlp_Is_oCMobContainer (vobPtr))
	|| (Hlp_Is_oCMobDoor (vobPtr))
	|| (Hlp_Is_oCMobLadder (vobPtr))
	|| (Hlp_Is_oCMobSwitch (vobPtr))
	|| (Hlp_Is_oCMobWheel (vobPtr))
	|| (Hlp_Is_oCMobBed (vobPtr))
	|| (Hlp_Is_oCMobInter (vobPtr))
	|| (Hlp_Is_oCItem (vobPtr))

	|| (Hlp_Is_zCTrigger (vobPtr))
	|| (Hlp_Is_oCTriggerScript (vobPtr))

	|| (Hlp_Is_zCVobSpot (vobPtr))

	|| (Hlp_Is_zCVob__VobTransport (vobPtr)) //zCVob (supported by this feature)
	{
		return TRUE;
	};

	return FALSE;
};

/*
 *	Following objects can be selected by this feature when focused
 *	In case of 'focusable' objects we will also allow NPC movement
 */
func int FocusVobCanBeSelected__VobTransport (var int vobPtr) {
	//API function
	if (!FocusVobCanBeSelected__VobTransport_API (vobPtr)) {
		return FALSE;
	};

	if (Hlp_Is_oCMob (vobPtr))
	|| (Hlp_Is_oCMobFire (vobPtr))
	|| (Hlp_Is_oCMobLockable (vobPtr))
	|| (Hlp_Is_oCMobContainer (vobPtr))
	|| (Hlp_Is_oCMobDoor (vobPtr))
	|| (Hlp_Is_oCMobLadder (vobPtr))
	|| (Hlp_Is_oCMobSwitch (vobPtr))
	|| (Hlp_Is_oCMobWheel (vobPtr))
	|| (Hlp_Is_oCMobBed (vobPtr))
	|| (Hlp_Is_oCMobInter (vobPtr))
	|| (Hlp_Is_oCItem (vobPtr))

	|| (Hlp_Is_oCNpc (vobPtr))
	{
		return TRUE;
	};

	return FALSE;
};

/*
 *	Following objects can be selected by this feature
 *	NPC can't be selected (unless in focus)
 */
func int VobCanBeSelected__VobTransport (var int vobPtr) {
	//API function
	if (!VobCanBeSelected__VobTransport_API (vobPtr)) {
		return FALSE;
	};

	if (Hlp_Is_oCMob (vobPtr))
	|| (Hlp_Is_oCMobFire (vobPtr))
	|| (Hlp_Is_oCMobLockable (vobPtr))
	|| (Hlp_Is_oCMobContainer (vobPtr))
	|| (Hlp_Is_oCMobDoor (vobPtr))
	|| (Hlp_Is_oCMobLadder (vobPtr))
	|| (Hlp_Is_oCMobSwitch (vobPtr))
	|| (Hlp_Is_oCMobWheel (vobPtr))
	|| (Hlp_Is_oCMobBed (vobPtr))
	|| (Hlp_Is_oCMobInter (vobPtr))
	|| (Hlp_Is_oCItem (vobPtr))

	|| (Hlp_Is_zCTrigger (vobPtr))
	|| (Hlp_Is_oCTriggerScript (vobPtr))

	|| (Hlp_Is_zCVobSpot (vobPtr))

	|| (Hlp_Is_zCVob__VobTransport (vobPtr)) //zCVob

	{
		return TRUE;
	};

	return FALSE;
};

/*
 *	Following objects can be moved around
 */
func int VobCanBeMovedAround__VobTransport (var int vobPtr) {
	//API function
	if (!VobCanBeMovedAround__VobTransport_API (vobPtr)) {
		return FALSE;
	};

	if (Hlp_Is_oCMob (vobPtr))
	|| (Hlp_Is_oCMobFire (vobPtr))
	|| (Hlp_Is_oCMobLockable (vobPtr))
	|| (Hlp_Is_oCMobContainer (vobPtr))
	|| (Hlp_Is_oCMobDoor (vobPtr))
	|| (Hlp_Is_oCMobLadder (vobPtr))
	|| (Hlp_Is_oCMobSwitch (vobPtr))
	|| (Hlp_Is_oCMobWheel (vobPtr))
	|| (Hlp_Is_oCMobBed (vobPtr))
	|| (Hlp_Is_oCMobInter (vobPtr))
	|| (Hlp_Is_oCItem (vobPtr))

	|| (Hlp_Is_oCNpc (vobPtr))

	|| (Hlp_Is_zCTrigger (vobPtr))
	|| (Hlp_Is_oCTriggerScript (vobPtr))

	|| (Hlp_Is_zCVobSpot (vobPtr))

	|| (Hlp_Is_zCVob__VobTransport (vobPtr)) //zCVob
	{
		return TRUE;
	};

	return FALSE;
};

/*
 *	No extra rules here atm - only restricted by API function
 */
func int VobCanBeCloned__VobTransport (var int vobPtr) {
	//API fuction
	if (VobCanBeCloned__VobTransport_API (vobPtr)) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	No extra rules here atm - only restricted by API function
 */
 func int VobCanBePlaced__VobTransport (var int vobPtr) {
	//API function
	if (VobCanBePlaced__VobTransport_API (vobPtr)) {
		return TRUE;
	};

	return FALSE;
};

//---

func int Npc_GetFP (var int slfInstance, var string freepointName, var int distF, var int posPtr) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	oCNpc_ClearVobList (slf);
	oCNpc_CreateVobList (slf, distF);

	var int vobPtr;

	var int i; i = 0;
	var int loop;

	var int maxDist; maxDist = mkf (999999);
	var int dist;
	var int firstPtr; firstPtr = 0;
	var int nearestPtr; nearestPtr = 0;

	loop = slf.vobList_numInArray;

	while (i < loop);
		vobPtr = MEM_ReadIntArray (slf.vobList_array, i);
		if (Hlp_Is_zCVobSpot (vobPtr)) {
			var zCVob vobSpot; vobSpot = _^ (vobPtr);
			if (STR_StartsWith (vobSpot._zCObject_objectName, freepointName)) {
				if (!firstPtr) { firstPtr = vobPtr; };

				if (posPtr) {
					var int pos[3];
					MEM_CopyBytes (posPtr, _@ (pos), 12);

					dist = TRF_GetDistXYZ (pos[0], pos[1], pos[2], vobSpot.trafoObjToWorld[03], vobSpot.trafoObjToWorld[07], vobSpot.trafoObjToWorld[11]);
				} else {
					dist = NPC_GetDistToVobPtr (slfInstance, vobPtr);
				};

				if (lf (dist, maxDist)) {
					nearestPtr = vobPtr;
					maxDist = dist;
				};
			};
		};
		i += 1;
	end;

	if (nearestPtr) {
		return nearestPtr;
	};

	return firstPtr;
};

/*
 *	Function MoveVobInFront - created by Lehona
 *	Several modifications done:
 *	 - functions saves/restores BBox
 *	 - functions tries to align objects at free points starting with name FP_SLOT
 *	 - object is offset by additional half of a diameter from player
 */
func void MoveVobInFront__VobTransport (var int slfInstance, var int vobPtr, var int delta) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!vobPtr) { return; };

	var zCVob vob; vob = _^ (vobPtr);

	//Save BBox
	var zTBBox3D bbox; bbox = _^ (zCVob_GetBBox3DLocal (vobPtr));

	//--> Offset position based on how huge the object is
	var int minsXZ[3]; MEM_CopyBytes (_@ (bbox.mins), _@ (minsXZ), 12);
	var int maxsXZ[3]; MEM_CopyBytes (_@ (bbox.maxs), _@ (maxsXZ), 12);

	//we don't care about Y coordinates
	minsXZ[1] = FLOATNULL;
	maxsXZ[1] = FLOATNULL;

	var int sizeXZ[3]; SubVectors (_@ (sizeXZ), _@ (minsXZ), _@ (maxsXZ));
	var int diameter; diameter = zVEC3_LengthApprox (_@ (sizeXZ));
	delta = addF (delta, divf (diameter, mkf (2)));
	//<--

	//Move vob to NPC X Y Z coordinates
	vob.trafoObjToWorld [03] = slf._zCVob_trafoObjToWorld [03];
	vob.trafoObjToWorld [07] = slf._zCVob_trafoObjToWorld [07];
	vob.trafoObjToWorld [11] = slf._zCVob_trafoObjToWorld [11];

	//Adjust 'elevation'
	vob.trafoObjToWorld [07] = addf (vob.trafoObjToWorld [07], mkf (vobTransportElevationLevel));

	zCVob_Move (vobPtr, mulf (slf._zCVob_trafoObjToWorld[10], delta), mulf (slf._zCVob_trafoObjToWorld[6], delta), mulf (slf._zCVob_trafoObjToWorld[2], delta));

	//Vob-spot-slotting
	if (vobTransportMode == vobTransportMode_Movement) {
		var int pos[3]; TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));
		var int vobSpotPtr; vobSpotPtr = Npc_GetFP (slf, "FP_SLOT", mkf (vobTransportCollectVobSlotRange), _@ (pos));
		if (vobSpotPtr) {
			if (lef (zCVob_GetDistanceToVob (vobPtr, vobSpotPtr), mkf (vobTransportAlignVobSlotRange))) {
				var zCVob vobSpot; vobSpot = _^ (vobSpotPtr);

				// Update position
				AlignVobAt (vobPtr, _@ (vobSpot.trafoObjToWorld));
			};
		};
	};

	//Restore BBox
	zCVob_SetBBox3DLocal (vobPtr, _@ (bbox));
	vobTransportBBoxPtr = zCVob_GetBBox3DWorld (vobPtr);
};

func void Vob_CancelSelection (var int vobPtr) {
	if (!vobPtr) { return; };

	//Remove bbox
	zCVob_SetDrawBBox3D (vobPtr, 0);
	vobTransportBBoxPtr = 0;

	//Reset alpha
	if (vobTransportOriginalAlphaChanged) {
		var zCVob vob; vob = _^ (vobPtr);
		vob.visualAlpha = vobTransportOriginalAlpha;
		if (!vobTransportOriginalAlphaEnabled) {
			vob.bitfield[0] = (vob.bitfield[0] & ~ zCVob_bitfield0_visualAlphaEnabled);
		};

		vobTransportOriginalAlphaChanged = FALSE;
	};

	//Restore collisions
	Vob_RestoreCollBits (vobTransportVobPtr, vobTransportOriginalCollisions);
};

func int Ativate__VobTransport () {
	//Can we activate Vob transport ?
	if (VobTransportCanBeActivated__VobTransport_API ()) {
		//Init default values
		vobTransportMode = vobTransportMode_Init;
		vobTransportActionMode = vobTransportActionMode_Clone;

		//Default speed 1 if it was 0 previously
		if (!vobTransportMovementSpeed) { vobTransportMovementSpeed = 1; };
		return TRUE;
	};

	return FALSE;
};

func int BuyingHandleKey__VobTransport (var int key) {
	//Change voblist category
	if ((key == -1) || (key == KEY_UPARROW) || (key == KEY_DOWNARROW)) {
		BuildBuyVobList__VobTransport (key);
	};

	if (key == KEY_LEFTARROW) {
		vobTransportShowcaseVobIndex -= 1;
	};

	if (key == KEY_RIGHTARROW) {
		vobTransportShowcaseVobIndex += 1;
	};

	//Do we have anything in vobList_array ?
	var oCNpc her; her = Hlp_GetNPC (hero);
	if ((her.vobList_numInArray > 0) && (her.vobList_array)) {

		//Safety check for boundaries
		if ((key == -1) || (key == KEY_UPARROW) || (key == KEY_DOWNARROW)) {
			if (vobTransportShowcaseVobIndex < 0) { vobTransportShowcaseVobIndex = 0; };
			if (vobTransportShowcaseVobIndex >= her.vobList_numInArray) { vobTransportShowcaseVobIndex = her.vobList_numInArray - 1; };
		} else {
			if (vobTransportShowcaseVobIndex < 0) { vobTransportShowcaseVobIndex = her.vobList_numInArray - 1; };
			if (vobTransportShowcaseVobIndex >= her.vobList_numInArray) { vobTransportShowcaseVobIndex = 0; };
		};

		//
		var int vobPtr; vobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);

		if (VobCanBeBought__VobTransport_API (vobPtr)) {
			var zCVob vob; vob = _^ (vobPtr);
			var string objectName; objectName = vob._zCObject_objectName;
			var string visualName; visualName = Vob_GetVisualName (vobPtr);

			//Create new object - for showcase
			if (!vobTransportShowcaseVobPtr) {
				//Create new vob
				vobTransportShowcaseVobPtr = InsertObject ("zCVob", objectName, visualName, _@ (vob.trafoObjToWorld), 0);
			} else {
				//Update visual and objectName
				zCVob_SetVisual (vobTransportShowcaseVobPtr, visualName);
				vob = _^ (vobTransportShowcaseVobPtr);
				vob._zCObject_objectName = objectName;
			};

			var int vobRemoveCollisions; vobRemoveCollisions = Vob_GetCollBits (vobTransportShowcaseVobPtr);
			Vob_RemoveCollBits (vobTransportShowcaseVobPtr, vobRemoveCollisions);

			vobTransportVobChanged = TRUE;
		} else {
			PrintS (vobTransportPrint_BuyVobNothingToBuy);
		};
	};

	//These keys are handled
	if ((key == -1) || (key == KEY_UPARROW) || (key == KEY_DOWNARROW) || (key == KEY_LEFTARROW) || (key == KEY_RIGHTARROW)) {
		return TRUE;
	};

	return FALSE;
};

func int ActivateBuying__VobTransport () {
	//Can we activate Vob transport ?
	if (VobTransportCanBeActivated__VobTransport_API ()) {

		//Init categories (key == -1)
		var int retVal; retVal = BuyingHandleKey__VobTransport (-1);

		//Add frame function that will rotate showcased vob
		FF_ApplyOnceExtGT (FrameFunction_RotateShowcasedVob__VobTransport, 16, -1);

		//Put player in sleeping mode
		PC_PutInSleepingMode ();
		PrintS (vobTransportPrint_BuyVobActivated);

		vobTransportMode = vobTransportMode_BuyVob;

		//Default speed 1 if it was 0 previously
		if (!vobTransportMovementSpeed) { vobTransportMovementSpeed = 1; };
		return TRUE;
	};

	return FALSE;
};

func void BuyingDisposeShowcaseVob__VobTransport () {
	if (vobTransportShowcaseVobPtr) {
		Vob_CancelSelection (vobTransportShowcaseVobPtr);

		oCNpc_SetFocusVob (hero, 0);
		oCNpc_ClearVobList (hero);

		RemoveoCVobSafe (vobTransportShowcaseVobPtr, 1);
		vobTransportShowcaseVobPtr = 0;
	};
};

func void CancelBuying__VobTransport () {
	BuyingDisposeShowcaseVob__VobTransport ();

	vobTransportMode = vobTransportMode_Idle;
	PC_RemoveFromSleepingMode ();
};

func void BuyingConfirmSelection__VobTransport () {
	//Set to null
	vobTransportVobPtr = 0;

	var oCNpc her; her = Hlp_GetNPC (hero);
	if ((her.vobList_numInArray > 0) && (her.vobList_array)) {
		if ((vobTransportShowcaseVobIndex >= 0) && (vobTransportShowcaseVobIndex < her.vobList_numInArray)) {
			vobTransportVobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);
		};
	};

	BuyingDisposeShowcaseVob__VobTransport ();

	vobTransportActionMode = vobTransportActionMode_Clone;
	vobTransportMode = vobTransportMode_SelectConfirm;
};

func void DoDeleteObject__VobTransport () {
	zCVob_SetDrawBBox3D (vobTransportVobPtr, 0);

	oCNpc_SetFocusVob (hero, 0);
	oCNpc_ClearVobList (hero);

	RemoveoCVobSafe (vobTransportVobPtr, 1);
	vobTransportVobPtr = 0;
};

func void DeleteObject__VobTransport () {
	if (VobCanBeDeleted__VobTransport (vobTransportVobPtr)) {
		var int doDelete; doDelete = TRUE;

		//-->
		//First KEY_DELETE deletes contents (oCMobContainer)
		if (Hlp_Is_oCMobContainer (vobTransportVobPtr)) {
			if (!Mob_IsEmpty (vobTransportVobPtr)) {
				Mob_RemoveAllItems (vobTransportVobPtr);
				doDelete = FALSE;
				PrintS (vobTransportPrint_ContainerContentsDeleted);
			};
		};
		//<--

		if (doDelete) {
			DoDeleteObject__VobTransport ();
			vobTransportMode = vobTransportMode_Init;
		};
	};
};

func void ApplyPhysicsOnItem__VobTransport () {
	//Drop item (apply physics)
	if (Hlp_Is_oCItem (vobTransportVobPtr)) {
		if (VobCanBePlaced__VobTransport (vobTransportVobPtr)) {
			vobTransportActionMode = vobTransportActionMode_DropItem;
			vobTransportMode = vobTransportMode_Done;
		};
	};
};

//Update keys
func int IdentifyKey__VobTransport (var int key) {
	var int ctrlPressed; ctrlPressed = MEM_KeyState (KEY_LCONTROL);
	ctrlPressed = ((ctrlPressed == KEY_PRESSED) || (ctrlPressed == KEY_HOLD));

//--- Keyboard

	//Key left
	if ((key == MEM_GetKey ("keyLeft")) || (key == MEM_GetSecondaryKey ("keyLeft")) || (key == MEM_GetKey ("keyStrafeLeft")) || (key == MEM_GetSecondaryKey ("keyStrafeLeft"))) {
		key = KEY_LEFTARROW;
	};

	//Key right
	if ((key == MEM_GetKey ("keyRight")) || (key == MEM_GetSecondaryKey ("keyRight")) || (key == MEM_GetKey ("keyStrafeRight")) || (key == MEM_GetSecondaryKey ("keyStrafeRight"))) {
		key = KEY_RIGHTARROW;
	};

	//Key up
	if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp"))) {
		key = KEY_UPARROW;
	};

	//Key down
	if ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown"))) {
		key = KEY_DOWNARROW;
	};

	//NumPad enter
	if (key == KEY_NUMPADENTER) {
		key = KEY_RETURN;
	};

//--- Mouse

	//Left / Up
	if (key == MOUSE_WHEEL_UP) {
		if (ctrlPressed) {
			key = KEY_UPARROW;
		} else {
			key = KEY_LEFTARROW;
		};
	};

	//Right / Down
	if (key == MOUSE_WHEEL_DOWN) {
		if (ctrlPressed) {
			key = KEY_DOWNARROW;
		} else {
			key = KEY_RIGHTARROW;
		};
	};

	return +key;
};

func void _eventGameHandleEvent__VobTransport (var int dummyVariable) {
	var int cancel; cancel = FALSE;
	var int input; input = MEM_ReadInt (ESP + 4);

	if (!input) { return; };

	//Safety-check
	if (!Hlp_IsValidNPC (hero)) { return; };

	var int key; key = IdentifyKey__VobTransport (input);

	var zCVob vob;

	var int ctrlPressed; ctrlPressed = MEM_KeyState (KEY_LCONTROL);
	ctrlPressed = ((ctrlPressed == KEY_PRESSED) || (ctrlPressed == KEY_HOLD));

	var int shiftPressed; shiftPressed = MEM_KeyState (KEY_LSHIFT);
	shiftPressed = ((shiftPressed == KEY_PRESSED) || (shiftPressed == KEY_HOLD));

	vobTransportVobChanged = FALSE;

//--- Idle - waiting for player's input!

	if (vobTransportMode == vobTransportMode_Idle) {
		//--- Activate vob Transport mode
		if (key == KEY_C) {
			cancel = Ativate__VobTransport ();
		} else

		//--- Activate buying
		if (key == KEY_V) {
			cancel = ActivateBuying__VobTransport ();
		};
	};

//--- Selection mode

	if ((vobTransportMode == vobTransportMode_SelectVob) && (!cancel)) {
		//Apply physics / Print to zSpy
		if (key == KEY_P) {
			//Print to zSpy details relevant for object creation (via InsertAnything!)
			if (ctrlPressed) {
				PrintCodeTozSpy__VobTransport (vobTransportVobPtr);
			} else {
				ApplyPhysicsOnItem__VobTransport ();
			};
		};

		//Confirm selection - enter
		if ((key == KEY_RETURN) || (key == KEY_C)) {
			//Clone object - Left Ctrl + Enter
			if (ctrlPressed) {
				vobTransportMode = vobTransportMode_SelectConfirm;
				vobTransportActionMode = vobTransportActionMode_Clone;
			} else
			//Transform object - Left shift + Enter
			if (shiftPressed) {
				//Default - initial rotation of Y axis
				vobTransportTransformationMode = vobTransportTransformation_RotY;
				lastVobTransportMode = vobTransportMode;
				vobTransportMode = vobTransportMode_Transform;

				vob = _^ (vobTransportVobPtr);
				MEM_CopyBytes (_@ (vob.trafoObjToWorld), _@ (vobTransportOriginalTrafo), 64);

				if (!vobTransportOriginalAlphaChanged) {
					vobTransportOriginalAlphaEnabled = ((vob.bitfield[0] & zCVob_bitfield0_visualAlphaEnabled) == zCVob_bitfield0_visualAlphaEnabled);
					vobTransportOriginalAlpha = vob.visualAlpha;
				};

				//Backup collision bitfields
				vobTransportOriginalCollisions = Vob_GetCollBits (vobTransportVobPtr);

				//Remove active collisions
				Vob_RemoveCollBits (vobTransportVobPtr, vobTransportOriginalCollisions);

				if (!vobTransportOriginalAlphaChanged) {
					//Don't adjust alpha for zCDecal - they are already difficult to spot :)
					if (!Hlp_VobVisual_Is_zCDecal (vobTransportVobPtr)) {
						//Update alpha
						vob.bitfield[0] = vob.bitfield[0] | zCVob_bitfield0_visualAlphaEnabled;
						vob.visualAlpha = divf (mkf (vobTransportAlpha), mkf (100));
					};

					vobTransportOriginalAlphaChanged = TRUE;
				};
			} else {
			//Confirm selection - move object
				vobTransportMode = vobTransportMode_SelectConfirm;
				vobTransportActionMode = vobTransportActionMode_Move;
			};
		};

		//Select previous vob
		if (key == KEY_LEFTARROW) {
			vobTransportMode = vobTransportMode_SelectPrev;
		};

		//Select next vob
		if (key == KEY_RIGHTARROW) {
			vobTransportMode = vobTransportMode_SelectNext;
		};

		//Delete object
		if (key == KEY_DELETE) {
			DeleteObject__VobTransport ();
		};

		//Cancel selection
		if (key == KEY_ESCAPE) {
			Vob_CancelSelection (vobTransportVobPtr);

			PC_RemoveFromSleepingMode ();
			vobTransportMode = vobTransportMode_Idle;
		};

		//'Handle' key
		if ((key == KEY_P) || (key == KEY_RETURN) || (key == KEY_C) || (key == KEY_LEFTARROW) || (key == KEY_RIGHTARROW) || (key == KEY_DELETE) || (key == KEY_ESCAPE)) {
			cancel = TRUE;
		};
	};

//--- Movement mode

	if ((vobTransportMode == vobTransportMode_Movement) && (!cancel)) {
		//Toggle alignment to surface
		if (key == KEY_V) {
			vobTransportAlignToFloor = !vobTransportAlignToFloor;
		};

		//Apply physics
		if (key == KEY_P) {
			ApplyPhysicsOnItem__VobTransport ();
		};

		//Delete object
		if (key == KEY_DELETE) {
			//Any object can be deleted while moving (if we allowed selection)
			DoDeleteObject__VobTransport ();
			vobTransportMode = vobTransportMode_Done;
		};

		//Escape - cancel
		if (key == KEY_ESCAPE) {
			//Cloning mode - cancel >> delete object
			if (vobTransportActionMode == vobTransportActionMode_Clone) {

				Vob_CancelSelection (vobTransportVobPtr);

				oCNpc_SetFocusVob (hero, 0);
				oCNpc_ClearVobList (hero);

				RemoveoCVobSafe (vobTransportVobPtr, 1);
				vobTransportVobPtr = 0;

				vobTransportMode = vobTransportMode_Done;
			};

			//Moving mode - cancel >> reset to original position
			if (vobTransportActionMode == vobTransportActionMode_Move) {
				if (vobTransportVobPtr) {
					AlignVobAt (vobTransportVobPtr, _@ (vobTransportOriginalTrafo));
					Vob_CancelSelection (vobTransportVobPtr);
				};

				vobTransportMode = vobTransportMode_Done;
			};
		};

		//--- Enter - switch to Transformation mode (where you can adjust rotation & elevation)
		if ((key == KEY_RETURN) || (key == KEY_C)) {
			if (shiftPressed) {
				//Default - initial rotation of Y axis
				vobTransportTransformationMode = vobTransportTransformation_RotY;
				lastVobTransportMode = vobTransportMode;
				vobTransportMode = vobTransportMode_Transform;
				PC_PutInSleepingMode ();
			} else {
				if (VobCanBePlaced__VobTransport_API (vobTransportVobPtr)) {
					vobTransportMode = vobTransportMode_Done;
					PC_RemoveFromSleepingMode ();
				};
			};
		};

		//'Handle' key
		if ((key == KEY_V) || (key == KEY_P) || (key == KEY_DELETE) || (key == KEY_ESCAPE) || (key == KEY_RETURN) || (key == KEY_C)){
			cancel = TRUE;
		};
	};

//--- Transform

	if ((vobTransportMode == vobTransportMode_Transform) && (!cancel)) {
		if ((key == KEY_RETURN) || (key == KEY_C)) {
			if (VobCanBePlaced__VobTransport_API (vobTransportVobPtr)) {
				vobTransportMode = vobTransportMode_Done;
				PC_RemoveFromSleepingMode ();
			};
		};

		if (key == KEY_ESCAPE) {
			//Switch back to movement mode
			if (lastVobTransportMode == vobTransportMode_Movement) {
				PC_RemoveFromSleepingMode ();
				vobTransportMode = vobTransportMode_Movement;
			} else
			//Switch back to selection mode
			if (lastVobTransportMode == vobTransportMode_SelectVob) {
				vobTransportMode = vobTransportMode_SelectVob;

				//Restore trafo and alpha
				if (vobTransportVobPtr) {
					AlignVobAt (vobTransportVobPtr, _@ (vobTransportOriginalTrafo));
					Vob_RestoreCollBits (vobTransportVobPtr, vobTransportOriginalCollisions);
				};
			};
		};

		//Reset rotation
		var int rotation; rotation = 0;

		//--- Adjust movement speed - key Space

		//Movement speed 1 > 10 > 20 > 50 > 100
		if (key == KEY_SPACE) {
			if (vobTransportMovementSpeed == 1) { vobTransportMovementSpeed = 10; } else
			if (vobTransportMovementSpeed == 10) { vobTransportMovementSpeed = 20; } else
			if (vobTransportMovementSpeed == 20) { vobTransportMovementSpeed = 50; } else
			if (vobTransportMovementSpeed == 50) { vobTransportMovementSpeed = 100; } else
			{ vobTransportMovementSpeed = 1; };
		};

		//--- change to X axis rotation
		if (key == KEY_X) {
			vobTransportTransformationMode = vobTransportTransformation_RotX;
		};

		//--- change to Y axis rotation
		if (key == KEY_Y) {
			vobTransportTransformationMode = vobTransportTransformation_RotY;
		};

		//--- change to Z axis rotation
		if (key == KEY_Z) {
			vobTransportTransformationMode = vobTransportTransformation_RotZ;
		};

		//--- Rotate
		if (key == KEY_LEFTARROW) {
			rotation = -vobTransportMovementSpeed;
		};

		if (key == KEY_RIGHTARROW) {
			rotation = vobTransportMovementSpeed;
		};

		//--- Adjust elevation - Y position
		if (key == KEY_UPARROW) {
			vobTransportElevationLevel += vobTransportMovementSpeed;
		};

		if (key == KEY_DOWNARROW) {
			vobTransportElevationLevel -= vobTransportMovementSpeed;
		};

		if (rotation) {
			//Safety checks for rotation (probably not required :))
			if (rotation < 0) { rotation = 360 - (0 - rotation); };
			if (rotation > 360) { rotation = rotation - 360; };

			//Rotate
			if (vobTransportTransformationMode == vobTransportTransformation_RotX) {
				zCVob_RotateLocalX (vobTransportVobPtr, mkf (rotation));
			} else
			if (vobTransportTransformationMode == vobTransportTransformation_RotY) {
				zCVob_RotateLocalY (vobTransportVobPtr, mkf (rotation));
			} else
			if (vobTransportTransformationMode == vobTransportTransformation_RotZ) {
				zCVob_RotateLocalZ (vobTransportVobPtr, mkf (rotation));
			};
		};

		//When player is moving object elevation is being adjusted automatically, here we have to move object 'manually'
		if (vobTransportElevationLevel) {
			zCVob_Move (vobTransportVobPtr, FLOATNULL, mkf (vobTransportElevationLevel), FLOATNULL);
			vobTransportElevationLevel = 0;
		};

		//'Handle' key
		if ((key == KEY_SPACE) || (key == KEY_X) || (key == KEY_Y) || (key == KEY_Z) || (key == KEY_LEFTARROW) || (key == KEY_RIGHTARROW) || (key == KEY_UPARROW) || (key == KEY_DOWNARROW) || (key == KEY_RETURN) || (key == KEY_C) || (key == KEY_ESCAPE)) {
			cancel = TRUE;
		};
	};

//--- Buy objects

	if ((vobTransportMode == vobTransportMode_BuyVob) && (!cancel)) {
		//Cancel - escape
		if (key == KEY_ESCAPE) {
			CancelBuying__VobTransport ();
		};

		//Change selection - up, down (change categories) left right (change items)
		if ((key == KEY_LEFTARROW) || (key == KEY_RIGHTARROW) || (key == KEY_UPARROW) || (key == KEY_DOWNARROW)) {
			cancel = BuyingHandleKey__VobTransport (key);
		};

		//--- Confirm selection - enter

		if ((key == KEY_RETURN) || (key == KEY_C) || (key == KEY_V)) {
			BuyingConfirmSelection__VobTransport ();
		};

		if ((vobTransportVobChanged) && (vobTransportShowcaseVobPtr)) {
			//Call API function to get update on all texts for propertiesView.d
			var int retVal; retVal = VobCanBeBought__VobTransport_API (vobTransportShowcaseVobPtr);
		};

		//'Handle' key
		if ((key == KEY_ESCAPE) || (key == KEY_RETURN) || (key == KEY_C) || (key == KEY_V)) {
			cancel = TRUE;
		};
	};

	if (vobTransportMode != vobTransportMode_Idle) {
		if ((key == KEY_LCONTROL) || (key == KEY_LSHIFT)) {
			cancel = TRUE;
		};
	};

	if (cancel) {
		//EDI has to be also nulled
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void FrameFunction_RotateShowcasedVob__VobTransport () {
	//Remove frame function if not required anymore
	if (vobTransportMode != vobTransportMode_BuyVob) {
		FF_Remove (FrameFunction_RotateShowcasedVob__VobTransport);
	} else {
		//Rotate on Y axis
		if (vobTransportShowcaseVobPtr) {
			zCVob_RotateLocalY (vobTransportShowcaseVobPtr, mkf (1));
		};
	};
};

func void FrameFunction__VobTransport () {
	var int i;
	var int loop;

	var int vobPtr;
	var int vobPtrBackup;

	var oCNPC her;

	var zCVob vob;

	//Safety-check
	if (!Hlp_IsValidNPC (hero)) { return; };

	/*	Identification of object which should be moved around
			prio 1:	item in right hand
			prio 2:	focus_vob
			prio 3: last vobPtr (vobPtrBackup)
			prio 4: anything in view
			prio 5: everything else
	*/

	if (vobTransportMode == vobTransportMode_Init) {
		her = Hlp_GetNPC (hero);

		//Reset
		vobPtrBackup = vobTransportVobPtr;

		vobTransportVobPtr = 0;
		vobTransportElevationLevel = 0;

		//Is there anything in the hand?
		vobPtr = oCNpc_GetSlotItem (hero, "ZS_RIGHTHAND");
		if (vobPtr) {
			//Move around following objects
			if (FocusVobCanBeSelected__VobTransport (vobPtr)) {
				//Get pointer of item in hand
				vobTransportVobPtr = vobPtr;

				//Change vobTransportMode
				vobTransportMode = vobTransportMode_SelectVob;
			};
		};

		//Is there anything in hero's focus ?
		if ((!vobTransportVobPtr) && (her.focus_vob)) {
			//Move around following objects
			if (FocusVobCanBeSelected__VobTransport (her.focus_vob)) {
				//Get pointer of focus_vob
				vobTransportVobPtr = her.focus_vob;

				//Change vobTransportMode
				vobTransportMode = vobTransportMode_SelectVob;
			};
		};

		//Detect all nearby objects
		oCNpc_ClearVobList (hero);
		oCNpc_CreateVobList (hero, mkf (vobTransportCollectVobsRange));

		//If there was nothing in focus - find an object
		if ((!vobTransportVobPtr) && (her.vobList_array)) {

			i = 0;
			loop = her.vobList_numInArray;

			//last selected
			while (i < loop);
				vobPtr = MEM_ReadIntArray (her.vobList_array, i);

				if (VobCanBeSelected__VobTransport (vobPtr)) {
					if (vobPtr == vobPtrBackup) {
						//Get pointer of moved object & change vobTransportMode
						vobTransportVobPtr = vobPtr;
						vobTransportMode = vobTransportMode_SelectVob;
						break;
					};
				};

				i += 1;
			end;

			//anything in view
			i = 0;
			if (vobTransportMode == vobTransportMode_Init) {
				while (i < loop);
					vobPtr = MEM_ReadIntArray (her.vobList_array, i);

					if (VobCanBeSelected__VobTransport (vobPtr)) {
						//Is this vob in front of player - can player see it?
						//if (NPC_CanSeeVob (hero, vobPtr)) {
						if (oCNPC_CanSee (hero, vobPtr, 1)) {
							//Get pointer of moved object & change vobTransportMode
							vobTransportVobPtr = vobPtr;
							vobTransportMode = vobTransportMode_SelectVob;
							break;
						};
					};

					i += 1;
				end;
			};

			//... if nothing was found - search again for anything
			i = 0;
			if (vobTransportMode == vobTransportMode_Init) {
				while (i < loop);
					vobPtr = MEM_ReadIntArray (her.vobList_array, i);

					if (VobCanBeSelected__VobTransport (vobPtr)) {
						//Get pointer of moved object & change vobTransportMode
						vobTransportVobPtr = vobPtr;
						vobTransportMode = vobTransportMode_SelectVob;
						break;
					};

					i += 1;
				end;
			};
		};

		//If vobTransportMode was not changed ... then there was no object detected - disable vobTransportMode
		if (vobTransportMode == vobTransportMode_Init) {
			PrintS (vobTransportPrint_NoObjectsDetected);
			vobTransportMode = vobTransportMode_Done;
		} else {
			if (vobTransportVobPtr) {
				//Select mode - draw BBox and lock hero
				zCVob_SetDrawBBox3D (vobTransportVobPtr, 1);
				vobTransportOriginalCollisions = Vob_GetCollBits (vobTransportVobPtr);

				PC_PutInSleepingMode ();

				NPC_ClearAIQueue (hero);
				AI_TurnToVobPtr (hero, vobTransportVobPtr);
			};
		};
	};

	if (vobTransportMode == vobTransportMode_SelectNext) {
		//loop through vob list - select next in the list
		var int flagSelectNext; flagSelectNext = FALSE;

		her = Hlp_GetNPC (hero);
		if (her.vobList_array) {
			i = 0;
			loop = her.vobList_numInArray;

			while (i < loop);
				vobPtr = MEM_ReadIntArray (her.vobList_array, i);

				if (VobCanBeSelected__VobTransport (vobPtr)) {
					if (flagSelectNext == FALSE) {
						if (vobTransportVobPtr == vobPtr) {
							flagSelectNext = TRUE;
						};
					} else {
						//Remove BBox from last vobPtr
						Vob_CancelSelection (vobTransportVobPtr);

						//Get pointer of moved object
						vobTransportVobPtr = vobPtr;

						//Add BBox to next vobPtr
						zCVob_SetDrawBBox3D (vobTransportVobPtr, 1);
						vobTransportOriginalCollisions = Vob_GetCollBits (vobTransportVobPtr);

						NPC_ClearAIQueue (hero);
						AI_TurnToVobPtr (hero, vobTransportVobPtr);

						//Change vobTransportMode
						vobTransportMode = vobTransportMode_SelectVob;
						break;
					};
				};

				i += 1;
			end;
		};

		if ((vobTransportMode == vobTransportMode_SelectNext) && (!vobTransportVobPtr)) {
			PrintS (vobTransportPrint_NoObjectsDetected);
			vobTransportMode = vobTransportMode_Done;
		} else {
			vobTransportMode = vobTransportMode_SelectVob;
		};
	};

	if (vobTransportMode == vobTransportMode_SelectPrev) {
		//loop through vob list - select previous in the list
		var int flagSelectPrevious; flagSelectPrevious = FALSE;

		her = Hlp_GetNPC (hero);
		if (her.vobList_array) {
			i = her.vobList_numInArray;

			while (i > 0);
				vobPtr = MEM_ReadIntArray (her.vobList_array, i - 1);

				if (VobCanBeSelected__VobTransport (vobPtr)) {
					if (flagSelectPrevious == FALSE) {
						if (vobTransportVobPtr == vobPtr) {
							flagSelectPrevious = TRUE;
						};
					} else {
						//Remove BBox from last vobPtr
						Vob_CancelSelection (vobTransportVobPtr);

						//Get pointer of moved object
						vobTransportVobPtr = vobPtr;

						//Add BBox to previous vobPtr
						zCVob_SetDrawBBox3D (vobTransportVobPtr, 1);
						vobTransportOriginalCollisions = Vob_GetCollBits (vobTransportVobPtr);

						NPC_ClearAIQueue (hero);
						AI_TurnToVobPtr (hero, vobTransportVobPtr);

						//Change vobTransportMode
						vobTransportMode = vobTransportMode_SelectVob;
						break;
					};
				};

				i -= 1;
			end;
		};

		if ((vobTransportMode == vobTransportMode_SelectPrev) && (!vobTransportVobPtr)) {
			PrintS (vobTransportPrint_NoObjectsDetected);
			vobTransportMode = vobTransportMode_Done;
		} else {
			vobTransportMode = vobTransportMode_SelectVob;
		};
	};

	if (vobTransportMode == vobTransportMode_SelectConfirm) {
		if (VobCanBeMovedAround__VobTransport (vobTransportVobPtr)) {
			//Is this item in hand? If yes - drop from slot (insert into the world) and move around
			vobPtr = oCNpc_GetSlotItem (hero, "ZS_RIGHTHAND");
			if ((vobPtr) && (vobPtr == vobTransportVobPtr)) {
				//Remove from hand
				//vobTransportVobPtr = oCNpc_RemoveFromSlot_Fixed (hero, "ZS_RIGHTHAND", FALSE, 0);
				vobTransportVobPtr = oCNpc_DropFromSlot (hero, "ZS_RIGHTHAND");

				//Stop item from moving
				zCVob_SetPhysicsEnabled (vobTransportVobPtr, 0);
				zCVob_SetSleeping (vobTransportVobPtr, 1);
			};

			//Cancel selection
			Vob_CancelSelection (vobTransportVobPtr);

			vob = _^ (vobTransportVobPtr);
			MEM_CopyBytes (_@ (vob.trafoObjToWorld), _@ (vobTransportOriginalTrafo), 64);

			if (!vobTransportOriginalAlphaChanged) {
				vobTransportOriginalAlphaEnabled = ((vob.bitfield[0] & zCVob_bitfield0_visualAlphaEnabled) == zCVob_bitfield0_visualAlphaEnabled);
				vobTransportOriginalAlpha = vob.visualAlpha;
			};

			//Clone mode
			if (vobTransportActionMode == vobTransportActionMode_Clone) {
				if (VobCanBeCloned__VobTransport (vobTransportVobPtr)) {
					vobPtrBackup = vobTransportVobPtr;
					vobTransportVobPtr = CloneObject__VobTransport (vobTransportVobPtr);

					if (!vobTransportVobPtr) {
						vobTransportVobPtr = vobPtrBackup;

						PrintS (vobTransportPrint_CannotBeCloned);

						vobTransportMode = vobTransportMode_SelectVob;
					} else {
						PrintS (vobTransportPrint_Cloned);

						//Backup collision bitfields (has to be done here --> because clone factory will add collisions
						vobTransportOriginalCollisions = Vob_GetCollBits (vobTransportVobPtr);

						//Remove active collisions
						Vob_RemoveCollBits (vobTransportVobPtr, vobTransportOriginalCollisions);

						vobTransportMode = vobTransportMode_Movement;

						PC_RemoveFromSleepingMode ();
					};
				} else {
					PrintS (vobTransportPrint_CannotBeCloned);

					vobTransportMode = vobTransportMode_SelectVob;
				};
			} else
			if (vobTransportActionMode == vobTransportActionMode_Move) {
				PrintS (vobTransportPrint_MoveVobActivated);

				//Backup collision bitfields
				vobTransportOriginalCollisions = Vob_GetCollBits (vobTransportVobPtr);

				//Remove active collisions
				Vob_RemoveCollBits (vobTransportVobPtr, vobTransportOriginalCollisions);

				vobTransportMode = vobTransportMode_Movement;

				PC_RemoveFromSleepingMode ();
			};

			if (vobTransportMode == vobTransportMode_Movement) {
				//Update alpha
				if (!vobTransportOriginalAlphaChanged) {
					vob = _^ (vobTransportVobPtr);
					vob.bitfield[0] = vob.bitfield[0] | zCVob_bitfield0_visualAlphaEnabled;

					//Don't adjust alpha for zCDecal - they are already difficult to spot :)
					if (!Hlp_VobVisual_Is_zCDecal (vobTransportVobPtr)) {
						vob.visualAlpha = divf (mkf (vobTransportAlpha), mkf (100));
					};

					vobTransportOriginalAlphaChanged = TRUE;
				};
			};

			//Enable BBox
			zCVob_SetDrawBBox3D (vobTransportVobPtr, 1);
		} else {
			PrintS (vobTransportPrint_CannotBeClonedMoved);
			vobTransportMode = vobTransportMode_SelectVob;
		};
	};

	if (vobTransportMode == vobTransportMode_BuyVob) {
		if (vobTransportShowcaseVobPtr) {
			MoveVobInFront__VobTransport (hero, vobTransportShowcaseVobPtr, mkf (100));
		};
	};

	//Moving mode
	if (vobTransportMode == vobTransportMode_Movement) {
		if (vobTransportVobPtr) {
			//Move object in front of hero (X, Y, Z)
			MoveVobInFront__VobTransport (hero, vobTransportVobPtr, mkf (100));

			//Align vob to floor
			if (vobTransportAlignToFloor == TRUE) {
				SetVobToFloor (vobTransportVobPtr);
			};
		};
	};

	//Stop transport mode
	if (vobTransportMode == vobTransportMode_Done) {
		if (vobTransportVobPtr) {
			Vob_CancelSelection (vobTransportVobPtr);
		};

		//Drop item
		if (vobTransportActionMode == vobTransportActionMode_DropItem) {
			zCVob_SetPhysicsEnabled (vobTransportVobPtr, 1);
			zCVob_SetSleeping (vobTransportVobPtr, 0);
		};

		PC_RemoveFromSleepingMode ();

		//Restore collision bitfields
		Vob_RestoreCollBits (vobTransportVobPtr, vobTransportOriginalCollisions);

		//Disable vobTransportMode
		vobTransportMode = vobTransportMode_Idle;
	};

	//
	DisplayProperties__VobTransport ();
};

func void _hook_BBox3D_Draw () {
	if (!ECX) { return; };
	if (!vobTransportBBoxPtr) { return; };

	var int vobTransportBBoxColor;

	if (!vobTransportBBoxColor) {
		vobTransportBBoxColor = MEM_Alloc (4);
	};

	if (ECX == vobTransportBBoxPtr) {
		MEM_WriteInt (vobTransportBBoxColor, GFX_BLUE);
	};

	MEM_WriteInt (ESP + 4, vobTransportBBoxColor);
};

func void G12_VobTransport_Init () {
	G12_ColorConstants_Init ();

	//Init Game key events
	G12_GameHandleEvent_Init ();

	//Add listener for key
	GameHandleEvent_AddListener (_eventGameHandleEvent__VobTransport);

	//Frame function
	FF_ApplyOnceExtGT (FrameFunction__VobTransport, 0, -1);

	//BBox draw hook
	const int once = 0;
	if (!once) {
		//0x00531E90 public: void __thiscall zTBBox3D::Draw(struct zCOLOR const &)const
		const int zTBBox3D__Draw_G1 = 5447312;

		//0x00545EE0 public: void __thiscall zTBBox3D::Draw(struct zCOLOR const &)const
		const int zTBBox3D__Draw_G2 = 5529312;

		HookEngine (MEMINT_SwitchG1G2 (zTBBox3D__Draw_G1, zTBBox3D__Draw_G2), 5, "_hook_BBox3D_Draw");

		once = 1;
	};
};
