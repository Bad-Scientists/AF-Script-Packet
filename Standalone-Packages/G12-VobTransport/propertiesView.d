func void DisplayProperties__VobTransport () {
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

	var int fontHeight;
	var int posX;
	var int posY;

	var int spaceWidth;

	var int viewWidth;
	var int scaleF;

	if (vobTransportMode != vobTransportMode_Idle) {
		spaceWidth = Font_GetStringWidth (STR_SPACE, vobTransportFontName);
		spaceWidth = Print_ToVirtual (spaceWidth, PS_X);
	};

	if (vobTransportMode == vobTransportMode_Init)
	|| (vobTransportMode == vobTransportMode_SelectVob)
	|| (vobTransportMode == vobTransportMode_SelectNext)
	|| (vobTransportMode == vobTransportMode_SelectPrev)
	|| (vobTransportMode == vobTransportMode_SelectConfirm)
	|| (vobTransportMode == vobTransportMode_Movement)
	|| (vobTransportMode == vobTransportMode_Transform)
	{
		if (!vobTransportVobPtr) { return; };

		//Prevent unnecessary updates
		//if (lastVobTPtr == vobTransportVobPtr) {
		//	return;
		//};

		//lastVobTPtr = vobTransportVobPtr;		//zCObject

		var string s;
		var string s_vtbl; s_vtbl = STR_EMPTY;
		var string s_objectName; s_objectName = STR_EMPTY;
		var string s_visualName; s_visualName = STR_EMPTY;

		//zCVob
		var string s_collStatic; s_collStatic = STR_EMPTY;
		var string s_collDynamic; s_collDynamic = STR_EMPTY;
		var string s_vobType; s_vobType = STR_EMPTY;

		//oCMob
		var string s_mobName; s_mobName = STR_EMPTY;
		var string s_ownerStr; s_ownerStr = STR_EMPTY;
		var string s_ownerGuildStr; s_ownerGuildStr = STR_EMPTY;

		//oCMobInter
		var string s_triggerTarget; s_triggerTarget = STR_EMPTY;
		var string s_useWithItem; s_useWithItem = STR_EMPTY;
		var string s_sceme; s_sceme = STR_EMPTY;
		var string s_conditionFunc; s_conditionFunc = STR_EMPTY;
		var string s_onStateFuncName; s_onStateFuncName = STR_EMPTY;

		//oCMobContainer
		var string s_keyInstance; s_keyInstance = STR_EMPTY;
		var string s_pickLockStr; s_pickLockStr = STR_EMPTY;

		//oCMobFire
		var string s_fireSlot; s_fireSlot = STR_EMPTY;
		var string s_fireVobtreeName; s_fireVobtreeName = STR_EMPTY;

		//oCMobDoor
		var string s_addName; s_addName = STR_EMPTY;

		//zCTrigger
		var string s_respondToVobName; s_respondToVobName = STR_EMPTY;

		//oCTriggerScript
		var string s_scriptFunc; s_scriptFunc = STR_EMPTY;

		var string s_Title; s_Title = STR_EMPTY;

		var int collStatic; collStatic = 0;
		var int collDynamic; collDynamic = 0;

		var int vtbl; vtbl = 0;

		//--> Common attributes
		vob = _^ (vobTransportVobPtr);
		vtbl = MEM_ReadInt (vobTransportVobPtr);

		s_objectName = vob._zCObject_objectName;
		s_objectName = ConcatStrings ("name: ", s_objectName);

		s_visualName = Vob_GetVisualName (vobTransportVobPtr);
		s_visualName = ConcatStrings ("visual: ", s_visualName);

		collStatic = ((vob.bitfield[0] & zCVob_bitfield0_collDetectionStatic) == zCVob_bitfield0_collDetectionStatic);
		collDynamic = ((vob.bitfield[0] & zCVob_bitfield0_collDetectionDynamic) == zCVob_bitfield0_collDetectionDynamic);

		s_collStatic = ConcatStrings ("coll static: ", IntToString (collStatic));
		s_collDynamic = ConcatStrings ("coll dynamic: ", IntToString (collDynamic));
		//<--

		if (Hlp_Is_zCVob__VobTransport (vobTransportVobPtr)) {
			s_vtbl = ConcatStrings ("zCVob ", IntToString (vtbl));
			s_vobType = ConcatStrings ("vob type: ", IntToString (vob.type));
		} else

		//oCItem
		if (Hlp_Is_oCItem (vobTransportVobPtr)) {
			itm = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCItem ", IntToString (vtbl));
		} else

		//oCMobContainer - chest
		if (Hlp_Is_oCMobContainer (vobTransportVobPtr)) {
			mobContainer = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMobContainer ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobContainer._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobContainer._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobContainer._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobContainer._oCMobInter_triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobContainer._oCMobInter_useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobContainer._oCMobInter_sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobContainer._oCMobInter_conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobContainer._oCMobInter_onStateFuncName);

			s_keyInstance = ConcatStrings ("keyInstance: ", mobContainer._oCMobLockable_keyInstance);
			s_pickLockStr = ConcatStrings ("pickLockStr: ", mobContainer._oCMobLockable_pickLockStr);
		} else

		//oCMobFire
		if (Hlp_Is_oCMobFire (vobTransportVobPtr)) {
			mobFire = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMobFire ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobFire._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobFire._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobFire._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobFire._oCMobInter_triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobFire._oCMobInter_useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobFire._oCMobInter_sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobFire._oCMobInter_conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobFire._oCMobInter_onStateFuncName);

			s_fireSlot = ConcatStrings ("fireSlot: ", mobFire.fireSlot);
			s_fireVobtreeName = ConcatStrings ("fireVobtreeName: ", mobFire.fireVobtreeName);
		} else

		//oCMobDoor
		if (Hlp_Is_oCMobDoor (vobTransportVobPtr)) {
			mobDoor = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("h@42B3F5 oCMobDoor h@FFFFFF ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobDoor._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobDoor._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobDoor._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobDoor._oCMobInter_triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobDoor._oCMobInter_useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobDoor._oCMobInter_sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobDoor._oCMobInter_conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobDoor._oCMobInter_onStateFuncName);

			s_keyInstance = ConcatStrings ("keyInstance: ", mobDoor._oCMobLockable_keyInstance);
			s_pickLockStr = ConcatStrings ("pickLockStr: ", mobDoor._oCMobLockable_pickLockStr);

			s_addName = ConcatStrings ("addName: ", mobDoor.addName);
		} else

		//oCMobLadder
		if (Hlp_Is_oCMobLadder (vobTransportVobPtr)) {
			mobLadder = _^ (vobTransportVobPtr);

			s_vtbl = ConcatStrings ("oCMobLadder ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobLadder._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobLadder._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobLadder._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobLadder.triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobLadder.useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobLadder.sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobLadder.conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobLadder.onStateFuncName);
		} else

		//oCMobLockable
		if (Hlp_Is_oCMobLockable (vobTransportVobPtr)) {
			mobLockable = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMobLockable ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobLockable._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobLockable._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobLockable._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobLockable._oCMobInter_triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobLockable._oCMobInter_useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobLockable._oCMobInter_sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobLockable._oCMobInter_conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobLockable._oCMobInter_onStateFuncName);

			s_keyInstance = ConcatStrings ("keyInstance: ", mobLockable.keyInstance);
			s_pickLockStr = ConcatStrings ("pickLockStr: ", mobLockable.pickLockStr);
		} else

		//oCMobSwitch
		if (Hlp_Is_oCMobSwitch (vobTransportVobPtr)) {
			mobInter = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMobSwitch ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobInter._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobInter._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobInter._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobInter.triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobInter.useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobInter.sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobInter.conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobInter.onStateFuncName);
		} else

		//oCMobWheel
		if (Hlp_Is_oCMobWheel (vobTransportVobPtr)) {
			mobInter = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMobWheel ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobInter._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobInter._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobInter._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobInter.triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobInter.useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobInter.sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobInter.conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobInter.onStateFuncName);
		} else

		//oCMobBed
		if (Hlp_Is_oCMobBed (vobTransportVobPtr)) {
			mobInter = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMobBed ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobInter._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobInter._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobInter._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobInter.triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobInter.useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobInter.sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobInter.conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobInter.onStateFuncName);
		} else

		//oCMobInter
		if (Hlp_Is_oCMobInter (vobTransportVobPtr)) {
			mobInter = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMobInter ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mobInter._oCMob_name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mobInter._oCMob_ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mobInter._oCMob_ownerGuildStr);

			s_triggerTarget = ConcatStrings ("triggerTarget: ", mobInter.triggerTarget);
			s_useWithItem = ConcatStrings ("useWithItem: ", mobInter.useWithItem);
			s_sceme = ConcatStrings ("sceme: ", mobInter.sceme);
			s_conditionFunc = ConcatStrings ("conditionFunc: ", mobInter.conditionFunc);
			s_onStateFuncName = ConcatStrings ("onStateFuncName: ", mobInter.onStateFuncName);
		} else

		//oCMob
		if (Hlp_Is_oCMob (vobTransportVobPtr)) {
			mob = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("oCMob ", IntToString (vtbl));

			s_mobName = ConcatStrings ("mob name: ", mob.name);
			s_ownerStr = ConcatStrings ("ownerStr: ", mob.ownerStr);
			s_ownerGuildStr = ConcatStrings ("ownerGuildStr: ", mob.ownerGuildStr);
		} else

		//zCTrigger
		if (Hlp_Is_zCTrigger (vobTransportVobPtr)) {
			trigger = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("zCTrigger ", IntToString (vtbl));

			s_triggerTarget = ConcatStrings ("triggerTarget: ", trigger.triggerTarget);
			s_respondToVobName = ConcatStrings ("respondToVobName: ", trigger.respondToVobName);
		} else

		//oCTriggerScript
		if (Hlp_Is_oCTriggerScript (vobTransportVobPtr)) {
			triggerScript = _^ (vobTransportVobPtr);
			s_vtbl = ConcatStrings ("zCTrigger ", IntToString (vtbl));

			s_triggerTarget = ConcatStrings ("triggerTarget: ", triggerScript._zCTrigger_triggerTarget);
			s_respondToVobName = ConcatStrings ("respondToVobName: ", triggerScript._zCTrigger_respondToVobName);

			s_scriptFunc = ConcatStrings ("scriptFunc: ", triggerScript.scriptFunc);
		};

		//Default - white color
		var int titleColor; titleColor = RGBA (255, 255, 255, 255);


		//Create
		if (!vobTransportPropertiesViewVisible) {
			scaleF = _getInterfaceScaling ();

			//--- hVobTransportPropertiesViewFrame
			viewWidth = vobTransportPropertiesView_WidthPxl;
			viewWidth = Print_ToVirtual (viewWidth, PS_X);
			viewWidth = roundf (mulf (mkf (viewWidth), scaleF));

			fontHeight = Print_GetFontHeight (vobTransportFontName);
			fontHeight = Print_ToVirtual (fontHeight, PS_Y);

			if (vobTransportPropertiesView_PPosX == -1) {
				posX = (PS_VMax - viewWidth) / 2;
			} else {
				posX = Print_ToVirtual (vobTransportPropertiesView_PPosX, PS_X);
			};

			if (vobTransportPropertiesView_VPosX > -1) {
				posX = vobTransportPropertiesView_VPosX;
			};

			if (vobTransportPropertiesView_PPosY == -1) {
				posY = (PS_VMax / 2 - (vobTransportPropertiesView_Lines * fontHeight) / 2);
			} else {
				posY = Print_ToVirtual (vobTransportPropertiesView_PPosY, PS_Y);
			};

			if (vobTransportPropertiesView_VPosY > -1) {
				posY = vobTransportPropertiesView_VPosY;
			};

			if (!Hlp_IsValidHandle (hVobTransportPropertiesViewFrame)) {
				hVobTransportPropertiesViewFrame  = View_Create (posX, posY, posX + viewWidth, posY + vobTransportPropertiesView_Lines * fontHeight);
				View_SetTexture (hVobTransportPropertiesViewFrame, vobTransportViewTexture);
			};

			View_Open_Safe (hVobTransportPropertiesViewFrame);
			View_MoveTo_Safe (hVobTransportPropertiesViewFrame, posX, posY);
			View_Resize_Safe (hVobTransportPropertiesViewFrame, viewWidth, vobTransportPropertiesView_Lines * fontHeight);

			//--- hVobTransportPropertiesViewHeader
			if (!Hlp_IsValidHandle (hVobTransportPropertiesViewHeader)) {
				hVobTransportPropertiesViewHeader = View_Create (posX, posY, posX + viewWidth, posY + 1 * fontHeight);
				View_AddText (hVobTransportPropertiesViewHeader, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportPropertiesViewHeader);
			View_MoveTo_Safe (hVobTransportPropertiesViewHeader, posX, posY);
			View_Resize_Safe (hVobTransportPropertiesViewHeader, viewWidth, 1 * fontHeight);

			posY += fontHeight;

			//--- hVobTransportPropertiesView
			if (!Hlp_IsValidHandle (hVobTransportPropertiesView)) {
				hVobTransportPropertiesView = View_Create (posX, posY, posX + viewWidth, posY + vobTransportPropertiesView_Lines * fontHeight);
				View_AddText (hVobTransportPropertiesView, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportPropertiesView);
			View_MoveTo_Safe (hVobTransportPropertiesView, posX, posY);
			View_Resize_Safe (hVobTransportPropertiesView, viewWidth, vobTransportPropertiesView_Lines * fontHeight);

			vobTransportPropertiesViewVisible = TRUE;

			//--- Delete texts
			View_DeleteText (hVobTransportPropertiesViewHeader);
			View_DeleteText (hVobTransportPropertiesView);
		};

		//Header
		//View_SetFontColor (hVobTransportPropertiesViewHeader, titleColor);
		View_SetTextMarginAndFontColor (hVobTransportPropertiesViewHeader, s_Title, titleColor, spaceWidth * 2);

		//Properties
		var int sbb; sbb = SB_Get();
		const int sb0 = 0;
		if (!sb0) {
			sb0 = SB_New();
		};

		SB_Use(sb0);
		if (vobTransportMode == vobTransportMode_SelectVob) {
			s_Title = vobTransportView_TitleSelection;

			SB (vobTransportView_InstructionMove);
			SB (Print_LineSeperator);

			SB (vobTransportView_InstructionClone);
			SB (Print_LineSeperator);

			SB (vobTransportView_InstructionTransform);
			SB (Print_LineSeperator);

			//-->
			//These instructions are pretty much pointless - everyone knows this :)
			//SB (vobTransportView_InstructionDelete);
			//SB (Print_LineSeperator);

			//SB (vobTransportView_InstructionCancel);
			//SB (Print_LineSeperator);
			//<--

			//Will be displayed only for items (further below)
			//SB (vobTransportView_InstructionDropItem);
			//SB (Print_LineSeperator);
		};

		if (vobTransportMode == vobTransportMode_Movement) {
			s_Title = vobTransportView_TitleMovement;

			SB (vobTransportView_InstructionConfirm);
			SB (Print_LineSeperator);

			SB (vobTransportView_InstructionTransform);
			SB (Print_LineSeperator);

			//Align to surface only in case that elevation mode is off ...
			if (vobTransportAlignObject == vobTransportAlignObject_Dont) {
				SB (vobTransportView_InstructionDontAlign);
				SB (Print_LineSeperator);
			} else
			if (vobTransportAlignObject == vobTransportAlignObject_InFront) {
				SB (vobTransportView_InstructionAlignInFront);
				SB (Print_LineSeperator);
			} else
			if (vobTransportAlignObject == vobTransportAlignObject_SetToFloor) {
				SB (vobTransportView_InstructionAlignToFloor);
				SB (Print_LineSeperator);
			};
		};

		if (vobTransportMode == vobTransportMode_Transform) {
			s_Title = vobTransportView_TitleTransform;

			s = ConcatStrings (vobTransportView_InstructionRotateXYZ, " (");
			if (vobTransportTransformationMode == vobTransportTransformation_RotX) {
				s = ConcatStrings (s, "X");
			} else if (vobTransportTransformationMode == vobTransportTransformation_RotY) {
				s = ConcatStrings (s, "Y");
			} else if (vobTransportTransformationMode == vobTransportTransformation_RotZ) {
				s = ConcatStrings (s, "Z");
			};
			s = ConcatStrings (s, ")");

			SB (s);
			SB (Print_LineSeperator);

			SB (vobTransportView_InstructionSpeed);
			SBi (vobTransportMovementSpeed);
			SB (Print_LineSeperator);

			//X axis
			if (vobTransportTransformationMode == vobTransportTransformation_RotX) {
				titleColor = RGBA (255, 128, 000, 255);
			} else if (vobTransportTransformationMode == vobTransportTransformation_RotY) {
				titleColor = RGBA (255, 255, 255, 255);
			} else if (vobTransportTransformationMode == vobTransportTransformation_RotZ) {
				titleColor = RGBA (255, 255, 000, 255);
			};

			SetFontColor (titleColor);
		};

		if ((vobTransportMode == vobTransportMode_SelectVob) || (vobTransportMode == vobTransportMode_Movement)) {
			if (Hlp_Is_oCItem (vobTransportVobPtr)) {
				SB (vobTransportView_InstructionDropItem);
				SB (Print_LineSeperator);
			};
		};

		SB (Print_LineSeperator);
		SB (Print_LineSeperator);
		SB (s_vtbl);
		SB (Print_LineSeperator);
		SB (s_objectName);
		SB (Print_LineSeperator);
		SB (s_visualName);
		SB (Print_LineSeperator);
		SB (s_collStatic);
		SB (Print_LineSeperator);
		SB (s_collDynamic);
		SB (Print_LineSeperator);
		SB (s_vobType);
		SB (Print_LineSeperator);

		SB (s_mobName);
		SB (Print_LineSeperator);
		SB (s_ownerStr);
		SB (Print_LineSeperator);
		SB (s_ownerGuildStr);
		SB (Print_LineSeperator);

		SB (s_triggerTarget);
		SB (Print_LineSeperator);
		SB (s_useWithItem);
		SB (Print_LineSeperator);
		SB (s_sceme);
		SB (Print_LineSeperator);
		SB (s_conditionFunc);
		SB (Print_LineSeperator);
		SB (s_onStateFuncName);
		SB (Print_LineSeperator);

		if (Hlp_Is_oCMobContainer (vobTransportVobPtr)) {
			SB (s_keyInstance);
			SB (Print_LineSeperator);
			SB (s_pickLockStr);
			SB (Print_LineSeperator);
		} else
		if (Hlp_Is_oCMobFire (vobTransportVobPtr)) {
			SB (s_fireSlot);
			SB (Print_LineSeperator);
			SB (s_fireVobtreeName);
			SB (Print_LineSeperator);
		} else
		if (Hlp_Is_oCMobDoor (vobTransportVobPtr)) {
			SB (s_keyInstance);
			SB (Print_LineSeperator);
			SB (s_pickLockStr);
			SB (Print_LineSeperator);

			SB (s_addName);
			SB (Print_LineSeperator);
		} else
		if (Hlp_Is_zCTrigger (vobTransportVobPtr)) {
			SB (s_respondToVobName);
			SB (Print_LineSeperator);
		} else
		if (Hlp_Is_oCTriggerScript (vobTransportVobPtr)) {
			SB (s_scriptFunc);
			SB (Print_LineSeperator);
		};

		s = SB_ToString();
		SB_Clear();
		SB_Use(sbb);

		View_SetTextMargin (hVobTransportPropertiesView, s, spaceWidth * 2);

	} else {
		if (vobTransportPropertiesViewVisible) {
			View_Close_Safe (hVobTransportPropertiesView);
			View_Close_Safe (hVobTransportPropertiesViewHeader);
			View_Close_Safe (hVobTransportPropertiesViewFrame);

			//lastVobTPtr = 0;
			vobTransportPropertiesViewVisible = FALSE;
		};
	};

	if (vobTransportMode == vobTransportMode_BuyVob) {
		if (!vobTransportBuyVobViewVisible) {
			scaleF = _getInterfaceScaling ();

			//--- hVobTransportPropertiesViewFrame
			viewWidth = vobTransportBuyVobView_WidthPxl;
			viewWidth = Print_ToVirtual (viewWidth, PS_X);
			viewWidth = roundf (mulf (mkf (viewWidth), scaleF));

			fontHeight = Print_GetFontHeight (vobTransportFontName);
			fontHeight = Print_ToVirtual (fontHeight, PS_Y);

			if (vobTransportBuyVobViewPPosX == -1) {
				posX = (PS_VMax - viewWidth) / 2;
			} else {
				posX = Print_ToVirtual (vobTransportBuyVobViewPPosX, PS_X);
			};

			if (vobTransportBuyVobViewVPosX > -1) {
				posX = vobTransportBuyVobViewVPosX;
			};

			if (vobTransportBuyVobViewPPosY == -1) {
				posY = (PS_VMax / 2 - (vobTransportBuyVobView_Lines * fontHeight) / 2);
			} else {
				posY = Print_ToVirtual (vobTransportBuyVobViewPPosY, PS_Y);
			};

			if (vobTransportBuyVobViewVPosY > -1) {
				posY = vobTransportBuyVobViewVPosY;
			};

			if (!Hlp_IsValidHandle (hVobTransportBuyVobViewFrame)) {
				hVobTransportBuyVobViewFrame  = View_Create (posX, posY, posX + viewWidth, posY + (vobTransportBuyVobView_Lines * fontHeight) + spaceWidth);
				View_SetTexture (hVobTransportBuyVobViewFrame, vobTransportViewTexture);
			};

			View_Open_Safe (hVobTransportBuyVobViewFrame);
			View_MoveTo_Safe (hVobTransportBuyVobViewFrame, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobViewFrame, viewWidth, vobTransportBuyVobView_Lines * fontHeight);

			posY += (spaceWidth);

			//--- hVobTransportBuyVobView_Description
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Description)) {
				hVobTransportBuyVobView_Description = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Description, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Description);
			View_MoveTo_Safe (hVobTransportBuyVobView_Description, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Description, viewWidth, fontHeight);

			posY += (fontHeight);

			//--- hVobTransportBuyVobView_Line1
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Line1)) {
				hVobTransportBuyVobView_Line1 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Line1, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Line1);
			View_MoveTo_Safe (hVobTransportBuyVobView_Line1, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Line1, viewWidth, fontHeight);

			//--- hVobTransportBuyVobView_Count1
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Count1)) {
				hVobTransportBuyVobView_Count1 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Count1, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Count1);
			View_MoveTo_Safe (hVobTransportBuyVobView_Count1, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Count1, viewWidth, fontHeight);

			posY += (fontHeight);

			//--- hVobTransportBuyVobView_Line2
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Line2)) {
				hVobTransportBuyVobView_Line2 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Line2, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Line2);
			View_MoveTo_Safe (hVobTransportBuyVobView_Line2, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Line2, viewWidth, fontHeight);

			//--- hVobTransportBuyVobView_Count2
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Count2)) {
				hVobTransportBuyVobView_Count2 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Count2, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Count2);
			View_MoveTo_Safe (hVobTransportBuyVobView_Count2, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Count2, viewWidth, fontHeight);

			posY += (fontHeight);

			//--- hVobTransportBuyVobView_Line3
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Line3)) {
				hVobTransportBuyVobView_Line3 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Line3, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Line3);
			View_MoveTo_Safe (hVobTransportBuyVobView_Line3, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Line3, viewWidth, fontHeight);

			//--- hVobTransportBuyVobView_Count3
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Count3)) {
				hVobTransportBuyVobView_Count3 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Count3, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Count3);
			View_MoveTo_Safe (hVobTransportBuyVobView_Count3, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Count3, viewWidth, fontHeight);

			posY += (fontHeight);

			//--- hVobTransportBuyVobView_Line4
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Line4)) {
				hVobTransportBuyVobView_Line4 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Line4, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Line4);
			View_MoveTo_Safe (hVobTransportBuyVobView_Line4, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Line4, viewWidth, fontHeight);

			//--- hVobTransportBuyVobView_Count4
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Count4)) {
				hVobTransportBuyVobView_Count4 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Count4, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Count4);
			View_MoveTo_Safe (hVobTransportBuyVobView_Count4, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Count4, viewWidth, fontHeight);

			posY += (fontHeight);

			//--- hVobTransportBuyVobView_Line5
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Line5)) {
				hVobTransportBuyVobView_Line5 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Line5, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Line5);
			View_MoveTo_Safe (hVobTransportBuyVobView_Line5, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Line5, viewWidth, fontHeight);

			//--- hVobTransportBuyVobView_Count5
			if (!Hlp_IsValidHandle (hVobTransportBuyVobView_Count5)) {
				hVobTransportBuyVobView_Count5 = View_Create (posX, posY, posX + viewWidth, posY + (1 * fontHeight) + spaceWidth);
				View_AddText (hVobTransportBuyVobView_Count5, 00, 00, STR_EMPTY, vobTransportFontName);
			};

			View_Open_Safe (hVobTransportBuyVobView_Count5);
			View_MoveTo_Safe (hVobTransportBuyVobView_Count5, posX, posY);
			View_Resize_Safe (hVobTransportBuyVobView_Count5, viewWidth, fontHeight);

			posY += (fontHeight);

			vobTransportBuyVobViewVisible = TRUE;
		};

		//Description
		View_SetTextMargin (hVobTransportBuyVobView_Description, sVobTransportBuyVobView_Description, 0);		//0 - align center

		//Item-like view
		View_SetTextMargin (hVobTransportBuyVobView_Line1, sVobTransportBuyVobView_Line1, spaceWidth * 2);		//positive value - align left with margin
		View_SetTextMarginAndFontColor (hVobTransportBuyVobView_Count1, sVobTransportBuyVobView_Count1, colorVobTransportBuyVobView_Count1, - spaceWidth * 2);	//negative value - align right with margin

		View_SetTextMargin (hVobTransportBuyVobView_Line2, sVobTransportBuyVobView_Line2, spaceWidth * 2);
		View_SetTextMarginAndFontColor (hVobTransportBuyVobView_Count2, sVobTransportBuyVobView_Count2, colorVobTransportBuyVobView_Count2, - spaceWidth * 2);

		View_SetTextMargin (hVobTransportBuyVobView_Line3, sVobTransportBuyVobView_Line3, spaceWidth * 2);
		View_SetTextMarginAndFontColor (hVobTransportBuyVobView_Count3, sVobTransportBuyVobView_Count3, colorVobTransportBuyVobView_Count3, - spaceWidth * 2);

		View_SetTextMargin (hVobTransportBuyVobView_Line4, sVobTransportBuyVobView_Line4, spaceWidth * 2);
		View_SetTextMarginAndFontColor (hVobTransportBuyVobView_Count4, sVobTransportBuyVobView_Count4, colorVobTransportBuyVobView_Count4, - spaceWidth * 2);

		View_SetTextMargin (hVobTransportBuyVobView_Line5, sVobTransportBuyVobView_Line5, spaceWidth * 2);
		View_SetTextMarginAndFontColor (hVobTransportBuyVobView_Count5, sVobTransportBuyVobView_Count5, colorVobTransportBuyVobView_Count5, - spaceWidth * 2);
	} else {
		if (vobTransportBuyVobViewVisible) {
			View_Close_Safe (hVobTransportBuyVobView_Description);

			View_Close_Safe (hVobTransportBuyVobView_Line1);
			View_Close_Safe (hVobTransportBuyVobView_Line2);
			View_Close_Safe (hVobTransportBuyVobView_Line3);
			View_Close_Safe (hVobTransportBuyVobView_Line4);
			View_Close_Safe (hVobTransportBuyVobView_Line5);

			View_Close_Safe (hVobTransportBuyVobView_Count1);
			View_Close_Safe (hVobTransportBuyVobView_Count2);
			View_Close_Safe (hVobTransportBuyVobView_Count3);
			View_Close_Safe (hVobTransportBuyVobView_Count4);
			View_Close_Safe (hVobTransportBuyVobView_Count5);

			View_Close_Safe (hVobTransportBuyVobViewFrame);

			vobTransportBuyVobViewVisible = FALSE;
		};
	};
};
