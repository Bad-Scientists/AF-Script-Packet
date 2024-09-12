/*
 *	Enhanced InfoManager
 *
 *	Modifiers:			Usage:								Explanation:
 *		f@				'f@font_15_white.tga TEST'			 - applies font_15_white.tga to greyed out dialog choice. Has to be separated by space.
 *		fs@				'fs@font_old_20_white.tga TEST'		 - applies font_old_20_white.tga to selected dialog choice. Has to be separated by space.
 *		h@				'h@00CC66 TEST'						 - applies color in hexcode to greyed out dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
 *		hs@				'hs@66FFB2 TEST'					 - applies color in hexcode to selected dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
 *		a@				'a@TEST' 'a@ TEST'					 - enables answering mode. Does not have to be separated by space. (removes space after @ sign if there is any)
 *		s@				's@spinnerID TEST'					 - enables spinner mode. Has to be separated by space. Requires unique spinnerID after @ sign.
 *		d@				'd@'								 - disables dialog choice. Player will not be able to select such dialog choice. Does not have to be separated by space.
 *		al@				'al@'								 - aligns text to left. Does not have to be separated by space.
 *		ac@				'ac@'								 - aligns text to center. Does not have to be separated by space.
 *		ar@				'ar@'								 - aligns text to right. Does not have to be separated by space.
 *		o@				'o@[format]:TEST~'					 - adds text in between : ~ as an overlay with its own format (unique color or alignment). Don't use with fonts changing text height - this is not supported yet.
 *						'o@h@00CC66 hs@66FFB2:TEST~'			- colors modifiers
 *						'o@ar@ h@00CC66 hs@66FFB2:TEST~'		- alignment modifiers
 *						'o@tab@8:TEST~'					 	 	- tab offset modifier
 *
 *		hidden@			'hidden@'							 - removes dialog choice from dialog box.
 *
 *		indOff@			'indOff@'							 - does not create spinner / answer indicators
 *		item@			'item@self:ItMiNugget'				 - creates 'item preview' - passively opens inventory for specified npc (default self) with focusing on specified item - will display item info
 *
 */

// -- Global vars --

//Answer / Input field
var string InfoManagerAnswer;

//Spinner
var int InfoManagerSpinnerValue;
var string InfoManagerSpinnerID;

var int InfoManagerSpinnerValueMin;	//min value (can be set by key Home)
var int InfoManagerSpinnerValueMax;	//max value (can be set by key End)
var int InfoManagerSpinnerPageSize; //incremental increase (can be set by Page Up/Down)

var string InfoManagerSpinnerNumber;
var int InfoManagerSpinnerNumberEditMode;

//Last choice text - might be useful
var string InfoManageLastChoiceText;
var string InfoManageLastChoiceTextClean; //without EIM modifiers

//-- Internal constants, classes & variables --

const int cIM_RememberSelectedChoice_None = 0;			//Does nothing (default vanilla behaviour)
const int cIM_RememberSelectedChoice_All = 1;			//Moves cursor to last selected choice
const int cIM_RememberSelectedChoice_Spinners = 2;		//Moves cursor to last selected choice only when used with spinners

const string InfoManagerTabSize = "-";
const int ALIGN_TAB = 255;

const int EIM_OVERLAY_MAX = 255;
const int EIM_DIALOG_MAX = 255;

instance zCViewText2@ (zCViewText2);

/*
 *	Default values / 'API' customizaton
 */
class zEIM_Defaults {
	var int font;
	var int fontSelected;

	var int color;
	var int colorSelected;

	var int colorDisabled;
	var int colorDisabledSelected; //this should never happen :)

	var int alignment;

	var int indicatorColor;
	var int indicatorAlpha;

	var string spinnerIndicatorString;
	var string answerIndicatorString;

	var int spinnerIndicatorAnimation;
	var int answerIndicatorAnimation;

	var int numKeyControls;
	var int numKeyNumbers;

	var int alphaBlendFunc;

	var int rememberSelectedChoice;
};

/*
 *	Description parsing
 */
class zEIM_Description {
	var int thisView; //zCViewText2*

	var int isSelected;
	var int choiceIndex;

	var int font;
	var int fontSelected;

	var string fontName;
	var string fontNameSelected;

	var int color;
	var int colorSelected;

	var int isAnswer;

	var int isSpinner;
	var string spinnerID;
	var int spinnerLoopingOff;

	var int alignment;
	var int tabOffset;

	var int hasOverlay;
	var int isHidden;
	var int isDisabled;

	var int indicatorsOff;

	var int hasItemPreview;

	var int itemInstance1;
	var int npcInstance1;
	var int itemInstance2;
	var int npcInstance2;
};

/*
 *	Overlay data
 */

class zEIM_Overlays {
	var string overlayID[EIM_OVERLAY_MAX];

	var int overlayPtr[EIM_OVERLAY_MAX]; //zCViewText2*
	var int overlayChoiceIndex[EIM_OVERLAY_MAX];

	var int overlayColor[EIM_OVERLAY_MAX];
	var int overlayColorSelected[EIM_OVERLAY_MAX];

	var int overlayIndex; //tracking current index of parsed overlay
	var int nextAvailableOverlayIndex; //tracking next available index of parsed overlay

	var int overlayCount; //number of created overlays
};

/*
 *	Enhanced info manager data
 */
class zEIM {
	var string dialogCachedDescriptions[EIM_DIALOG_MAX]; //cached dialog descriptions
	var int dialogCachedCount;

	var string dialogSpinnerID[EIM_DIALOG_MAX]; //spinner IDs

	var int dialogColor[EIM_DIALOG_MAX];
	var int dialogColorSelected[EIM_DIALOG_MAX];

	var int dialogDisabled[EIM_DIALOG_MAX]; //track which dialogues are disabledd

	var int isDisabled;
	var int lastChoiceSelected;
	var int lastChoiceSelectedMode;
	var int wasUpdated;

	var int answerMode;

	var int displayAnswerIndicator;
	var int displaySpinnerIndicator;
	var int displayItemPreview;

	var int alignment; //alignment of selected choice

	var int itemPreviewVisible;

	var int itemInstance1;
	var int npcInstance1;
	var int itemInstance2;
	var int npcInstance2;

	//Answer indicator
	var int answerIndicatorPtr;
	var int answerAniProgress;

	//Spinner indicators
	var int leftSpinnerIndicatorPtr;
	var int rightSpinnerIndicatorPtr;
	var int spinnerAniProgress;

	var int spinnerLoopingOff;

	var int diaInstancePtr[EIM_DIALOG_MAX];
	var int diaInstancePtrCount;

	var int infosCollected;
	var int choicesCollected;

	var int infosCollectedAllDisabled;

	var int refresh;

	var int ready; //0 - not ready, 1 - infos collected, 2 - choices collected, 3 - ready
};

instance zEIM_Defaults@(zEIM_Defaults) {};
instance zEIM_Description@(zEIM_Description) {};
instance zEIM_Overlays@(zEIM_Overlays) {};
instance zEIM@(zEIM) {};

var zEIM_Defaults eimDefaults;
var zEIM_Description eimDescription;
var zEIM_Overlays eimOverlays;
var zEIM eim;

/*
 *	Description parsing
 */
func void EIM_ParseDescription(var int strPtr) {
	var string t; t = STR_EMPTY;
	var string s; s = MEM_ReadString(strPtr);

    var int len; len = STR_Len(s);
    var int buf; buf = STR_toChar(s);

	var int b;

    var int i; i = 0;

	var int j;
	var int k;
	var int l;

	var int wasUpdated; wasUpdated = FALSE;

	var string modifier;
	var string modifierParams;

	var string s1;
	var string s2;
	var string s3;

	var int fromIndex; fromIndex = 0;
	var int isOverlay; isOverlay = FALSE;

	//Reset modifier data
	eimDescription.fontName = STR_EMPTY;
	eimDescription.fontNameSelected = STR_EMPTY;

	eimDescription.isAnswer = FALSE;
	eimDescription.isSpinner = FALSE;
	eimDescription.spinnerID = STR_EMPTY;
	eimDescription.spinnerLoopingOff = FALSE;

	eimDescription.tabOffset = 0;

	eimDescription.hasOverlay = FALSE;

	eimDescription.isHidden = FALSE;
	eimDescription.isDisabled = FALSE;

	eimDescription.indicatorsOff = FALSE;

	eimDescription.hasItemPreview = FALSE;
	eimDescription.itemInstance1 = -1;
	eimDescription.npcInstance1 = -1;
	eimDescription.itemInstance2 = -1;
	eimDescription.npcInstance2 = -1;

	//Defaults
	eimDescription.alignment = eimDefaults.alignment;
	eimDescription.color = eimDefaults.color;
	eimDescription.colorSelected = eimDefaults.colorSelected;

	//Reset index for overlays
	eimOverlays.overlayIndex = 0;

	var string overlayText;
	var string thisID;

	var int ptr;
	var int fontPtr;

	var zCViewText2 thisView;
	var zCViewText2 overlayView;

	if (!MEM_InformationMan.dlgChoice) { return; };
	var zCViewDialogChoice dlgChoice; dlgChoice = _^(MEM_InformationMan.dlgChoice);

	var int defaultPosX; defaultPosX = dlgChoice.sizeMargin_0[0];

	thisView = _^(eimDescription.thisView);

    while(i < len);
        b = MEM_ReadInt(buf + i) & 255;

		//All modifiers are identified by @ char - search for it first!
		if (b == 64) {
			//Reset
			modifier = STR_EMPTY;
			modifierParams = STR_EMPTY;

			//Extract modifier
			j = i - 1;
			while(j >= 0);
				b = MEM_ReadInt(buf + j) & 255;
				//' ', '~'
				if ((b == 32) || (b == 126)) {
					j += 1;
					break;
				};
				modifier = ConcatStrings(BtoC(b), modifier);
				j -= 1;
			end;

			if (j < 0) { j = 0; };

			//Overlay - in this first loop we will ignore it
			if (Hlp_StrCmp(modifier, "o"))
			{
				eimDescription.hasOverlay = TRUE;

				k = i + 1;
				b = 0;
				while(k < len);
					b = MEM_ReadInt(buf + k) & 255;
					if (b == 126) {
						break;
					};
					modifierParams = ConcatStrings(modifierParams, BtoC(b));
					k += 1;
				end;

				if (k > len) { k = len; };

				//Build 'clean' description string
				s1 = mySTR_SubStr(s, fromIndex, (k - fromIndex + 1));
				t = ConcatStrings(t, s1);

				//Move needle to the end of modifier
				i = k;
				fromIndex = i + 1;

				wasUpdated = TRUE;
			};

			//Parse parameters
			if (Hlp_StrCmp(modifier, "f"))
			|| (Hlp_StrCmp(modifier, "fs"))
			|| (Hlp_StrCmp(modifier, "h"))
			|| (Hlp_StrCmp(modifier, "hs"))
			|| (Hlp_StrCmp(modifier, "s"))
			|| (Hlp_StrCmp(modifier, "tab"))
			|| (Hlp_StrCmp(modifier, "item"))

			|| (Hlp_StrCmp(modifier, "a"))
			|| (Hlp_StrCmp(modifier, "d"))
			|| (Hlp_StrCmp(modifier, "al"))
			|| (Hlp_StrCmp(modifier, "ac"))
			|| (Hlp_StrCmp(modifier, "ar"))
			|| (Hlp_StrCmp(modifier, "spinnerLoopingOff"))
			|| (Hlp_StrCmp(modifier, "hidden"))
			|| (Hlp_StrCmp(modifier, "indOff"))
			{
				k = i + 1;
				b = 0;
				while(k < len);
					b = MEM_ReadInt(buf + k) & 255;
					//Default modifier separator is SPACE
					//Overlay modifier can have SPACE, COLON and ~
					if (b == 32) {
						k += 1;
						break;
					};

					modifierParams = ConcatStrings(modifierParams, BtoC(b));
					k += 1;
				end;

				if (k > len) { k = len; };

				//Build 'clean' description string
				s1 = mySTR_SubStr(s, fromIndex, (j - fromIndex));
				t = ConcatStrings(t, s1);

				//Move needle to the end of modifier
				i = k;
				fromIndex = i;

				wasUpdated = TRUE;
			};

			//Update modifier params
			if (Hlp_StrCmp(modifier, "f")) {
				eimDescription.fontName = modifierParams;
				eimDescription.font = Print_GetFontPtr(eimDescription.fontName);
			} else
			if (Hlp_StrCmp(modifier, "fs")) {
				eimDescription.fontNameSelected = modifierParams;
				eimDescription.fontSelected = Print_GetFontPtr(eimDescription.fontNameSelected);
			} else
			if (Hlp_StrCmp(modifier, "h")) {
				eimDescription.color = HEX2RGBA(modifierParams);
			} else
			if (Hlp_StrCmp(modifier, "hs")) {
				eimDescription.colorSelected = HEX2RGBA(modifierParams);
			} else
			if (Hlp_StrCmp(modifier, "s")) {
				eimDescription.isSpinner = TRUE;
				eimDescription.spinnerID = modifierParams;
			} else
			if (Hlp_StrCmp(modifier, "a")) {
				eimDescription.isAnswer = TRUE;
			} else
			if (Hlp_StrCmp(modifier, "d")) {
				eimDescription.isDisabled = TRUE;
				eimDescription.color = eimDefaults.colorDisabled;
				eimDescription.colorSelected = eimDefaults.colorDisabledSelected;
			} else
			if (Hlp_StrCmp(modifier, "al")) {
				eimDescription.alignment = ALIGN_LEFT;
			} else
			if (Hlp_StrCmp(modifier, "ac")) {
				eimDescription.alignment = ALIGN_CENTER;
			} else
			if (Hlp_StrCmp(modifier, "ar")) {
				eimDescription.alignment = ALIGN_RIGHT;
			} else
			//if (Hlp_StrCmp(modifier, "tab")) {
			//	eimDescription.alignment = ALIGN_TAB;
			//	eimDescription.tabOffset = STR_ToInt(modifierParams);
			//} else
			if (Hlp_StrCmp(modifier, "item")) {
				var string itemInstanceName;
				var string npcInstanceName;

				eimDescription.hasItemPreview = TRUE;

				//Default self
				var oCNpc npc; npc = _^(MEM_InformationMan.npc);

				//Get item and npc instance
				//item@self:ItMiNugget
				l = STR_IndexOf(modifierParams, ":");
				if (l > -1) {
					npcInstanceName = mySTR_SubStr(modifierParams, 0, l);
					itemInstanceName = mySTR_SubStr(modifierParams, l + 1, STR_Len(modifierParams) - (l + 1));

					var int symbID; symbID = MEM_GetSymbolIndex(npcInstanceName);
					if (symbID > -1) {
						npc = Hlp_GetNpc(symbID);
					};
				} else {
					itemInstanceName = modifierParams;
				};

				var int itemInstance; itemInstance = -1;
				var int npcInstance; npcInstance = Hlp_GetInstanceID(npc);

				if (Npc_HasItemInstanceName(npc, itemInstanceName)) {
					itemInstance = Hlp_GetInstanceID(item);
				};

				if ((itemInstance > -1) && (npcInstance > -1))
				{
					if (eimDescription.itemInstance1 == -1) {
						eimDescription.itemInstance1 = itemInstance;
						eimDescription.npcInstance1 = npcInstance;
					} else {
						eimDescription.itemInstance2 = itemInstance;
						eimDescription.npcInstance2 = npcInstance;
					};
				};
			} else
			if (Hlp_StrCmp(modifier, "spinnerLoopingOff")) {
				eimDescription.spinnerLoopingOff = TRUE;
			} else
			if (Hlp_StrCmp(modifier, "hidden")) {
				eimDescription.isHidden = TRUE;
			} else
			if (Hlp_StrCmp(modifier, "indOff")) {
				eimDescription.indicatorsOff = TRUE;
			};
		};

		i += 1;
	end;

	if (wasUpdated) {
		//Build final string
		if (fromIndex < len) {
			s1 = mySTR_SubStr(s, fromIndex, len - (fromIndex));
			t = ConcatStrings(t, s1);
		};

		MEM_WriteString(strPtr, t);
	};

	//Run second loop - only if we have overlays
	if (!eimDescription.hasOverlay) {
		return;
	};

	var int overlayAlignment;
	var int overlayColor;
	var int overlayColorSelected;
	var int overlayTabOffset;
	var int overlayPosX;

	//Set default font
	if (eimDescription.isSelected) {
		fontPtr = eimDescription.fontSelected;
	} else {
		fontPtr = eimDescription.font;
	};

	overlayPosX = thisView.pixelPositionX;

	var int insertNewOverlay;

	wasUpdated = FALSE;

	t = STR_EMPTY;
	s = MEM_ReadString(strPtr);

	len = STR_Len(s);
	buf = STR_toChar(s);

	i = 0;
	fromIndex = 0;

	while(i < len);
		b = MEM_ReadInt(buf + i) & 255;

		if (isOverlay) {
			//o@[params]:[text]~
			//Colon - end of modifier parameters
			if (b == 58) {
				//Extract overlay text
				j = i + 1;
				b = 0;
				while(j < len);
					b = MEM_ReadInt(buf + j) & 255;
					if (b == 126) {
						break;
					};

					overlayText = ConcatStrings(overlayText, BtoC(b));
					j += 1;
				end;

				if (j > len) { j = len; };

				//Move needle to the end of modifier
				i = j;
				fromIndex = i + 1;

				wasUpdated = TRUE;

				if (STR_Len(overlayText) == 0) {
					i += 1;
					continue;
				};

				//By default assume this is new overlay
				insertNewOverlay = TRUE;

				//Do not insert overlays in answer/input mode
				if (eim.answerMode)
				&& (eimDescription.isAnswer)
				&& (eimDescription.isSelected)
				{
					insertNewOverlay = FALSE;
				};

				if (insertNewOverlay)
				{
					//Check max limit
					if (eimOverlays.overlayCount >= EIM_OVERLAY_MAX) {
						insertNewOverlay = FALSE;
					};

					//Update/create overlay
					//Build overlay ID
					thisID = IntToString(eimDescription.choiceIndex);
					thisID = ConcatStrings(thisID, ".");
					thisID = ConcatStrings(thisID, IntToString(eimOverlays.overlayIndex));

					eimOverlays.nextAvailableOverlayIndex = -1;

					j = 0;
					while(j < eimOverlays.overlayCount);
						//Find next available overlay index
						if (eimOverlays.nextAvailableOverlayIndex == -1) {
							if (MEM_ReadIntArray(_@ (eimOverlays.overlayChoiceIndex), j) == -1) {
								eimOverlays.nextAvailableOverlayIndex = j;
							};
						};

						//If overlay with this ID already exists in list of all overlays - update it
						if (Hlp_StrCmp(MEM_ReadStringArray(_@s(eimOverlays.overlayID), j), thisID)) {
							//Update overlay text and colors
							ptr = MEM_ReadIntArray(_@(eimOverlays.overlayPtr), j);
							if (ptr) {
								overlayView = _^(ptr);

								//Update text
								overlayView.text = overlayText;

								//Update position
								//Inline with text
								if (overlayAlignment == -1) {
									overlayView.pixelPositionX = overlayPosX;
									//Update position for next string
									overlayPosX += Font_GetStringWidthPtr(overlayText, fontPtr);
								} else
								if (overlayAlignment == ALIGN_LEFT) {
									overlayView.pixelPositionX = defaultPosX;
								} else
								if (overlayAlignment == ALIGN_CENTER) {
									overlayView.pixelPositionX = (dlgChoice.pixelSizeX / 2) - (Font_GetStringWidthPtr(overlayText, fontPtr) / 2) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

									if (overlayView.pixelPositionX < defaultPosX) {
										overlayView.pixelPositionX = defaultPosX;
									};
								} else
								if (overlayAlignment == ALIGN_RIGHT) {
									overlayView.pixelPositionX = dlgChoice.pixelSizeX - Font_GetStringWidthPtr(overlayText, fontPtr) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

									if (overlayView.pixelPositionX < defaultPosX) {
										overlayView.pixelPositionX = defaultPosX;
									};
								} else
								if (overlayAlignment == ALIGN_TAB) {
									overlayView.pixelPositionX = defaultPosX + Font_GetStringWidthPtr(InfoManagerTabSize, fontPtr) * overlayTabOffset;
								};
							};

							insertNewOverlay = FALSE;
							break;
						};

						j += 1;
					end;

					if (insertNewOverlay) {
						//Increase index if needed
						if (eimOverlays.nextAvailableOverlayIndex == -1) {
							eimOverlays.nextAvailableOverlayIndex = eimOverlays.overlayCount;
							eimOverlays.overlayCount += 1;
						};

						//Create new zCViewText2 instance for overlay
						ptr = create(zCViewText2@);
						overlayView = _^(ptr);

						//Copy properties from 'parent' dialogue view
						overlayView.enabledColor = thisView.enabledColor;
						overlayView.font = thisView.font;

						overlayView.enabledBlend = thisView.enabledBlend;
						overlayView.funcAlphaBlend = thisView.funcAlphaBlend;

						//Update text
						overlayView.text = overlayText;

						//In line with text
						if (overlayAlignment == -1) {
							overlayView.pixelPositionX = overlayPosX;
							//Update position for next string
							overlayPosX += Font_GetStringWidthPtr(overlayText, fontPtr);
						} else
						//align left
						if (overlayAlignment == ALIGN_LEFT) {
							overlayView.pixelPositionX = defaultPosX;
						} else
						//align center
						if (overlayAlignment == ALIGN_CENTER) {
							overlayView.pixelPositionX = (dlgChoice.pixelSizeX / 2) - (Font_GetStringWidthPtr(overlayText, fontPtr) / 2) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

							if (overlayView.pixelPositionX < defaultPosX) {
								overlayView.pixelPositionX = defaultPosX;
							};
						} else
						//align right
						if (overlayAlignment == ALIGN_RIGHT) {
							overlayView.pixelPositionX = dlgChoice.pixelSizeX - Font_GetStringWidthPtr(overlayText, fontPtr) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

							if (overlayView.pixelPositionX < defaultPosX) {
								overlayView.pixelPositionX = defaultPosX;
							};
						} else
						if (overlayAlignment == ALIGN_TAB) {
							overlayView.pixelPositionX = defaultPosX + Font_GetStringWidthPtr(InfoManagerTabSize, fontPtr) * overlayTabOffset;
						};

						//We will exploit this variable a little bit
						overlayView.timer = eimOverlays.nextAvailableOverlayIndex;
						overlayView.enabledTimer = FALSE;

						//Insert indicator to dialog choices
						MEM_ArrayInsert(_@(dlgChoice.listTextLines_array), ptr);

						MEM_WriteStringArray(_@s(eimOverlays.overlayID), eimOverlays.nextAvailableOverlayIndex, thisID);

						//MEM_WriteStatStringArr(eimOverlays.overlayID, eimOverlays.nextAvailableOverlayIndex, thisID);

						MEM_WriteIntArray(_@(eimOverlays.overlayColor), eimOverlays.nextAvailableOverlayIndex, overlayColor);
						MEM_WriteIntArray(_@(eimOverlays.overlayColorSelected), eimOverlays.nextAvailableOverlayIndex, overlayColorSelected);

						MEM_WriteIntArray(_@(eimOverlays.overlayPtr), eimOverlays.nextAvailableOverlayIndex, ptr);
						MEM_WriteIntArray(_@(eimOverlays.overlayChoiceIndex), eimOverlays.nextAvailableOverlayIndex, eimDescription.choiceIndex);

						//MEM_WriteIntArray(_@(eimOverlays.overlayPosX), eimOverlays.nextAvailableOverlayIndex, overlayView.pixelPositionX);

						//-->
						overlayView.pixelPositionY = thisView.pixelPositionY;

						//Update color
						if (eimDescription.isSelected) {
							overlayView.color = overlayColorSelected;
							overlayView.alpha = GetAlpha(overlayColorSelected);
						} else {
							overlayView.color = overlayColor;
							overlayView.alpha = GetAlpha(overlayColor);
						};
						//<--

						//Reset values for next overlay
						if (eimOverlays.overlayCount < EIM_OVERLAY_MAX) {
							MEM_WriteIntArray(_@ (eimOverlays.overlayPtr), eimOverlays.overlayCount, 0);
							MEM_WriteIntArray(_@ (eimOverlays.overlayChoiceIndex), eimOverlays.overlayCount, -1);
						};
					};

					//Convert rest of the dialogue description to overlay!
					if (fromIndex < len)
					{
						//Get overlay leftover
						var string overlayLeftover;
						overlayLeftover = mySTR_SubStr(s, fromIndex, (len - fromIndex));

						//Search for overlay
						j = STR_IndexOf(overlayLeftover, "o@");

						//No more overlays - convert remaining string to overlay
						if (j == -1) {
							s1 = mySTR_SubStr(s, 0, fromIndex);
							s = Concat4Strings(s1, "o@:", overlayLeftover, "~");

							//Update len and buf
							len = STR_Len(s);
							buf = STR_toChar(s);
						} else
						//If there is any string between overlays - convert this substring into an overlay
						if (j > 0) {
							s1 = mySTR_SubStr(s, 0, fromIndex);

							//Get substring
							s2 = mySTR_Prefix(overlayLeftover, j);
							s2 = Concat3Strings("o@:", s2, "~");

							s3 = mySTR_SubStr(overlayLeftover, j, STR_Len(overlayLeftover) - j);

							s = Concat3Strings(s1, s2, s3);

							//Update len and buf
							len = STR_Len(s);
							buf = STR_toChar(s);
						};
					};

					eimOverlays.overlayIndex += 1;
				};

				//End of overlay
				isOverlay = FALSE;
			};

			//This should not be required...
			//if (b == 126) {
			//	isOverlay = FALSE;
			//};
		};

		//All modifiers are identified by @ char - search for it first!
		if (b == 64) {
			//Reset
			modifier = STR_EMPTY;
			modifierParams = STR_EMPTY;

			//Extract modifier
			j = i - 1;
			while(j >= 0);
				b = MEM_ReadInt(buf + j) & 255;
				//Default modifier separator is SPACE
				//Overlay modifier can have SPACE, COLON and ~
				if ((b == 32) || (b == 64) || (b == 126)) {
					j += 1;
					break;
				};
				modifier = ConcatStrings(BtoC(b), modifier);
				j -= 1;
			end;

			if (j < 0) { j = 0; };

			//Overlay
			if (Hlp_StrCmp(modifier, "o"))
			{
				isOverlay = TRUE;

				//Reset overlay vars
				overlayColor = eimDescription.color;
				overlayColorSelected = eimDescription.colorSelected;
				overlayAlignment = -1;
				overlayTabOffset = 0;
				overlayText = STR_EMPTY;

				//Build 'clean' description string
				s1 = mySTR_SubStr(s, fromIndex, (j - fromIndex));
				t = ConcatStrings(t, s1);

				//Update position for next string
				overlayPosX += Font_GetStringWidthPtr(s1, fontPtr);

				wasUpdated = TRUE;
			};

			if (isOverlay) {
				if (Hlp_StrCmp(modifier, "h"))
				|| (Hlp_StrCmp(modifier, "hs"))

				|| (Hlp_StrCmp(modifier, "al"))
				|| (Hlp_StrCmp(modifier, "ac"))
				|| (Hlp_StrCmp(modifier, "ar"))

				|| (Hlp_StrCmp(modifier, "tab"))
				{
					k = i + 1;
					b = 0;
					while(k < len);
						b = MEM_ReadInt(buf + k) & 255;
						//Default modifier separator is SPACE
						//Overlay modifier can have SPACE, COLON and ~
						if ((b == 32) || (b == 58) || (b == 126)) {
							k += 1;
							break;
						};

						modifierParams = ConcatStrings(modifierParams, BtoC(b));
						k += 1;
					end;
				};

				if (Hlp_StrCmp(modifier, "h")) {
					overlayColor = HEX2RGBA(modifierParams);
				} else
				if (Hlp_StrCmp(modifier, "hs")) {
					overlayColorSelected = HEX2RGBA(modifierParams);
				} else
				if (Hlp_StrCmp(modifier, "al")) {
					overlayAlignment = ALIGN_LEFT;
				} else
				if (Hlp_StrCmp(modifier, "ac")) {
					overlayAlignment = ALIGN_CENTER;
				} else
				if (Hlp_StrCmp(modifier, "ar")) {
					overlayAlignment = ALIGN_RIGHT;
				} else
				if (Hlp_StrCmp(modifier, "tab")) {
					overlayAlignment = ALIGN_TAB;
					overlayTabOffset = STR_ToInt(modifierParams);
				};
			};
		};

		i += 1;
	end;

	if (wasUpdated) {
		//Build final string
		if (fromIndex < len) {
			s1 = mySTR_SubStr(s, fromIndex, len - (fromIndex));
			t = ConcatStrings(t, s1);
		};

		MEM_WriteString(strPtr, t);
	};
};

/*
 *	Helper functions
 */
func int Choice_IsDisabled (var string s) {
	if (STR_IndexOf(s, "d@ ") > -1) {
		return TRUE;
	};

	return FALSE;
};

func int Choice_IsHidden (var string s) {
	if (STR_IndexOf(s, "hidden@") > -1) {
		return TRUE;
	};

	return FALSE;
};

/*
 *	Reset values
 */
func void EIM_Reset () {
	eim.ready = 0; //not ready
	eim.diaInstancePtrCount = 0;
	eim.infosCollectedAllDisabled = FALSE;
};

func int EIM_GetInfoPtr (var int index) {
	if ((index < 0) || (index >= eim.diaInstancePtrCount)) {
		return 0;
	};

	return MEM_ReadIntArray (_@ (eim.diaInstancePtr), index);
};

func void EIM_AnimateIndicators () {
	var int answerWidth;

	var int spaceWidth;
	var int spinnerWidthL;
	var int spinnerWidthR;

	const int MOVE_MAX_PIXELS = 15;

	var zCViewText2 answerIndicator;
	var zCViewText2 spinnerIndicatorL;
	var zCViewText2 spinnerIndicatorR;

	if (!MEM_InformationMan.dlgChoice) { return; };
	var zCViewDialogChoice dlgChoice; dlgChoice = _^ (MEM_InformationMan.dlgChoice);

	//Animate answer indicator
	if (eim.displayAnswerIndicator)
	&& (eim.answerIndicatorPtr)
	{
		answerIndicator = _^(eim.answerIndicatorPtr);

		if (eim.answerAniProgress > 2) {
			eim.answerAniProgress = 0;
		};

		if (eim.answerAniProgress == 0) {
			answerIndicator.text = ".";
		} else
		if (eim.answerAniProgress == 1) {
			answerIndicator.text = "..";
		} else
		if (eim.answerAniProgress == 2) {
			answerIndicator.text = "...";
		};

		//Adjust alignment of answer indicator (opposite to dialogue alignemnt)
		answerWidth = Font_GetStringWidthPtr ("...", answerIndicator.font);

		if ((eim.alignment == ALIGN_LEFT) || (eim.alignment == ALIGN_CENTER)) {
			answerIndicator.pixelPositionX = dlgChoice.pixelSizeX - answerWidth - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_1[0];
		} else {
			answerIndicator.pixelPositionX = dlgChoice.sizeMargin_0[0];
		};
	};

	//Animate spinner indicator
	if (eim.displaySpinnerIndicator)
	&& (eim.leftSpinnerIndicatorPtr)
	&& (eim.rightSpinnerIndicatorPtr)
	{
		//'Left' part
		spinnerIndicatorL = _^ (eim.leftSpinnerIndicatorPtr);
		spinnerIndicatorL.text = "<--";

		//'Right' part
		spinnerIndicatorR = _^ (eim.rightSpinnerIndicatorPtr);
		spinnerIndicatorR.text = "-->";

		spinnerWidthL = Font_GetStringWidthPtr(spinnerIndicatorL.text, spinnerIndicatorL.font);
		spinnerWidthR = Font_GetStringWidthPtr(spinnerIndicatorR.text, spinnerIndicatorR.font);

		spaceWidth = zCFont_GetWidth (spinnerIndicatorL.font, CtoB (STR_SPACE));

		//Adjust alignment of spinner indicator (opposite to dialogue alignemnt)

		//Left one
		if (eim.alignment == ALIGN_LEFT) {
			spinnerIndicatorL.pixelPositionX = dlgChoice.pixelSizeX - ((spinnerWidthL + MOVE_MAX_PIXELS) + (spaceWidth) + (spinnerWidthR + MOVE_MAX_PIXELS)) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_1[0];
		} else
		if (eim.alignment == ALIGN_CENTER) {
			spinnerIndicatorL.pixelPositionX = dlgChoice.sizeMargin_0[0] + (MOVE_MAX_PIXELS);
		} else {
			spinnerIndicatorL.pixelPositionX = dlgChoice.sizeMargin_0[0] + (MOVE_MAX_PIXELS);
		};

		//Right one
		if (eim.alignment == ALIGN_LEFT) {
			spinnerIndicatorR.pixelPositionX = dlgChoice.pixelSizeX - (spinnerWidthR + MOVE_MAX_PIXELS) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_1[0];
		} else
		if (eim.alignment == ALIGN_CENTER) {
			spinnerIndicatorR.pixelPositionX = dlgChoice.pixelSizeX - (spinnerWidthR + MOVE_MAX_PIXELS) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_1[0];
		} else {
			spinnerIndicatorR.pixelPositionX = dlgChoice.sizeMargin_0[0] + ((spinnerWidthL + MOVE_MAX_PIXELS) + (spaceWidth) + (MOVE_MAX_PIXELS));
		};

		var int movePixels; movePixels = eim.spinnerAniProgress;

		//Left part to left
		if (movePixels < MOVE_MAX_PIXELS) {
			spinnerIndicatorL.pixelPositionX -= movePixels;
		} else

		//Left part back
		if (movePixels < MOVE_MAX_PIXELS * 2) {
			spinnerIndicatorL.pixelPositionX -= ((MOVE_MAX_PIXELS * 2) - movePixels);
		} else

		//Right part to right
		if (movePixels < MOVE_MAX_PIXELS * 3) {
			spinnerIndicatorR.pixelPositionX += (movePixels - (MOVE_MAX_PIXELS * 2));
		} else

		//Right part back
		if (movePixels < MOVE_MAX_PIXELS * 4) {
			spinnerIndicatorR.pixelPositionX += ((MOVE_MAX_PIXELS * 4) - movePixels);
		} else {
			//Reset ani
			eim.spinnerAniProgress = 0;
		};
	};
};

//
func string EIM_GetNumKeyString (var int index) {
	if (index < 1) || (index > 9) { return STR_EMPTY; };

	var string s;
//	s = "(";
//	s = ConcatStrings (s, IntToString (index));
//	s = ConcatStrings (s, ") ");
//	return s;

	//overlay version
	//RGBA
	s = "o@ h@FF800080 ";

	s = ConcatStrings (s, ":(");
	s = ConcatStrings (s, IntToString (index));
	s = ConcatStrings (s, ") ~");

	return s;
};

//"modifierID@modifierParams "
func string Choice_GetModifier (var string s, var string modifierID) {
	var int index; index = STR_IndexOf (s, modifierID);
	if (index == -1) { return STR_EMPTY; };

	var int len; len = STR_Len (s);
	var int lenModifier; lenModifier = STR_Len (modifierID);

	//Get modifier
	var string s1; s1 = mySTR_SubStr (s, index + lenModifier, len - lenModifier);
	index = STR_IndexOf (s1, STR_SPACE);

	if (index == -1) {
		index = STR_Len (s1);
	};

	var string modifierParams; modifierParams = mySTR_Prefix (s1, index);
	return modifierParams;
};

func void InfoManager_SetInfoChoiceText_BySpinnerID (var string text, var string spinnerID) {
	if (InfoManager_HasFinished ()) { return; };

	if (!MEM_InformationMan.dlgChoice) { return; };
	var zCViewDialogChoice dlgChoice; dlgChoice = _^ (MEM_InformationMan.dlgChoice);
	if (!dlgChoice.listTextLines_array) { return; };
	if (!dlgChoice.listTextLines_numInArray) { return; };

	//Choices - have to be extracted from oCInfo.listChoices_next
	//MEM_InformationMan.info is oCInfo pointer
	if (MEM_InformationMan.Mode == INFO_MGR_MODE_CHOICE) {
		if (MEM_InformationMan.info) {
			var oCInfo info;
			info = _^ (MEM_InformationMan.info);

			var zCList l;

			var int list; list = info.listChoices_next;

			while (list);
				l = _^ (list);

				if (l.data) {
					var oCInfoChoice infoChoice;
					infoChoice = _^ (l.data);

					If (Hlp_StrCmp (Choice_GetModifier (infoChoice.text, "s@"), spinnerID)) {
						infoChoice.text = text;
						return;
					};
				};

				list = l.next;
			end;
		};
	};
};

func string EIM_InfoManager_GetChoiceDescription (var int index) {
//	if (!MEM_InformationMan.IsWaitingForSelection) { return STR_EMPTY; };
	if (!MEM_InformationMan.dlgChoice) { return STR_EMPTY; };
	var zCViewDialogChoice dlgChoice; dlgChoice = _^ (MEM_InformationMan.dlgChoice);
	if (!dlgChoice.listTextLines_array) { return STR_EMPTY; };
	if (!dlgChoice.listTextLines_numInArray) { return STR_EMPTY; };

	if ((index >= 0) && (index < dlgChoice.listTextLines_numInArray)) {
		var int infoPtr;
		var oCInfo info;

		if (MEM_InformationMan.Mode == INFO_MGR_MODE_INFO)
		{
			//infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr (MEM_InformationMan.npc, MEM_InformationMan.player, index);
			infoPtr = EIM_GetInfoPtr(index);

			if (infoPtr) {
				info = _^(infoPtr);
				return info.description;
			};
		} else
		//Choices - have to be extracted from oCInfo.listChoices_next
		//MEM_InformationMan.info is oCInfo pointer
		if (MEM_InformationMan.Mode == INFO_MGR_MODE_CHOICE) {
			infoPtr = MEM_InformationMan.info;

			if (infoPtr) {
				info = _^(infoPtr);

				//loop counter for all Choices
				var int i; i = 0;

				var oCInfoChoice infoChoice;

				var int list; list = info.listChoices_next;
				var zCList l;

				while (list);
					l = _^ (list);
					if (l.data) {
						//if our dialog option is dialog choice - put text to dlgDescription
						if (i == index) {
							infoChoice = _^(l.data);
							return infoChoice.Text;
						};
					};

					list = l.next;
					i += 1;
				end;
			};
		};
	};

	return STR_EMPTY;
};

func void InfoManager_SelectLastChoice () {
	if (!MEM_InformationMan.dlgChoice) { return; };
	var zCViewDialogChoice dlgChoice; dlgChoice = _^ (MEM_InformationMan.dlgChoice);
	zCViewDialogChoice_Select(dlgChoice.Choices - 1);
};

func void InfoManager_SkipDisabledDialogChoices (var int key) {
	var string s;

	var zCViewDialogChoice dlgChoice;
	var int nextChoiceIndex;
	var int lastChoiceIndex;

	if (!MEM_InformationMan.dlgChoice) { return; };
	dlgChoice = _^ (MEM_InformationMan.dlgChoice);
	lastChoiceIndex = dlgChoice.ChoiceSelected;
	nextChoiceIndex = lastChoiceIndex;

	var int loop; loop = MEM_StackPos.position;

	if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp")) || (key == MOUSE_WHEEL_UP))
	{
		nextChoiceIndex -= 1;

		if (nextChoiceIndex < 0) {
			nextChoiceIndex = dlgChoice.Choices - 1;
		};
	};

	if ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown")) || (key == MOUSE_WHEEL_DOWN))
	{
		nextChoiceIndex += 1;

		if (nextChoiceIndex >= dlgChoice.Choices) {
			nextChoiceIndex = 0;
		};
	};

	s = EIM_InfoManager_GetChoiceDescription (nextChoiceIndex);

	eim.isDisabled = FALSE;

	if (Choice_IsDisabled (s)) {
		//Auto-scrolling
		if (key == -1) {
			key = MEM_GetKey ("keyDown");
			zCViewDialogChoice_SelectNext ();
			MEM_StackPos.position = loop;
		};

		eim.isDisabled = TRUE;

		//Prevent infinite loops
		if (nextChoiceIndex != lastChoiceIndex) {
			if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp")) || (key == MOUSE_WHEEL_UP)) {
				zCViewDialogChoice_SelectPrevious ();
			} else {
				zCViewDialogChoice_SelectNext ();
			};

			MEM_StackPos.position = loop;
		};
	};
};

func void _hook_zCViewDialogChoice_HandleEvent_EIM () {
	var string s;

	//'Refresh' dialogs (in case that there is just 1 dialog choice)
	//eim.wasUpdated = FALSE;

	var int key; key = MEM_ReadInt (ESP + 4);

	var int cancel; cancel = FALSE;
	var int update; update = FALSE;

	var int len;
	//cancel mouse input in event handler
	//524	2050 - Left Mouse button
	//525	2052 - Right Mouse button
	//526        - Middle Mouse button
	//527        -
	//528        -
	//522	2057 - Wheel up
	//523	2058 - Wheel down

	/*
	if (key == 2050) {
		//Do not cancel if user double-clicked
		if (InfoManagerMouseDoubleClick) {
			InfoManagerMouseDoubleClick = FALSE;
			//Overwrite in case we want to enter answer mode
			key = KEY_RETURN;
		} else {
			cancel = TRUE;
		};
	};
	if (key == 2052) {
		cancel = TRUE;
	};
	*/

	const int mem = 0;
	if (!mem) { mem = MEM_Alloc(1); };

	//cancel selection by KEY_TAB (causing auto-selection in combination with Alt + Tab)
	if (key == KEY_TAB) {
		cancel = TRUE;
	};

	//Work with input only in case InfoManager is waiting for an input
	if (MEM_InformationMan.IsWaitingForSelection) {

		//G2A tweak - dialog confirmation with SPACE
		//Additionally we will allow confirmation via numpad enter
		if (!eim.displayAnswerIndicator) {
			if ((key == KEY_SPACE) || (key == KEY_NUMPADENTER)) { key = KEY_RETURN; update = TRUE; };
		} else {
			if (!eim.answerMode)
			&& ((key == KEY_SPACE) || (key == KEY_NUMPADENTER)) { key = KEY_RETURN; };
		};

		//-- Answer

		//eim.displayAnswerIndicator is set by _hook_oCInformationManager_Update_EnhancedInfoManager
		if (eim.displayAnswerIndicator) {
			//cancel answer mode
			if (eim.answerMode) {
				if (key == KEY_ESCAPE) {
					eim.refresh = TRUE;
					eim.answerMode = FALSE;
					InfoManagerAnswer = STR_EMPTY;
				};
			};

			//Enter answer mode / confirm answer
			if (key == KEY_RETURN) {
				//If answer mode was not enabled
				if (!eim.answerMode) {
					//Reset answer
					InfoManagerAnswer = STR_EMPTY;
				};

				//on/off
				eim.answerMode = !eim.answerMode;

				//Refresh all overlays (remove in answer more ... add when done)
				eim.refresh = TRUE;
			};

			s = STR_EMPTY;

			if (eim.answerMode) {
				var int shift;
				shift = (MEM_KeyState (KEY_LSHIFT) == KEY_PRESSED) | (MEM_KeyState (KEY_LSHIFT) == KEY_HOLD) | (MEM_KeyState (KEY_RSHIFT) == KEY_PRESSED) | (MEM_KeyState (KEY_RSHIFT) == KEY_HOLD);

				if (key == KEY_1) { if (shift) { s = "!"; } else { s = "1"; }; };
				if (key == KEY_2) { if (shift) { s = "@"; } else { s = "2"; }; };
				if (key == KEY_3) { if (shift) { s = "#"; } else { s = "3"; }; };
				if (key == KEY_4) { if (shift) { s = "$"; } else { s = "4"; }; };
				if (key == KEY_5) { if (shift) { s = "%"; } else { s = "5"; }; };
				if (key == KEY_6) { if (shift) { s = "^"; } else { s = "6"; }; };
				if (key == KEY_7) { if (shift) { s = "&"; } else { s = "7"; }; };
				if (key == KEY_8) { if (shift) { s = "*"; } else { s = "8"; }; };
				if (key == KEY_9) { if (shift) { s = "("; } else { s = "9"; }; };
				if (key == KEY_0) { if (shift) { s = ")"; } else { s = "0"; }; };

				if (key == KEY_MINUS) { if (shift) { s = "-"; } else { s = "_"; }; };
				if (key == KEY_EQUALS) { if (shift) { s = "+"; } else { s = "="; }; };

				//Backspace
				if (key == KEY_BACK) {
					len = STR_Len (InfoManagerAnswer);

					if (len == 1) {
						InfoManagerAnswer = STR_EMPTY;
					} else
					if (len > 1) {
						InfoManagerAnswer = mySTR_SubStr (InfoManagerAnswer, 0, len - 1);
					};
				};

				if (key == KEY_Q) { if (shift) { s = "Q"; } else { s = "q"; }; };
				if (key == KEY_W) { if (shift) { s = "W"; } else { s = "w"; }; };
				if (key == KEY_E) { if (shift) { s = "E"; } else { s = "e"; }; };
				if (key == KEY_R) { if (shift) { s = "R"; } else { s = "r"; }; };
				if (key == KEY_T) { if (shift) { s = "T"; } else { s = "t"; }; };
				if (key == KEY_Y) { if (shift) { s = "Y"; } else { s = "y"; }; };
				if (key == KEY_U) { if (shift) { s = "U"; } else { s = "u"; }; };
				if (key == KEY_I) { if (shift) { s = "I"; } else { s = "i"; }; };
				if (key == KEY_O) { if (shift) { s = "O"; } else { s = "o"; }; };
				if (key == KEY_P) { if (shift) { s = "P"; } else { s = "p"; }; };

				if (key == KEY_LBRACKET) { if (shift) { s = "{"; } else { s = "["; }; };
				if (key == KEY_RBRACKET) { if (shift) { s = "}"; } else { s = "]"; }; };

				if (key == KEY_A) { if (shift) { s = "A"; } else { s = "a"; }; };
				if (key == KEY_S) { if (shift) { s = "S"; } else { s = "s"; }; };
				if (key == KEY_D) { if (shift) { s = "D"; } else { s = "d"; }; };
				if (key == KEY_F) { if (shift) { s = "F"; } else { s = "f"; }; };
				if (key == KEY_G) { if (shift) { s = "G"; } else { s = "g"; }; };
				if (key == KEY_H) { if (shift) { s = "H"; } else { s = "h"; }; };
				if (key == KEY_J) { if (shift) { s = "J"; } else { s = "j"; }; };
				if (key == KEY_K) { if (shift) { s = "K"; } else { s = "k"; }; };
				if (key == KEY_L) { if (shift) { s = "L"; } else { s = "l"; }; };

				if (key == KEY_SEMICOLON) { if (shift) { s = ":"; } else { s = ";"; }; };
				if (key == KEY_APOSTROPHE) { if (shift) {
						//Double quote
						MEM_WriteByte (mem, 34);
						s = STR_FromChar (mem);
					} else {
						s = "'";
					};
				};

				if (key == KEY_GRAVE) { if (shift) { s = "~"; } else { s = "`"; }; };

				//I left backslash commented out, because it is escape character that caused my N++ to format rest of the code 'incorrectly' :)
				//So this way we will have both nice code format as well as an option to write backslash :)
				if (key == KEY_BACKSLASH) { if (shift) {
						s = STR_PIPE;
					} else {
						//Backslash
						MEM_WriteByte (mem, 92);
						s = STR_FromChar (mem);
					};
				};

				if (key == KEY_Z) { if (shift) { s = "Z"; } else { s = "z"; }; };
				if (key == KEY_X) { if (shift) { s = "X"; } else { s = "x"; }; };
				if (key == KEY_C) { if (shift) { s = "C"; } else { s = "c"; }; };
				if (key == KEY_V) { if (shift) { s = "V"; } else { s = "v"; }; };
				if (key == KEY_B) { if (shift) { s = "B"; } else { s = "b"; }; };
				if (key == KEY_N) { if (shift) { s = "N"; } else { s = "n"; }; };
				if (key == KEY_M) { if (shift) { s = "M"; } else { s = "m"; }; };

				if (key == KEY_COMMA) { if (shift) { s = "<"; } else { s = ","; }; };
				if (key == KEY_PERIOD) { if (shift) { s = ">"; } else { s = "."; }; };
				if (key == KEY_SLASH) { if (shift) { s = "?"; } else { s = "/"; }; };

				if (key == KEY_SPACE) { s = STR_SPACE; };

				if (key == KEY_NUMPAD0) { s = "0"; };
				if (key == KEY_NUMPAD1) { s = "1"; };
				if (key == KEY_NUMPAD2) { s = "2"; };
				if (key == KEY_NUMPAD3) { s = "3"; };
				if (key == KEY_NUMPAD4) { s = "4"; };
				if (key == KEY_NUMPAD5) { s = "5"; };
				if (key == KEY_NUMPAD6) { s = "6"; };
				if (key == KEY_NUMPAD7) { s = "7"; };
				if (key == KEY_NUMPAD8) { s = "8"; };
				if (key == KEY_NUMPAD9) { s = "9"; };

				if (key == KEY_MULTIPLY) { s = "*"; };
				if (key == KEY_SUBTRACT) { s = "-"; };
				if (key == KEY_ADD) { s = "+"; };
				if (key == KEY_DECIMAL) { s = "."; };

				if (STR_Len (s) > 0) {
					InfoManagerAnswer = ConcatStrings (InfoManagerAnswer, s);
				};

				cancel = TRUE; //cancel input
			};
		} else

		//-- Spinner

		if (eim.displaySpinnerIndicator) {
			var int lastSpinnerValue; lastSpinnerValue = InfoManagerSpinnerValue;

			//Default value if not set
			if (InfoManagerSpinnerPageSize == 0) { InfoManagerSpinnerPageSize = 5; };

			//Get Left Shift key status
			var int lShift;

			lShift = MEM_KeyState (KEY_LSHIFT);

			if ((lShift == KEY_PRESSED) || (lShift == KEY_HOLD)) {
				if (key == MOUSE_WHEEL_DOWN) {
					key = MEM_GetKey ("keyLeft");
				};

				if (key == MOUSE_WHEEL_UP) {
					key = MEM_GetKey ("keyRight");
				};
			};

			//Home
			if (key == KEY_HOME) {
				InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
				cancel = TRUE;
			} else

			//End
			if (key == KEY_END) {
				InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
				cancel = TRUE;
			} else

			//Page Up --> - InfoManagerSpinnerPageSize
			if (key == KEY_PRIOR) {
				//
				//12 --> 10 --> 5 --> 1 --> 12
				if (InfoManagerSpinnerValue > InfoManagerSpinnerValueMin) {
					if (((InfoManagerSpinnerValue / InfoManagerSpinnerPageSize) * InfoManagerSpinnerPageSize) < InfoManagerSpinnerValue) {
						InfoManagerSpinnerValue = (InfoManagerSpinnerValue / InfoManagerSpinnerPageSize) * InfoManagerSpinnerPageSize;
					} else {
						InfoManagerSpinnerValue -= InfoManagerSpinnerPageSize;
					};

					if (InfoManagerSpinnerValue < InfoManagerSpinnerValueMin) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
					};
				} else {
					if (eim.spinnerLoopingOff) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
					} else {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
					};
				};

				cancel = TRUE;
			} else

			//Page Down --> + InfoManagerSpinnerPageSize
			if (key == KEY_NEXT) {
				//1 --> 5 --> 10 --> 12 --> 1
				if (InfoManagerSpinnerValue < InfoManagerSpinnerValueMax) {
					if ((((InfoManagerSpinnerValue / InfoManagerSpinnerPageSize) + 1) * InfoManagerSpinnerPageSize) > InfoManagerSpinnerValue) {
						InfoManagerSpinnerValue = ((InfoManagerSpinnerValue / InfoManagerSpinnerPageSize) + 1) * InfoManagerSpinnerPageSize;
					} else {
						InfoManagerSpinnerValue += InfoManagerSpinnerPageSize;
					};

					if (InfoManagerSpinnerValue > InfoManagerSpinnerValueMax) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
					};
				} else {
					if (eim.spinnerLoopingOff) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
					} else {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
					};
				};

				cancel = TRUE;
			} else

			if ((key == MEM_GetKey ("keyLeft")) || (key == MEM_GetSecondaryKey ("keyLeft")) || (key == MEM_GetKey ("keyStrafeLeft")) || (key == MEM_GetSecondaryKey ("keyStrafeLeft")))
			{
				InfoManagerSpinnerValue -= 1;
				cancel = TRUE;
			} else

			if ((key == MEM_GetKey ("keyRight")) || (key == MEM_GetSecondaryKey ("keyRight")) || (key == MEM_GetKey ("keyStrafeRight")) || (key == MEM_GetSecondaryKey ("keyStrafeRight")))
			{
				InfoManagerSpinnerValue += 1;
				cancel = TRUE; //cancel input (just in case)
			};

			//Edit number
			if (key == KEY_NUMPAD0) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "0"); cancel = TRUE; };
			if (key == KEY_NUMPAD1) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "1"); cancel = TRUE; };
			if (key == KEY_NUMPAD2) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "2"); cancel = TRUE; };
			if (key == KEY_NUMPAD3) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "3"); cancel = TRUE; };
			if (key == KEY_NUMPAD4) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "4"); cancel = TRUE; };
			if (key == KEY_NUMPAD5) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "5"); cancel = TRUE; };
			if (key == KEY_NUMPAD6) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "6"); cancel = TRUE; };
			if (key == KEY_NUMPAD7) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "7"); cancel = TRUE; };
			if (key == KEY_NUMPAD8) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "8"); cancel = TRUE; };
			if (key == KEY_NUMPAD9) { InfoManagerSpinnerNumber = ConcatStrings (InfoManagerSpinnerNumber, "9"); cancel = TRUE; };

			//Reset value
			if (key == KEY_ESCAPE) {
				InfoManagerSpinnerNumber = STR_EMPTY;
				InfoManagerSpinnerNumberEditMode = FALSE;
				cancel = TRUE;
			};

			//Backspace
			if (key == KEY_BACK) {
				len = STR_Len (InfoManagerSpinnerNumber);

				if (len == 0) {
					if (!InfoManagerSpinnerNumberEditMode) {
						InfoManagerSpinnerNumber = IntToString (InfoManagerSpinnerValue);
						InfoManagerSpinnerNumberEditMode = TRUE;
					};
				} else
				if (len == 1) {
					InfoManagerSpinnerNumberEditMode = TRUE;
					InfoManagerSpinnerNumber = STR_EMPTY;
				} else
				if (len > 1) {
					InfoManagerSpinnerNumber = mySTR_SubStr (InfoManagerSpinnerNumber, 0, len - 1);
				};

				cancel = TRUE;
			};

			if (!InfoManagerSpinnerNumberEditMode) {
				InfoManagerSpinnerNumberEditMode = STR_Len (InfoManagerSpinnerNumber);
			};

			//First ENTER stops 'editing' mode
			if (key == KEY_RETURN) {
				if (InfoManagerSpinnerNumberEditMode) {
					InfoManagerSpinnerValue = STR_ToInt (InfoManagerSpinnerNumber);

					//Reset value (
					InfoManagerSpinnerNumber = STR_EMPTY;
					InfoManagerSpinnerNumberEditMode = FALSE;

					cancel = TRUE;
					update = FALSE;
				};
			};

			if ((key == KEY_RETURN) || (key == MEM_GetKey ("keyAction")) || (key == MEM_GetSecondaryKey ("keyAction"))) {
				//Safety check - don't do anything if InfoManagerSpinnerValue is out of bounds!
				if ((InfoManagerSpinnerValue < InfoManagerSpinnerValueMin) || (InfoManagerSpinnerValue > InfoManagerSpinnerValueMax)) {
					//Update value
					if (InfoManagerSpinnerValue < InfoManagerSpinnerValueMin) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
					};

					if (InfoManagerSpinnerValue > InfoManagerSpinnerValueMax) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
					};

					cancel = TRUE;
					update = FALSE;
				};
			};

			if (cancel) {
				//Min/Max values
				if (InfoManagerSpinnerValue < InfoManagerSpinnerValueMin) {
					if (eim.spinnerLoopingOff) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
					} else {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
					};
				};

				if (InfoManagerSpinnerValue > InfoManagerSpinnerValueMax) {
					if (eim.spinnerLoopingOff) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
					} else {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
					};
				};
			};

			//Refresh all overlays (everything might have changed)
			//if (InfoManagerSpinnerValue != lastSpinnerValue) {
			//	InfoManagerRefreshOverlays = cIM_RefreshOverlays;
			//};
		};

		//-- Num Keys control

		if (!eim.answerMode) {
			//var int numKeyPressed; numKeyPressed = FALSE;

			if (eimDefaults.numKeyControls) {
				//Override Num Keys

				//2021-04-24
				//Seems like union is doing this already :-/ :-)
				const int unionActivatedCheck = 0;

				var int unionActivated;

				if (!unionActivatedCheck) {
					unionActivated = MEM_GothOptExists ("INTERNAL", "UnionActivated");
					unionActivatedCheck = 1;
				};

				if (!unionActivated) {
					if (key == KEY_0) { cancel = TRUE; };
					if (key == KEY_1) { key = KEY_0; update = TRUE; };
					if (key == KEY_2) { key = KEY_1; update = TRUE; };
					if (key == KEY_3) { key = KEY_2; update = TRUE; };
					if (key == KEY_4) { key = KEY_3; update = TRUE; };
					if (key == KEY_5) { key = KEY_4; update = TRUE; };
					if (key == KEY_6) { key = KEY_5; update = TRUE; };
					if (key == KEY_7) { key = KEY_6; update = TRUE; };
					if (key == KEY_8) { key = KEY_7; update = TRUE; };
					if (key == KEY_9) { key = KEY_8; update = TRUE; };
				};
			};

			//We have to refresh dialog colors
			//if ((key == KEY_0) || (key == KEY_1) || (key == KEY_2) || (key == KEY_3) || (key == KEY_4) || (key == KEY_5)
			//|| (key == KEY_6) || (key == KEY_7) || (key == KEY_8) || (key == KEY_9)) {
			//	numKeyPressed = TRUE;
			//};

			//if (InfoManagerRefreshOverlays == cIM_RefreshNothing)
			//&& (numKeyPressed)
			//{
			//	InfoManagerRefreshOverlays = cIM_RefreshDialogColors;
			//};
		};

		//-- Additional tweaks

		//cancel KEY_BACKSPACE (opens up inventory in G1 - override does not work!)
		if (key == KEY_BACK) {
			cancel = TRUE;
		};

		//cancel KEY_GRAVE changes fight mode to fist mode, this caused some issues ... we will use it for a better purpose - move cursor to last dialog choice
		if (key == KEY_GRAVE) {
			//Don't change position if answer mode / input field is activated
			if (!eim.answerMode) {
				InfoManager_SelectLastChoice ();
				InfoManager_SkipDisabledDialogChoices (-1);
				eim.refresh = TRUE;
				cancel = TRUE;
			};
		};

		if (key == KEY_RETURN) {
			//Skip disabled dialog choices
			InfoManager_SkipDisabledDialogChoices (-1);
		};

		//Skip disabled dialog choices
		if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp")) || (key == MOUSE_WHEEL_UP))
		|| ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown")) || (key == MOUSE_WHEEL_DOWN))
		{
			InfoManager_SkipDisabledDialogChoices (key);
		};
	};

	//cancel input if InfoManager is waiting for anything
	if (MEM_InformationMan.IsWaitingForEnd)
	|| (MEM_InformationMan.IsWaitingForOpen)
	|| (MEM_InformationMan.IsWaitingForClose)
//	|| (MEM_InformationMan.IsWaitingForScript) this would prevent us from cancelling output units
	{
		cancel = TRUE;
	};

	//Safety check in case of disabled dialog choice
	if (eim.isDisabled) {
		if (key == KEY_RETURN) {
			cancel = TRUE;
			update = FALSE;
		};
	};

	if (cancel) {
		//EDI has to be also nulled --> otherwise for example with Backspace Inventory opens up
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};

	if (update) {
		MEM_WriteInt (ESP + 4, key);
		EDI = key;
	};
};

func void EIM_CloseItemPreview ()
{
	if (eim.itemPreviewVisible) {
		Npc_CloseInventory(eim.npcInstance1);
		Npc_CloseInventory(eim.npcInstance2);

		eim.npcInstance1 = -1;
		eim.npcInstance2 = -1;

		eim.itemPreviewVisible = FALSE;
	};
};

func void _hook_oCInformationManager_Update_EIM () {
	if (!MEM_Game.infoman) { return; };

	//Close item preview
	if (MEM_InformationMan.IsDone)
	|| (MEM_InformationMan.IsWaitingForClose)
	|| (MEM_InformationMan.IsWaitingForScript)
	|| (MEM_InformationMan.IsWaitingForEnd)
	{
		//Close item preview every time we are waiting for something
		EIM_CloseItemPreview ();
	};

	//Don't run if done
	if (MEM_InformationMan.IsDone) { return; };

	//Don't run if opening / closing / in dialogue / ending
	if (MEM_InformationMan.IsWaitingForOpen) { return; };
	if (MEM_InformationMan.IsWaitingForClose) { return; };
	if (MEM_InformationMan.IsWaitingForScript) { return; };
	if (MEM_InformationMan.IsWaitingForEnd) { return; };

	//Don't run during trading
	if (MEM_InformationMan.Mode == INFO_MGR_MODE_TRADE) { return; };

	//More safety checks
	if (!MEM_InformationMan.dlgChoice) { return; };
	var zCViewDialogChoice dlgChoice; dlgChoice = _^ (MEM_InformationMan.dlgChoice);
	if (!dlgChoice.listTextLines_array) { return; };
	if (!dlgChoice.listTextLines_numInArray) { return; };

	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	//Do we have infos collected?
	if (eim.ready == 0)
	{
		if (eim.infosCollected) {
			eim.ready = 1; //infos collected
		};

		if (eim.choicesCollected) {
			eim.ready = 2; //choices collected
		};
	};

	if (eim.ready == 0) { return; };

	//If all dialogues are disabled --> add exit option!
	if (eim.infosCollectedAllDisabled) {
		if (MEM_InformationMan.IndexBye == -1) {
			//0x00759590 public: void __fastcall zCViewDialogChoice::AddChoice(class zSTRING &,int)
			const int zCViewDialogChoice__AddChoice_G1 = 7706000;

			//0x0068F710 public: void __fastcall zCViewDialogChoice::AddChoice(class zSTRING &,int)
			const int zCViewDialogChoice__AddChoice_G2 = 6878992;

			MEM_InformationMan.IndexBye = dlgChoice.choices;

			CALL_IntParam(0);
			CALL__fastcall(MEM_InformationMan.dlgChoice, _@s(DIALOG_ENDE), MEMINT_SwitchG1G2(zCViewDialogChoice__AddChoice_G1, zCViewDialogChoice__AddChoice_G2));
		};
	};

	var zCArray arr; arr = _^ (_@ (dlgChoice.listTextLines_array));

	//crash
	//zCInputCallback_SetHandleEventTop (MEM_InformationMan.dlgChoice);

	var int i;
	var int j;
	var int k;

	var int loop;

	var zCViewText2 txt;

	var zCViewText2 spinnerIndicatorL;
	var zCViewText2 spinnerIndicatorR;
	var zCViewText2 answerIndicator;

	var zCViewText2 overlayView;
	var zCViewText2 parentView;

	var int infoPtr;
	var oCInfo info;

	var int overlayPtr;

	var int refreshOverlays; refreshOverlays = FALSE;
	var int refreshOverlayColors; refreshOverlayColors = FALSE;

	//Default colors
	var int readColor;

	var int color;
	var int colorSelected;

//---

	var int defaultPosX;

	//Horizontal text scrolling
	var int horizontalScrolling;
		const int HSCROLL_IDLE		= 0; //wont do anything
		const int HSCROLL_INIT		= 1; //waits for a while ... then starts scrolling
		const int HSCROLL_SCROLL	= 2; //scrolls text, once done it will force reset
		const int HSCROLL_WAIT		= 3; //waits for a while ... then resets text
		const int HSCROLL_RESET		= 4; //reset indicator

	var int timerHorizontalScrolling;
	var int horizontalScrollingChoiceNumber;

	//Horizontal text scrolling for disabled dialogues
	var int horizontalScrollingDisabled;
	var int timerHorizontalScrollingDisabled;

	var int timerSpinnerAnimation;
	var int timerAnswerAnimation;

	var int symbID;

	var int isDisabled;

//---

	//if (InfoManagerRefreshOverlays == cIM_RefreshDialogColors) {
	//	InfoManagerRefreshOverlays = cIM_RefreshNothing;
	//	refreshOverlayColors = TRUE;
	//};

//--> zSpy debug
//	var int lastNpc;
//	var string lastMethod;
//	if (lastNpc != MEM_InformationMan.npc) {
//		var oCNpc npc; npc = _^ (MEM_InformationMan.npc);
//		zSpy_Info (ConcatStrings ("EIM.npc ", IntToString (npc.IDX)));
//		lastNpc = MEM_InformationMan.npc;
//	};

//	if ((!Hlp_StrCmp (lastMethod, MEM_InformationMan.LastMethod))) {
//		zSpy_Info (ConcatStrings ("EIM.lastMethod: ", MEM_InformationMan.LastMethod));
//		lastMethod = MEM_InformationMan.LastMethod;
//	};
//<--

	//Init
	if (eim.ready < 3) {
		//Load all dialogues
		eim.diaInstancePtrCount = 0;
		while (eim.diaInstancePtrCount < dlgChoice.Choices && (eim.diaInstancePtrCount < EIM_DIALOG_MAX));
			infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr (MEM_InformationMan.npc, MEM_InformationMan.player, eim.diaInstancePtrCount);
			MEM_WriteIntArray (_@ (eim.diaInstancePtr), eim.diaInstancePtrCount, infoPtr);

			eim.diaInstancePtrCount += 1;
		end;

		eim.refresh = TRUE;
		eim.ready = 3; //ready
	};

	if (eim.refresh) {
		eim.refresh = FALSE;

		//Reset pointers
		eim.answerIndicatorPtr = 0;
		eim.leftSpinnerIndicatorPtr = 0;
		eim.rightSpinnerIndicatorPtr = 0;

		eimOverlays.overlayCount = 0;

		//Reset value on CollectInfos/CollectChoices
		InfoManagerSpinnerNumber = STR_EMPTY;
		InfoManagerSpinnerNumberEditMode = FALSE;
		InfoManagerSpinnerID = STR_EMPTY;

		//Flag all overlays for deletion
		if (dlgChoice.listTextLines_numInArray > dlgChoice.Choices) {
			//arr = _^ (_@ (dlgChoice.listTextLines_array));

			if (arr.array) {
				i = dlgChoice.Choices;
				while (i < dlgChoice.listTextLines_numInArray);
					txt = _^ (MEM_ReadIntArray (arr.array, i));
					txt.enabledTimer = TRUE;
					txt.timer = FLOATNULL;
					i += 1;
				end;
			};
		};

		eim.dialogCachedCount = 0;
		//InfoManagerRefreshOverlays = cIM_RefreshNothing;
		refreshOverlays = TRUE;
		refreshOverlayColors = TRUE;

		horizontalScrolling = HSCROLL_IDLE;
		horizontalScrollingDisabled = HSCROLL_IDLE;

		//Reset
		MEM_WriteIntArray (_@(eimOverlays.overlayChoiceIndex), 0, -1);
		MEM_WriteIntArray (_@(eimOverlays.overlayPtr), 0, 0);
		MEM_WriteStringArray (_@s(eimOverlays.overlayID), 0, STR_EMPTY);

		if (eim.infosCollected) || (eim.choicesCollected)
		{
			if (eimDefaults.rememberSelectedChoice == cIM_RememberSelectedChoice_All)
			|| ((eimDefaults.rememberSelectedChoice == cIM_RememberSelectedChoice_Spinners) && (eim.displaySpinnerIndicator))
			{
				if (eim.lastChoiceSelectedMode != dlgChoice.ChoiceSelected) {
					if (eim.lastChoiceSelectedMode < dlgChoice.choices) {
						//Restore previous cursor position
						dlgChoice.ChoiceSelected = eim.lastChoiceSelectedMode;
						//Show selected choice
						zCViewDialogChoice_ShowSelected ();
						//Force auto-scrolling update
						eim.lastChoiceSelected = -1;
					};
				};
			};
		};
	};

	if (eim.lastChoiceSelected != dlgChoice.ChoiceSelected) {
		//Reset value when choice changes
		InfoManagerSpinnerNumber = STR_EMPTY;
		InfoManagerSpinnerNumberEditMode = FALSE;

		InfoManagerSpinnerID = STR_EMPTY;

		InfoManageLastChoiceText = STR_EMPTY;
		InfoManageLastChoiceTextClean = STR_EMPTY;

		//Internal vars
		eim.alignment = eimDefaults.alignment;
		eim.displayAnswerIndicator = FALSE;
		eim.displaySpinnerIndicator = FALSE;
		eim.displayItemPreview = FALSE;

		//Auto-scrolling for disabled dialog choices
		InfoManager_SkipDisabledDialogChoices (-1);
	};

	//Horizontal text scrolling - reset if selection changed / if scrolling was reset
	if (horizontalScrolling) {
		if ((horizontalScrollingChoiceNumber != dlgChoice.ChoiceSelected) || (horizontalScrolling == HSCROLL_RESET)) {
			if (horizontalScrolling == HSCROLL_RESET) {
				horizontalScrolling = HSCROLL_INIT;
				timerHorizontalScrolling = 0;
			} else {
				horizontalScrolling = HSCROLL_IDLE;
			};

			//timerHorizontalScrolling += MEM_Timer.frameTime;

			//Reset cached dialog --> this will update dialog choice text
			if (horizontalScrollingChoiceNumber >= 0 && horizontalScrollingChoiceNumber < EIM_DIALOG_MAX) {
				MEM_WriteStringArray (_@s (eim.dialogCachedDescriptions), horizontalScrollingChoiceNumber, STR_EMPTY);
			};
		};
	};

	if (horizontalScrollingDisabled) {
		if (horizontalScrollingDisabled == HSCROLL_RESET) {
			horizontalScrollingDisabled = HSCROLL_INIT;
			timerHorizontalScrollingDisabled = 0;
			//timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			//Reset cached dialogue --> this will update dialog choice text

			i = 0;
			while (i < dlgChoice.choices);

				isDisabled = MEM_ReadIntArray (_@ (eim.dialogDisabled), i);
				if (isDisabled) {
					//Reset cached dialog --> this will update dialog choice text
					if (i < EIM_DIALOG_MAX) {
						MEM_WriteStringArray (_@s (eim.dialogCachedDescriptions), i, STR_EMPTY);
					};
				};

				i += 1;
			end;
		};
	};

	var int retVal;

	var int choiceConditionEvaluated; choiceConditionEvaluated = FALSE;
	var int rerunDiaCondition; rerunDiaCondition = FALSE;

	var oCInfoChoice infoChoice;
	var int list;
	var zCList l;

	if (dlgChoice.listTextLines_array)
	&& (dlgChoice.listTextLines_numInArray)
	{
		var int nextPosY;
		var string dlgFont;
		var string dlgFontSelected;

		var int dlgFontPtr;
		var int dlgFontSelectedPtr;

		var string oldDescription;
		var string dlgDescription;
		var int descriptionAvailable;

		//--> This piece of code will re-evaluate all condition functions (oCInfoManager_GetInfoUnimportant) and detect description changes
		i = 0;
		nextPosY = 0;

		loop = dlgChoice.Choices;
		if (loop > arr.numInArray) {
			loop = arr.numInArray;
		};

		while (i < loop);

			//Recalculate Y pos
			var int ptr; ptr = MEM_ReadIntArray (arr.array, i);
			txt = _^(ptr);

			txt.enabledBlend = TRUE;
			txt.funcAlphaBlend = eimDefaults.alphaBlendFunc;

			var int loop_Spinner; loop_Spinner = MEM_StackPos.position;

			//Get current fontame
			if (eimDefaults.font) {
				dlgFontPtr = eimDefaults.font;
			} else {
				dlgFontPtr = txt.font;
			};

			if (eimDefaults.fontSelected) {
				dlgFontSelectedPtr = eimDefaults.fontSelected;
			} else {
				dlgFontSelectedPtr = dlgFontPtr;
			};

			eimDescription.font = dlgFontPtr;
			eimDescription.fontSelected = dlgFontSelectedPtr;
			eimDescription.isSelected = (i == dlgChoice.choiceSelected);
			eimDescription.thisView = ptr;
			eimDescription.choiceIndex = i;

			dlgDescription = STR_EMPTY;
			descriptionAvailable = FALSE;

			infoPtr = 0;

			if (i < eim.dialogCachedCount) {
				oldDescription = MEM_ReadStringArray (_@s (eim.dialogCachedDescriptions), i);
			} else {
				oldDescription = STR_EMPTY;
			};

			if (MEM_InformationMan.Mode == INFO_MGR_MODE_INFO) {
				//infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr (MEM_InformationMan.npc, MEM_InformationMan.player, i);
				infoPtr = EIM_GetInfoPtr (i);

				if (infoPtr) {
					info = _^ (infoPtr);

					//--> re-evaluate dialog conditions
					self = _^ (MEM_InformationMan.npc);
					other = _^ (MEM_InformationMan.player);

					retVal = FALSE;

					if (info.conditions > -1) {
						MEM_CallByID (info.conditions);
						retVal = MEMINT_PopInt();
					};
					//<--

					dlgDescription = info.description;
					descriptionAvailable = TRUE;
				};
			} else

			//Choices - have to be extracted from oCInfo.listChoices_next
			//MEM_InformationMan.info is oCInfo pointer
			if (MEM_InformationMan.Mode == INFO_MGR_MODE_CHOICE) {

				infoPtr = MEM_InformationMan.info;

				if (infoPtr) {
					info = _^ (infoPtr);

					//--> re-evaluate dialog conditions
					//Prevent multiple calls for each choice - if already evaluated!
					if (!choiceConditionEvaluated) {
						self = _^ (MEM_InformationMan.npc);
						other = _^ (MEM_InformationMan.player);

						retVal = FALSE;
						if (info.conditions > -1) {
							MEM_CallByID (info.conditions);
							retVal = MEMINT_PopInt();
						};

						choiceConditionEvaluated = TRUE;
					};
					//<--

					//infoPtr = 0;

					j = 0;
					list = info.listChoices_next;
					while (list);
						l = _^ (list);

						//if our dialog option is dialog choice - put text to dlgDescription
						if (l.data) {
							if (i == j) {
								//choicePtr = l.data;
								infoChoice = _^ (l.data);
								dlgDescription = infoChoice.Text;
								descriptionAvailable = TRUE;
								break;
							};
						};

						list = l.next;
						j += 1;
					end;
				};
			};

			//Replace default 'ENDE.' with constant value DIALOG_ENDE
			if (!descriptionAvailable) {
				if ((MEM_InformationMan.IndexBye > -1) && (i == 0)) {
					txt = _^ (MEM_ReadIntArray (arr.array, MEM_InformationMan.IndexBye));

					if (Hlp_StrCmp (txt.text, "ENDE.")) {
						dlgDescription = DIALOG_ENDE;
						descriptionAvailable = TRUE;
					};
				};
			};

			//if (i >= dlgChoice.LineStart)
			//&& (txt.pixelPositionY + dlgChoice.offsetTextPixelY - dlgChoice.sizeMargin_0[1] <= dlgChoice.pixelSizeY)
			//{
			//Store in cache
			if (descriptionAvailable) {
				if (i >= eim.dialogCachedCount) {
					if (i < EIM_DIALOG_MAX) {
						MEM_WriteStringArray (_@s (eim.dialogCachedDescriptions), i, dlgDescription);
						eim.dialogCachedCount += 1;
						eim.wasUpdated = FALSE;
					};
				} else {
					//Compare with cached description
					if (!Hlp_StrCmp (oldDescription, dlgDescription)) {
						//Update cache
						MEM_WriteStringArray (_@s (eim.dialogCachedDescriptions), i, dlgDescription);

						//description changed!
						eim.wasUpdated = FALSE;
					};
				};

				if (i == dlgChoice.ChoiceSelected) {
					InfoManageLastChoiceText = dlgDescription;
				};
			};

			if (!eim.wasUpdated) || (refreshOverlays)
			{
				/*
				TODO: Potential for optimization:
				Atm we are removing all overlays for changed dialog choice and then code below re-evaluates description - since all of them are deleted, code will in some cases add new version of them.
				We should check what exactly was changed - and if for example only color/text is changed then we should only update colors/texts.
				*/

				//--> Remove old overlays for this dialog choice
				j = 0;
				while (j < eimOverlays.overlayCount);
					if (MEM_ReadIntArray (_@ (eimOverlays.overlayChoiceIndex), j) == i) {
						overlayPtr = MEM_ReadIntArray (_@ (eimOverlays.overlayPtr), j);
						if (overlayPtr) {
							MEM_WriteIntArray (_@(eimOverlays.overlayChoiceIndex), j, -1);
							MEM_WriteIntArray (_@(eimOverlays.overlayPtr), j, 0);
							MEM_WriteStringArray (_@s(eimOverlays.overlayID), j, STR_EMPTY);

							//Let engine release object
							overlayView = _^ (overlayPtr);
							overlayView.enabledTimer = TRUE;
							overlayView.timer = FLOATNULL;

							refreshOverlayColors = TRUE;
						};
					};

					j += 1;
				end;
				//<-- remove old overlays

				//Default values
				color = eimDefaults.color;
				colorSelected = eimDefaults.colorSelected;

				//alignment = eimDefaults.alignment;

				if (descriptionAvailable) {
					defaultPosX = dlgChoice.sizeMargin_0[0];

					if (eimDefaults.numKeyNumbers) {
						dlgDescription = ConcatStrings (EIM_GetNumKeyString(i + 1), dlgDescription);
					};

					EIM_ParseDescription(_@s(dlgDescription));

					//Well ... spinners are quite complex :)
					//Condition function updates everything spinner-related
					//However first time condition runs InfoManagerSpinnerID is not setup ... so only on second run EIM will refresh dialogue / choice descriptions
					//There is 1 frame - where dialogue description won't be updated - so this condition below checks whether spinner is selected - if yes - we will re-evaluate condition one more time.
					if (eimDescription.isSpinner && eimDescription.isSelected) {
						if (!rerunDiaCondition) {
							rerunDiaCondition = TRUE;

							//Reset for dialogue with choices
							choiceConditionEvaluated = FALSE;
							MEM_StackPos.position = loop_Spinner;
						};
					};

					//Get font and color
					dlgFontPtr = eimDescription.font;
					dlgFontSelectedPtr = eimDescription.fontSelected;

					color = eimDescription.color;
					colorSelected = eimDescription.colorSelected;

					//Update selected choice
					if (eimDescription.isSelected) {
						InfoManageLastChoiceTextClean = dlgDescription;

						//Spinner looping
						eim.spinnerLoopingOff = eimDescription.spinnerLoopingOff;

						//Set alignemnt for selected choice
						eim.alignment = eimDescription.alignment;

						//Setup item preview
						if (eimDescription.hasItemPreview) {
							//Close item preview
							EIM_CloseItemPreview ();
							//eim.properties = eim.properties | dialogChoiceType_ItemPreview;

							eim.displayItemPreview = TRUE;

							eim.itemInstance1 = eimDescription.itemInstance1;
							eim.npcInstance1 = eimDescription.npcInstance1;
							eim.itemInstance2 = eimDescription.itemInstance2;
							eim.npcInstance2 = eimDescription.npcInstance2;
						};

						//Indicators
						if (!eimDescription.indicatorsOff) {
							//Answer
							if (eimDescription.isAnswer) {
								eim.displayAnswerIndicator = TRUE;
							};

							//Spinner
							if (eimDescription.isSpinner) {
								InfoManagerSpinnerID = eimDescription.spinnerID;
								eim.displaySpinnerIndicator = TRUE;
							};
						};

						//Update font ptr
						dlgFontPtr = dlgFontSelectedPtr;

						//Update color
						txt.color = colorSelected;
						txt.alpha = GetAlpha(colorSelected);
					} else {
						txt.color = color;
						txt.alpha = GetAlpha(color);
					};

					//Update spinner ID
					if (eimDescription.isSpinner) {
						if (i < EIM_OVERLAY_MAX) {
							MEM_WriteStringArray (_@s (eim.dialogSpinnerID), i, eimDescription.spinnerID);
						};
					};

					//Replace dialog option text with 'clean' dlgDescription
					txt.text = dlgDescription;

					//Update alignment
					if (eimDescription.alignment == ALIGN_LEFT) {
						txt.pixelPositionX = defaultPosX;
					} else
					if (eimDescription.alignment == ALIGN_CENTER) {
						txt.pixelPositionX = (dlgChoice.pixelSizeX / 2) - (Font_GetStringWidthPtr (txt.text, dlgFontPtr) / 2) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					} else
					if (eimDescription.alignment == ALIGN_RIGHT) {
						txt.pixelPositionX = dlgChoice.pixelSizeX - Font_GetStringWidthPtr (txt.text, dlgFontPtr) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					};

					//Store required properties
					if (i < EIM_DIALOG_MAX) {
						MEM_WriteIntArray (_@ (eim.dialogDisabled), i, eimDescription.isDisabled);
						MEM_WriteIntArray (_@ (eim.dialogColor), i, color);
						MEM_WriteIntArray (_@ (eim.dialogColorSelected), i, colorSelected);

						eim.wasUpdated = TRUE;
					};
				};
			};
			//};

			//Recalculate offsetTextpy and posY for dialog items in case fonts changed
			if (i < dlgChoice.Choices) {
				if (i == 0) {
					nextPosY = txt.pixelPositionY;
					dlgChoice.offsetTextPixelY = 0;
				} else {
					txt.pixelPositionY = nextPosY;
				};

				if (i < dlgChoice.LineStart) {
					dlgChoice.offsetTextPixelY -= zCFont_GetFontY (dlgFontPtr);
				};

				//Apply new font (or re-apply old one)
				//txt.font = Print_GetFontPtr (dlgFont);
				txt.font = dlgFontPtr;

				//
				nextPosY += zCFont_GetFontY (dlgFontPtr);
			};

			i += 1;
		end;

		if (eim.refresh) //?redundant, we reset var above
		|| (eim.lastChoiceSelected != dlgChoice.ChoiceSelected)
		|| (refreshOverlayColors)
		{
			/*
			class zCViewDialogChoice has 2 color properties - 1 for greyed out dialog, 1 for selected
			Whenever we change cursor position Gothic will re-apply colors to all dialogs using these values :-/
			Since we can have our own custom colors on each dialog choice we have to refresh colors every time cursor moves

			var int ColorSelected;		//zCOLOR //248
			var int ColorGrayed;		//zCOLOR //252
			*/
			//Small optimization - work only with visible dialogue choices
			i = dlgChoice.LineStart;

			while (i < dlgChoice.choices);
				txt = _^ (MEM_ReadIntArray (arr.array, i));

				//Small optimization - work only with visible dialogue choices
				if (txt.pixelPositionY + dlgChoice.offsetTextPixelY - dlgChoice.sizeMargin_0[1] > dlgChoice.pixelSizeY) {
					break;
				};

				if (i == dlgChoice.ChoiceSelected) {
					readColor = MEM_ReadIntArray (_@ (eim.dialogColorSelected), i);
					txt.color = readColor;
					txt.alpha = GetAlpha(readColor);

					//Horizontal scrolling - if dialogue text > dialogue window
					if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlgChoice.pixelSizeX - dlgChoice.sizeMargin_1[0])) {
						//Init scrolling
						horizontalScrolling = HSCROLL_INIT;
						timerHorizontalScrolling = 0;
						timerHorizontalScrolling += MEM_Timer.frameTime;
						horizontalScrollingChoiceNumber = dlgChoice.ChoiceSelected;
					};
				} else {
					readColor = MEM_ReadIntArray (_@ (eim.dialogColor), i);
					txt.color = readColor;
					txt.alpha = GetAlpha(readColor);

					//Check disabled dialogues --> do we need to scroll any horizontal text?
					isDisabled = MEM_ReadIntArray (_@ (eim.dialogDisabled), i);

					if (horizontalScrollingDisabled == HSCROLL_IDLE) {
						if (isDisabled) {
							//Horizontal scrolling - if dialogue text > dialogue window
							if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlgChoice.pixelSizeX - dlgChoice.sizeMargin_1[0])) {
								//Init scrolling
								horizontalScrollingDisabled = HSCROLL_INIT;
								timerHorizontalScrollingDisabled = 0;
								//timerHorizontalScrollingDisabled += MEM_Timer.frameTime;
							};
						};
					};
				};

				//TODO: do we need this?
				//Apply alpha function
				txt.enabledBlend = TRUE;
				txt.funcAlphaBlend = eimDefaults.alphaBlendFunc;

				i += 1;
			end;

			//--> Update overlay colors
			i = 0;

			while (i < eimOverlays.overlayCount);

				overlayPtr = MEM_ReadIntArray (_@ (eimOverlays.overlayPtr), i);

				if (overlayPtr) {
					overlayView = _^(overlayPtr);
					var int overlayChoiceIndex; overlayChoiceIndex = MEM_ReadIntArray (_@ (eimOverlays.overlayChoiceIndex), overlayView.timer);

					if (overlayChoiceIndex < dlgChoice.listTextLines_numInArray) {
						//adjust posY
						parentView = _^ (MEM_ReadIntArray(arr.array, overlayChoiceIndex));

						//var int pixelPositionX; pixelPositionX = MEM_ReadIntArray(_@(eimOverlays.overlayPosX), overlayView.timer);

						//Update Y pos
						overlayView.pixelPositionY = parentView.pixelPositionY;
						//overlayView.pixelPositionX = pixelPositionX;

						//Update color
						if (overlayChoiceIndex == dlgChoice.choiceSelected) {
							readColor = MEM_ReadIntArray (_@(eimOverlays.overlayColorSelected), overlayView.timer);
							overlayView.color = readColor;
							overlayView.alpha = GetAlpha(readColor);
						} else {
							readColor = MEM_ReadIntArray (_@(eimOverlays.overlayColor), overlayView.timer);
							overlayView.color = readColor;
							overlayView.alpha = GetAlpha(readColor);
						};
					};
				};

				i += 1;
			end;

			//<-- Overlays
		};

		//-- Answer

		if (eim.displayAnswerIndicator) {
			txt = _^ (MEM_ReadIntArray (arr.array, dlgChoice.ChoiceSelected));

			//Add answer indicator
			if (!eim.answerMode) {
				if (!eim.answerIndicatorPtr) {
					//txt.enabledBlend = TRUE;
					//txt.funcAlphaBlend = eimDefaults.alphaBlendFunc;

					//Create new zCViewText2 instance for our indicator
					eim.answerIndicatorPtr = create (zCViewText2@);
					answerIndicator = _^ (eim.answerIndicatorPtr);

					answerIndicator.text = eimDefaults.answerIndicatorString;

					answerIndicator.enabledBlend = txt.enabledBlend;
					answerIndicator.funcAlphaBlend = txt.funcAlphaBlend;
					//answerIndicator.alpha = eimDefaults.indicatorAlpha;

					//Insert indicator to dialog choices
					MEM_ArrayInsert (_@ (dlgChoice.listTextLines_array), eim.answerIndicatorPtr);

					//'Animate' to update positions (non animated indicator will get it's position updated below
					if (eimDefaults.answerIndicatorAnimation) {
						eim.answerAniProgress = 0;
						EIM_AnimateIndicators ();
					};

					timerAnswerAnimation = 450;
				};

				answerIndicator = _^ (eim.answerIndicatorPtr);
				answerIndicator.font = txt.font;

				answerIndicator.enabledColor = txt.enabledColor;

				answerIndicator.color = eimDefaults.indicatorColor;
				answerIndicator.alpha = GetAlpha (eimDefaults.indicatorColor);

				answerIndicator.pixelPositionY = txt.pixelPositionY;

				//Update alignment
				if (!eimDefaults.answerIndicatorAnimation)
				{
					if (eim.alignment == ALIGN_LEFT) || (eim.alignment == ALIGN_CENTER) {
						answerIndicator.pixelPositionX = dlgChoice.pixelSizeX - Font_GetStringWidthPtr (answerIndicator.text, answerIndicator.font) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];
					} else {
						answerIndicator.pixelPositionX = dlgChoice.sizeMargin_0[0];
					};
				} else
				{
					//Animation implemented without FrameFunctions
					timerAnswerAnimation += MEM_Timer.frameTime;
					if (timerAnswerAnimation > 450) {
						timerAnswerAnimation = 0;
						eim.answerAniProgress += 1;
						EIM_AnimateIndicators ();
					};
				};
			} else {
				//Replace description with current answer
				dlgDescription = ConcatStrings (InfoManagerAnswer, "_");
				txt.text = dlgDescription;

				//Update alignment
				if (eim.alignment == ALIGN_LEFT) {
					txt.pixelPositionX = defaultPosX;
				} else
				if (eim.alignment == ALIGN_CENTER) {
					txt.pixelPositionX = (dlgChoice.pixelSizeX / 2) - (Font_GetStringWidthPtr (txt.text, txt.font) / 2) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

					if (txt.pixelPositionX < defaultPosX) {
						txt.pixelPositionX = defaultPosX;
					};
				} else
				if (eim.alignment == ALIGN_RIGHT) {
					txt.pixelPositionX = dlgChoice.pixelSizeX - Font_GetStringWidthPtr (txt.text, txt.font) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_0[0];

					if (txt.pixelPositionX < defaultPosX) {
						txt.pixelPositionX = defaultPosX;
					};
				};
			};
		};

		//Remove if not required (or if we are already answering)
		if (!eim.displayAnswerIndicator) || (eim.answerMode) {
			if (eim.answerIndicatorPtr) {
				eim.refresh = TRUE;
			};
		};

		//-- Spinner

		if (eim.displaySpinnerIndicator) {
			//Get spinner ID
			//InfoManagerSpinnerID = MEM_ReadStringArray (_@s (eim.dialogSpinnerID), dlgChoice.ChoiceSelected);

			//Dokazeme tu pridat novy 'dialog' s transparentnym textom '<>' ako overlay ???
			//Funguje !

			txt = _^ (MEM_ReadIntArray (arr.array, dlgChoice.ChoiceSelected));

			//Create spinner indicators
			if (!eim.leftSpinnerIndicatorPtr) {
				//txt.enabledBlend = TRUE;
				//txt.funcAlphaBlend = eimDefaults.alphaBlendFunc;

				//Create 1st zCViewText2 instance for our indicator
				eim.leftSpinnerIndicatorPtr = create (zCViewText2@);
				MEM_ArrayInsert (_@ (dlgChoice.listTextLines_array), eim.leftSpinnerIndicatorPtr);

				//Create 2nd zCViewText2 instance for our indicator
				eim.rightSpinnerIndicatorPtr = create (zCViewText2@);
				MEM_ArrayInsert (_@ (dlgChoice.listTextLines_array), eim.rightSpinnerIndicatorPtr);

				//'Animate' to update positions (non animated indicator will get it's position updated below
				if (eimDefaults.spinnerIndicatorAnimation) {
					spinnerIndicatorL = _^ (eim.leftSpinnerIndicatorPtr);
					spinnerIndicatorL.font = txt.font;

					spinnerIndicatorR = _^ (eim.rightSpinnerIndicatorPtr);
					spinnerIndicatorR.font = txt.font;

					eim.spinnerAniProgress = 0;
					EIM_AnimateIndicators ();
				};

				timerSpinnerAnimation = 10;
			};

			//Update properties

			//'Left' part of spinner indicator
			spinnerIndicatorL = _^ (eim.leftSpinnerIndicatorPtr);

			if (!eimDefaults.spinnerIndicatorAnimation) {
				spinnerIndicatorL.text = eimDefaults.spinnerIndicatorString;
			};

			spinnerIndicatorL.enabledColor = txt.enabledColor;
			spinnerIndicatorL.font = txt.font;

			spinnerIndicatorL.enabledBlend = txt.enabledBlend;
			spinnerIndicatorL.funcAlphaBlend = txt.funcAlphaBlend;

			spinnerIndicatorL.color = eimDefaults.indicatorColor;
			spinnerIndicatorL.alpha = GetAlpha (eimDefaults.indicatorColor);

			spinnerIndicatorL.pixelPositionY = txt.pixelPositionY;

			//'Right' part of spinner indicator
			spinnerIndicatorR = _^ (eim.rightSpinnerIndicatorPtr);

			if (!eimDefaults.spinnerIndicatorAnimation) {
				//spinnerIndicatorR.text = eimDefaults.spinnerIndicatorString;
			};

			spinnerIndicatorR.enabledColor = txt.enabledColor;
			spinnerIndicatorR.font = txt.font;

			spinnerIndicatorR.enabledBlend = txt.enabledBlend;
			spinnerIndicatorR.funcAlphaBlend = txt.funcAlphaBlend;

			spinnerIndicatorR.color = eimDefaults.indicatorColor;
			spinnerIndicatorR.alpha = GetAlpha (eimDefaults.indicatorColor);

			spinnerIndicatorR.pixelPositionY = txt.pixelPositionY;

			if (!eimDefaults.spinnerIndicatorAnimation)
			{
				if (eim.leftSpinnerIndicatorPtr) {
					spinnerIndicatorL = _^ (eim.leftSpinnerIndicatorPtr);
					spinnerIndicatorL.text = eimDefaults.spinnerIndicatorString;

					//Adjust alignment of spinner indicator

					if (eim.alignment == ALIGN_LEFT) || (eim.alignment == ALIGN_CENTER) {
						spinnerIndicatorL.pixelPositionX = dlgChoice.pixelSizeX - Font_GetStringWidthPtr (spinnerIndicatorL.text, spinnerIndicatorL.font) - dlgChoice.offsetTextPixelX - dlgChoice.sizeMargin_1[0];
					} else {
						spinnerIndicatorL.pixelPositionX = dlgChoice.sizeMargin_0[0];
					};
				};
			} else {
				//Animation implemented without FrameFunctions
				timerSpinnerAnimation += MEM_Timer.frameTime;
				if (timerSpinnerAnimation > 10) {
					timerSpinnerAnimation = 0;

					eim.spinnerAniProgress += 1;
					EIM_AnimateIndicators ();
				};
			};
		} else
		{
			//Remove spinner if not required
			if (eim.leftSpinnerIndicatorPtr) {
				eim.refresh = TRUE;
			};
		};

		//-- Item preview

		if (eim.displayItemPreview) {
			//Open item preview only once dialogue is fully opened
			if (dlgChoice.hasOpened) {
				if ((eim.npcInstance1 > -1) && (eim.itemInstance1 > -1)) {
					//Enable item preview
					if (!eim.itemPreviewVisible) {
						eim.itemPreviewVisible = TRUE;

						//First time will have focus - in order to render item details
						//Npc_InvOpenPassive (var int slfInstance, var int itemInstanceID, var int hasInvFocus)
						Npc_InvOpenPassive(eim.npcInstance1, eim.itemInstance1, TRUE);

						if ((eim.npcInstance2 > -1) && (eim.itemInstance2 > -1)) {
							Npc_InvOpenPassive(eim.npcInstance2, eim.itemInstance2, FALSE);
						};
					};
				};
			};
		} else {
			//Close item preview if not active anymore
			EIM_CloseItemPreview ();
		};

//-- Horizontal auto-scrolling for selected dialogue choice

		var int b;
		var int charWidth;

		var int pixelScrolling;

		//First wait for a moment ...
		if (horizontalScrolling == HSCROLL_INIT) {
			timerHorizontalScrolling += MEM_Timer.frameTime;

			if (timerHorizontalScrolling >= 2000) {
				timerHorizontalScrolling = 0;
				horizontalScrolling = HSCROLL_SCROLL;
				pixelScrolling = FALSE;
			};
		};

		//Scroll text
		if (horizontalScrolling == HSCROLL_SCROLL) {
			timerHorizontalScrolling += MEM_Timer.frameTime;

			if ((timerHorizontalScrolling >= 90) && (!pixelScrolling)) {
				timerHorizontalScrolling = 0;

				//we cannot really change txt.pixelPositionX if txt.pixelPositionX < defaultPosX then dialogue choice wont render ...
				//so the only option to scroll text is to trim it ...
				txt = _^ (MEM_ReadIntArray (arr.array, dlgChoice.ChoiceSelected));

				//Double check size - shall we trim?
				if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlgChoice.pixelSizeX - dlgChoice.sizeMargin_1[0])) {
					//Switch to pixel scrolling
					b = CtoB (STR_Left (txt.text, 1));
					charWidth = zCFont_GetWidth(txt.font, b);
					txt.pixelPositionX += charWidth;
					pixelScrolling = TRUE;

					txt.text = mySTR_SubStr (txt.text, 1, STR_Len (txt.text) - 1);
				} else {
					//If text was scrolled completely ... wait
					horizontalScrolling = HSCROLL_WAIT;
				};
			};

			//Pixel scrolling
			if (pixelScrolling) {
				if (timerHorizontalScrolling >= 10) {
					timerHorizontalScrolling = 0;

					txt = _^ (MEM_ReadIntArray (arr.array, dlgChoice.ChoiceSelected));

					if (txt.pixelPositionX > dlgChoice.sizeMargin_0[0]) {
						txt.pixelPositionX -= 1;
					} else {
						pixelScrolling = FALSE;
						timerHorizontalScrolling = 90;
					};
				};
			};
		};

		//Wait for a moment - and reset scrolling
		if (horizontalScrolling == HSCROLL_WAIT) {
			timerHorizontalScrolling += MEM_Timer.frameTime;

			if (timerHorizontalScrolling >= 4000) {
				timerHorizontalScrolling = 0;
				//This will force an update
				horizontalScrolling = HSCROLL_RESET;
			};
		};

//-- Horizontal auto-scrolling for disabled dialogue choices

		var int pixelScrollingDisabled;

		//First wait for a moment ...
		if (horizontalScrollingDisabled == HSCROLL_INIT) {
			timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			if (timerHorizontalScrollingDisabled >= 2000) {
				timerHorizontalScrollingDisabled = 0;
				horizontalScrollingDisabled = HSCROLL_SCROLL;
				pixelScrollingDisabled = FALSE;
			};
		};

		//Scroll disabled text
		if (horizontalScrollingDisabled == HSCROLL_SCROLL) {
			timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			//loop through all dialogues
			var int wasSomethingScrolled;

			if ((timerHorizontalScrollingDisabled >= 90) && (!pixelScrollingDisabled)) {
				timerHorizontalScrollingDisabled = 0;

				wasSomethingScrolled = FALSE;

				//we cannot really change txt.pixelPositionX if txt.pixelPositionX < defaultPosX then dialogue choice wont render ...
				//so the only option to scroll text is to trim it ...

				//Small optimization - work only with visible dialogue choices
				i = dlgChoice.LineStart;
				while (i < dlgChoice.choices);
					txt = _^ (MEM_ReadIntArray (arr.array, i));

					//Small optimization - work only with visible dialogue choices
					if (txt.pixelPositionY + dlgChoice.offsetTextPixelY - dlgChoice.sizeMargin_0[1] > dlgChoice.pixelSizeY) {
						break;
					};

					isDisabled = MEM_ReadIntArray (_@ (eim.dialogDisabled), i);
					if (isDisabled) {
						//Double check size - shall we trim?
						if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlgChoice.pixelSizeX - dlgChoice.sizeMargin_1[0])) {
							//Switch to pixel scrolling
							b = CtoB (STR_Left (txt.text, 1));
							charWidth = zCFont_GetWidth (txt.font, b);
							txt.pixelPositionX += charWidth;
							pixelScrollingDisabled = TRUE;

							txt.text = mySTR_SubStr (txt.text, 1, STR_Len (txt.text) - 1);
							wasSomethingScrolled = TRUE;
						};
					};

					i += 1;
				end;

				if (!wasSomethingScrolled) {
					//If text was scrolled completely ... wait
					horizontalScrollingDisabled = HSCROLL_WAIT;
				};
			};

			//Pixel scrolling
			if (pixelScrollingDisabled) {
				if (timerHorizontalScrollingDisabled >= 10) {
					timerHorizontalScrollingDisabled = 0;

					wasSomethingScrolled = FALSE;

					//Small optimization - work only with visible dialogue choices
					i = dlgChoice.LineStart;
					while (i < dlgChoice.choices);
						txt = _^ (MEM_ReadIntArray (arr.array, i));

						//Small optimization - work only with visible dialogue choices
						if (txt.pixelPositionY + dlgChoice.offsetTextPixelY - dlgChoice.sizeMargin_0[1] > dlgChoice.pixelSizeY) {
							break;
						};

						isDisabled = MEM_ReadIntArray (_@ (eim.dialogDisabled), i);
						if (isDisabled) {

							if (txt.pixelPositionX > dlgChoice.sizeMargin_0[0]) {
								txt.pixelPositionX -= 1;
								wasSomethingScrolled = TRUE;
							};
						};

						i += 1;
					end;

					if (!wasSomethingScrolled) {
						pixelScrollingDisabled = FALSE;
						timerHorizontalScrollingDisabled = 90;
					};
				};
			};
		};

		//Wait for a moment - and reset scrolling
		if (horizontalScrollingDisabled == HSCROLL_WAIT) {
			timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			//Only if we are not updating **selected** dialogue choice!
			//Scrolling of selected dialogue choice has prio
			if (horizontalScrolling != HSCROLL_SCROLL) {
				if (timerHorizontalScrollingDisabled >= 4000) {
					timerHorizontalScrollingDisabled = 0;
					//This will force an update
					horizontalScrollingDisabled = HSCROLL_RESET;
				};
			};
		};

		eim.lastChoiceSelected = dlgChoice.ChoiceSelected;
		eim.lastChoiceSelectedMode = dlgChoice.ChoiceSelected;
	};

	eim.infosCollected = FALSE;
	eim.choicesCollected = FALSE;

	eim.infosCollectedAllDisabled = FALSE;
};

/*
 *
 */
func void _hook_oCInformationManager_CollectChoices_EIM () {
	EIM_Reset ();

	if (!MEM_Game.infoman) { return; };

	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	var int infoPtr; infoPtr = MEM_InformationMan.info;
	if (!infoPtr) { return; };

	eim.choicesCollected = TRUE;

	//We can't use first parameter - it is a lie !!! :)
	//infoPtr = MEM_ReadInt (ESP + 4);
	eim.lastChoiceSelected = -1;

	var oCInfo info;
	info = _^ (infoPtr);

	self = _^ (MEM_InformationMan.npc);
	other = _^ (MEM_InformationMan.player);

	//--> re-evaluate dialog conditions
	var int retVal; retVal = FALSE;
	if (info.conditions > -1) {
		MEM_CallByID (info.conditions);
		retVal = MEMINT_PopInt();
	};
	//<--

	var int i; i = 0;

	if (info.listChoices_next) {

		var oCInfoChoice infoChoice;
		var int list;
		var zCList l;
		var zCList p;
		var zCList n;

		//Remove hidden@ choices
		list = info.listChoices_next;

		while (list);
			l = _^ (list);

			if (l.data) {
				infoChoice = _^ (l.data);

				if (Choice_IsHidden (infoChoice.Text)) {
					//Get next item
					if (l.next) {
						n = _^ (l.next);

						if (i == 0) {
							//Replace current item with next item
							l.data = n.data;
							l.next = n.next;
						} else {
							//Replace pointer of previous item with next item
							p.next = l.next;
						};

						//restart loop
						i = 0;
						list = info.listChoices_next;
						continue;
					} else {
						if (i == 0) {
							info.listChoices_next = 0;
						} else {
							//Remove pointer of previous item
							p.next = 0;
						};
					};
				};
			};

			//remember previous
			p = _^ (list);

			list = l.next;
			i += 1;
		end;

		//Check d@ (disabled) choices
		var int allDisabled; allDisabled = TRUE;

		list = info.listChoices_next;

		while (list);
			l = _^ (list);

			if (l.data) {
				infoChoice = _^ (l.data);

				if (!Choice_IsDisabled (infoChoice.Text)) {
					allDisabled = FALSE;
					break;
				};
			};

			list = l.next;
		end;

		//If all choices are disabled --> ClearChoices!
		if (allDisabled) {
			//0x00665CC0 public: void __thiscall oCInfo::RemoveAllChoices(void)
			const int oCInfo__RemoveAllChoices_G1 = 6708416;

			//0x00703D70 public: void __thiscall oCInfo::RemoveAllChoices(void)
			const int oCInfo__RemoveAllChoices_G2 = 7355760;

			CALL__thiscall (infoPtr, MEMINT_SwitchG1G2 (oCInfo__RemoveAllChoices_G1, oCInfo__RemoveAllChoices_G2));
		};
	};
};

/*
 *
 */
func void _hook_oCInformationManager_CollectInfos_EIM () {
	EIM_Reset ();

	if (!MEM_Game.infoman) { return; };

	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	var oCNPC slf; slf = _^ (MEM_InformationMan.npc);
	if (!Hlp_IsValidNpc (slf)) { return; };

	var int slfInstance; slfInstance = Hlp_GetInstanceID (slf);

	if (!MEM_InfoMan.infoList_next) { return; };

	eim.infosCollected = TRUE;

	var oCInfo info;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	eim.lastChoiceSelected = -1;

	var int count; count = 0;
	var int allDisabled; allDisabled = TRUE;

	while (infoPtr);
		list = _^ (infoPtr);

		if (list.data) {
			info = _^ (list.data);
			if (info.npc == slfInstance) {

				//Here we have to re-evaluate dialogue conditions.
				//Because we can have a situation where condition function updates description
				//and dialogues will no longer be hidden.

				self = _^ (MEM_InformationMan.npc);
				other = _^ (MEM_InformationMan.player);

				var int retVal; retVal = FALSE;

				if (info.conditions > -1) {
					MEM_CallByID (info.conditions);
					retVal = MEMINT_PopInt();
				};

				if (Choice_IsHidden (info.description)) {
					//hide
					if (info.permanent == 1) {
						info.told = -2;
						info.permanent = 0;
					} else {
						if (info.told == 0) {
							info.told = -1;
						};
					};
				} else {
					//restore
					if (info.told == -1) {
						info.told = 0;
					} else
					if (info.told == -2) {
						info.permanent = 1;
						info.told = 0;
					};
				};

				if (retVal) {
					//Only if not told / permanent
					if ((info.told == 0) || (info.permanent == 1)) {
						if (!Choice_IsDisabled (info.description)) {
							allDisabled = FALSE;
						};
					};
					count += 1;
				};
			};
		};

		infoPtr = list.next;
	end;

	//If all dialogues are disabled - add exit option! (in oCInformationManager::Update, because CollectInfos will remove all choices)
	//Add exit option - only if there are dialogues!
	if ((allDisabled) && (count > 0)) {
		eim.infosCollectedAllDisabled = TRUE;
	};
};

func void _hook_oCInformationManager_OnImportantBegin_EIM () {
	EIM_Reset ();
};

func void _hook_oCInformationManager_OnExit_EIM () {
	EIM_Reset ();
};

func void _hook_zCViewDialogChoice_HighlightSelected_EIM () {
	eim.refresh = TRUE;
};

func void _hook_oCItemContainer_DrawCategory_EIM () {
	if (!ECX) { return; };
	if (!eim.itemPreviewVisible) { return; };

	var oCItemContainer itemContainer; itemContainer = _^ (ECX);

	/*
	var int    inventory2_oCItemContainer_maxSlotsCol;                    // 44
	var int    inventory2_oCItemContainer_maxSlotsColScr;                 // 48
	var int    inventory2_oCItemContainer_maxSlotsRow;                    // 52
	var int    inventory2_oCItemContainer_maxSlotsRowScr;                 // 56
	var int    inventory2_oCItemContainer_maxSlots;                       // 60
	*/

	const int maxSlotsCol = 1;
	const int maxSlotsRow = 1;
	const int maxSlots = maxSlotsCol * maxSlotsRow;

	//We have to use offsets - G1 class is different than the one from G2A
	MEM_WriteInt (_@ (itemContainer) + 44, maxSlotsCol);
	MEM_WriteInt (_@ (itemContainer) + 48, maxSlotsCol * 2);
	MEM_WriteInt (_@ (itemContainer) + 52, maxSlotsRow);
	MEM_WriteInt (_@ (itemContainer) + 56, maxSlotsRow * 2);
	MEM_WriteInt (_@ (itemContainer) + 60, maxSlots);
};

func void _hook_oCItemContainer_DrawItemInfo_GetHandleEvent_EIM () {
	if (!ECX) { return; };

	//0x007A5560 public: int __thiscall zCInputCallback::GetEnableHandleEvent(void)
	const int zCInputCallback__GetEnableHandleEvent_G2 = 8017248;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(ECX), zCInputCallback__GetEnableHandleEvent_G2);
		call = CALL_End();
	};

	EAX = 0;

	if ((retVal) || (eim.itemPreviewVisible)) {
		EAX = 1;
	};
};

func void _hook_oCItemContainer_DrawItemInfo_PreRenderItem_EIM () {
	var int npcInventoryPtr; npcInventoryPtr = MEMINT_SwitchG1G2 (ESI, EBP);
	if (!npcInventoryPtr) { return; };

	var oCNpcInventory npcInventory; npcInventory = _^ (npcInventoryPtr);

	//If there is dialogue choice - move viewItemInfo above dialogue
	if (MEM_InformationMan.dlgChoice) {
		var zCViewDialogChoice dlgChoice; dlgChoice = _^ (MEM_InformationMan.dlgChoice);

		if (dlgChoice.hasOpened) || (gf (dlgChoice.timeOpen, FLOATNULL))
		{
			var zCView v; v = _^ (npcInventory.inventory2_oCItemContainer_viewItemInfo);

			var int newX;
			var int newY;

			newX = v.vposx;
			newY = v.vposy - (8192 - dlgChoice.virtualPositionY);

			zCViewPtr_SetPos (npcInventory.inventory2_oCItemContainer_viewItemInfo, newX, newY);
		};
	};
};

func void EIM_LoadAPI() {
	var string fontName; fontName = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGSELECTED", STR_EMPTY);

	if (STR_Len(fontName)) {
		eimDefaults.fontSelected = Print_GetFontPtr (fontName);
	} else {
		eimDefaults.fontSelected = 0;
	};

	fontName = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGGREY", STR_EMPTY);

	if (STR_Len (fontName)) {
		eimDefaults.font = Print_GetFontPtr (fontName);
	} else {
		eimDefaults.font = 0;
	};

	eimDefaults.colorSelected = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDEFAULTDIALOGCOLORSELECTED", "FFFFFF");
	eimDefaults.color = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDEFAULTCOLORDIALOGGREY", "C8C8C8");
	eimDefaults.colorDisabledSelected = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDISABLEDDIALOGCOLORSELECTED", "808080");
	eimDefaults.colorDisabled = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDISABLEDCOLORDIALOGGREY", "666666");
	eimDefaults.alignment = API_GetSymbolIntValue ("INFOMANAGERDEFAULTDIALOGALIGNMENT", ALIGN_LEFT);
	eimDefaults.indicatorColor = API_GetSymbolHEX2RGBAValue ("INFOMANAGERINDICATORCOLORDEFAULT", "C8C8C8");
	eimDefaults.indicatorAlpha = API_GetSymbolIntValue ("INFOMANAGERINDICATORALPHA", 255);
	eimDefaults.spinnerIndicatorString = API_GetSymbolStringValue ("INFOMANAGERSPINNERINDICATORSTRING", "<-- -->");
	eimDefaults.answerIndicatorString = API_GetSymbolStringValue ("INFOMANAGERANSWERINDICATORSTRING", "...");
	eimDefaults.answerIndicatorAnimation = API_GetSymbolIntValue ("INFOMANAGERANSWERANIMATION", 1);
	eimDefaults.spinnerIndicatorAnimation = API_GetSymbolIntValue ("INFOMANAGERSPINNERINDICATORANIMATION", 1);
	eimDefaults.numKeyControls = API_GetSymbolIntValue ("INFOMANAGERNUMKEYSCONTROLS", 1);
	eimDefaults.numKeyNumbers = API_GetSymbolIntValue ("INFOMANAGERNUMKEYSNUMBERS", 0);
	eimDefaults.alphaBlendFunc = API_GetSymbolIntValue ("INFOMANAGERALPHABLENDFUNC", 3);
	eimDefaults.rememberSelectedChoice = API_GetSymbolIntValue ("INFOMANAGERREMEMBERSELECTEDCHOICE", cIM_RememberSelectedChoice_Spinners);
};

func void EIM_Init() {
	//Create EIM objects
	var int ptr;
	if (_@(eimDefaults) == 0) {
		ptr = create(zEIM_Defaults@);
		eimDefaults = _^(ptr);
	};

	if (_@(eimDescription) == 0) {
		ptr = create(zEIM_Description@);
		eimDescription = _^(ptr);
	};

	if (_@(eimOverlays) == 0) {
		ptr = create(zEIM_Overlays@);
		eimOverlays = _^(ptr);
	};

	if (_@(eim) == 0) {
		ptr = create(zEIM@);
		eim = _^(ptr);
	};

	eim.displayItemPreview = FALSE;
	eim.itemPreviewVisible = FALSE;

	eim.itemInstance1 = -1;
	eim.npcInstance1 = -1;
	eim.itemInstance2 = -1;
	eim.npcInstance2 = -1;

	//Reset pointers
	eim.answerIndicatorPtr = 0;
	eim.leftSpinnerIndicatorPtr = 0;
	eim.rightSpinnerIndicatorPtr = 0;
};

func void G12_EnhancedInfoManager_Init () {
	//Create EIM objects
	EIM_Init();

	//-- Load API values / init default values
	EIM_LoadAPI();

	const int once = 0;
	if (!once) {
		HookEngine (zCViewDialogChoice__HandleEvent, 9, "_hook_zCViewDialogChoice_HandleEvent_EIM");
		HookEngine (oCInformationManager__Update, 5, "_hook_oCInformationManager_Update_EIM");

		HookEngine (oCInformationManager__CollectChoices, 5, "_hook_oCInformationManager_CollectChoices_EIM");
		HookEngine (oCInformationManager__CollectInfos, 7, "_hook_oCInformationManager_CollectInfos_EIM");

		//0x0072D0A0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G1 = 7524512;

		//0x00661DB0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G2 = 6692272;

		HookEngine (MEMINT_SwitchG1G2 (oCInformationManager__OnImportantBegin_G1, oCInformationManager__OnImportantBegin_G2), 6, "_hook_oCInformationManager_OnImportantBegin_EIM");

		//0x0072E360 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G1 = 7529312;

		//0x006630D0 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G2 = 6697168;

		HookEngine (MEMINT_SwitchG1G2 (oCInformationManager__OnExit_G1, oCInformationManager__OnExit_G2), 6, "_hook_oCInformationManager_OnExit_EIM");

		//TODO: this one is recoloring all dialogue choices - we should probably replace this one with our own implementation
		//0x007594A0 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G1 = 7705760;

		//0x0068F620 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G2 = 6878752;

		HookEngine (MEMINT_SwitchG1G2 (zCViewDialogChoice__HighlightSelected_G1, zCViewDialogChoice__HighlightSelected_G2), 9, "_hook_zCViewDialogChoice_HighlightSelected_EIM");

		//TODO: investigate potential performance improvement - if we would sort all infos by both .npc and .nr then we could in theory improve performance (infos without npc would have to be at the beginning of the list)
		//0x006647E0 private: static int __cdecl oCInfoManager::CompareInfos(class oCInfo *,class oCInfo *)

		//-- Item preview --

		//G2A only
		if (MEMINT_SwitchG1G2 (0, 1)) {
			//This hook will override maxSlots to 1 slot
			//0x00706B60 protected: virtual void __thiscall oCItemContainer::DrawCategory(void)
			const int oCItemContainer__DrawCategory_G2 = 7367520;
			HookEngine (oCItemContainer__DrawCategory_G2, 6, "_hook_oCItemContainer_DrawCategory_EIM");

			//This hook makes sure DrawItemInfo renders at all (in G2A item info is not rendered if inventory has not enabled events - so we override it with item preview feature)
			//00706e5f
			const int oCItemContainer__DrawItemInfo_GetHandleEvent_G2 = 7368287;

			var int ptr; ptr = oCItemContainer__DrawItemInfo_GetHandleEvent_G2;
			MemoryProtectionOverride (ptr, 5);
			MEM_WriteByte (ptr, 144); ptr += 1;
			MEM_WriteByte (ptr, 144); ptr += 1;
			MEM_WriteByte (ptr, 144); ptr += 1;
			MEM_WriteByte (ptr, 144); ptr += 1;
			MEM_WriteByte (ptr, 144); ptr += 1;

			HookEngine (oCItemContainer__DrawItemInfo_GetHandleEvent_G2, 5, "_hook_oCItemContainer_DrawItemInfo_GetHandleEvent_EIM");
		};

		//This hook moves item info above dialogue choice box
		//00667328
		const int oCItemContainer__DrawItemInfo_PreRenderItem_G1 = 6714152;

		//00706fee
		const int oCItemContainer__DrawItemInfo_PreRenderItem_G2 = 7368686;

		HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__DrawItemInfo_PreRenderItem_G1, oCItemContainer__DrawItemInfo_PreRenderItem_G2), 5, "_hook_oCItemContainer_DrawItemInfo_PreRenderItem_EIM");

		once = 1;
	};
};

/*
 *  G12_EnhancedInfoManager_Destructable_Init
 *   - Another version of 'G12_EnhancedInfoManager_Init' with possibility to de-initialization.
 *   By default, this should be used in 'ZS_Talk' function.
 *   - Don't use 'G12_EnhancedInfoManager_Init', if you use that.
 */
var int EnhancedInfoManager_Hooked;
var int oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_1;
var int oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_2;
var int oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_3;
var int oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_4;
var int oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_5;

func void G12_EnhancedInfoManager_Destructable_Init () {
	//Create EIM objects
	EIM_Init();

	//-- Load API values / init default values
	EIM_LoadAPI();

	if (!EnhancedInfoManager_Hooked) {
		HookEngine (zCViewDialogChoice__HandleEvent, 9, "_hook_zCViewDialogChoice_HandleEvent_EIM");
		HookEngine (oCInformationManager__Update, 5, "_hook_oCInformationManager_Update_EIM");

		HookEngine (oCInformationManager__CollectChoices, 5, "_hook_oCInformationManager_CollectChoices_EIM");
		HookEngine (oCInformationManager__CollectInfos, 7, "_hook_oCInformationManager_CollectInfos_EIM");

		//0x0072D0A0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G1 = 7524512;

		//0x00661DB0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G2 = 6692272;

		HookEngine (MEMINT_SwitchG1G2 (oCInformationManager__OnImportantBegin_G1, oCInformationManager__OnImportantBegin_G2), 6, "_hook_oCInformationManager_OnImportantBegin_EIM");

		//0x0072E360 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G1 = 7529312;

		//0x006630D0 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G2 = 6697168;

		HookEngine (MEMINT_SwitchG1G2 (oCInformationManager__OnExit_G1, oCInformationManager__OnExit_G2), 6, "_hook_oCInformationManager_OnExit_EIM");

		//0x007594A0 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G1 = 7705760;

		//0x0068F620 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G2 = 6878752;

		HookEngine (MEMINT_SwitchG1G2 (zCViewDialogChoice__HighlightSelected_G1, zCViewDialogChoice__HighlightSelected_G2), 9, "_hook_zCViewDialogChoice_HighlightSelected_EIM");

		//TODO: investigate potential performance improvement - if we would sort all infos by both .npc and .nr then we could in theory improve performance (infos without npc would have to be at the beginning of the list)
		//0x006647E0 private: static int __cdecl oCInfoManager::CompareInfos(class oCInfo *,class oCInfo *)

		//-- Item preview --

		//G2A only
		if (MEMINT_SwitchG1G2 (0, 1)) {
			//This hook will override maxSlots to 1 slot
			//0x00706B60 protected: virtual void __thiscall oCItemContainer::DrawCategory(void)
			const int oCItemContainer__DrawCategory_G2 = 7367520;
			HookEngine (oCItemContainer__DrawCategory_G2, 6, "_hook_oCItemContainer_DrawCategory_EIM");

			//This hook makes sure DrawItemInfo renders at all (in G2A item info is not rendered if inventory has not enabled events - so we override it with item preview feature)
			//00706e5f
			const int oCItemContainer__DrawItemInfo_GetHandleEvent_G2 = 7368287;

			var int ptr; ptr = oCItemContainer__DrawItemInfo_GetHandleEvent_G2;
			MemoryProtectionOverride (ptr, 5);
            oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_1 = MEM_ReadByte(ptr);
			MEM_WriteByte (ptr, 144); ptr += 1;
            oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_2 = MEM_ReadByte(ptr);
			MEM_WriteByte (ptr, 144); ptr += 1;
            oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_3 = MEM_ReadByte(ptr);
			MEM_WriteByte (ptr, 144); ptr += 1;
            oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_4 = MEM_ReadByte(ptr);
			MEM_WriteByte (ptr, 144); ptr += 1;
            oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_5 = MEM_ReadByte(ptr);
			MEM_WriteByte (ptr, 144); ptr += 1;

			HookEngine (oCItemContainer__DrawItemInfo_GetHandleEvent_G2, 5, "_hook_oCItemContainer_DrawItemInfo_GetHandleEvent_EIM");
		};

		//This hook moves item info above dialogue choice box
		//00667328
		const int oCItemContainer__DrawItemInfo_PreRenderItem_G1 = 6714152;

		//00706fee
		const int oCItemContainer__DrawItemInfo_PreRenderItem_G2 = 7368686;

		HookEngine (MEMINT_SwitchG1G2 (oCItemContainer__DrawItemInfo_PreRenderItem_G1, oCItemContainer__DrawItemInfo_PreRenderItem_G2), 5, "_hook_oCItemContainer_DrawItemInfo_PreRenderItem_EIM");

		EnhancedInfoManager_Hooked = 1;
	};
};

/*
 *  G12_EnhancedInfoManager_Destruct
 *   - De-initialization of 'G12_EnhancedInfoManager_Destructable_Init' function.
 *   This should be called in 'ZS_Talk_End'.
 */
func void G12_EnhancedInfoManager_Destruct () {
	if (EnhancedInfoManager_Hooked) {
		RemoveHook (zCViewDialogChoice__HandleEvent, 9, "_hook_zCViewDialogChoice_HandleEvent_EIM");
		RemoveHook (oCInformationManager__Update, 5, "_hook_oCInformationManager_Update_EIM");

		RemoveHook (oCInformationManager__CollectChoices, 5, "_hook_oCInformationManager_CollectChoices_EIM");
		RemoveHook (oCInformationManager__CollectInfos, 7, "_hook_oCInformationManager_CollectInfos_EIM");

		//0x0072D0A0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G1 = 7524512;

		//0x00661DB0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G2 = 6692272;

		RemoveHook (MEMINT_SwitchG1G2 (oCInformationManager__OnImportantBegin_G1, oCInformationManager__OnImportantBegin_G2), 6, "_hook_oCInformationManager_OnImportantBegin_EIM");

		//0x0072E360 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G1 = 7529312;

		//0x006630D0 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G2 = 6697168;

		RemoveHook (MEMINT_SwitchG1G2 (oCInformationManager__OnExit_G1, oCInformationManager__OnExit_G2), 6, "_hook_oCInformationManager_OnExit_EIM");

		//0x007594A0 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G1 = 7705760;

		//0x0068F620 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G2 = 6878752;

		RemoveHook (MEMINT_SwitchG1G2 (zCViewDialogChoice__HighlightSelected_G1, zCViewDialogChoice__HighlightSelected_G2), 9, "_hook_zCViewDialogChoice_HighlightSelected_EIM");

		//TODO: investigate potential performance improvement - if we would sort all infos by both .npc and .nr then we could in theory improve performance (infos without npc would have to be at the beginning of the list)
		//0x006647E0 private: static int __cdecl oCInfoManager::CompareInfos(class oCInfo *,class oCInfo *)

		//-- Item preview --

		//G2A only
		if (MEMINT_SwitchG1G2 (0, 1)) {
			//This hook will override maxSlots to 1 slot
			//0x00706B60 protected: virtual void __thiscall oCItemContainer::DrawCategory(void)
			const int oCItemContainer__DrawCategory_G2 = 7367520;
			RemoveHook (oCItemContainer__DrawCategory_G2, 6, "_hook_oCItemContainer_DrawCategory_EIM");

			//This hook makes sure DrawItemInfo renders at all (in G2A item info is not rendered if inventory has not enabled events - so we override it with item preview feature)
			//00706e5f
			const int oCItemContainer__DrawItemInfo_GetHandleEvent_G2 = 7368287;

			var int ptr; ptr = oCItemContainer__DrawItemInfo_GetHandleEvent_G2;
			MemoryProtectionOverride (ptr, 5);
			MEM_WriteByte (ptr, oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_1); ptr += 1;
			MEM_WriteByte (ptr, oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_2); ptr += 1;
			MEM_WriteByte (ptr, oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_3); ptr += 1;
			MEM_WriteByte (ptr, oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_4); ptr += 1;
			MEM_WriteByte (ptr, oCItemContainer__DrawItemInfo_GetHandleEvent_G2_Byte_5); ptr += 1;

			RemoveHook (oCItemContainer__DrawItemInfo_GetHandleEvent_G2, 5, "_hook_oCItemContainer_DrawItemInfo_GetHandleEvent_EIM");
		};

		//This hook moves item info above dialogue choice box
		//00667328
		const int oCItemContainer__DrawItemInfo_PreRenderItem_G1 = 6714152;

		//00706fee
		const int oCItemContainer__DrawItemInfo_PreRenderItem_G2 = 7368686;

		RemoveHook (MEMINT_SwitchG1G2 (oCItemContainer__DrawItemInfo_PreRenderItem_G1, oCItemContainer__DrawItemInfo_PreRenderItem_G2), 5, "_hook_oCItemContainer_DrawItemInfo_PreRenderItem_EIM");

		EnhancedInfoManager_Hooked = 0;
	};
};