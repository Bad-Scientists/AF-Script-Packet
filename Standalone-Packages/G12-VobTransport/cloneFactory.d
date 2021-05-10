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

func int CloneObject__VobTransport (var int vobPtr) {
	var zCDecal decal;
	var zCVob vob;
	var oCItem itm;
	var oCMobContainer mobContainer;
	var oCMobFire mobFire;
	var oCMobDoor mobDoor;
	var oCMobInter mobLadder;
	var oCMobLockable mobLockable;
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
		oCMobInter		supported
		oCMob			supported

		zCTrigger
		oCTriggerScript

	*/
	//zCDecal (TGA textures)
	if (Hlp_Is_zCDecal (vobPtr)) {
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
		instName = oCItem_GetInstanceName (Hlp_GetInstanceID (itm));

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

		newMobContainer._oCMob_name = mobContainer._oCMob_name;
		newMobContainer._oCMob_bitfield = mobContainer._oCMob_bitfield;
		newMobContainer._oCMob_visualDestroyed = mobContainer._oCMob_visualDestroyed;
		newMobContainer._oCMob_ownerStr = mobContainer._oCMob_ownerStr;
		newMobContainer._oCMob_ownerGuildStr = mobContainer._oCMob_ownerGuildStr;
		newMobContainer._oCMob_owner = mobContainer._oCMob_owner;
		newMobContainer._oCMob_ownerGuild = mobContainer._oCMob_ownerGuild;
		newMobContainer._oCMob_focusNameIndex = mobContainer._oCMob_focusNameIndex;

		newMobContainer._oCMobInter_triggerTarget = mobContainer._oCMobInter_triggerTarget;
		newMobContainer._oCMobInter_useWithItem = mobContainer._oCMobInter_useWithItem;
		newMobContainer._oCMobInter_sceme = mobContainer._oCMobInter_sceme;
		newMobContainer._oCMobInter_conditionFunc = mobContainer._oCMobInter_conditionFunc;
		newMobContainer._oCMobInter_onStateFuncName = mobContainer._oCMobInter_onStateFuncName;

		newMobContainer._oCMobLockable_bitfield = mobContainer._oCMobLockable_bitfield;
		newMobContainer._oCMobLockable_keyInstance = mobContainer._oCMobLockable_keyInstance;
		newMobContainer._oCMobLockable_pickLockStr = mobContainer._oCMobLockable_pickLockStr;

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

		newMobFire._oCMob_name = mobFire._oCMob_name;
		newMobFire._oCMob_bitfield = mobFire._oCMob_bitfield;
		newMobFire._oCMob_visualDestroyed = mobFire._oCMob_visualDestroyed;
		newMobFire._oCMob_ownerStr = mobFire._oCMob_ownerStr;
		newMobFire._oCMob_ownerGuildStr = mobFire._oCMob_ownerGuildStr;
		newMobFire._oCMob_owner = mobFire._oCMob_owner;
		newMobFire._oCMob_ownerGuild = mobFire._oCMob_ownerGuild;
		newMobFire._oCMob_focusNameIndex = mobFire._oCMob_focusNameIndex;

		newMobFire._oCMobInter_triggerTarget = mobFire._oCMobInter_triggerTarget;
		newMobFire._oCMobInter_useWithItem = mobFire._oCMobInter_useWithItem;
		newMobFire._oCMobInter_sceme = mobFire._oCMobInter_sceme;
		newMobFire._oCMobInter_conditionFunc = mobFire._oCMobInter_conditionFunc;
		newMobFire._oCMobInter_onStateFuncName = mobFire._oCMobInter_onStateFuncName;

		newMobFire._oCMobInter_bitfield = mobFire._oCMobInter_bitfield;

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
		
		newMobDoor._oCMob_name = mobDoor._oCMob_name;
		newMobDoor._oCMob_bitfield = mobDoor._oCMob_bitfield;
		newMobDoor._oCMob_visualDestroyed = mobDoor._oCMob_visualDestroyed;
		newMobDoor._oCMob_ownerStr = mobDoor._oCMob_ownerStr;
		newMobDoor._oCMob_ownerGuildStr = mobDoor._oCMob_ownerGuildStr;
		newMobDoor._oCMob_owner = mobDoor._oCMob_owner;
		newMobDoor._oCMob_ownerGuild = mobDoor._oCMob_ownerGuild;
		newMobDoor._oCMob_focusNameIndex = mobDoor._oCMob_focusNameIndex;

		newMobDoor._oCMobInter_triggerTarget = mobDoor._oCMobInter_triggerTarget;
		newMobDoor._oCMobInter_useWithItem = mobDoor._oCMobInter_useWithItem;
		newMobDoor._oCMobInter_sceme = mobDoor._oCMobInter_sceme;
		newMobDoor._oCMobInter_conditionFunc = mobDoor._oCMobInter_conditionFunc;
		newMobDoor._oCMobInter_onStateFuncName = mobDoor._oCMobInter_onStateFuncName;

		newMobDoor._oCMobInter_bitfield = mobDoor._oCMobInter_bitfield;

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

		newMobLadder._oCMob_name = mobLadder._oCMob_name;
		newMobLadder._oCMob_bitfield = mobLadder._oCMob_bitfield;
		newMobLadder._oCMob_visualDestroyed = mobLadder._oCMob_visualDestroyed;
		newMobLadder._oCMob_ownerStr = mobLadder._oCMob_ownerStr;
		newMobLadder._oCMob_ownerGuildStr = mobLadder._oCMob_ownerGuildStr;
		newMobLadder._oCMob_owner = mobLadder._oCMob_owner;
		newMobLadder._oCMob_ownerGuild = mobLadder._oCMob_ownerGuild;
		newMobLadder._oCMob_focusNameIndex = mobLadder._oCMob_focusNameIndex;

		newMobLadder.triggerTarget = mobLadder.triggerTarget;
		newMobLadder.useWithItem = mobLadder.useWithItem;
		newMobLadder.sceme = mobLadder.sceme;
		newMobLadder.conditionFunc = mobLadder.conditionFunc;
		newMobLadder.onStateFuncName = mobLadder.onStateFuncName;

		newMobLadder.bitfield = mobLadder.bitfield;
		
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

		newMobLockable._oCMob_name = mobLockable._oCMob_name;
		newMobLockable._oCMob_bitfield = mobLockable._oCMob_bitfield;
		newMobLockable._oCMob_visualDestroyed = mobLockable._oCMob_visualDestroyed;
		newMobLockable._oCMob_ownerStr = mobLockable._oCMob_ownerStr;
		newMobLockable._oCMob_ownerGuildStr = mobLockable._oCMob_ownerGuildStr;
		newMobLockable._oCMob_owner = mobLockable._oCMob_owner;
		newMobLockable._oCMob_ownerGuild = mobLockable._oCMob_ownerGuild;
		newMobLockable._oCMob_focusNameIndex = mobLockable._oCMob_focusNameIndex;

		newMobLockable._oCMobInter_triggerTarget = mobLockable._oCMobInter_triggerTarget;
		newMobLockable._oCMobInter_useWithItem = mobLockable._oCMobInter_useWithItem;
		newMobLockable._oCMobInter_sceme = mobLockable._oCMobInter_sceme;
		newMobLockable._oCMobInter_conditionFunc = mobLockable._oCMobInter_conditionFunc;
		newMobLockable._oCMobInter_onStateFuncName = mobLockable._oCMobInter_onStateFuncName;

		newMobLockable.bitfield = mobLockable.bitfield;
		newMobLockable.keyInstance = mobLockable.keyInstance;
		newMobLockable.pickLockStr = mobLockable.pickLockStr;
		
		return vobPtr;
	};

	//oCMobInter
	if (Hlp_Is_oCMobInter (vobPtr)) {
		mobInter = _^ (vobPtr);
		
		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mobInter._zCObject_objectName);

		vobPtr = InsertObject ("oCMobInter", objectName, visualName, _@ (mobInter._zCVob_trafoObjToWorld), 0);
		
		var oCMobInter newMobInter; newMobInter = _^ (vobPtr);

		MEM_CopyBytes (_@ (mobInter._zCVob_bitfield), _@ (newMobInter._zCVob_bitfield), 20);

		newMobInter._oCMob_name = mobInter._oCMob_name;
		newMobInter._oCMob_bitfield = mobInter._oCMob_bitfield;
		newMobInter._oCMob_visualDestroyed = mobInter._oCMob_visualDestroyed;
		newMobInter._oCMob_ownerStr = mobInter._oCMob_ownerStr;
		newMobInter._oCMob_ownerGuildStr = mobInter._oCMob_ownerGuildStr;
		newMobInter._oCMob_owner = mobInter._oCMob_owner;
		newMobInter._oCMob_ownerGuild = mobInter._oCMob_ownerGuild;
		newMobInter._oCMob_focusNameIndex = mobInter._oCMob_focusNameIndex;

		newMobInter.triggerTarget = mobInter.triggerTarget;
		newMobInter.useWithItem = mobInter.useWithItem;
		newMobInter.sceme = mobInter.sceme;
		newMobInter.conditionFunc = mobInter.conditionFunc;
		newMobInter.onStateFuncName = mobInter.onStateFuncName;

		newMobInter.bitfield = mobInter.bitfield;

		return vobPtr;
	};

	//oCMob
	if (Hlp_Is_oCMob (vobPtr)) {
		mob = _^ (vobPtr);
		
		visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (mob._zCObject_objectName);

		vobPtr = InsertObject ("oCMob", objectName, visualName, _@ (mob._zCVob_trafoObjToWorld), 0);
		
		var oCMob newMob; newMob = _^ (vobPtr);

		MEM_CopyBytes (_@ (mob._zCVob_bitfield), _@ (newMob._zCVob_bitfield), 20);

		newMob.name = mob.name;
		newMob.bitfield = mob.bitfield;
		newMob.visualDestroyed = mob.visualDestroyed;
		newMob.ownerStr = mob.ownerStr;
		newMob.ownerGuildStr = mob.ownerGuildStr;
		newMob.owner = mob.owner;
		newMob.ownerGuild = mob.ownerGuild;
		newMob.focusNameIndex = mob.focusNameIndex;

		return vobPtr;
	};

	return 0;

	//zCTrigger
	if (Hlp_Is_zCTrigger (vobPtr)) {
		trigger = _^ (vobPtr);
		
		//visualName = Vob_GetVisualName (vobPtr);
		objectName = CloneCreateNewName__VobTransport (trigger._zCObject_objectName);

		vobPtr = InsertTrigger (objectName, _@ (trigger._zCVob_trafoObjToWorld));
		
		var zCTrigger newTrigger; newTrigger = _^ (vobPtr);

		MEM_CopyBytes (_@ (trigger._zCVob_bitfield), _@ (newTrigger._zCVob_bitfield), 20);

		newTrigger.triggerTarget = trigger.triggerTarget;
		newTrigger.bitfield = trigger.bitfield;
		newTrigger.respondToVobName = trigger.respondToVobName;
		newTrigger.numCanBeActivated = trigger.numCanBeActivated;
		newTrigger.retriggerWaitSec = trigger.retriggerWaitSec;
		newTrigger.damageThreshold = trigger.damageThreshold;
		newTrigger.fireDelaySec = trigger.fireDelaySec;
		newTrigger.nextTimeTriggerable = trigger.nextTimeTriggerable;
		newTrigger.savedOtherVob = trigger.savedOtherVob;
		newTrigger.countCanBeActivated = trigger.countCanBeActivated;

		MEM_CopyBytes (_@ (trigger._zCVob_bbox3D_mins), _@ (newTrigger._zCVob_bbox3D_mins), 12);
		MEM_CopyBytes (_@ (trigger._zCVob_bbox3D_maxs), _@ (newTrigger._zCVob_bbox3D_maxs), 12);

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

		newTriggerScript._zCTrigger_triggerTarget = triggerScript._zCTrigger_triggerTarget;
		newTriggerScript._zCTrigger_bitfield = triggerScript._zCTrigger_bitfield;
		newTriggerScript._zCTrigger_respondToVobName = triggerScript._zCTrigger_respondToVobName;
		newTriggerScript._zCTrigger_numCanBeActivated = triggerScript._zCTrigger_numCanBeActivated;
		newTriggerScript._zCTrigger_retriggerWaitSec = triggerScript._zCTrigger_retriggerWaitSec;
		newTriggerScript._zCTrigger_damageThreshold = triggerScript._zCTrigger_damageThreshold;
		newTriggerScript._zCTrigger_fireDelaySec = triggerScript._zCTrigger_fireDelaySec;
		newTriggerScript._zCTrigger_nextTimeTriggerable = triggerScript._zCTrigger_nextTimeTriggerable;
		newTriggerScript._zCTrigger_savedOtherVob = triggerScript._zCTrigger_savedOtherVob;
		newTriggerScript._zCTrigger_countCanBeActivated = triggerScript._zCTrigger_countCanBeActivated;

		newTriggerScript.scriptFunc = triggerScript.scriptFunc;

		MEM_CopyBytes (_@ (triggerScript._zCVob_bbox3D_mins), _@ (newTriggerScript._zCVob_bbox3D_mins), 12);
		MEM_CopyBytes (_@ (triggerScript._zCVob_bbox3D_maxs), _@ (newTriggerScript._zCVob_bbox3D_maxs), 12);
		return vobPtr;
	};

	return 0;
};