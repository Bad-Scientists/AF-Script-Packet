instance Puppet (C_Npc) {};

var int puppetMasterEnabled;

var string puppetNode;
var int puppetNodeIndex;

var int puppetNodeVobPtr;

const int HUMAN_NODENAMES_MAX = 25;

const string HUMAN_NODENAMES [HUMAN_NODENAMES_MAX] = {
	"BIP01",
	"BIP01 PELVIS",
	"BIP01 SPINE",
	"BIP01 SPINE1",
	"BIP01 SPINE2",
	"BIP01 NECK",
	"BIP01 HEAD",

	"BIP01 L CLAVICLE",
	"BIP01 L UPPERARM",
	"BIP01 L FOREARM",
	"BIP01 L HAND",
	"BIP01 L FINGER0",

	"BIP01 R CLAVICLE",
	"BIP01 R UPPERARM",
	"BIP01 R FOREARM",
	"BIP01 R HAND",
	"BIP01 R FINGER0",

	"BIP01 L THIGH",
	"BIP01 L CALF",
	"BIP01 L FOOT",
	"BIP01 L TOE0",

	"BIP01 R THIGH",
	"BIP01 R CALF",
	"BIP01 R FOOT",
	"BIP01 R TOE0"
};

func string GetNodeName__PuppetMaster (var int index) {
	if (index < 0) { return ""; };
	if (index >= HUMAN_NODENAMES_MAX) { return ""; };

	return MEM_ReadStatStringArr (HUMAN_NODENAMES, index);
};

func void DrawBBox__PuppetMaster () {
	if (!STR_Len (puppetNode)) { return; };

	var int vobPtr; vobPtr = _@ (Puppet);

	if (!Hlp_VobVisual_Is_zCModel (vobPtr)) { return; };

	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	//zCModelNodeInst *
	var int modelNodeInstPtr; modelNodeInstPtr = zCModel_SearchNode (visualPtr, puppetNode);

	if (!modelNodeInstPtr) { return; };

	var int trafo[16];
	zCVob_GetTrafoModelNodeToWorld (vobPtr, modelNodeInstPtr, _@ (trafo));

	//Create 'helper' vob
	if (!puppetNodeVobPtr) {
		//Insert empty vob
		puppetNodeVobPtr = InsertObject ("zCVob", "", "", _@ (trafo), 0);

		//Remove collisions
		var int vobRemoveCollisions; vobRemoveCollisions = Vob_GetCollBits (puppetNodeVobPtr);
		Vob_RemoveCollBits (puppetNodeVobPtr, vobRemoveCollisions);

		//Draw bbox
		zCVob_SetDrawBBox3D (puppetNodeVobPtr, 1);
	};

	AlignVobAt (puppetNodeVobPtr, _@ (trafo));

	var int BBox[6];
	zCModel_GetBBox3DNodeWorld (visualPtr, modelNodeInstPtr, _@ (BBox));

	//Only head has its own BBox? (so this is kind of pointless ... :))
	zCVob_SetBBox3DWorld (puppetNodeVobPtr, _@ (BBox));
};

//---

instance DIA_PuppetMaster_Main (C_Info) {
	nr = 1;
	condition = DIA_PuppetMaster_Main_Condition;
	information = DIA_PuppetMaster_Main_Info;
	important = TRUE;
	permanent = TRUE;
};

//---
func void DIA_PuppetMaster_UpdateNodePos_Hanlder (var string spinnerID) {
	var string oldDescription;
	var string oldDescription1;
	var string oldDescription2;
	var string oldDescription3;

	if (!InfoManager_IsInChoiceMode ()) {
		oldDescription = "";
		oldDescription1 = "";
		oldDescription2 = "";
		oldDescription3 = "";
		return;
	};

	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	var int value;

	var int min;
	var int max;

	//Min/max values
	min = -1;
	max = 1;

	//Check boundaries
	if (value < min) { value = min; };
	if (value > max) { value = max; };

	var int isActive; isActive = Hlp_StrCmp (InfoManagerSpinnerID, spinnerID);

	//Setup spinner if spinner ID has changed
	if (isActive) {
		//Setup spinner if spinner ID has changed
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
			//Restore value
			InfoManagerSpinnerValue = value;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 30;

		//Min/Max value (Home/End keys)
		InfoManagerSpinnerValueMin = -360;
		InfoManagerSpinnerValueMax = 360;

		//Update
		value = InfoManagerSpinnerValue;
	};

	lastSpinnerID = InfoManagerSpinnerID;

	var string newDescription; newDescription = "";

	//newDescription = ConcatStrings (newDescription, "h@");
	newDescription = ConcatStrings (newDescription, "s@");
	newDescription = ConcatStrings (newDescription, spinnerID);
	newDescription = ConcatStrings (newDescription, " ");

	if (value) {
		var int vobPtr; vobPtr = _@ (Puppet);

		if (Hlp_VobVisual_Is_zCModel (vobPtr)) {

			var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

			//zCModelNodeInst *
			var int modelNodeInstPtr; modelNodeInstPtr = zCModel_SearchNode (visualPtr, puppetNode);

			if (modelNodeInstPtr) {
				var int trafoPtr; trafoPtr = modelNodeInstPtr + 12;

				var int trafo[16];

				MEM_CopyBytes (trafoPtr, _@ (trafo), 64);

				if (Hlp_StrCmp (spinnerID, "UpdatePosX")) {
					trafo[03] = addf (trafo[03], mkf (value));
				} else
				if (Hlp_StrCmp (spinnerID, "UpdatePosY")) {
					trafo[07] = addf (trafo[07], mkf (value));
				} else
				if (Hlp_StrCmp (spinnerID, "UpdatePosZ")) {
					trafo[11] = addf (trafo[11], mkf (value));
				};

				MEM_CopyBytes (_@ (trafo), trafoPtr, 64);

				//Update
				DrawBBox__PuppetMaster ();
			};
		};

		value = 0;
		InfoManagerSpinnerValue = 0;
	};

	if (Hlp_StrCmp (spinnerID, "UpdatePosX")) {
		newDescription = ConcatStrings (newDescription, "Move on X axis.");
		oldDescription = oldDescription1;
	} else
	if (Hlp_StrCmp (spinnerID, "UpdatePosY")) {
		newDescription = ConcatStrings (newDescription, "Move on Y axis.");
		oldDescription = oldDescription2;
	} else
	if (Hlp_StrCmp (spinnerID, "UpdatePosZ")) {
		newDescription = ConcatStrings (newDescription, "Move on Z axis.");
		oldDescription = oldDescription3;
	};

	//Update choice description!
	if (!Hlp_StrCmp (oldDescription, newDescription)) {
		InfoManager_SetInfoChoiceText_BySpinnerID (newDescription, spinnerID);
	};

	if (Hlp_StrCmp (spinnerID, "UpdatePosX")) {
		oldDescription1 = newDescription;
	};
	if (Hlp_StrCmp (spinnerID, "UpdatePosY")) {
		oldDescription2 = newDescription;
	};
	if (Hlp_StrCmp (spinnerID, "UpdatePosZ")) {
		oldDescription3 = newDescription;
	};
};

//---

func void DIA_PuppetMaster_RotateNode_Handler (var string spinnerID) {
	var string oldDescription;
	var string oldDescription1;
	var string oldDescription2;
	var string oldDescription3;

	if (!InfoManager_IsInChoiceMode ()) {
		oldDescription = "";
		oldDescription1 = "";
		oldDescription2 = "";
		oldDescription3 = "";
		return;
	};

	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	var int value;

	var int min;
	var int max;

	//Min/max values
	min = -1;
	max = 1;

	//Check boundaries
	if (value < min) { value = min; };
	if (value > max) { value = max; };

	var int isActive; isActive = Hlp_StrCmp (InfoManagerSpinnerID, spinnerID);

	//Setup spinner if spinner ID has changed
	if (isActive) {
		//Setup spinner if spinner ID has changed
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
			//Restore value
			InfoManagerSpinnerValue = value;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 30;

		//Min/Max value (Home/End keys)
		InfoManagerSpinnerValueMin = -360;
		InfoManagerSpinnerValueMax = 360;

		//Update
		value = InfoManagerSpinnerValue;
	};

	lastSpinnerID = InfoManagerSpinnerID;

	var string newDescription; newDescription = "";

	//newDescription = ConcatStrings (newDescription, "h@");
	newDescription = ConcatStrings (newDescription, "s@");
	newDescription = ConcatStrings (newDescription, spinnerID);
	newDescription = ConcatStrings (newDescription, " ");

	if (value) {
		var int vobPtr; vobPtr = _@ (Puppet);

		if (Hlp_VobVisual_Is_zCModel (vobPtr)) {

			var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

			//zCModelNodeInst *
			var int modelNodeInstPtr; modelNodeInstPtr = zCModel_SearchNode (visualPtr, puppetNode);

			if (modelNodeInstPtr) {
				var int trafoPtr; trafoPtr = modelNodeInstPtr + 12;

				if (Hlp_StrCmp (spinnerID, "RotateNodeX")) {
					zMAT4_PostRotateX (trafoPtr, mkf (value));
				} else
				if (Hlp_StrCmp (spinnerID, "RotateNodeY")) {
					zMAT4_PostRotateY (trafoPtr, mkf (value));
				} else
				if (Hlp_StrCmp (spinnerID, "RotateNodeZ")) {
					zMAT4_PostRotateZ (trafoPtr, mkf (value));
				};

				//Update
				DrawBBox__PuppetMaster ();
			};
		};

		value = 0;
		InfoManagerSpinnerValue = 0;
	};

	if (Hlp_StrCmp (spinnerID, "RotateNodeX")) {
		newDescription = ConcatStrings (newDescription, "Rotate around X axis.");
		oldDescription = oldDescription1;
	} else
	if (Hlp_StrCmp (spinnerID, "RotateNodeY")) {
		newDescription = ConcatStrings (newDescription, "Rotate around Y axis.");
		oldDescription = oldDescription2;
	} else
	if (Hlp_StrCmp (spinnerID, "RotateNodeZ")) {
		newDescription = ConcatStrings (newDescription, "Rotate around Z axis.");
		oldDescription = oldDescription3;
	};

	//Update choice description!
	if (!Hlp_StrCmp (oldDescription, newDescription)) {
		InfoManager_SetInfoChoiceText_BySpinnerID (newDescription, spinnerID);
	};

	if (Hlp_StrCmp (spinnerID, "RotateNodeX")) {
		oldDescription1 = newDescription;
	};
	if (Hlp_StrCmp (spinnerID, "RotateNodeY")) {
		oldDescription2 = newDescription;
	};
	if (Hlp_StrCmp (spinnerID, "RotateNodeZ")) {
		oldDescription3 = newDescription;
	};
};

func int DIA_PuppetMaster_Main_Condition () {
	if (!puppetMasterEnabled) { return FALSE; };

	//Execute here - to reset oldDescription, oldDescription2, oldDescription3 if we are not in choice mode!
	DIA_PuppetMaster_UpdateNodePos_Hanlder ("UpdatePosX");
	DIA_PuppetMaster_UpdateNodePos_Hanlder ("UpdatePosY");
	DIA_PuppetMaster_UpdateNodePos_Hanlder ("UpdatePosZ");

	DIA_PuppetMaster_RotateNode_Handler ("RotateNodeX");
	DIA_PuppetMaster_RotateNode_Handler ("RotateNodeY");
	DIA_PuppetMaster_RotateNode_Handler ("RotateNodeZ");

	var string oldDescription1;

	//Do not execute code below, if choices are not yet displayed :)
	if (!InfoManager_IsInChoiceMode ()) {
		oldDescription1 = "";
		return TRUE;
	};

	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	var int min;
	var int max;

	var int isActive;
	var string editedNumber;

//-- Spinner Choice #1

	var int value1; //Spinner #1 value

	//Min/max values
	min = 0;
	max = HUMAN_NODENAMES_MAX - 1;

	//Check boundaries
	if (value1 < min) { value1 = min; };
	if (value1 > max) { value1 = max; };

	isActive = Hlp_StrCmp (InfoManagerSpinnerID, "SelectNode");

	//Setup spinner if spinner ID has changed
	if (isActive) {
		//What is current InfoManagerSpinnerID ?
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {

			//Update value
			InfoManagerSpinnerValue = value1;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 5;

		//Min/max value (Home/End keys)
		InfoManagerSpinnerValueMin = 0;
		InfoManagerSpinnerValueMax = HUMAN_NODENAMES_MAX - 1;

		//Update
		value1 = InfoManagerSpinnerValue;
	};

	//Remember, remember!
	var string newDescription1;

	if (max == 0) {
		//newDescription1 = "d@ "; //disabled
	};

	var string prevNodeName;
	var string nextNodeName;

	var int lastValue1;

	if (value1 != lastValue1) {
		prevNodeName = GetNodeName__PuppetMaster (value1 - 1);
		puppetNode = GetNodeName__PuppetMaster (value1);
		nextNodeName = GetNodeName__PuppetMaster (value1 + 1);

		DrawBBox__PuppetMaster ();
		lastValue1 = value1;
	};

	//Spinner ID
	newDescription1 = "";
	newDescription1 = ConcatStrings (newDescription1, "s@SelectNode Select node: ");

	//Manually typed in number:
	/*
	if (InfoManagerSpinnerNumberEditMode)
	&& (TRUE) //change to FALSE if you don't want to allow manual typing
	&& (isActive)
	{
		editedNumber = InfoManagerSpinnerNumber;
		editedNumber = ConcatStrings (editedNumber, "_");

		//Check boundaries - if value is out, add red color overlay
		if ((STR_ToInt (InfoManagerSpinnerNumber) < min) || (STR_ToInt (InfoManagerSpinnerNumber) > max)) {
			editedNumber = ConcatStrings ("o@h@FF3030 hs@FF4646 :", editedNumber);
			editedNumber = ConcatStrings (editedNumber, "~");
		};

		newDescription1 = ConcatStrings (newDescription1, editedNumber);
	} else {
		newDescription1 = ConcatStrings (newDescription1, IntToString (value1));
	};
	*/

	newDescription1 = ConcatStrings (newDescription1, "o@h@00CC66 hs@66FFB2:");
	newDescription1 = ConcatStrings (newDescription1, puppetNode);
	newDescription1 = ConcatStrings (newDescription1, "~");

	//Update choice description!
	if (!Hlp_StrCmp (oldDescription1, newDescription1)) {
		InfoManager_SetInfoChoiceText_BySpinnerID (newDescription1, "SelectNode");
	};
	oldDescription1 = newDescription1;

	puppetNodeIndex = value1;

//-- Spinner Choice #2

/*

		var int value2; //Spinner #2 value

		//Min/max values
		min = 1;
		max = NPC_HasItems (self, ItFoMutton);

		//Check boundaries
		if (value2 < min) { value2 = min; };
		if (value2 > max) { value2 = max; };

		isActive = Hlp_StrCmp (InfoManagerSpinnerID, "CookFish");

		//Setup spinner if spinner ID has changed
		if (isActive) {
			//What is current InfoManagerSpinnerID ?
			if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
				//Update value
				InfoManagerSpinnerValue = value2;
			};

			//Page Up/Down quantity
			InfoManagerSpinnerPageSize = 5;

			//Min/max value (Home/End keys)
			InfoManagerSpinnerValueMin = min;
			InfoManagerSpinnerValueMax = max;

			//Update
			value2 = InfoManagerSpinnerValue;
		};

		//Remember, remember!
		var string newDescription2;
		var string oldDescription2;

		oldDescription2 = newDescription2;
		newDescription2 = "";

		if (max == 0) {
			//newDescription2 = "d@ "; //disabled
		};

		//Spinner ID CookMeat
		newDescription2 = ConcatStrings (newDescription2, "s@CookFish Cook some Fish: ");

		//Manually typed in number:
		if (InfoManagerSpinnerNumberEditMode)
		&& (TRUE) //change to FALSE if you don't want to allow manual typing
		&& (isActive)
		{
			editedNumber = InfoManagerSpinnerNumber;
			editedNumber = ConcatStrings (editedNumber, "_");

			//Check boundaries - if value is out, add red color overlay
			if ((STR_ToInt (InfoManagerSpinnerNumber) < min) || (STR_ToInt (InfoManagerSpinnerNumber) > max)) {
				editedNumber = ConcatStrings ("o@h@FF3030 hs@FF4646 :", editedNumber);
				editedNumber = ConcatStrings (editedNumber, "~");
			};

			newDescription2 = ConcatStrings (newDescription2, editedNumber);
		} else {
			newDescription2 = ConcatStrings (newDescription2, IntToString (value2));
		};

		newDescription2 = ConcatStrings (newDescription2, " / ");
		newDescription2 = ConcatStrings (newDescription2, IntToString (max));

		//Update choice description!
		if (!Hlp_StrCmp (oldDescription2, newDescription2)) {
			InfoManager_SetInfoChoiceText_BySpinnerID (newDescription2, "CookFish");
		};
*/

//--

		lastSpinnerID = InfoManagerSpinnerID;

		return TRUE;
};

func void DIA_PuppetMaster_Main_Info () {
	Info_ClearChoices (DIA_PuppetMaster_Main);

	Info_AddChoice (DIA_PuppetMaster_Main, DIALOG_ENDE, DIA_PuppetMaster_Main_Exit);

	Info_AddChoice (DIA_PuppetMaster_Main, "s@UpdatePosZ", DIA_PuppetMaster_Main_Info);
	Info_AddChoice (DIA_PuppetMaster_Main, "s@UpdatePosY", DIA_PuppetMaster_Main_Info);
	Info_AddChoice (DIA_PuppetMaster_Main, "s@UpdatePosX", DIA_PuppetMaster_Main_Info);

	Info_AddChoice (DIA_PuppetMaster_Main, "s@RotateNodeZ", DIA_PuppetMaster_Main_Info);
	Info_AddChoice (DIA_PuppetMaster_Main, "s@RotateNodeY", DIA_PuppetMaster_Main_Info);
	Info_AddChoice (DIA_PuppetMaster_Main, "s@RotateNodeX", DIA_PuppetMaster_Main_Info);

	Info_AddChoice (DIA_PuppetMaster_Main, "s@SelectNode", DIA_PuppetMaster_Main_Info);
};

func void DIA_PuppetMaster_Main_Exit () {
	Info_ClearChoices (DIA_PuppetMaster_Main);

	//Remove vob for bbox
	RemoveoCVobSafe (puppetNodeVobPtr, 1);

	puppetNodeVobPtr = 0;

	puppetMasterEnabled = FALSE;
	AI_StopProcessInfos (self);
};

func string CC_PuppetMaster (var string param) {
	var oCNPC her; her = Hlp_GetNPC (hero);
	if (!Hlp_Is_oCNpc (her.focus_vob)) { return "hero.focus_vob is not an NPC."; };

	Puppet = _^ (her.focus_vob);

	var int isSleeping; isSleeping = zCVob_IsSleeping (her.focus_vob);
	if (!isSleeping) {
		zCVob_SetSleeping (her.focus_vob, 1);
	};

	//Hide console
	zCConsole_Hide ();

	//Enable Puppet master
	puppetMasterEnabled = TRUE;

	//Default node
	if (!STR_Len (puppetNode)) {
		puppetNodeIndex = 0;
	};

	puppetNode = GetNodeName__PuppetMaster (puppetNodeIndex);

	//Initial draw
	DrawBBox__PuppetMaster ();

	var int npcInstance; npcInstance =  Hlp_GetInstanceID (hero);

	DIA_PuppetMaster_Main.npc = npcInstance;

	AI_ProcessInfos (hero);
	return "ok";
};

func void CC_PuppetMaster_Init () {
	//Init Enhanced info manager
	G12_EnhancedInfoManager_Init ();

	//Register console command
	CC_Register (CC_PuppetMaster, "puppetMaster", "Manipulate limbs of an Npc.");
};
