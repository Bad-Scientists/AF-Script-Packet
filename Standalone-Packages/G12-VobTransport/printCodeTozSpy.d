/*
 *	This function will generate code that can be copy-pasted from zSpy log an used to insert objects in-game
 */
func void PrintCodeTozSpy__VobTransport ( var int vobPtr) {
	var zCVob vob;
	var oCItem itm;
	var oCMobFire mobFire;
	var oCMobContainer mobContainer;
	var oCMobDoor mobDoor;
	var oCMobInter mobLadder;
	var oCMobLockable mobLockable;
	var oCMob mob;
	var oCMobInter mobInter;
	var zCTrigger trigger;
	var oCTriggerScript triggerScript;

	var string s_objectName;
	var string s_visualName;
	var string s_variableName;

	var string msg;

	if (!vobPtr) { return; };

//--- Setup zSpy output

	var int oldErrorLevel; oldErrorLevel = zERROR_GetFilterLevel ();
	zERROR_SetFilterLevel (3);

//---

	vob = _^ (vobPtr);
	s_objectName = vob._zCObject_objectName;
	s_visualName = Vob_GetVisualName (vobPtr);

	if (STR_Len (s_objectName) == 0) {
		msg = s_objectName;
	} else {
		msg = s_visualName;
	};

	//This should serve as a comment
	msg = ConcatStrings ("//", msg);
	msg = ConcatStrings (msg, " insert code:");
	MEM_Info (msg);

//--- Variable declarations

	MEM_Info ("var int vobPtr;");
	MEM_Info ("var float pos[3];");
	MEM_Info ("var float at[3];");
	MEM_Info ("var float up[3];");
	MEM_Info ("var float right[3];");
	MEM_Info ("var int trafo[16];");
	MEM_Info (STR_EMPTY);
	MEM_Info ("NewTrafo(_@(trafo));");
	MEM_Info (STR_EMPTY);

//--- Print object trafo

	var int vec[3];
	if (zCVob_GetPositionWorldToPos (vobPtr, _@ (vec))) {
		//...
	};

	//pos[0] = 3684.757080; pos[1] = 6424.923340; pos[2] = 32131.988281;
	msg = "pos[0] = ";

	msg = ConcatStrings (msg, toStringF (vec[0]));
	msg = ConcatStrings (msg, "; pos[1] = ");

	msg = ConcatStrings (msg, toStringF (vec[1]));
	msg = ConcatStrings (msg, "; pos[2] = ");

	msg = ConcatStrings (msg, toStringF (vec[2]));
	msg = ConcatStrings (msg, ";");

	MEM_Info (msg);

	MEM_CopyBytes (zCVob_GetAtVectorWorld (vobPtr), _@ (vec), 12);

//---

	msg = "at[0] = ";

	msg = ConcatStrings (msg, toStringF (vec[0]));
	msg = ConcatStrings (msg, "; at[1] = ");

	msg = ConcatStrings (msg, toStringF (vec[1]));
	msg = ConcatStrings (msg, "; at[2] = ");

	msg = ConcatStrings (msg, toStringF (vec[2]));
	msg = ConcatStrings (msg, ";");

	MEM_Info (msg);

	MEM_CopyBytes (zCVob_GetUpVectorWorld (vobPtr), _@ (vec), 12);

//---

	msg = "up[0] = ";

	msg = ConcatStrings (msg, toStringF (vec[0]));
	msg = ConcatStrings (msg, "; up[1] = ");

	msg = ConcatStrings (msg, toStringF (vec[1]));
	msg = ConcatStrings (msg, "; up[2] = ");

	msg = ConcatStrings (msg, toStringF (vec[2]));
	msg = ConcatStrings (msg, ";");

	MEM_Info (msg);

//---

	MEM_CopyBytes (zCVob_GetRightVectorWorld (vobPtr), _@ (vec), 12);

	msg = "right[0] = ";

	msg = ConcatStrings (msg, toStringF (vec[0]));
	msg = ConcatStrings (msg, "; right[1] = ");

	msg = ConcatStrings (msg, toStringF (vec[1]));
	msg = ConcatStrings (msg, "; right[2] = ");

	msg = ConcatStrings (msg, toStringF (vec[2]));
	msg = ConcatStrings (msg, ";");

	MEM_Info (msg);

//--- Put trafo together

	MEM_Info (STR_EMPTY);
	MEM_Info ("vectorPosToTrf (_@f (pos), _@ (trafo));");
	MEM_Info ("zMAT4_SetAtVector (_@ (trafo), _@f (at));");
	MEM_Info ("zMAT4_SetUpVector (_@ (trafo), _@f (up));");
	MEM_Info ("zMAT4_SetRightVector (_@ (trafo), _@f (right));");

	MEM_Info (STR_EMPTY);

//--- Object creation script

	//0x007DB44C const zCVob::`vftable'
	const int zCVob_vtbl_G1 = 8238156;

	//0x0083997C const zCVob::`vftable'
	const int zCVob_vtbl_G2 = 8624508;

	if (Hlp_VobVisual_Is_zCDecal (vobPtr)) {
		MEM_Info ("zCDecal not supported yet.");
	} else
	if (MEM_ReadInt (vobPtr) == MEMINT_SwitchG1G2 (zCVob_vtbl_G1, zCVob_vtbl_G2)) {
		//InsertObject ("zCVob", objectName, visualName, _@ (vob.trafoObjToWorld), 0);
		msg = "vobPtr = InsertObject (";
		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, "zCVob");
		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo), 0);");
		MEM_Info (msg);
	} else
	if (Hlp_Is_oCItem (vobPtr)) {
		//vobPtr = InsertItemPos ("ItFoMuttonRaw", 1, _@f(pos), 0);
		itm = _^ (vobPtr);

		msg = "vobPtr = InsertItem (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, IntToString (itm.amount));
		msg = ConcatStrings (msg, ", _@ (trafo));");
		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobContainer (vobPtr)) {
		//vobPtr = InsertMobContainer ("CRATE_ADDEDBYSCRIPT_01", "CHESTSMALL_OCCRATESMALL.MDS", _@ (trafo));
		msg = "vobPtr = InsertMobContainer (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo));");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobFire (vobPtr)) {
		//vobPtr = InsertMobFire (s_objectName, s_visualName, _@ (trafo));
		msg = "vobPtr = InsertMobFire (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo));");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobDoor (vobPtr)) {
		//vobPtr = InsertMobDoor (objectName, visualName, _@ (trafo));
		msg = "vobPtr = InsertMobDoor (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo));");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobLadder (vobPtr)) {
		//vobPtr = InsertObject ("oCMobLadder", objectName, visualName, _@ (trafo), 0);
		msg = "vobPtr = InsertObject (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, "oCMobLadder");

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo), 0);");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobSwitch (vobPtr)) {
		//vobPtr = InsertObject ("oCMobSwitch", objectName, visualName, _@ (trafo), 0);
		msg = "vobPtr = InsertObject (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, "oCMobSwitch");

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo), 0);");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobWheel (vobPtr)) {
		//vobPtr = InsertObject ("oCMobWheel", objectName, visualName, _@ (trafo), 0);
		msg = "vobPtr = InsertObject (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, "oCMobWheel");

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo), 0);");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobBed (vobPtr)) {
		//vobPtr = InsertObject ("oCMobBed", objectName, visualName, _@ (trafo), 0);
		msg = "vobPtr = InsertObject (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, "oCMobBed");

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo), 0);");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMobInter (vobPtr)) {
		//vobPtr = InsertObject ("oCMobInter", objectName, visualName, _@ (trafo), 0);
		msg = "vobPtr = InsertObject (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, "oCMobInter");

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo), 0);");

		MEM_Info (msg);
	} else
	if (Hlp_Is_oCMob (vobPtr)) {
		//vobPtr = InsertObject ("oCMOB", objectName, visualName, _@ (trafo), 0);
		msg = "vobPtr = InsertObject (";
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, "oCMOB");

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_objectName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", ");
		msg = ConcatStrings (msg, BtoC(34));

		msg = ConcatStrings (msg, s_visualName);

		msg = ConcatStrings (msg, BtoC(34));
		msg = ConcatStrings (msg, ", _@ (trafo), 0);");

		MEM_Info (msg);
	//} else
	//if (Hlp_Is_zCTrigger (vobPtr)) {
	//
	//} else
	//if (Hlp_Is_oCTriggerScript (vobPtr)) {
	//
	} else {
		MEM_Info ("This object is not yet supported.");
	};

//--- oCMob

	if (Hlp_Is_oCMob (vobPtr)) {
		mob = _^ (vobPtr);

		//mob name
		if (mob.focusNameIndex > -1) {
			s_variableName = GetSymbolName (mob.focusNameIndex);

			msg = "oCMob_SetMobName (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, s_variableName);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};

		//ownerStr & ownerGuildStr
		if ((STR_Len (mob.ownerStr)) || (STR_Len (mob.ownerGuildStr))) {
			//oCMob_SetOwnerStr (vobPtr, mob.ownerStr, mob.ownerGuildStr);

			msg = "oCMob_SetOwnerStr (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mob.ownerStr);

			msg = ConcatStrings (msg, BtoC(34));
			msg = ConcatStrings (msg, ", ");
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mob.ownerGuildStr);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};
	};

//--- oCMobInter

	if (Hlp_Is_oCMobInter (vobPtr)) {
		mobInter = _^ (vobPtr);

		//triggerTarget
		if (STR_Len (mobInter.triggerTarget)) {
			//oCMobInter_SetTriggerTarget (vobPtr, mobInter.triggerTarget);

			msg = "oCMobInter_SetTriggerTarget (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobInter.triggerTarget);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};

		//useWithItem
		if (STR_Len (mobInter.useWithItem)) {
			//oCMobInter_SetUseWithItem (vobPtr, mobInter.useWithItem);

			msg = "oCMobInter_SetUseWithItem (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobInter.useWithItem);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};

		//sceme
		if (STR_Len (mobInter.sceme)) {
			//oCMobInter_SetSceme (vobPtr, mobInter.sceme);

			msg = "oCMobInter_SetSceme (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobInter.sceme);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};

		//conditionFunc
		if (STR_Len (mobInter.conditionFunc)) {
			//oCMobInter_SetConditionFunc (vobPtr, mobInter.conditionFunc);

			msg = "oCMobInter_SetConditionFunc (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobInter.conditionFunc);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};

		//onStateFuncName
		if (STR_Len (mobInter.onStateFuncName)) {
			//oCMobInter_SetOnStateFuncName (vobPtr, mobInter.onStateFuncName);

			msg = "oCMobInter_SetOnStateFuncName (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobInter.onStateFuncName);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};
	};

//--- oCMobLockable (oCMobContainer, oCMobDoor)

	if (Hlp_Is_oCMobLockable (vobPtr)) {
		mobLockable = _^ (vobPtr);

		//keyInstance
		if (STR_Len (mobLockable.keyInstance)) {
			//oCMobLockable_SetKeyInstance (vobPtr, mobLockable.keyInstance);

			msg = "oCMobLockable_SetKeyInstance (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobLockable.keyInstance);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};

		//pickLockStr
		if (STR_Len (mobLockable.pickLockStr)) {
			//oCMobLockable_SetPickLockStr (vobPtr, mobLockable.pickLockStr);

			msg = "oCMobLockable_SetPickLockStr (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobLockable.pickLockStr);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};
	};

//--- oCMobDoor

	if (Hlp_Is_oCMobDoor (vobPtr)) {
		mobDoor = _^ (vobPtr);

		//addName
		if (STR_Len (mobDoor.addName)) {
			//oCMobDoor_SetAddName (vobPtr, mobDoor.addName);

			msg = "oCMobDoor_SetAddName (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobDoor.addName);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};
	};

//--- oCMobFire

	if (Hlp_Is_oCMobFire (vobPtr)) {
		mobFire = _^ (vobPtr);

		//fireSlot
		if (STR_Len (mobFire.fireSlot)) {
			//oCMobFire_SetFireSlot (vobPtr, mobFire.fireSlot);

			msg = "oCMobFire_SetFireSlot (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobFire.fireSlot);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};

		//fireVobtreeName
		if (STR_Len (mobFire.fireVobtreeName)) {
			//oCMobFire_SetFireVobtreeName (vobPtr, mobFire.fireVobtreeName);

			msg = "oCMobFire_SetFireVobtreeName (vobPtr, ";
			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, mobFire.fireVobtreeName);

			msg = ConcatStrings (msg, BtoC(34));

			msg = ConcatStrings (msg, ");");

			MEM_Info (msg);
		};
	};

	zERROR_SetFilterLevel (oldErrorLevel);
};
