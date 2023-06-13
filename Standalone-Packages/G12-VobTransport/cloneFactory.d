/*
 *	Function generates new name
 *	"VOB_BUY_OC_BED_V1" 		--> "VOB_BUY_OC_BED_V1_CLONE_001"
 *	"VOB_BUY_OC_BED_V1_CLONE_001"	--> "VOB_BUY_OC_BED_V1_CLONE_002"
 */
func string CloneCreateNewName__VobTransport (var string vobName) {
	var int i; i = STR_IndexOf (vobName, "_CLONE_");
	var int indexValue;
	var string indexS;

	if (i > -1) {
		indexS = mySTR_SubStr (vobName, i + 7, STR_Len (vobName) - i + 1);
		indexValue = STR_ToInt (indexS);

		indexValue += 1;

		indexS = IntToString (indexValue);
		if (indexValue < 10) {
			indexS = ConcatStrings ("00", indexS);
		} else
		if (indexValue < 100) {
			indexS = ConcatStrings ("0", indexS);
		};

		vobName = mySTR_SubStr (vobName, 0, i + 7);
		vobName = ConcatStrings (vobName, indexS);
	} else {
		//First clone
		vobName = ConcatStrings (vobName, "_CLONE_001");
	};

	return vobName;
};

func void CopyoCMobProperties__VobTransport (var int mobPtr1, var int mobPtr2) {
	if (!Hlp_Is_oCMob (mobPtr1)) { return; };
	if (!Hlp_Is_oCMob (mobPtr2)) { return; };

	var oCMob mob1; mob1 = _^ (mobPtr1);
	var oCMob mob2; mob2 = _^ (mobPtr2);

	mob2.name = mob1.name;
	mob2.bitfield = mob1.bitfield;
	mob2.visualDestroyed = mob1.visualDestroyed;
	mob2.ownerStr = mob1.ownerStr;
	mob2.ownerGuildStr = mob1.ownerGuildStr;
	mob2.owner = mob1.owner;
	mob2.ownerGuild = mob1.ownerGuild;
	mob2.focusNameIndex = mob1.focusNameIndex;
};

func void CopyoCMobInterProperties__VobTransport (var int mobPtr1, var int mobPtr2) {
	if (!Hlp_Is_oCMobInter (mobPtr1)) { return; };
	if (!Hlp_Is_oCMobInter (mobPtr2)) { return; };

	var oCMobInter mob1; mob1 = _^ (mobPtr1);
	var oCMobInter mob2; mob2 = _^ (mobPtr2);

	mob2.triggerTarget = mob1.triggerTarget;
	mob2.useWithItem = mob1.useWithItem;
	mob2.sceme = mob1.sceme;
	mob2.conditionFunc = mob1.conditionFunc;
	mob2.onStateFuncName = mob1.onStateFuncName;
};

func void CopyoCMobLockableProperties__VobTransport (var int mobPtr1, var int mobPtr2) {
	if (!Hlp_Is_oCMobLockable (mobPtr1)) { return; };
	if (!Hlp_Is_oCMobLockable (mobPtr2)) { return; };

	var oCMobLockable mob1; mob1 = _^ (mobPtr1);
	var oCMobLockable mob2; mob2 = _^ (mobPtr2);

	mob2.bitfield = mob1.bitfield;
	mob2.keyInstance = mob1.keyInstance;
	mob2.pickLockStr = mob1.pickLockStr;
};

func void CopyozCTriggerProperties__VobTransport (var int triggerPtr1, var int triggerPtr2) {
	if (!Hlp_Is_zCTrigger (triggerPtr1)) { return; };
	if (!Hlp_Is_zCTrigger (triggerPtr2)) { return; };

	var zCTrigger trigger1; trigger1 = _^ (triggerPtr1);
	var zCTrigger trigger2; trigger2 = _^ (triggerPtr2);

	trigger2.triggerTarget = trigger1.triggerTarget;
	trigger2.bitfield = trigger1.bitfield;
	trigger2.respondToVobName = trigger1.respondToVobName;
	trigger2.numCanBeActivated = trigger1.numCanBeActivated;
	trigger2.retriggerWaitSec = trigger1.retriggerWaitSec;
	trigger2.damageThreshold = trigger1.damageThreshold;
	trigger2.fireDelaySec = trigger1.fireDelaySec;
	trigger2.nextTimeTriggerable = trigger1.nextTimeTriggerable;
	trigger2.savedOtherVob = trigger1.savedOtherVob;
	trigger2.countCanBeActivated = trigger1.countCanBeActivated;

	MEM_CopyBytes (_@ (trigger1._zCVob_bbox3D_mins), _@ (trigger2._zCVob_bbox3D_mins), 12);
	MEM_CopyBytes (_@ (trigger1._zCVob_bbox3D_maxs), _@ (trigger2._zCVob_bbox3D_maxs), 12);
};

func int CloneObject__VobTransport (var int vobPtr) {
	var zCDecal decal;
	var zCVob vob;
	var oCItem itm;
	var oCMobContainer mobContainer;
	var oCMobFire mobFire;
	var oCMobDoor mobDoor;
	var oCMobInter mobLadder;
	var oCMobLockable mobLockable;

	//oCMobSwitch is same as oCMobInter
	var oCMobInter mobSwitch;
	//oCMobWheel is same as oCMobInter
	var oCMobInter mobWheel;
	//oCMobBed is same as oCMobInter
	var oCMobInter mobBed;

	var oCMob mob;
	var oCMobInter mobInter;
	var zCTrigger trigger;
	var oCTriggerScript triggerScript;

	var string instName;
	var string visualName;
	var string objectName;

	var int amount;

	var int newVobPtr;
	var zCVob newVob;

	/*
	We can clone following objects:
		TODO: add properties into view and cloning factory
		NOTE: keep in mind that order in which objects are recognized is important in order to properly clone objects!
			Hlp_Is_oCMob returns true for: oCMob_vtbl, oCMobInter_vtbl, oCMobSwitch_vtbl, oCMobWheel_vtbl, oCMobContainer_vtbl, oCMobLockable_vtbl, oCMobLadder_vtbl, oCMobFire_vtbl, oCMobBed_vtbl, oCMobDoor_vtbl
			Hlp_Is_oCMobInter returns true for: oCMobInter_vtbl, oCMobSwitch_vtbl, oCMobWheel_vtbl, oCMobContainer_vtbl, , oCMobLockable_vtbl, oCMobLadder_vtbl, oCMobFire_vtbl, oCMobBed_vtbl, oCMobDoor_vtbl
			Hlp_Is_oCMobLockable returns true for: oCMobContainer_vtbl, oCMobLockable_vtbl, oCMobDoor_vtbl

		zCDecal			supported
		zCVob			supported
		oCItem			supported
		oCMobContainer		supported
		oCMobFire		supported
		oCMobDoor		supported
		oCMobLadder		supported
		oCMobLockable		supported
		oCMobSwitch		supported
		oCMobWheel		supported
		oCMobBed		supported
		oCMobInter		supported
		oCMob			supported

		zCTrigger
		oCTriggerScript

	*/
	//zCDecal (TGA textures)
	if (Hlp_VobVisual_Is_zCDecal (vobPtr)) {
		vob = _^ (vobPtr);
		decal = _^ (vob.visual);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (vob._zCObject_objectName);

		newVobPtr = InsertObject ("zCVob", objectName, visualName, _@ (vob.trafoObjToWorld), 0);

		newVob = _^ (newVobPtr);

		//Copy all properties (do we need to copy all of them ?)
		newVob.visualAlpha = vob.visualAlpha;

		newVob.lightColorStat = vob.lightColorStat;
		newVob.lightColorDyn = vob.lightColorDyn;

		newVob.vobPresetName = vob.vobPresetName;

		MEM_CopyBytes (_@ (vob.bitfield), _@ (newVob.bitfield), 20);

		//Create new zCDecal visual
		newVob.visual = zCDecal_Create (visualName, decal.xdim, decal.ydim);

		var zCDecal newDecal; newDecal = _^ (newVob.visual);

		//blank
		//B_Msg_Add (Visual_GetVisualName (decal.nextLODVisual));
		//B_Msg_Add (Visual_GetVisualName (decal.prevLODVisual));

		//newDecal.nextLODVisual = decal.nextLODVisual; zCVisual*
		//newDecal.prevLODVisual = decal.prevLODVisual; zCVisual*

		//Copy all properties (do we need to copy all of them ?)
		newDecal.lodFarDistance = decal.lodFarDistance;
		newDecal.lodNearFadeOutDistance = decal.lodNearFadeOutDistance;

		newDecal.xdim = decal.xdim;
		newDecal.ydim = decal.ydim;

		newDecal.xoffset = decal.xoffset;
		newDecal.yoffset = decal.yoffset;
		newDecal.decal2Sided = decal.decal2Sided;

		//--> zCMaterial*

		//Here we have to create new zCMaterial
		newDecal.decalMaterial = zCMaterial_Create ();

		var zCMaterial m1; m1 = _^ (decal.decalMaterial);
		var zCMaterial m2; m2 = _^ (newDecal.decalMaterial);

		//Copy all properties (do we need to copy all of them ?)
		m2.polyList_array = m1.polyList_array;
		m2.polyList_numAlloc = m1.polyList_numAlloc;
		m2.polyList_numInArray = m1.polyList_numInArray;
		m2.polyListTimeStamp = m1.polyListTimeStamp;

		m2.texture = m1.texture;
		m2.color = m1.color;
		m2.smoothAngle = m1.smoothAngle;
		m2.matGroup = m1.matGroup;

		m2.bspSectorFront = m1.bspSectorFront;
		m2.bspSectorBack = m1.bspSectorBack;
		m2.texAniCtrl = m1.texAniCtrl;
		m2.detailObjectVisualName = m1.detailObjectVisualName;

		m2.kambient = m1.kambient;
		m2.kdiffuse = m1.kdiffuse;

		MEM_CopyBytes (_@ (m1.bitfield), _@ (m2.bitfield), 24);

		m2.detailTexture = m1.detailTexture;
		m2.detailTextureScale = m1.detailTextureScale;

		m2.texAniMapDelta[0] = m1.texAniMapDelta[0];
		m2.texAniMapDelta[1] = m1.texAniMapDelta[1];

		m2.default_mapping[0] = m1.default_mapping[0];
		m2.default_mapping[1] = m1.default_mapping[1];

		m2.texScale[0] = m1.texScale[0];
		m2.texScale[1] = m1.texScale[1];

		//<--

		return newVobPtr;
	};

	//0x007DB44C const zCVob::`vftable'
	const int zCVob_vtbl_G1 = 8238156;

	//0x0083997C const zCVob::`vftable'
	const int zCVob_vtbl_G2 = 8624508;

	//
	if (MEM_ReadInt (vobPtr) == MEMINT_SwitchG1G2 (zCVob_vtbl_G1, zCVob_vtbl_G2)) {
		vob = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (vob._zCObject_objectName);

		newVobPtr = InsertObject ("zCVob", objectName, visualName, _@ (vob.trafoObjToWorld), 0);

		newVob = _^ (newVobPtr);

		newVob.visualAlpha = vob.visualAlpha;

		newVob.lightColorStat = vob.lightColorStat;
		newVob.lightColorDyn = vob.lightColorDyn;

		newVob.vobPresetName = vob.vobPresetName;

		MEM_CopyBytes (_@ (vob.bitfield), _@ (newVob.bitfield), 20);

		return newVobPtr;
	};

	//oCItem
	if (Hlp_Is_oCItem (vobPtr)) {
		itm = _^ (vobPtr);
		amount = itm.amount;
		instName = GetSymbolName (Hlp_GetInstanceID (itm));

		vobPtr = InsertItem (instName, amount, _@ (itm._zCVob_trafoObjToWorld));

		return vobPtr;
	};

	//oCMobContainer (chest)
	if (Hlp_Is_oCMobContainer (vobPtr)) {
		mobContainer = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobContainer._zCObject_objectName);

		vobPtr = InsertMobContainer (objectName, visualName, _@ (mobContainer._zCVob_trafoObjToWorld));

		var oCMobContainer newMobContainer; newMobContainer = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobContainer._zCVob_bitfield), _@ (newMobContainer._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobContainer), _@ (newMobContainer));
		CopyoCMobInterProperties__VobTransport (_@ (mobContainer), _@ (newMobContainer));
		CopyoCMobLockableProperties__VobTransport (_@ (mobContainer), _@ (newMobContainer));

		//
		//Mob_TransferItemsToMob (_@ (mobContainer), _@ (newMobContainer));
		Mob_CopyItemsToMob (_@ (mobContainer), _@ (newMobContainer));

		//mobContainer.contains is empty
		//newMobContainer.contains = mobContainer.contains;
		//FillMobContainer (vobPtr, mobContainer.contains);

		//Will this work? - nope
		//newMobContainer.items = mobContainer.items;
		//newMobContainer.containList_next = mobContainer.containList_next;

		//LockMobLockable (vobPtr, mobContainer.keyInstance, mobContainer.pickLockStr, (mobContainer.bitfield | oCMobLockable_bitfield_locked));
		return vobPtr;
	};

	//oCMobFire
	if (Hlp_Is_oCMobFire (vobPtr)) {
		mobFire = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobFire._zCObject_objectName);

		vobPtr = InsertMobFire (objectName, visualName, _@ (mobFire._zCVob_trafoObjToWorld));

		var oCMobFire newMobFire; newMobFire = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobFire._zCVob_bitfield), _@ (newMobFire._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobFire), _@ (newMobFire));
		CopyoCMobInterProperties__VobTransport (_@ (mobFire), _@ (newMobFire));

		newMobFire.fireSlot = mobFire.fireSlot;
		newMobFire.fireVobtreeName = mobFire.fireVobtreeName;

		return vobPtr;
	};

	//oCMobDoor
	if (Hlp_Is_oCMobDoor (vobPtr)) {
		mobDoor = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobDoor._zCObject_objectName);

		vobPtr = InsertMobDoor (objectName, visualName, _@ (mobDoor._zCVob_trafoObjToWorld));

		var oCMobDoor newMobDoor; newMobDoor = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobDoor._zCVob_bitfield), _@ (newMobDoor._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobDoor), _@ (newMobDoor));
		CopyoCMobInterProperties__VobTransport (_@ (mobDoor), _@ (newMobDoor));

		newMobDoor.addName = mobDoor.addName;

		return vobPtr;
	};

	//oCMobLadder
	//class oCMobLadder same as oCMobInter
	if (Hlp_Is_oCMobLadder (vobPtr)) {
		mobLadder = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobLadder._zCObject_objectName);

		vobPtr = InsertObject ("oCMobLadder", objectName, visualName, _@ (mobLadder._zCVob_trafoObjToWorld), 0);

		var oCMobInter newMobLadder; newMobLadder = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobLadder._zCVob_bitfield), _@ (newMobLadder._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobLadder), _@ (newMobLadder));
		CopyoCMobInterProperties__VobTransport (_@ (mobLadder), _@ (newMobLadder));

		return vobPtr;
	};

	//Is this one redundant ?
	if (Hlp_Is_oCMobLockable (vobPtr)) {
		mobLockable = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobLockable._zCObject_objectName);

		vobPtr = InsertObject ("oCMobLockable", objectName, visualName, _@ (mobLockable._zCVob_trafoObjToWorld), 0);

		var oCMobLockable newMobLockable; newMobLockable = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobLockable._zCVob_bitfield), _@ (newMobLockable._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobLockable), _@ (newMobLockable));
		CopyoCMobInterProperties__VobTransport (_@ (mobLockable), _@ (newMobLockable));
		CopyoCMobLockableProperties__VobTransport (_@ (mobLockable), _@ (newMobLockable));

		return vobPtr;
	};

	//
	if (Hlp_Is_oCMobSwitch (vobPtr)) {
		mobSwitch = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobSwitch._zCObject_objectName);

		vobPtr = InsertObject ("oCMobSwitch", objectName, visualName, _@ (mobSwitch._zCVob_trafoObjToWorld), 0);

		//oCMobSwitch is same as oCMobInter
		var oCMobInter newMobSwitch; newMobSwitch = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobSwitch._zCVob_bitfield), _@ (newMobSwitch._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobSwitch), _@ (newMobSwitch));
		CopyoCMobInterProperties__VobTransport (_@ (mobSwitch), _@ (newMobSwitch));
		CopyoCMobLockableProperties__VobTransport (_@ (mobSwitch), _@ (newMobSwitch));

		return vobPtr;
	};

	//oCMobWheel
	if (Hlp_Is_oCMobWheel (vobPtr)) {
		mobWheel = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobWheel._zCObject_objectName);

		vobPtr = InsertObject ("oCMobWheel", objectName, visualName, _@ (mobWheel._zCVob_trafoObjToWorld), 0);

		//oCMobWheel is same as oCMobInter
		var oCMobInter newMobWheel; newMobWheel = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobWheel._zCVob_bitfield), _@ (newMobWheel._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobWheel), _@ (newMobWheel));
		CopyoCMobInterProperties__VobTransport (_@ (mobWheel), _@ (newMobWheel));

		return vobPtr;
	};

	//oCMobBed
	if (Hlp_Is_oCMobBed (vobPtr)) {
		mobBed = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobBed._zCObject_objectName);

		vobPtr = InsertObject ("oCMobBed", objectName, visualName, _@ (mobBed._zCVob_trafoObjToWorld), 0);

		//oCMobBed is same as oCMobInter
		var oCMobInter newMobBed; newMobBed = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobBed._zCVob_bitfield), _@ (newMobBed._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobBed), _@ (newMobBed));
		CopyoCMobInterProperties__VobTransport (_@ (mobBed), _@ (newMobBed));

		return vobPtr;
	};

	//oCMobInter
	if (Hlp_Is_oCMobInter (vobPtr)) {
		mobInter = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobInter._zCObject_objectName);

		vobPtr = InsertObject ("oCMobInter", objectName, visualName, _@ (mobInter._zCVob_trafoObjToWorld), 0);

		//oCMobWheel is same as oCMobInter
		var oCMobInter newMobInter; newMobInter = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobInter._zCVob_bitfield), _@ (newMobInter._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mobInter), _@ (newMobInter));
		CopyoCMobInterProperties__VobTransport (_@ (mobInter), _@ (newMobInter));

		return vobPtr;
	};

	//oCMob
	if (Hlp_Is_oCMob (vobPtr)) {
		mob = _^ (vobPtr);

		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mob._zCObject_objectName);

		vobPtr = InsertObject ("oCMOB", objectName, visualName, _@ (mob._zCVob_trafoObjToWorld), 0);

		var oCMob newMob; newMob = _^ (vobPtr);

		MEM_CopyBytes (_@ (mob._zCVob_bitfield), _@ (newMob._zCVob_bitfield), 20);

		CopyoCMobProperties__VobTransport (_@ (mob), _@ (newMob));

		return vobPtr;
	};

	//NOT YET SUPPORTED
	return 0;

	//zCTrigger
	if (Hlp_Is_zCTrigger (vobPtr)) {
		trigger = _^ (vobPtr);

		//visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (trigger._zCObject_objectName);

		vobPtr = InsertTrigger (objectName, _@ (trigger._zCVob_trafoObjToWorld));

		var zCTrigger newTrigger; newTrigger = _^ (vobPtr);

		MEM_CopyBytes (_@ (trigger._zCVob_bitfield), _@ (newTrigger._zCVob_bitfield), 20);

		CopyozCTriggerProperties__VobTransport (_@ (trigger), _@ (newTrigger));

		return vobPtr;
	};

	//oCTriggerScript
	if (Hlp_Is_oCTriggerScript (vobPtr)) {
		triggerScript = _^ (vobPtr);

		//visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (triggerScript._zCObject_objectName);

		vobPtr = InsertTriggerScript (objectName, _@ (triggerScript._zCVob_trafoObjToWorld));

		var oCTriggerScript newTriggerScript; newTriggerScript = _^ (vobPtr);

		MEM_CopyBytes (_@ (triggerScript._zCVob_bitfield), _@ (newTriggerScript._zCVob_bitfield), 20);

		CopyozCTriggerProperties__VobTransport (_@ (trigger), _@ (newTrigger));

		newTriggerScript.scriptFunc = triggerScript.scriptFunc;

		return vobPtr;
	};

	return 0;
};
