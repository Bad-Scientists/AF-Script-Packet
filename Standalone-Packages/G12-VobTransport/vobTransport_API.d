/*
 *	EXAMPLE #2
 *	 - player can manipulate anything in Marvin mode
 * 	 - there is no option to buy anything
 */

const string vobTransportFontName			= "font_old_10_white.tga";
const string vobTransportViewTexture			= "DLG_NOISE.TGA";

//Default values
const int vobTransportPropertiesView_PPosX		= 0;		//if not defined (-1) it will go to the middle of screen on X axis. In pixels
const int vobTransportPropertiesView_PPosY		= -1;		//if not defined (-1) it will go to the middle of screen on Y axis. In pixels
//Virtual positions have higher prio than pixel positions.
const int vobTransportPropertiesView_VPosX		= -1;		//if not defined (-1) then vobTransportPropertiesView_PPosX will be taken into consideration. Virtual coordinates
const int vobTransportPropertiesView_VPosY		= -1;		//if not defined (-1) then vobTransportPropertiesView_VPosY will be taken into consideration. Virtual coordinates

const int vobTransportPropertiesView_WidthPxl		= 360;		//In pixels
const int vobTransportPropertiesView_Lines		= 30;		//29 lines + 1 empty delimiter

const int vobTransportBuyVobViewPPosX			= -1;		//if not defined (-1) it will go to the middle of screen on X axis
const int vobTransportBuyVobViewPPosY			= -1;		//if not defined (-1) it will go to the middle of screen on X axis
//Virtual positions have higher prio than pixel positions.
const int vobTransportBuyVobViewVPosX			= -1;		//if not defined (-1) then vobTransportBuyVobViewPPosX will be taken into consideration. Virtual coordinates (max 8192)
const int vobTransportBuyVobViewVPosY			= 6600;		//if not defined (-1) then vobTransportBuyVobViewPPosY will be taken into consideration. Virtual coordinates (max 8192)

const int vobTransportBuyVobView_WidthPxl		= 540;
const int vobTransportBuyVobView_Lines			= 7;		//7 lines

const int vobTransportAlpha				= 80;

//Interaction prints
const string vobTransportPrint_BuyVobActivated		= "Select objects which you would like to buy.";
const string vobTransportPrint_BuyVobNothingToBuy	= "Nothing to buy.";
const string vobTransportPrint_ContainerContentsDeleted	= "oCMobContainer contents deleted.";
const string vobTransportPrint_ItemDropped		= "Item dropped.";
const string vobTransportPrint_NoObjectsDetected	= "No objects detected.";
const string vobTransportPrint_CannotBeCloned		= "Object cannot be cloned.";
const string vobTransportPrint_Cloned			= "Object cloned.";
const string vobTransportPrint_MoveVobActivated		= "Object moving.";
const string vobTransportPrint_CannotBeClonedMoved	= "Object cannot be cloned or moved.";

//Vob transport modes
const string vobTransportView_TitleSelection		= "<< Selection mode >>";
 const string vobTransportView_InstructionMove		= "Press C to select";
 const string vobTransportView_InstructionClone		= "Press Ctrl + C to copy object";
 const string vobTransportView_InstructionTransform	= "Press Shift + C to enter transform mode";
 const string vobTransportView_InstructionDelete	= "Press Del to delete object";
 const string vobTransportView_InstructionCancel	= "Press Esc to cancel selection";
 const string vobTransportView_InstructionDropItem	= "Press P to apply physics on an item";

const string vobTransportView_TitleMovement		= "<< Movement mode >>";
 const string vobTransportView_InstructionConfirm	= "Press C to confirm position";
 //const string vobTransportView_InstructionTransform	= "L Shift + C - transform";

const string vobTransportView_TitleTransform		= "<< Transform mode >>";
 const string vobTransportView_InstructionRotateXYZ	= "Press X Y Z to switch axes";
 const string vobTransportView_InstructionSpeed		= "Press SPACE to adjust speed: ";

 const string vobTransportView_InstructionDontAlign	= "Press V - do not align object (1/3).";
 const string vobTransportView_InstructionAlignInFront	= "Press V - align in front (2/3).";
 const string vobTransportView_InstructionAlignToFloor	= "Press V - align to floor (3/3).";

const int VOBTRANSPORT_CANBUY_VOBLIST_MAX		= 23;

const string VOBTRANSPORT_CANBUY_VOBLIST [VOBTRANSPORT_CANBUY_VOBLIST_MAX] = {
	"VOB_BUY_OC_BED_V1",				//BED_1_OC.ASC
	"VOB_BUY_OC_BED_V2",				//BED_2_OC.ASC
	"VOB_BUY_OC_TABLE_V1",				//OC_TABLE_V1.3DS
	"VOB_BUY_OC_TABLE_V2",				//OC_TABLE_V2.3DS
	"VOB_BUY_OC_CHAIR_V1",				//CHAIR_1_OC.ASC
	"VOB_BUY_OC_CHAIR_V2",				//CHAIR_2_OC.ASC
	"VOB_BUY_OC_CHEST_V1",				//CHESTSMALL_OCCRATESMALL.MDS
	"VOB_BUY_OC_CHEST_V2",				//CHESTSMALL_OCCRATESMALLLOCKED.MDS
	"VOB_BUY_OC_CHEST_V9",				//CHESTBIG_OCCRATELARGE.MDS
	"VOB_BUY_OC_CHEST_V10",				//CHESTBIG_OCCRATELARGELOCKED.MDS

	"VOB_BUY_OC_CHEST_V3",				//CHESTSMALL_OCCHESTSMALL.MDS
	"VOB_BUY_OC_CHEST_V4",				//CHESTSMALL_OCCHESTSMALLLOCKED.MDS
	"VOB_BUY_OC_CHEST_V5",				//CHESTBIG_OCCHESTMEDIUM.MDS
	"VOB_BUY_OC_CHEST_V6",				//CHESTBIG_OCCHESTMEDIUMLOCKED.MDS
	"VOB_BUY_OC_CHEST_V7",				//CHESTBIG_OCCHESTLARGE.MDS
	"VOB_BUY_OC_CHEST_V8",				//CHESTBIG_OCCHESTLARGELOCKED.MDS

	"VOB_BUY_OC_WEAPONSHELF_V1",			//OC_WEAPON_SHELF_EMPTY_V1.3DS
	"VOB_BUY_OC_WEAPONSHELF_V2",			//OC_WEAPON_SHELF_EMPTY_V2.3DS
	"VOB_BUY_OC_DECORATE_V1",			//OC_DECORATE_V1.3DS
	"VOB_BUY_OC_DECORATE_V2",			//OC_DECORATE_V2.3DS
	"VOB_BUY_OC_MOBSHELVES_V1",			//OC_MOB_SHELVES_BIG.3DS
	"VOB_BUY_OC_SHELF_V4",				//OC_SHELF_V4.3DS
	"VOB_BUY_OC_FIREPLACE_V1"			//FIREPLACE_MIDDLE.ASC
};

const string VOBTRANSPORT_CANBUY_VOBLIST_DESCRIPTION [VOBTRANSPORT_CANBUY_VOBLIST_MAX] = {
	"Bed v1",					//BED_1_OC.ASC
	"Bed v2",					//BED_2_OC.ASC
	"Table v1",					//OC_TABLE_V1.3DS
	"Table v2",					//OC_TABLE_V2.3DS
	"Chair v1",					//CHAIR_1_OC.ASC
	"Chair v2",					//CHAIR_2_OC.ASC
	"Crate v1",					//CHESTSMALL_OCCRATESMALL.MDS
	"Crate v2, with lock",				//CHESTSMALL_OCCRATESMALLLOCKED.MDS
	"Crate v1, huge",				//CHESTBIG_OCCRATELARGE.MDS
	"Crate v2, huge, with lock",			//CHESTBIG_OCCRATELARGELOCKED.MDS

	"Chest v1",					//CHESTSMALL_OCCHESTSMALL.MDS
	"Chest v2, with lock",				//CHESTSMALL_OCCHESTSMALLLOCKED.MDS
	"Chest v1, medium",				//CHESTBIG_OCCHESTMEDIUM.MDS
	"Chest v2, medium, with lock",			//CHESTBIG_OCCHESTMEDIUMLOCKED.MDS
	"Chest v1, huge",				//CHESTBIG_OCCHESTLARGE.MDS
	"Chest v2, huge, with lock",			//CHESTBIG_OCCHESTLARGELOCKED.MDS

	"Weapon shelf v1",				//OC_WEAPON_SHELF_EMPTY_V1.3DS
	"Weapon shelf v2",				//OC_WEAPON_SHELF_EMPTY_V2.3DS
	"Decoration v1",				//OC_DECORATE_V1.3DS
	"Decoration v2",				//OC_DECORATE_V2.3DS
	"Shelf v1",					//OC_MOB_SHELVES_BIG.3DS
	"Shelf v1",					//OC_SHELF_V4.3DS
	"Torch v1"					//FIREPLACE_MIDDLE.ASC
};

const int VOBTRANSPORT_CANBUY_VOBLIST_VALUE [VOBTRANSPORT_CANBUY_VOBLIST_MAX] = {
	200,						//BED_1_OC.ASC
	250,						//BED_2_OC.ASC
	200,						//OC_TABLE_V1.3DS
	250,						//OC_TABLE_V2.3DS
	50,						//CHAIR_1_OC.ASC
	50,						//CHAIR_2_OC.ASC
	100,						//CHESTSMALL_OCCRATESMALL.MDS
	150,						//CHESTSMALL_OCCRATESMALLLOCKED.MDS
	200,						//CHESTBIG_OCCRATELARGE.MDS
	250,						//CHESTBIG_OCCRATELARGELOCKED.MDS

	200,						//CHESTSMALL_OCCHESTSMALL.MDS
	250,						//CHESTSMALL_OCCHESTSMALLLOCKED.MDS
	300,						//CHESTBIG_OCCHESTMEDIUM.MDS
	350,						//CHESTBIG_OCCHESTMEDIUMLOCKED.MDS
	400,						//CHESTBIG_OCCHESTLARGE.MDS
	450,						//CHESTBIG_OCCHESTLARGELOCKED.MDS

	100,						//OC_WEAPON_SHELF_EMPTY_V1.3DS
	100,						//OC_WEAPON_SHELF_EMPTY_V2.3DS
	100,						//OC_DECORATE_V1.3DS
	100,						//OC_DECORATE_V2.3DS
	200,						//OC_MOB_SHELVES_BIG.3DS
	100,						//OC_SHELF_V4.3DS
	100						//FIREPLACE_MIDDLE.ASC
};

/*
 *
 */
const int VOBTRANSPORT_CANBUY_VOBLIST_CATEGORIES_MAX = 4;

const string VOBTRANSPORT_CANBUY_VOBLIST_FURNITURE [6] = {
	"VOB_BUY_OC_BED_V1",				//BED_1_OC.ASC
	"VOB_BUY_OC_BED_V2",				//BED_2_OC.ASC
	"VOB_BUY_OC_TABLE_V1",				//OC_TABLE_V1.3DS
	"VOB_BUY_OC_TABLE_V2",				//OC_TABLE_V2.3DS
	"VOB_BUY_OC_CHAIR_V1",				//CHAIR_1_OC.ASC
	"VOB_BUY_OC_CHAIR_V2"				//CHAIR_2_OC.ASC
};

const string VOBTRANSPORT_CANBUY_VOBLIST_CHESTS [10] = {
	"VOB_BUY_OC_CHEST_V1",				//CHESTSMALL_OCCRATESMALL.MDS
	"VOB_BUY_OC_CHEST_V2",				//CHESTSMALL_OCCRATESMALLLOCKED.MDS
	"VOB_BUY_OC_CHEST_V9",				//CHESTBIG_OCCRATELARGE.MDS
	"VOB_BUY_OC_CHEST_V10",				//CHESTBIG_OCCRATELARGELOCKED.MDS

	"VOB_BUY_OC_CHEST_V3",				//CHESTSMALL_OCCHESTSMALL.MDS
	"VOB_BUY_OC_CHEST_V4",				//CHESTSMALL_OCCHESTSMALLLOCKED.MDS
	"VOB_BUY_OC_CHEST_V5",				//CHESTBIG_OCCHESTMEDIUM.MDS
	"VOB_BUY_OC_CHEST_V6",				//CHESTBIG_OCCHESTMEDIUMLOCKED.MDS
	"VOB_BUY_OC_CHEST_V7",				//CHESTBIG_OCCHESTLARGE.MDS
	"VOB_BUY_OC_CHEST_V8"				//CHESTBIG_OCCHESTLARGELOCKED.MDS
};

const string VOBTRANSPORT_CANBUY_VOBLIST_DECORATION [7] = {
	"VOB_BUY_OC_WEAPONSHELF_V1",			//OC_WEAPON_SHELF_EMPTY_V1.3DS
	"VOB_BUY_OC_WEAPONSHELF_V2",			//OC_WEAPON_SHELF_EMPTY_V2.3DS
	"VOB_BUY_OC_DECORATE_V1",			//OC_DECORATE_V1.3DS
	"VOB_BUY_OC_DECORATE_V2",			//OC_DECORATE_V2.3DS
	"VOB_BUY_OC_MOBSHELVES_V1",			//OC_MOB_SHELVES_BIG.3DS
	"VOB_BUY_OC_SHELF_V4",				//OC_SHELF_V4.3DS
	"VOB_BUY_OC_FIREPLACE_V1"			//FIREPLACE_MIDDLE.ASC
};

func void BuildBuyVobList__VobTransport (var int key) {
	//Clear voblist
	oCNpc_ClearVobList (hero);

	var int vobPtr;
	var string vobName;

	if (key == KEY_DOWNARROW) {
		vobTransportShowcaseVobVerticalIndex -= 1;

		if (vobTransportShowcaseVobVerticalIndex < 0) {
			vobTransportShowcaseVobVerticalIndex = 3;
		};
	};

	if (key == KEY_UPARROW) {
		vobTransportShowcaseVobVerticalIndex += 1;

		if (vobTransportShowcaseVobVerticalIndex > 3) {
			vobTransportShowcaseVobVerticalIndex = 0;
		};
	};

	if (key == -1) {
		vobTransportShowcaseVobVerticalIndex = 0;
	};

	var int i;

	//All

	if (vobTransportShowcaseVobVerticalIndex == 0) {
		repeat (i, VOBTRANSPORT_CANBUY_VOBLIST_MAX);
			vobName = MEM_ReadStatStringArr (VOBTRANSPORT_CANBUY_VOBLIST, i);
			vobPtr = MEM_SearchVobByName (vobName);
			oCNpc_InsertInVobList (hero, vobPtr);
		end;
	};

	//Special categories

	if (vobTransportShowcaseVobVerticalIndex == 1) {
		repeat (i, 6);
			vobName = MEM_ReadStatStringArr (VOBTRANSPORT_CANBUY_VOBLIST_FURNITURE, i);
			vobPtr = MEM_SearchVobByName (vobName);
			oCNpc_InsertInVobList (hero, vobPtr);
		end;
	};

	if (vobTransportShowcaseVobVerticalIndex == 2) {
		repeat (i, 10);
			vobName = MEM_ReadStatStringArr (VOBTRANSPORT_CANBUY_VOBLIST_CHESTS, i);
			vobPtr = MEM_SearchVobByName (vobName);
			oCNpc_InsertInVobList (hero, vobPtr);
		end;
	};

	if (vobTransportShowcaseVobVerticalIndex == 3) {
		repeat (i, 7);
			vobName = MEM_ReadStatStringArr (VOBTRANSPORT_CANBUY_VOBLIST_DECORATION, i);
			vobPtr = MEM_SearchVobByName (vobName);
			oCNpc_InsertInVobList (hero, vobPtr);
		end;
	};
};

/*
 *	VobCanBeBought__VobTransport_API
 *	 - this function recognizes which objects you can buy:
 *		- by default you can buy everything listed in VOBTRANSPORT_CANBUY_VOBLIST
 *	 	- then you can buy 'clones' - if you try to clone bought object - you can clone it and buy it again
 */
func int VobCanBeBought__VobTransport_API (var int vobPtr) {
	var zCVob vob;
	var string s;
	var string vobName;
	var string objectName;
	var int j;
	var int vobCount;

	//In this example - we will not allow buying
	PrintS ("In this example there is nothing to be bought.");
	return FALSE;

	if (!vobPtr) { return FALSE; };

	vob = _^ (vobPtr);

	repeat (i, VOBTRANSPORT_CANBUY_VOBLIST_MAX); var int i;
		vobName = MEM_ReadStatStringArr (VOBTRANSPORT_CANBUY_VOBLIST, i);
		objectName = vob._zCObject_objectName;

		//Original		clone - we will let player to buy again clones
		//VOB_BUY_OC_BED_V1	VOB_BUY_OC_BED_V1_CLONE_001
		j = STR_IndexOf (objectName, "_CLONE_");
		if (j > -1) {
			objectName = mySTR_SubStr (objectName, 0, j);
		};

		if (Hlp_StrCmp (objectName, vobName)) {
			//Update description
			sVobTransportBuyVobView_Description = MEM_ReadStatStringArr (VOBTRANSPORT_CANBUY_VOBLIST_DESCRIPTION, i);
			//Value
			vobTransportShowcaseVobBuyValue = MEM_ReadIntArray (_@ (VOBTRANSPORT_CANBUY_VOBLIST_VALUE), i);

			//Update texts
			sVobTransportBuyVobView_Line1 = "Price: ";
			sVobTransportBuyVobView_Count1 = IntToString (vobTransportShowcaseVobBuyValue);

			var int oreTotal; oreTotal = NPC_HasItemInstanceName (hero, "ItMiNugget");

			sVobTransportBuyVobView_Line2 = "Your ore: ";
			sVobTransportBuyVobView_Count2 = IntToString (oreTotal);

			s = "Category: ";
			if (vobTransportShowcaseVobVerticalIndex == 0) { s = ConcatStrings (s, "All"); vobCount = VOBTRANSPORT_CANBUY_VOBLIST_MAX; };
			if (vobTransportShowcaseVobVerticalIndex == 1) { s = ConcatStrings (s, "Furniture"); vobCount = 6; };
			if (vobTransportShowcaseVobVerticalIndex == 2) { s = ConcatStrings (s, "Chests"); vobCount = 10; };
			if (vobTransportShowcaseVobVerticalIndex == 3) { s = ConcatStrings (s, "Decorations"); vobCount = 7; };

			sVobTransportBuyVobView_Line4 = "Vob:";
			sVobTransportBuyVobView_Count4 = IntToString (vobTransportShowcaseVobIndex + 1); //index starts with 0
			sVobTransportBuyVobView_Count4 = ConcatStrings (sVobTransportBuyVobView_Count4, "/");
			sVobTransportBuyVobView_Count4 = ConcatStrings (sVobTransportBuyVobView_Count4, IntToString (vobCount));

			sVobTransportBuyVobView_Line5 = s;
			sVobTransportBuyVobView_Count5 = IntToString (vobTransportShowcaseVobVerticalIndex + 1); //index starts with 0
			sVobTransportBuyVobView_Count5 = ConcatStrings (sVobTransportBuyVobView_Count5, "/");
			sVobTransportBuyVobView_Count5 = ConcatStrings (sVobTransportBuyVobView_Count5, IntToString (VOBTRANSPORT_CANBUY_VOBLIST_CATEGORIES_MAX));

			colorVobTransportBuyVobView_Count1 = RGBA (255, 255, 255, 255);
			colorVobTransportBuyVobView_Count2 = RGBA (255, 255, 255, 255);
			colorVobTransportBuyVobView_Count3 = RGBA (255, 255, 255, 255);
			colorVobTransportBuyVobView_Count4 = RGBA (255, 255, 255, 255);
			colorVobTransportBuyVobView_Count5 = RGBA (255, 255, 255, 255);

			if (oreTotal >= vobTransportShowcaseVobBuyValue) {
				colorVobTransportBuyVobView_Count2 = RGBA (102, 255, 102, 255);
			} else {
				colorVobTransportBuyVobView_Count2 = RGBA (255, 070, 070, 255);
			};

			return TRUE;
		};
	end;

	return FALSE;
};

/*
 *	VobTransportCanBeActivated__VobTransport_API
 *	 - here you can define where & when vob transport can be activated
 */
func int VobTransportCanBeActivated__VobTransport_API () {
	if (!Hlp_IsValidNPC (hero)) { return FALSE; };

	//Allow in Marvin mode
	if (MEM_Game.game_testmode) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	VobCanBeDeleted__VobTransport_API
 *	 - here you can define where & when objects can be deleted
 */
func int VobCanBeDeleted__VobTransport_API (var int vobPtr) {
	//Allow in Marvin mode
	if (MEM_Game.game_testmode) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	FocusVobCanBeSelected__VobTransport_API
 *	 - here you can define where & when focusable objects can be selected byt this feature
 */
func int FocusVobCanBeSelected__VobTransport_API (var int vobPtr) {
	//Allow in Marvin mode
	if (MEM_Game.game_testmode) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	VobCanBeSelected__VobTransport_API
 *	 - here you can define which objects can be selected by this feature
 */
func int VobCanBeSelected__VobTransport_API (var int vobPtr) {
	//Allow in Marvin mode
	if (MEM_Game.game_testmode) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	VobCanBeMovedAround__VobTransport_API
 *	 - here you can define which objects can be moved around
 *	 - we need to have this one with a little bit different rules than VobCanBeSelected__VobTransport_API - because of vobs that can be bought
 */
func int VobCanBeMovedAround__VobTransport_API (var int vobPtr) {
	//Allow in Marvin mode
	if (MEM_Game.game_testmode) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	VobCanBeCloned__VobTransport_API
 *	 - here you can define which objects can be cloned
 */
func int VobCanBeCloned__VobTransport_API (var int vobPtr) {
	//Allow in Marvin mode
	if (MEM_Game.game_testmode) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	VobCanBePlaced__VobTransport_API
 *	 - here you can define which objects can be placed
 */
func int VobCanBePlaced__VobTransport_API (var int vobPtr) {
	//Allow in Marvin mode
	if (MEM_Game.game_testmode) {
		return TRUE;
	};

	return FALSE;
};
