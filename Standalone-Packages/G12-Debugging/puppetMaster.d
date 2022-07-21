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

instance DIA_PuppetMaster_Exit (C_Info) {
	npc = PC_Hero;
	nr = 999;
	condition = DIA_PuppetMaster_Exit_Condition;
	information = DIA_PuppetMaster_Exit_Info;
	important = FALSE;
	permanent = TRUE;
	description = DIALOG_ENDE;
};

func int DIA_PuppetMaster_Exit_Condition () {
	return TRUE;
};

func void DIA_PuppetMaster_Exit_Info () {
	//Remove vob for bbox
	RemoveoCVobSafe (puppetNodeVobPtr, 1);

	puppetNodeVobPtr = 0;

	AI_StopProcessInfos (self);
};

//---

instance DIA_PuppetMaster_SelectNode (C_Info) {
	npc = PC_Hero;
	nr = 1;
	condition = DIA_PuppetMaster_SelectNode_Condition;
	information = DIA_PuppetMaster_SelectNode_Info;
	important = FALSE;
	permanent = TRUE;
	description = "dummy";
};

func int DIA_PuppetMaster_SelectNode_Condition () {
	if (!puppetMasterEnabled) { return FALSE; };

	//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
	var string lastSpinnerID;

	var int value; value = puppetNodeIndex;
	var int lastValue;

	var int min;
	var int max;

	//Min/max values
	min = 0;
	max = HUMAN_NODENAMES_MAX - 1;

	//Check boundaries
	if (value < min) { value = min; };
	if (value > max) { value = max; };

	var int isActive; isActive = Hlp_StrCmp (InfoManagerSpinnerID, "SelectNode");

	//Setup spinner if spinner ID has changed
	if (isActive) {
		//Setup spinner if spinner ID has changed
		if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
			//Restore value
			InfoManagerSpinnerValue = value;
		};

		//Page Up/Down quantity
		InfoManagerSpinnerPageSize = 5;

		//Min/Max value (Home/End keys)
		InfoManagerSpinnerValueMin = 0;
		InfoManagerSpinnerValueMax = HUMAN_NODENAMES_MAX - 1;

		//Update
		value = InfoManagerSpinnerValue;
	};

	lastSpinnerID = InfoManagerSpinnerID;

	var string prevNodeName;
	var string nextNodeName;

	if (value != lastValue) {
		prevNodeName = GetNodeName__PuppetMaster (value - 1);
		puppetNode = GetNodeName__PuppetMaster (value);
		nextNodeName = GetNodeName__PuppetMaster (value + 1);

		DrawBBox__PuppetMaster ();
	};

	var string newDescription; newDescription = "";

	//newDescription = ConcatStrings (newDescription, "h@");
	newDescription = ConcatStrings (newDescription, "s@SelectNode Select node: ");

	//if (STR_Len (prevNodeName)) {
	//	newDescription = ConcatStrings (newDescription, prevNodeName);
	//	newDescription = ConcatStrings (newDescription, ", ");
	//};

	newDescription = ConcatStrings (newDescription, "o@h@00CC66 hs@66FFB2:");
	newDescription = ConcatStrings (newDescription, puppetNode);
	newDescription = ConcatStrings (newDescription, "~");

	//if (STR_Len (nextNodeName)) {
	//	newDescription = ConcatStrings (newDescription, ", ");
	//	newDescription = ConcatStrings (newDescription, nextNodeName);
	//};

	lastValue = value;
	puppetNodeIndex = value;

	//Update description
	DIA_PuppetMaster_SelectNode.description = newDescription;

	return TRUE;
};

func void DIA_PuppetMaster_SelectNode_Info () {
};

//---
func int DIA_PuppetMaster_RotateNode_Condition (var C_Info inst, var string spinnerID) {
	if (!puppetMasterEnabled) { return FALSE; };

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
	if (Hlp_StrCmp (spinnerID, "RotateNodeX")) {
		newDescription = ConcatStrings (newDescription, "Rotate around X axis.");
	} else
	if (Hlp_StrCmp (spinnerID, "RotateNodeY")) {
		newDescription = ConcatStrings (newDescription, "Rotate around Y axis.");
	} else
	if (Hlp_StrCmp (spinnerID, "RotateNodeZ")) {
		newDescription = ConcatStrings (newDescription, "Rotate around Z axis.");
	};

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

	//Update description
	inst.description = newDescription;

	return TRUE;
};

instance DIA_PuppetMaster_RotateNodeX (C_Info) {
	npc = PC_Hero;
	nr = 2;
	condition = DIA_PuppetMaster_RotateNodeX_Condition;
	information = DIA_PuppetMaster_RotateNodeX_Info;
	important = FALSE;
	permanent = TRUE;
	description = "dummy";
};

func int DIA_PuppetMaster_RotateNodeX_Condition () {
	return + DIA_PuppetMaster_RotateNode_Condition (DIA_PuppetMaster_RotateNodeX, "RotateNodeX");
};

func void DIA_PuppetMaster_RotateNodeX_Info () {
};

//---

instance DIA_PuppetMaster_RotateNodeY (C_Info) {
	npc = PC_Hero;
	nr = 3;
	condition = DIA_PuppetMaster_RotateNodeY_Condition;
	information = DIA_PuppetMaster_RotateNodeY_Info;
	important = FALSE;
	permanent = TRUE;
	description = "dummy";
};

func int DIA_PuppetMaster_RotateNodeY_Condition () {
	return + DIA_PuppetMaster_RotateNode_Condition (DIA_PuppetMaster_RotateNodeY, "RotateNodeY");
};

func void DIA_PuppetMaster_RotateNodeY_Info () {
};

//---

instance DIA_PuppetMaster_RotateNodeZ (C_Info) {
	npc = PC_Hero;
	nr = 4;
	condition = DIA_PuppetMaster_RotateNodeZ_Condition;
	information = DIA_PuppetMaster_RotateNodeZ_Info;
	important = FALSE;
	permanent = TRUE;
	description = "dummy";
};

func int DIA_PuppetMaster_RotateNodeZ_Condition () {
	return + DIA_PuppetMaster_RotateNode_Condition (DIA_PuppetMaster_RotateNodeZ, "RotateNodeZ");
};

func void DIA_PuppetMaster_RotateNodeZ_Info () {
};

//---

func int DIA_PuppetMaster_UpdatePos_Condition (var C_Info inst, var string spinnerID) {
	if (!puppetMasterEnabled) { return FALSE; };

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

	if (Hlp_StrCmp (spinnerID, "UpdatePosX")) {
		newDescription = ConcatStrings (newDescription, "Move on X axis.");
	} else
	if (Hlp_StrCmp (spinnerID, "UpdatePosY")) {
		newDescription = ConcatStrings (newDescription, "Move on Y axis.");
	} else
	if (Hlp_StrCmp (spinnerID, "UpdatePosZ")) {
		newDescription = ConcatStrings (newDescription, "Move on Z axis.");
	};

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

	//Update description
	inst.description = newDescription;

	return TRUE;
};

instance DIA_PuppetMaster_UpdatePosX (C_Info) {
	npc = PC_Hero;
	nr = 5;
	condition = DIA_PuppetMaster_UpdatePosX_Condition;
	information = DIA_PuppetMaster_UpdatePosX_Info;
	important = FALSE;
	permanent = TRUE;
	description = "dummy";
};

func int DIA_PuppetMaster_UpdatePosX_Condition () {
	return + DIA_PuppetMaster_UpdatePos_Condition (DIA_PuppetMaster_UpdatePosX, "UpdatePosX");
};

func void DIA_PuppetMaster_UpdatePosX_Info () {
};

//---

instance DIA_PuppetMaster_UpdatePosY (C_Info) {
	npc = PC_Hero;
	nr = 6;
	condition = DIA_PuppetMaster_UpdatePosY_Condition;
	information = DIA_PuppetMaster_UpdatePosY_Info;
	important = FALSE;
	permanent = TRUE;
	description = "dummy";
};

func int DIA_PuppetMaster_UpdatePosY_Condition () {
	return + DIA_PuppetMaster_UpdatePos_Condition (DIA_PuppetMaster_UpdatePosY, "UpdatePosY");
};

func void DIA_PuppetMaster_UpdatePosY_Info () {
};

//---

instance DIA_PuppetMaster_UpdatePosZ (C_Info) {
	npc = PC_Hero;
	nr = 7;
	condition = DIA_PuppetMaster_UpdatePosZ_Condition;
	information = DIA_PuppetMaster_UpdatePosZ_Info;
	important = FALSE;
	permanent = TRUE;
	description = "dummy";
};

func int DIA_PuppetMaster_UpdatePosZ_Condition () {
	return + DIA_PuppetMaster_UpdatePos_Condition (DIA_PuppetMaster_UpdatePosZ, "UpdatePosZ");
};

func void DIA_PuppetMaster_UpdatePosZ_Info () {
};

//---

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
		puppetNode = "BIP01";
		puppetNodeIndex = 0;
	};

	//Initial draw
	DrawBBox__PuppetMaster ();

	AI_ProcessInfos (hero);
	return "ok";
};

func void CC_PuppetMaster_Init () {
	//Init Enhanced info manager
	G12_EnhancedInfoManager_Init ();

	//Register console command
	CC_Register (CC_PuppetMaster, "puppetMaster", "Manipulate limbs of an Npc.");
};
