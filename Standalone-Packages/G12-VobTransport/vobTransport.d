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
 */
func void MoveVobInFront__VobTransport (var int slfInstance, var int vobPtr, var int delta) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	if (!vobPtr) { return; };

	var zCVob vob; vob = _^ (vobPtr);

	//Save BBox
	var zTBBox3D bbox; bbox = _^ (zCVob_GetBBox3DLocal (vobPtr));

	//Move vob to NPC X Y Z coordinates
	vob.trafoObjToWorld [03] = slf._zCVob_trafoObjToWorld [03];
	vob.trafoObjToWorld [07] = slf._zCVob_trafoObjToWorld [07];
	vob.trafoObjToWorld [11] = slf._zCVob_trafoObjToWorld [11];

	//Adjust 'elevation'
	vob.trafoObjToWorld [07] = addf (vob.trafoObjToWorld [07], mkf (vobTransportElevationLevel));

	zCVob_Move (vobPtr, mulf (slf._zCVob_trafoObjToWorld[10], delta), mulf (slf._zCVob_trafoObjToWorld[6], delta), mulf (slf._zCVob_trafoObjToWorld[2], delta));

	//Vob-spot-slotting
	var int pos[3]; TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));
	var int vobSpotPtr; vobSpotPtr = Npc_GetFP (slf, "FP_SLOT", mkf (vobTransportCollectVobSlotRange), _@ (pos));
	if (vobSpotPtr) {
		if (lef (zCVob_GetDistanceToVob (vobPtr, vobSpotPtr), mkf (vobTransportAlignVobSlotRange))) {
			var zCVob vobSpot; vobSpot = _^ (vobSpotPtr);

			// Update position
			AlignVobAt(vobPtr, _@(vobSpot.trafoObjToWorld));
		};
	};

	//Restore BBox
	zCVob_SetBBox3DLocal (vobPtr, _@ (bbox));
};

func int HandleElevationAndRotation__VobTransport (var int key, var int mvmtMode) {
	var int rotation;
	var int cancel; cancel = FALSE;

	if (vobTransportTransformationMode != vobTransportTransformation_None) {
		//Reset
		rotation = 0;

		//--- Space - movement speed increase

		//Movement speed 1 > 10 > 20
		if (key == KEY_SPACE) {
			if (vobTransportMovementSpeed == 1) {
				vobTransportMovementSpeed = 10;
			} else
			if (vobTransportMovementSpeed == 10) {
				vobTransportMovementSpeed = 20;
			} else {
				vobTransportMovementSpeed = 1;
			};

			cancel = TRUE;
		};

		//--- X - rotate X axis

		if (key == KEY_X) {
			if (vobTransportTransformationMode == vobTransportTransformation_RotX) {
				vobTransportTransformationMode = vobTransportTransformation_None;
				if (mvmtMode) { PC_RemoveFromSleepingMode (); };
			} else {
				vobTransportTransformationMode = vobTransportTransformation_RotX;
			};

			cancel = TRUE;
		};

		//--- Y - rotate Y axis

		if (key == KEY_Y) {
			if (vobTransportTransformationMode == vobTransportTransformation_RotY) {
				vobTransportTransformationMode = vobTransportTransformation_None;
				if (mvmtMode) { PC_RemoveFromSleepingMode (); };
			} else {
				vobTransportTransformationMode = vobTransportTransformation_RotY;
			};

			cancel = TRUE;
		};

		//--- Z - rotate Z axis

		if (key == KEY_Z) {
			if (vobTransportTransformationMode == vobTransportTransformation_RotZ) {
				vobTransportTransformationMode = vobTransportTransformation_None;
				if (mvmtMode) { PC_RemoveFromSleepingMode (); };
			} else {
				vobTransportTransformationMode = vobTransportTransformation_RotZ;
			};

			cancel = TRUE;
		};

		//--- E - elevate

		if (key == KEY_E) {
			if (vobTransportTransformationMode == vobTransportTransformation_Elevation) {
				vobTransportTransformationMode = vobTransportTransformation_None;
				if (mvmtMode) { PC_RemoveFromSleepingMode (); };
			} else {
				vobTransportTransformationMode = vobTransportTransformation_Elevation;
			};

			cancel = TRUE;
		};

		//--- Rotation

		if ((vobTransportTransformationMode == vobTransportTransformation_RotX)
		|| (vobTransportTransformationMode == vobTransportTransformation_RotY)
		|| (vobTransportTransformationMode == vobTransportTransformation_RotZ)) {

			//Left / down key
			//if ((key == KEY_LEFTARROW) || (key == MOUSE_WHEEL_UP) || (key == KEY_DOWNARROW)) {
			if ((key == MEM_GetKey ("keyLeft")) || (key == MEM_GetSecondaryKey ("keyLeft")) || (key == MEM_GetKey ("keyStrafeLeft")) || (key == MEM_GetSecondaryKey ("keyStrafeLeft")) || (key == MOUSE_WHEEL_UP)) {

				rotation = -vobTransportMovementSpeed;
				cancel = TRUE;
			};

			// right / up key
			//if ((key == KEY_RIGHTARROW) || (key == MOUSE_WHEEL_DOWN) || (key == KEY_UPARROW)) {
			if ((key == MEM_GetKey ("keyRight")) || (key == MEM_GetSecondaryKey ("keyRight")) || (key == MEM_GetKey ("keyStrafeRight")) || (key == MEM_GetSecondaryKey ("keyStrafeRight")) || (key == MOUSE_WHEEL_DOWN)) {
				rotation = vobTransportMovementSpeed;
				cancel = TRUE;
			};
		};

		//--- Elevation - up - down key

		if (vobTransportTransformationMode == vobTransportTransformation_Elevation) {
			//if (key == KEY_UPARROW) {
			if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp")) || (key == MOUSE_WHEEL_UP)) {
				vobTransportElevationLevel += vobTransportMovementSpeed;
				cancel = TRUE;
			};

			//if (key == KEY_DOWNARROW) {
			if ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown")) || (key == MOUSE_WHEEL_DOWN)) {
				vobTransportElevationLevel -= vobTransportMovementSpeed;
				cancel = TRUE;
			};
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
		if ((vobTransportElevationLevel) && (!mvmtMode)) {
			zCVob_Move (vobTransportVobPtr, FLOATNULL, mkf (vobTransportElevationLevel), FLOATNULL);
			vobTransportElevationLevel = 0;
		};
	};

	return cancel;
};

func void Vob_CancelSelection (var int vobPtr) {
	if (!vobPtr) { return; };

	//Remove bbox
	zCVob_SetDrawBBox3D (vobPtr, 0);

	//Reset alpha
	if (vobTransportOriginalAlphaChanged) {
		var zCVob vob;
		vob = _^ (vobPtr);
		vob.visualAlpha = vobTransportOriginalAlpha;
		if (!vobTransportOriginalAlphaEnabled) {
			vob.bitfield[0] = (vob.bitfield[0] & ~ zCVob_bitfield0_visualAlphaEnabled);
		};

		vobTransportOriginalAlphaChanged = FALSE;
	};
};

func void _eventGameHandleEvent__VobTransport (var int dummyVariable) {
	var int cancel; cancel = FALSE;
	var int key; key = MEM_ReadInt (ESP + 4);

	if (!key) { return; };

	//Safety-check
	if (!Hlp_IsValidNPC (hero)) { return; };

	var int vobPtr;
	var string objectName;
	var string visualName;
	var oCNPC her;
	var zCVob vob;

	var int retVal;

	var int ctrlPressed;

	var int vobChanged; vobChanged = FALSE;

	//--- Idle

	if (vobTransportMode == vobTransportMode_Idle) {

		//--- Activate vob Transport mode

		if (key == KEY_LBRACKET) {
			//Can we activate Vob transport ?
			if (VobTransportCanBeActivated__VobTransport_API ()) {
				//Init default values
				vobTransportMode = vobTransportMode_Init;
				vobTransportActionMode = vobTransportActionMode_Clone;
				vobTransportTransformationMode = vobTransportTransformation_None;

				if (!vobTransportMovementSpeed) { vobTransportMovementSpeed = 1; };
				cancel = TRUE;
			};
		} else

		//--- Buy objects

		if (key == KEY_RBRACKET) {
			//Can we activate Vob transport ?
			if (VobTransportCanBeActivated__VobTransport_API ()) {
				//Do we have anything in vobList_array ?
				BuildBuyVobList__VobTransport (-1);

				her = Hlp_GetNPC (hero);
				if ((her.vobList_numInArray > 0) && (her.vobList_array)) {

					if (vobTransportShowcaseVobIndex < 0) { vobTransportShowcaseVobIndex = 0; };
					if (vobTransportShowcaseVobIndex >= her.vobList_numInArray) { vobTransportShowcaseVobIndex = her.vobList_numInArray - 1; };

					if (!vobTransportShowcaseVobPtr) {

						vobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);

						if (VobCanBeBought__VobTransport_API (vobPtr)) {
							vob = _^ (vobPtr);
							objectName = vob._zCObject_objectName;
							visualName = Vob_GetVisualName (vobPtr);

							vobTransportShowcaseVobPtr = InsertObject ("zCVob", objectName, visualName, _@ (vob.trafoObjToWorld), 0);

							var int vobRemoveCollisions; vobRemoveCollisions = Vob_GetCollBits (vobTransportShowcaseVobPtr);
							Vob_RemoveCollBits (vobTransportShowcaseVobPtr, vobRemoveCollisions);

							//Add frame function that will rotate showcased vob
							FF_ApplyOnceExtGT (FrameFunction_RotateShowcasedVob__VobTransport, 16, -1);

							//Put player in sleeping mode
							PC_PutInSleepingMode ();
							PrintS (vobTransportPrint_BuyVobActivated);

							vobTransportMode = vobTransportMode_BuyVob;
							vobChanged = TRUE;
						} else {
							PrintS (vobTransportPrint_BuyVobNothingToBuy);
						};
					};
				} else {
					PrintS (vobTransportPrint_BuyVobNothingToBuy);
				};

				if (!vobTransportMovementSpeed) { vobTransportMovementSpeed = 1; };
				cancel = TRUE;
			};
		};
	};

	//--- Selection mode

	if ((vobTransportMode == vobTransportMode_SelectVob) && (!cancel)) {
		//Print to zSpy details relevant for object creation (via InsertAnything!)
		if (key == KEY_P) {
			PrintCodeTozSpy__VobTransport (vobTransportVobPtr);
		};

		if (key == KEY_LBRACKET) {
			ctrlPressed = MEM_KeyState (KEY_LCONTROL);

			//--- Confirm selection (will clone object by default)

			if (!ctrlPressed) {
				vobTransportMode = vobTransportMode_SelectConfirm;
				cancel = TRUE;
			} else {

				//--- Drop item in combination with Ctrl

				if (Hlp_Is_oCItem (vobTransportVobPtr)) {
					if (VobCanBePlaced__VobTransport (vobTransportVobPtr)) {
						vobTransportActionMode = vobTransportActionMode_DropItem;
						vobTransportMode = vobTransportMode_Done;

						cancel = TRUE;
					};
				};
			};
		};

		//--- Enter - enter Transform mode

		if (key == KEY_RETURN) {
			vobTransportTransformationMode = vobTransportTransformation_RotY;
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
				if (!Hlp_Is_zCDecal (vobTransportVobPtr)) {
					//Update alpha
					vob.bitfield[0] = vob.bitfield[0] | zCVob_bitfield0_visualAlphaEnabled;
					vob.visualAlpha = divf (mkf (50), mkf (100));
				};

				vobTransportOriginalAlphaChanged = TRUE;
			};

			cancel = TRUE;
		};

		//--- Move object

		if (key == KEY_M) {
			vobTransportMode = vobTransportMode_SelectConfirm;
			vobTransportActionMode = vobTransportActionMode_Move;
			cancel = TRUE;
		};

		//Select previous vob
		//if ((key == KEY_LEFTARROW) || (key == MOUSE_WHEEL_UP)) {
		if ((key == MEM_GetKey ("keyLeft")) || (key == MEM_GetSecondaryKey ("keyLeft")) || (key == MEM_GetKey ("keyStrafeLeft")) || (key == MEM_GetSecondaryKey ("keyStrafeLeft"))) {
			vobTransportMode = vobTransportMode_SelectPrev;
			cancel = TRUE;
		};

		//Select next vob
		//if ((key == KEY_RIGHTARROW) || (key == MOUSE_WHEEL_DOWN)) {
		if ((key == MEM_GetKey ("keyRight")) || (key == MEM_GetSecondaryKey ("keyRight")) || (key == MEM_GetKey ("keyStrafeRight")) || (key == MEM_GetSecondaryKey ("keyStrafeRight"))) {
			vobTransportMode = vobTransportMode_SelectNext;
			cancel = TRUE;
		};

		//--- Delete object

		if (key == KEY_DELETE) {
			if (VobCanBeDeleted__VobTransport (vobTransportVobPtr)) {
				var int doDelete; doDelete = TRUE;

				//-->	oCMobContainer
				//	 - First KEY_DELETE deletes contents
				if (Hlp_Is_oCMobContainer (vobTransportVobPtr)) {
					if (!Mob_IsEmpty (vobTransportVobPtr)) {
						Mob_RemoveAllItems (vobTransportVobPtr);
						doDelete = FALSE;
						PrintS (vobTransportPrint_ContainerContentsDeleted);
					};
				};
				//<--

				if (doDelete) {
					zCVob_SetDrawBBox3D (vobTransportVobPtr, 0);

					oCNpc_SetFocusVob (hero, 0);
					oCNpc_ClearVobList (hero);

					RemoveoCVobSafe (vobTransportVobPtr, 1);
					vobTransportVobPtr = 0;

					vobTransportTransformationMode = vobTransportTransformation_None;
					vobTransportMode = vobTransportMode_Init;
				};

				cancel = TRUE;
			};
		};

		//--- Cancel selection

		if ((key == KEY_ESCAPE) || (key == KEY_RBRACKET)) {
			Vob_CancelSelection (vobTransportVobPtr);

			PC_RemoveFromSleepingMode ();
			vobTransportMode = vobTransportMode_Idle;

			cancel = TRUE;
		};
	};

	//--- Transform

	if ((vobTransportMode == vobTransportMode_Transform) && (!cancel)) {
		if ((key == KEY_RETURN) || (key == KEY_LBRACKET)) {
			vobTransportMode = vobTransportMode_SelectVob;
			vobTransportTransformationMode = vobTransportTransformation_None;
			cancel = TRUE;
		};

		if ((key == KEY_ESCAPE) || (key == KEY_RBRACKET)) {
			vobTransportMode = vobTransportMode_SelectVob;
			vobTransportTransformationMode = vobTransportTransformation_None;

			if (vobTransportVobPtr) {
				AlignVobAt (vobTransportVobPtr, _@ (vobTransportOriginalTrafo));

				//Vob_CancelSelection (vobTransportVobPtr);
				//zCVob_SetDrawBBox3D (vobTransportVobPtr, 1);

				Vob_RestoreCollBits (vobTransportVobPtr, vobTransportOriginalCollisions);
			};

			cancel = TRUE;
		};

		if (!cancel) {
			cancel = HandleElevationAndRotation__VobTransport (key, FALSE);
		};
	};

	//--- Movement mode

	if ((vobTransportMode == vobTransportMode_Movement) && (!cancel)) {
		if (key == KEY_LBRACKET) {
			ctrlPressed = MEM_KeyState (KEY_LCONTROL);

			//--- Confirm position

			if (!ctrlPressed) {
				if (VobCanBePlaced__VobTransport (vobTransportVobPtr)) {
					vobTransportMode = vobTransportMode_Done;
					cancel = TRUE;
				};
			} else {
				if (Hlp_Is_oCItem (vobTransportVobPtr)) {
					if (VobCanBePlaced__VobTransport_API (vobTransportVobPtr)) {
						vobTransportActionMode = vobTransportActionMode_DropItem;
						vobTransportMode = vobTransportMode_Done;
						PrintS (vobTransportPrint_ItemDropped);
						cancel = TRUE;
					};
				};
			};
		};

		if (key == KEY_M) {
			if (VobCanBePlaced__VobTransport_API (vobTransportVobPtr)) {
				vobTransportMode = vobTransportMode_Done;
				cancel = TRUE;
			};
		};

		//--- Toggle alignment to surface

		if (key == KEY_RBRACKET) {
			if (vobTransportTransformationMode != vobTransportTransformation_Elevation) {
				vobTransportAlignToFloor = !vobTransportAlignToFloor;
				cancel = TRUE;
			};
		};

		//--- Delete object

		if (key == KEY_DELETE) {
			//Any object can be deleted while moving (if we allowed selection)
			//if (VobCanBeDeleted__VobTransport (vobTransportVobPtr)) {
				zCVob_SetDrawBBox3D (vobTransportVobPtr, 0);

				oCNpc_SetFocusVob (hero, 0);
				oCNpc_ClearVobList (hero);

				RemoveoCVobSafe (vobTransportVobPtr, 1);
				vobTransportVobPtr = 0;
				cancel = TRUE;
			//} else {
			//	PrintS ("Object can't be deleted.");
			//};

			vobTransportMode = vobTransportMode_Done;
		};

		//--- Escape

		if (key == KEY_ESCAPE) {

			//--- Rotation mode - escape

			if (vobTransportTransformationMode != vobTransportTransformation_None) {
				vobTransportTransformationMode = vobTransportTransformation_None;
				PC_RemoveFromSleepingMode ();
				cancel = TRUE;
			} else {

				//--- Cloning object - cancel >> delete object

				if (vobTransportActionMode == vobTransportActionMode_Clone) {

					Vob_CancelSelection (vobTransportVobPtr);

					oCNpc_SetFocusVob (hero, 0);
					oCNpc_ClearVobList (hero);

					RemoveoCVobSafe (vobTransportVobPtr, 1);
					vobTransportVobPtr = 0;

					vobTransportMode = vobTransportMode_Done;
					cancel = TRUE;
				};

				//--- Moving object - cancel >> reset to original position

				if (vobTransportActionMode == vobTransportActionMode_Move) {
					if (vobTransportVobPtr) {
						AlignVobAt (vobTransportVobPtr, _@ (vobTransportOriginalTrafo));
						Vob_CancelSelection (vobTransportVobPtr);
					};

					vobTransportMode = vobTransportMode_Done;
					cancel = TRUE;
				};
			};
		};

		//--- Enter - toggle Transformation (rotation & elevation)

		if (key == KEY_RETURN) {
			if (vobTransportTransformationMode == vobTransportTransformation_None) {
				vobTransportTransformationMode = vobTransportTransformation_RotY;
				PC_PutInSleepingMode ();
			} else {
				vobTransportTransformationMode = vobTransportTransformation_None;
				PC_RemoveFromSleepingMode ();
			};

			cancel = TRUE;
		};

		if (!cancel) {
			cancel = HandleElevationAndRotation__VobTransport (key, TRUE);
		};
	};

	//--- Buy objects

	if ((vobTransportMode == vobTransportMode_BuyVob) && (!cancel)) {

		//--- Escape - cancel buying

		if ((key == KEY_ESCAPE) || (key == KEY_RBRACKET)) {
			if (vobTransportShowcaseVobPtr) {
				Vob_CancelSelection (vobTransportShowcaseVobPtr);

				oCNpc_SetFocusVob (hero, 0);
				oCNpc_ClearVobList (hero);

				RemoveoCVobSafe (vobTransportShowcaseVobPtr, 1);
				vobTransportShowcaseVobPtr = 0;

				vobTransportMode = vobTransportMode_Idle;
			};

			PC_RemoveFromSleepingMode ();
			cancel = TRUE;
		};

		//--- Select previous object

		if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp")) || (key == MOUSE_WHEEL_UP)) {
			BuildBuyVobList__VobTransport (KEY_UPARROW);
				her = Hlp_GetNPC (hero);
				if ((her.vobList_numInArray > 0) && (her.vobList_array)) {

					if (vobTransportShowcaseVobIndex < 0) { vobTransportShowcaseVobIndex = 0; };
					if (vobTransportShowcaseVobIndex >= her.vobList_numInArray) { vobTransportShowcaseVobIndex = her.vobList_numInArray - 1; };

					vobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);

					if (VobCanBeBought__VobTransport_API (vobPtr)) {
						vob = _^ (vobPtr);
						objectName = vob._zCObject_objectName;
						visualName = Vob_GetVisualName (vobPtr);

						zCVob_SetVisual (vobTransportShowcaseVobPtr, visualName);
						vob = _^ (vobTransportShowcaseVobPtr);
						vob._zCObject_objectName = objectName;
						vobChanged = TRUE;
					} else {
						PrintS (vobTransportPrint_BuyVobNothingToBuy);
					};
				} else {
					PrintS (vobTransportPrint_BuyVobNothingToBuy);
				};
			cancel = TRUE;
		};

		if ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown")) || (key == MOUSE_WHEEL_DOWN)) {
			BuildBuyVobList__VobTransport (KEY_DOWNARROW);
				her = Hlp_GetNPC (hero);
				if ((her.vobList_numInArray > 0) && (her.vobList_array)) {

					if (vobTransportShowcaseVobIndex < 0) { vobTransportShowcaseVobIndex = 0; };
					if (vobTransportShowcaseVobIndex >= her.vobList_numInArray) { vobTransportShowcaseVobIndex = her.vobList_numInArray - 1; };

					vobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);

					if (VobCanBeBought__VobTransport_API (vobPtr)) {
						vob = _^ (vobPtr);
						objectName = vob._zCObject_objectName;
						visualName = Vob_GetVisualName (vobPtr);

						zCVob_SetVisual (vobTransportShowcaseVobPtr, visualName);
						vob = _^ (vobTransportShowcaseVobPtr);
						vob._zCObject_objectName = objectName;
						vobChanged = TRUE;
					} else {
						PrintS (vobTransportPrint_BuyVobNothingToBuy);
					};
				} else {
					PrintS (vobTransportPrint_BuyVobNothingToBuy);
				};
			cancel = TRUE;
		};

		//if ((key == KEY_LEFTARROW) || (key == MOUSE_WHEEL_UP)) {
		if ((key == MEM_GetKey ("keyLeft")) || (key == MEM_GetSecondaryKey ("keyLeft")) || (key == MEM_GetKey ("keyStrafeLeft")) || (key == MEM_GetSecondaryKey ("keyStrafeLeft"))) {
			vobTransportShowcaseVobIndex -= 1;

			her = Hlp_GetNPC (hero);
			if ((her.vobList_numInArray > 0) && (her.vobList_array)) {
				if (vobTransportShowcaseVobIndex < 0) { vobTransportShowcaseVobIndex = her.vobList_numInArray - 1; };

				vobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);
				vob = _^ (vobPtr);
				objectName = vob._zCObject_objectName;
				visualName = Vob_GetVisualName (vobPtr);

				zCVob_SetVisual (vobTransportShowcaseVobPtr, visualName);
				vob = _^ (vobTransportShowcaseVobPtr);
				vob._zCObject_objectName = objectName;
				vobChanged = TRUE;
			};

			cancel = TRUE;
		};

		//--- Select next object

		//if ((key == KEY_RIGHTARROW) || (key == MOUSE_WHEEL_DOWN)) {
		if ((key == MEM_GetKey ("keyRight")) || (key == MEM_GetSecondaryKey ("keyRight")) || (key == MEM_GetKey ("keyStrafeRight")) || (key == MEM_GetSecondaryKey ("keyStrafeRight"))) {
			vobTransportShowcaseVobIndex += 1;

			her = Hlp_GetNPC (hero);
			if ((her.vobList_numInArray > 0) && (her.vobList_array)) {
				if (vobTransportShowcaseVobIndex >= her.vobList_numInArray) { vobTransportShowcaseVobIndex = 0; };

				vobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);
				vob = _^ (vobPtr);
				objectName = vob._zCObject_objectName;
				visualName = Vob_GetVisualName (vobPtr);

				zCVob_SetVisual (vobTransportShowcaseVobPtr, visualName);
				vob = _^ (vobTransportShowcaseVobPtr);
				vob._zCObject_objectName = objectName;
				vobChanged = TRUE;
			};

			cancel = TRUE;
		};

		//--- Buy object

		if (key == KEY_LBRACKET) {
			her = Hlp_GetNPC (hero);
			if ((her.vobList_numInArray > 0) && (her.vobList_array)) {
				if ((vobTransportShowcaseVobIndex >= 0) && (vobTransportShowcaseVobIndex < her.vobList_numInArray)) {
					vobTransportVobPtr = MEM_ReadIntArray (her.vobList_array, vobTransportShowcaseVobIndex);
				};
			};

			zCVob_SetDrawBBox3D (vobTransportShowcaseVobPtr, 0);

			oCNpc_SetFocusVob (hero, 0);
			oCNpc_ClearVobList (hero);

			RemoveoCVobSafe (vobTransportShowcaseVobPtr, 1);
			vobTransportShowcaseVobPtr = 0;

			vobTransportActionMode = vobTransportActionMode_Clone;
			vobTransportMode = vobTransportMode_SelectConfirm;

			cancel = TRUE;
		};

		if ((vobChanged) && (vobTransportShowcaseVobPtr)) {
			//Call API function to get update on all texts for propertiesView.d
			retVal = VobCanBeBought__VobTransport_API (vobTransportShowcaseVobPtr);
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
			prio 1:	focus_vob
			prio 2: last vobPtr (vobPtrBackup)
			prio 3: anything in view
			prio 4: everything else
	*/

	if (vobTransportMode == vobTransportMode_Init) {
		her = Hlp_GetNPC (hero);

		//Reset
		vobPtrBackup = vobTransportVobPtr;

		vobTransportVobPtr = 0;
		vobTransportElevationLevel = 0;

		//Is there anything in hero's focus ?
		if (her.focus_vob) {
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
					if (!Hlp_Is_zCDecal (vobTransportVobPtr)) {
						vob.visualAlpha = divf (mkf (50), mkf (100));
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
			MoveVobInFront__VobTransport (hero, vobTransportShowcaseVobPtr, mkf (250));
		};
	};

	//Moving mode
	if (vobTransportMode == vobTransportMode_Movement) {
		if (vobTransportVobPtr) {
			//Move object in front of hero (X, Y, Z)
			MoveVobInFront__VobTransport (hero, vobTransportVobPtr, mkf (150));

			//Align vob to floor
			if (vobTransportTransformationMode != vobTransportTransformation_Elevation) {
				if (vobTransportAlignToFloor == TRUE) {
					SetVobToFloor (vobTransportVobPtr);
				};
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

func void G12_VobTransport_Init () {
	//Init Game key events
	G12_GameHandleEvent_Init ();

	//Add listener for key
	GameHandleEvent_AddListener (_eventGameHandleEvent__VobTransport);

	//Frame function
	FF_ApplyOnceExtGT (FrameFunction__VobTransport, 0, -1);
};
