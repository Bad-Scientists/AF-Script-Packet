/*
 *	How to enable this feature:
 *
 *	func void Init_Global () {
 *		...
 *		InfoManagerNumKeysControls = TRUE;
 *		InfoManagerNumKeysNumbers = TRUE;
 *		InfoManagerSpinnerIndicatorAnimation = TRUE;
 *		G12_EnhancedInfoManager_Init ();
 *	};
 *
 *	Modifiers:			Usage:								Explanation:
 *		f@				'f@font_15_white.tga TEST'			 - applies font_15_white.tga to greyed out dialog choice. Has to be separated by space.
 *		fs@				'fs@font_old_20_white.tga TEST'			- applies font_old_20_white.tga to selected dialog choice. Has to be separated by space.
 *		h@				'h@00CC66 TEST'						 - applies color in hexcode to greyed out dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
 *		hs@				'hs@66FFB2 TEST'					 - applies color in hexcode to selected dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
 *		a@				'a@TEST' 'a@ TEST'					 - enables answering mode. Does not have to be separated by space. (removes space after @ sign if there is any)
 *		s@				's@spinnerID TEST'					 - enables spinner mode. Has to be separated by space. Requires unique spinnerID after @ sign.
 *		d@				'd@'								 - disables dialog choice. Player will not be able to select such dialog choice. Does not have to be separated by space.
 *		al@				'al@'								 - aligns text to left. Does not have to be separated by space.
 *		ac@				'ac@'								 - aligns text to center. Does not have to be separated by space.
 *		ar@				'ar@'								 - aligns text to right. Does not have to be separated by space.
 *		o@				'o@format:TEST~'					 - adds text in between : ~ as an overlay with its own format (unique color or alignment). Don't use with fonts changing text height - this is not supported yet.
 *						'o@h@00CC66 hs@66FFB2:TEST~'			- colors modifiers
 *						'o@ar@ h@00CC66 hs@66FFB2:TEST~'		- alignment modifiers
 *						'o@tab8@:TEST~'					 	 	- tab offset modifier
 *
 *		hidden@			'hidden@'							 - removes dialog choice from dialog box.
 *
 *		indOff@			'indOff@'							 - does not create spinner / answer indicators
 *		item@			'item@self:ItMiNugget'				 - creates 'item preview' - passively opens inventory for specified npc (default self) with focusing on specified item - will display item info
 *
 *	---> DEV NOTES <---
 *	Notes for us: keep in mind that some modifiers do have same naming: spinner 's@', color selected 'hs@', font selected 'fs@' --> that's why we have to work with modifiers in specific order.
 *	First take care of 'hs@', 'fs@' then 's@' !!!
 */

//-- Internal variables
var int _InfoManagerDefaultDialogColorSelected;
var int _InfoManagerDefaultColorDialogGrey;

var int _InfoManagerDefaultFontDialogSelected;
var int _InfoManagerDefaultFontDialogGrey;

var int _InfoManagerDisabledDialogColorSelected;
var int _InfoManagerDisabledColorDialogGrey;

var int _InfoManagerDefaultDialogAlignment;

var int _InfoManagerIndicatorColorDefault;
var int _InfoManagerIndicatorAlpha;

var string _InfoManagerSpinnerIndicatorString;
var string _InfoManagerAnswerIndicatorString;

var int _InfoManagerSpinnerIndicatorAnimation;

var int _InfoManagerNumKeysControls;
var int _InfoManagerNumKeysNumbers;

var int _InfoManagerAlphaBlendFunc;

const int cIM_RememberSelectedChoice_None = 0;			//Does nothing (default vanilla behaviour)
const int cIM_RememberSelectedChoice_All = 1;			//Moves cursor to last selected choice
const int cIM_RememberSelectedChoice_Spinners = 2;		//Moves cursor to last selected choice only when used with spinners

var int _InfoManagerRememberSelectedChoice;

//--

var int InfoManagerSpinnerValueMin;	//Home
var int InfoManagerSpinnerValueMax;	//End
var int InfoManagerSpinnerPageSize; //Page Up/Down

//Item 'Preview mode'
var int InfoManagerItemPreviewMode;
var int InfoManagerItemPreviewModeOn;
var int InfoManagerItemPreviewNpcOne;
var int InfoManagerItemPreviewNpcTwo;

var int InfoManagerItemPreviewIDOne;
var int InfoManagerItemPreviewIDTwo;

//Dialog 'Answering system'
var int InfoManagerAnswerPossible;
var int InfoManagerAnswerMode;
var int InfoManagerAnswerAlignment;
var string InfoManagerAnswer;

var int InfoManagerSpinnerAlignment;
var int InfoManagerSpinnerNumberEditMode;
var string InfoManagerSpinnerNumber;

//Dialog 'Spinner system'
var int InfoManagerSpinnerPossible;
var int InfoManagerSpinnerValue;
var string InfoManagerSpinnerID;

var int InfoManagerChoiceDisabled;

//var int InfoManagerRefreshOverlays;
//const int cIM_RefreshNothing			= 0;
//const int cIM_RefreshOverlays			= 1;
//const int cIM_RefreshDialogColors		= 2;

//Variables used for elimination of unnecessary code runnings
var int InfoManagerLastChoiceSelected;
var int InfoManagerModeInfoLastChoiceSelected;

const int cIM_UpdateState_2BChanged	= 0;
const int cIM_UpdateState_Changed	= 1;

var int InfoManagerUpdateState;

instance zCViewText2@ (zCViewText2);

var int InfoManagerSpinnerIndicatorL;
var int InfoManagerSpinnerIndicatorR;

var int InfoManagerSpinnerIndicatorAniProgress;

var int InfoManagerAnswerIndicator;

var int InfoManagerDialogInstPtr[255];
var int InfoManagerDialogInstPtrCount;

var int InfoManagerCollectInfos;
var int InfoManagerCollectInfosAllDisabled;
var int InfoManagerCollectChoices;
var int InfoManagerHighlightSelected;

var int EnhancedInfoManagerReady;
	const int cEIM_Idle = 0;
	const int cEIM_InfosCollected = 1;
	const int cEIM_ChoicesCollected = 2;
	const int cEIM_Initialized = 3;

const int ALIGN_TAB = 255;
const string InfoManagerTabSize = "-";

func void EIM_Reset () {
	EnhancedInfoManagerReady = cEIM_Idle;
	InfoManagerDialogInstPtrCount = 0;
	InfoManagerCollectInfosAllDisabled = FALSE;
};

func int EIM_GetInfoPtr (var int index) {
	if ((index < 0) || (index >= InfoManagerDialogInstPtrCount)) {
		return 0;
	};

	return MEM_ReadIntArray (_@ (InfoManagerDialogInstPtr), index);
};

func void InfoManagerSpinnerAnimate () {
	var int spaceWidth;
	var int spinnerWidthL;
	var int spinnerWidthR;

	const int MOVE_MAX_PIXELS = 15;

	var zCViewText2 spinnedIndicatorL;
	var zCViewText2 spinnedIndicatorR;

	if (!MEM_InformationMan.DlgChoice) { return; };
	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);

	//Animate spinner indicator
	if (InfoManagerSpinnerIndicatorL)
	&& (InfoManagerSpinnerIndicatorR)
	{
		//'Left' part
		spinnedIndicatorL = _^ (InfoManagerSpinnerIndicatorL);
		spinnedIndicatorL.text = "<--";

		//'Right' part
		spinnedIndicatorR = _^ (InfoManagerSpinnerIndicatorR);
		spinnedIndicatorR.text = "-->";

		//We don't need to run these all the time
		const int init = 0;

		if (!init) {
			spinnerWidthL = Font_GetStringWidthPtr (spinnedIndicatorL.text, spinnedIndicatorL.font);
			spinnerWidthR = Font_GetStringWidthPtr (spinnedIndicatorR.text, spinnedIndicatorR.font);

			spaceWidth = zCFont_GetWidth (spinnedIndicatorL.font, CtoB (" "));

			init = 1;
		};

		if (InfoManagerSpinnerAlignment == ALIGN_LEFT)
		{
			spinnedIndicatorL.pixelPositionX = dlg.pixelSizeX - ((spinnerWidthL + MOVE_MAX_PIXELS) + (spaceWidth) + (spinnerWidthR + MOVE_MAX_PIXELS)) - dlg.offsetTextPixelX - dlg.sizeMargin_1[0];
		} else
		if (InfoManagerSpinnerAlignment == ALIGN_CENTER)
		{
			spinnedIndicatorL.pixelPositionX = dlg.sizeMargin_0[0] + (MOVE_MAX_PIXELS);
		} else
		{
			spinnedIndicatorL.pixelPositionX = dlg.sizeMargin_0[0] + (MOVE_MAX_PIXELS);
		};


		//Adjust alignment of spinner indicator

		if (InfoManagerSpinnerAlignment == ALIGN_LEFT)
		{
			spinnedIndicatorR.pixelPositionX = dlg.pixelSizeX - (spinnerWidthR + MOVE_MAX_PIXELS) - dlg.offsetTextPixelX - dlg.sizeMargin_1[0];
		} else
		if (InfoManagerSpinnerAlignment == ALIGN_CENTER)
		{
			spinnedIndicatorR.pixelPositionX = dlg.pixelSizeX - (spinnerWidthR + MOVE_MAX_PIXELS) - dlg.offsetTextPixelX - dlg.sizeMargin_1[0];
		} else
		{
			spinnedIndicatorR.pixelPositionX = dlg.sizeMargin_0[0] + ((spinnerWidthL + MOVE_MAX_PIXELS) + (spaceWidth) + (MOVE_MAX_PIXELS));
		};

		var int movePixels; movePixels = InfoManagerSpinnerIndicatorAniProgress;

		//Left part to left
		if (movePixels < MOVE_MAX_PIXELS) {
			spinnedIndicatorL.pixelPositionX -= movePixels;
		} else

		//Left part back
		if (movePixels < MOVE_MAX_PIXELS * 2) {
			spinnedIndicatorL.pixelPositionX -= ((MOVE_MAX_PIXELS * 2) - movePixels);
		} else

		//Right part to right
		if (movePixels < MOVE_MAX_PIXELS * 3) {
			spinnedIndicatorR.pixelPositionX += (movePixels - (MOVE_MAX_PIXELS * 2));
		} else

		//Right part back
		if (movePixels < MOVE_MAX_PIXELS * 4) {
			spinnedIndicatorR.pixelPositionX += ((MOVE_MAX_PIXELS * 4) - movePixels);
		} else {
			//Reset ani
			InfoManagerSpinnerIndicatorAniProgress = 0;
		};
	};
};

//
func string InfoManagerNumKeyString (var int index) {
	if (index < 1) || (index > 9) { return ""; };

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

func int Choice_IsDisabled (var string s) {
	if (STR_IndexOf (s, "d@ ") > -1) {
		return TRUE;
	};

	return FALSE;
};

func int Choice_IsHidden (var string s) {
	if (STR_IndexOf (s, "hidden@") > -1) {
		return TRUE;
	};

	return FALSE;
};

func string Choice_ExtractModifier (var int strPtr, var string modifierID) {
	var string s; s = MEM_ReadString (strPtr);

	var int index1; index1 = STR_IndexOf (s, modifierID);
	if (index1 == -1) { return ""; };

	var int len; len = STR_Len (s);
	var int lenModifier; lenModifier = STR_Len (modifierID);

	//Get prefix
	var string s1; s1 = mySTR_SubStr (s, 0, index1);

	//Get modifier
	var string s2; s2 = mySTR_SubStr (s, index1 + lenModifier, len - (lenModifier + index1));
	var int index2; index2 = STR_IndexOf (s2, " ");

	var int index3; index3 = index2;

	if (index2 == -1) {
		index3 = STR_Len (s2);
	};

	var string modifierValue; modifierValue = mySTR_Prefix (s2, index3);

	//Get suffix
	var string s3; s3 = mySTR_SubStr (s, index1 + (index2 + 1) + lenModifier, len - (lenModifier + index1 + (index2 + 1)));

	//Concat prefix with suffix and override original string
	s = s1;
	s = ConcatStrings (s, s3);

	MEM_WriteString (strPtr, s);

	//Return modifier value
	return modifierValue;
};

//"modifierID@modifierValue "
func string Choice_GetModifier (var string s, var string modifierID) {
	var int index; index = STR_IndexOf (s, modifierID);
	if (index == -1) { return ""; };

	var int len; len = STR_Len (s);
	var int lenModifier; lenModifier = STR_Len (modifierID);

	//Get modifier
	var string s1; s1 = mySTR_SubStr (s, index + lenModifier, len - lenModifier);
	index = STR_IndexOf (s1, " ");

	if (index == -1) {
		index = STR_Len (s1);
	};

	var string modifierValue; modifierValue = mySTR_Prefix (s1, index);
	return modifierValue;
};

func string Choice_RemoveModifier (var string s, var string modifierID) {
	var int index1; index1 = STR_IndexOf (s, modifierID);
	if (index1 == -1) { return s; };

	var int len; len = STR_Len (s);
	var int lenModifier; lenModifier = STR_Len (modifierID);

	//Get prefix
	var string s1; s1 = mySTR_SubStr (s, 0, index1);

	//Get modifier
	var string s2; s2 = mySTR_SubStr (s, index1 + lenModifier, len - (lenModifier + index1));
	var int index2; index2 = STR_IndexOf (s2, " ");

	var int index3; index3 = index2;

	if (index2 == -1) {
		index3 = STR_Len (s2);
	};

	//Get suffix
	var string s3; s3 = mySTR_SubStr (s, index1 + (index2 + 1) + lenModifier, len - (lenModifier + index1 + (index2 + 1)));

	//Concat prefix with suffix and override original string
	s = s1;
	s = ConcatStrings (s, s3);

	return s;
};

func string Choice_RemoveModifierOverlay (var string s) {
	var string s1;
	var string s2;
	var string s3;

	var int index;
	var int index2;
	var int index3;

	var int len;

	index = STR_IndexOf (s, "o@");
	index2 = STR_IndexOfFrom (s, ":", index);
	index3 = STR_IndexOfFrom (s, "~", index2);

	if ((index > -1) && (index2 > index) && (index3 > index2))
	{
		s1 = ""; s2 = ""; s3 = "";

		len = STR_Len (s);

		if (index > 0) {
			s1 = mySTR_SubStr (s, 0, index);
		};

		if (index3 > index2 + 1) {
			s2 = mySTR_SubStr (s, index2 + 1, (index3 - index2 - 1));
		};

		if (index3 < len) {
			s3 = mySTR_SubStr (s, index3 + 1, (len - index3 - 1));
		};

		s = s1;
		s = ConcatStrings (s, s2);
		s = ConcatStrings (s, s3);
	};

	return s;
};

func string Choice_RemoveModifierOverlayKeepInline (var string s) {
	var string overlayPrefix;
	var string overlayText;
	var string overlaySuffix;
	var string overlayFormat;

	var int index;
	var int index2;
	var int index3;

	var int len;

	var int overlayAlignment; overlayAlignment = -1;
	var int indexFormat;

	index = STR_IndexOf (s, "o@");
	index2 = STR_IndexOfFrom (s, ":", index);
	index3 = STR_IndexOfFrom (s, "~", index2);

	if ((index > -1) && (index2 > index) && (index3 > index2))
	{
		overlayPrefix = ""; overlayText = ""; overlaySuffix = "";

		len = STR_Len (s);

		if (index > 0) {
			overlayPrefix = mySTR_SubStr (s, 0, index);
		};

		overlayFormat = mySTR_SubStr (s, index + 2, index2 - index - 1);

		if (index3 > index2 + 1) {
			overlayText = mySTR_SubStr (s, index2 + 1, (index3 - index2 - 1));
		};

		if (index3 < len) {
			overlaySuffix = mySTR_SubStr (s, index3 + 1, (len - index3 - 1));
		};

		//--> Extract overlay format modifiers
		//Extract alignment
		indexFormat = STR_IndexOf (overlayFormat, "al@");
		if (indexFormat > -1) {
			overlayAlignment = ALIGN_LEFT;
		};

		indexFormat = STR_IndexOf (overlayFormat, "ac@");
		if (indexFormat > -1) {
			overlayAlignment = ALIGN_CENTER;
		};

		indexFormat = STR_IndexOf (overlayFormat, "ar@");
		if (indexFormat > -1) {
			overlayAlignment = ALIGN_RIGHT;
		};

		indexFormat = STR_IndexOf (overlayFormat, "tab@");
		if (indexFormat > -1) {
			overlayAlignment = ALIGN_TAB;
		};

		//---

		indexFormat = STR_IndexOf (overlayText, "al@");
		if (indexFormat > -1) {
			overlayAlignment = ALIGN_LEFT;
		};

		indexFormat = STR_IndexOf (overlayText, "ac@");
		if (indexFormat > -1) {
			overlayAlignment = ALIGN_CENTER;
		};

		indexFormat = STR_IndexOf (overlayText, "ar@");
		if (indexFormat > -1) {
			overlayAlignment = ALIGN_RIGHT;
		};
		//<--

		s = overlayPrefix;
		//Keep inline overlay
		if (overlayAlignment == -1) {
			s = ConcatStrings (s, overlayText);
		};
		s = ConcatStrings (s, overlaySuffix);
	};

	return s;
};

func string Choice_RemoveAllOverlays (var string s) {
	var int lastLen; lastLen = -1;
	var int len;
	var int index;

	index = STR_IndexOf (s, "o@");

	while (index > -1);
		s = Choice_RemoveModifierOverlay (s);
		len = STR_Len (s);
		index = STR_IndexOf (s, "o@");

		if (index) {
			if (len == lastLen) {
				index = -1;
			};
		};

		lastLen = len;
	end;

	return s;
};

func string Choice_RemoveAllModifiers (var string s) {
	s = Choice_RemoveAllOverlays (s);

	//
	s = Choice_RemoveModifier (s, "indOff@");
	s = Choice_RemoveModifier (s, "item@");

	s = Choice_RemoveModifier (s, "f@");
	s = Choice_RemoveModifier (s, "fs@");
	s = Choice_RemoveModifier (s, "h@");
	s = Choice_RemoveModifier (s, "hs@");
	s = Choice_RemoveModifier (s, "a@");
	s = Choice_RemoveModifier (s, "d@");
	s = Choice_RemoveModifier (s, "s@");

	s = Choice_RemoveModifier (s, "al@");
	s = Choice_RemoveModifier (s, "ac@");
	s = Choice_RemoveModifier (s, "ar@");
	s = Choice_RemoveModifier (s, "tab@");

	return s;
};

func string Choice_GetCleanText (var string s) {

//--- Remove overlays (will keep only text from 'inline' overlays)

	var int index;
	var int index2;
	var int index3;

	index = STR_IndexOf (s, "o@");
	index2 = STR_IndexOfFrom (s, ":", index);
	index3 = STR_IndexOfFrom (s, "~", index2);

	var int len;
	var int lastLen; lastLen = -1;

	var int loop; loop = 0;

	while (index > -1);

		len = STR_Len (s);

		if ((index > -1) && (index2 > index) && (index3 > index2)) {
			//Prevent infinite loops, if Choice_RemoveModifierOverlayKeepInline didn't remove anything ... break
			if (len == lastLen) {
				if (loop > 1) {
					index = -1;
					break;
				};
			} else {
				var string overlayFormat; overlayFormat = "";

				var string firstOverlay;		//first half of dialogue - including overlay
				var string splitDialog;			//second half of dialogue (might/might not include overlay)

				var string splitDialogOverlayPrefix;	//overlay prefix for second half of dialogue
				var string splitDialogOverlaySuffix;	//overlay suffix for second half of dialogue

				firstOverlay = mySTR_Prefix (s, index3 + 1);
				splitDialog = mySTR_SubStr (s, index3 + 1, len - index3);

				index3 = STR_IndexOf (splitDialog, "o@");

				//convert to overlays

				//no other overlay: firstOverlay & "o@:" & splitDialog & "~"
				if (index3 == -1) {
					s = firstOverlay;

					s = ConcatStrings (s, "o@");
					s = ConcatStrings (s, overlayFormat);
					s = ConcatStrings (s, ":");

					s = ConcatStrings (s, splitDialog);

					s = ConcatStrings (s, "~");
				} else {
					//if there is another overlay: firstOverlay & "o@:" & splitDialogOverlayPrefix & "~" & splitDialogOverlaySuffix
					if (index3 > 0) {
						var int len2; len2 = STR_Len (splitDialog);

						splitDialogOverlayPrefix = mySTR_SubStr (splitDialog, 0, index3);
						splitDialogOverlaySuffix = mySTR_SubStr (splitDialog, index3, len2 - index3);

						s = firstOverlay;

						s = ConcatStrings (s, "o@");
						s = ConcatStrings (s, overlayFormat);
						s = ConcatStrings (s, ":");

						s = ConcatStrings (s, splitDialogOverlayPrefix);

						s = ConcatStrings (s, "~");
						s = ConcatStrings (s, splitDialogOverlaySuffix);
					};
				};

				loop = 0;
			};
		};

		s = Choice_RemoveModifierOverlayKeepInline (s);

		index = STR_IndexOf (s, "o@");
		index2 = STR_IndexOfFrom (s, ":", index);
		index3 = STR_IndexOfFrom (s, "~", index2);

		if ((index > -1) && (index2 > index) && (index3 > index2)) {
		} else {
			break;
		};

		lastLen = len;
		loop += 1;
	end;

//--- Remove all other modifiers

//	s = Choice_RemoveAllModifiers (s);

	s = Choice_RemoveModifier (s, "indOff@");
	s = Choice_RemoveModifier (s, "item@");

	s = Choice_RemoveModifier (s, "f@");
	s = Choice_RemoveModifier (s, "fs@");
	s = Choice_RemoveModifier (s, "h@");
	s = Choice_RemoveModifier (s, "hs@");
	s = Choice_RemoveModifier (s, "a@");
	s = Choice_RemoveModifier (s, "d@");
	s = Choice_RemoveModifier (s, "s@");

	s = Choice_RemoveModifier (s, "al@");
	s = Choice_RemoveModifier (s, "ac@");
	s = Choice_RemoveModifier (s, "ar@");
	s = Choice_RemoveModifier (s, "tab@");

	return s;
};

func void InfoManager_SetInfoChoiceText_BySpinnerID (var string text, var string spinnerID) {
	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

	if (InfoManager_HasFinished ()) { return; };

	if (!MEM_InformationMan.DlgChoice) { return; };
	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);
	if (!dlg.listTextLines_array) { return; };
	if (!dlg.listTextLines_numInArray) { return; };

	//Choices - have to be extracted from oCInfo.listChoices_next
	//MEM_InformationMan.Info is oCInfo pointer
	if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {
		if (MEM_InformationMan.Info) {
			var oCInfo dlgInstance;
			dlgInstance = _^ (MEM_InformationMan.Info);

			var zCList l;

			var int list; list = dlgInstance.listChoices_next;

			while (list);
				l = _^ (list);

				if (l.data) {
					var oCInfoChoice dlgChoice;
					dlgChoice = _^ (l.data);

					If (Hlp_StrCmp (Choice_GetModifier (dlgChoice.text, "s@"), spinnerID)) {
						dlgChoice.Text = text;
						return;
					};
				};

				list = l.next;
			end;
		};
	};
};

func string InfoManager_GetChoiceDescription_EIM (var int index) {
//	if (!MEM_InformationMan.IsWaitingForSelection) { return ""; };

	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

	if (!MEM_InformationMan.DlgChoice) { return ""; };
	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);
	if (!dlg.listTextLines_array) { return ""; };
	if (!dlg.listTextLines_numInArray) { return ""; };

	if ((index >= 0) && (index < dlg.listTextLines_numInArray)) {
		var int infoPtr;
		var oCInfo dlgInstance;

		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO)
		{
			//var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
			//var C_NPC her; her = _^ (MEM_InformationMan.player);

			//infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr (MEM_InformationMan.npc, MEM_InformationMan.player, index);
			infoPtr = EIM_GetInfoPtr (index);

			if (infoPtr) {
				dlgInstance = _^ (infoPtr);
				return dlgInstance.description;
			};
		} else
		//Choices - have to be extracted from oCInfo.listChoices_next
		//MEM_InformationMan.Info is oCInfo pointer
		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {
			infoPtr = MEM_InformationMan.Info;

			if (infoPtr) {
				dlgInstance = _^ (infoPtr);

				//loop counter for all Choices
				var int i; i = 0;

				var oCInfoChoice dlgChoice;

				var int list; list = dlgInstance.listChoices_next;
				var zCList l;

				while (list);
					l = _^ (list);
					if (l.data) {
						//if our dialog option is dialog choice - put text to dlgDescription
						if (i == index) {
							dlgChoice = _^ (l.data);
							return dlgChoice.Text;
						};
					};

					list = l.next;
					i += 1;
				end;
			};
		};
	};

	return "";
};

func void InfoManager_SelectLastChoice () {
	if (!MEM_InformationMan.DlgChoice) { return; };
	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);
	zCViewDialogChoice_Select (dlg.Choices - 1);
};

func void InfoManager_SkipDisabledDialogChoices (var int key) {
	var string s;

	var zCViewDialogChoice dlg;
	var int nextChoiceIndex;
	var int lastChoiceIndex;

	if (!MEM_InformationMan.DlgChoice) { return; };
	dlg = _^ (MEM_InformationMan.DlgChoice);
	lastChoiceIndex = dlg.ChoiceSelected;
	nextChoiceIndex = lastChoiceIndex;

	var int loop; loop = MEM_StackPos.position;

	if ((key == MEM_GetKey ("keyUp")) || (key == MEM_GetSecondaryKey ("keyUp")) || (key == MOUSE_WHEEL_UP))
	{
		nextChoiceIndex -= 1;

		if (nextChoiceIndex < 0) {
			nextChoiceIndex = dlg.Choices - 1;
		};
	};

	if ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown")) || (key == MOUSE_WHEEL_DOWN))
	{
		nextChoiceIndex += 1;

		if (nextChoiceIndex >= dlg.Choices) {
			nextChoiceIndex = 0;
		};
	};

	s = InfoManager_GetChoiceDescription_EIM (nextChoiceIndex);

	InfoManagerChoiceDisabled = FALSE;

	if (Choice_IsDisabled (s)) {
		//Auto-scrolling
		if (key == -1) {
			key = MEM_GetKey ("keyDown");
			zCViewDialogChoice_SelectNext ();
			MEM_StackPos.position = loop;
		};

		InfoManagerChoiceDisabled = TRUE;

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
	//InfoManagerUpdateState = cIM_UpdateState_2BChanged;

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

	//cancel selection of dialog by KEY_TAB (causing auto-selection in combination with Alt + Tab)
	if (key == KEY_TAB) {
		cancel = TRUE;
	};

	//Work with input only in case InfoManager is waiting for an input
	if (MEM_InformationMan.IsWaitingForSelection) {

		//G2A tweak - dialog confirmation with SPACE
		//Additionally we will allow confirmation via numpad enter
		if (!InfoManagerAnswerPossible) {
			if ((key == KEY_SPACE) || (key == KEY_NUMPADENTER)) { key = KEY_RETURN; update = TRUE; };
		} else {
			if (!InfoManagerAnswerMode)
			&& ((key == KEY_SPACE) || (key == KEY_NUMPADENTER)) { key = KEY_RETURN; };
		};

//--- Answers -->

		//InfoManagerAnswerPossible is set by _hook_oCInformationManager_Update_EnhancedInfoManager
		if (InfoManagerAnswerPossible) {

			//cancel answer mode
			if (InfoManagerAnswerMode) {
				if (key == KEY_ESCAPE) {
					//InfoManagerRefreshOverlays = cIM_RefreshOverlays;
					InfoManagerHighlightSelected = TRUE;
					InfoManagerAnswerMode = FALSE;
					InfoManagerAnswer = "";
				};
			};

			//Enter answer mode / confirm answer
			if (key == KEY_RETURN) {
				//If answer mode was not enabled
				if (!InfoManagerAnswerMode) {
					//Reset answer
					InfoManagerAnswer = "";
				};

				//on/off
				InfoManagerAnswerMode = !InfoManagerAnswerMode;

				//Refresh all overlays (remove in answer more ... add when done)
				//InfoManagerRefreshOverlays = cIM_RefreshOverlays;
				InfoManagerHighlightSelected = TRUE;
			};

			s = "";

			if (InfoManagerAnswerMode) {
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
						InfoManagerAnswer = "";
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
						s = "|";
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

				if (key == KEY_SPACE) { s = " "; };

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

//--- Spinner -->

		if (InfoManagerSpinnerPossible)
		{
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
					InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
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
					InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
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
				InfoManagerSpinnerNumber = "";
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
					InfoManagerSpinnerNumber = "";
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
					InfoManagerSpinnerNumber = "";
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
					InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
				};

				if (InfoManagerSpinnerValue > InfoManagerSpinnerValueMax) {
					InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
				};
			};

			//Refresh all overlays (everything might have changed)
			//if (InfoManagerSpinnerValue != lastSpinnerValue) {
			//	InfoManagerRefreshOverlays = cIM_RefreshOverlays;
			//};
		};

//--- Num Keys control -->

		if (!InfoManagerAnswerMode) {
			//var int numKeyPressed; numKeyPressed = FALSE;

			if (_InfoManagerNumKeysControls) {
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

//--- Additional tweaks -->

		//cancel KEY_BACKSPACE (opens up inventory in G1 - override does not work!)
		if (key == KEY_BACK) {
			cancel = TRUE;
		};

		//cancel KEY_GRAVE changes fight mode to fist mode, this caused some issues ... we will use it for a better purpose - move cursor to last dialog choice
		if (key == KEY_GRAVE) {
			//Don't change position if answer mode / input field is activated
			if (!InfoManagerAnswerMode) {
				InfoManager_SelectLastChoice ();
				InfoManager_SkipDisabledDialogChoices (-1);
				InfoManagerHighlightSelected = TRUE;
				cancel = TRUE;

				//if (InfoManagerRefreshOverlays == cIM_RefreshNothing) {
				//	InfoManagerRefreshOverlays = cIM_RefreshDialogColors;
				//};
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
	if (InfoManagerChoiceDisabled) {
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

	//@Auronen - almost perfect :)
	//zCInputCallback_SetHandleEventTop (ECX);
};

func void EIM_CloseItemPreview ()
{
	if (InfoManagerItemPreviewModeOn) {
		Npc_CloseInventory (InfoManagerItemPreviewNpcOne);
		Npc_CloseInventory (InfoManagerItemPreviewNpcTwo);

		InfoManagerItemPreviewNpcOne = -1;
		InfoManagerItemPreviewNpcTwo = -1;

		InfoManagerItemPreviewModeOn = FALSE;
	};
};

func void _hook_oCInformationManager_Update_EIM () {
	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

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
	if (MEM_InformationMan.Mode == cINFO_MGR_MODE_TRADE) { return; };

	//More safety checks
	if (!MEM_InformationMan.DlgChoice) { return; };
	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);
	if (!dlg.listTextLines_array) { return; };
	if (!dlg.listTextLines_numInArray) { return; };

	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	//Do we have infos collected?
	if (InfoManagerCollectInfos) {
		EnhancedInfoManagerReady = cEIM_InfosCollected;
	};

	//Do we have choices collected?
	if (InfoManagerCollectChoices) {
		EnhancedInfoManagerReady = cEIM_ChoicesCollected;
	};

	//Don't do anything, if choices / infos were not yet collected
	if (!EnhancedInfoManagerReady) { return; };

	//If all dialogues are disabled --> add exit option!
	if (InfoManagerCollectInfosAllDisabled) {
		if (MEM_InformationMan.IndexBye == -1) {
			//0x00759590 public: void __fastcall zCViewDialogChoice::AddChoice(class zSTRING &,int)
			const int zCViewDialogChoice__AddChoice_G1 = 7706000;

			//0x0068F710 public: void __fastcall zCViewDialogChoice::AddChoice(class zSTRING &,int)
			const int zCViewDialogChoice__AddChoice_G2 = 6878992;

			MEM_InformationMan.IndexBye = dlg.choices;

			CALL_IntParam (0);
			CALL__fastcall (MEM_InformationMan.DlgChoice, _@s (DIALOG_ENDE), MEMINT_SwitchG1G2 (zCViewDialogChoice__AddChoice_G1, zCViewDialogChoice__AddChoice_G2));
		};
	};

	var zCArray arr; arr = _^ (_@ (dlg.listTextLines_array));

	//crash
	//zCInputCallback_SetHandleEventTop (MEM_InformationMan.DlgChoice);

	var int i;
	var int j;
	var int loop;

	var zCViewText2 txt;
	var zCViewText2 tempTxt;

	var zCViewText2 spinnedIndicatorL;
	var zCViewText2 spinnedIndicatorR;

	var zCViewText2 answerIndicator;

	var int infoPtr;
	//var int choicePtr;
	var oCInfo dlgInstance;

/*
MEM_InformationMan.LastMethod:
	OnTradeBegin
	OnInfo2

	OnImportantBegin
	InfoWaitForEnd
	CollectInfos
	Update
	CollectInfos
	OnExit
	InfoWaitForEnd
*/

	var int overlayCount;
	var int nextAvailableOverlayIndex;
	var int overlayPtr;

	var string thisID;

//---
	const int DIALOG_MAX = 255;

	var int dialogCachedCount;
	var string dialogCachedDescriptions[DIALOG_MAX];	//cached dialog descriptions
	var string dialogSpinnerID[DIALOG_MAX];			//spinner ID
	var int dialogColor[DIALOG_MAX];
	var int dialogColorSelected[DIALOG_MAX];

	var int dialogProperties[DIALOG_MAX];			//dialog properties: answer, spinner, disabled
	var int properties;

		const int dialogChoiceType_IndicatorsOff	= 1;
		const int dialogChoiceType_Answer			= 2;
		const int dialogChoiceType_Spinner			= 4;
		const int dialogChoiceType_Disabled			= 8;
		const int dialogChoiceType_AlignLeft		= 16;
		const int dialogChoiceType_AlignCenter		= 32;
		const int dialogChoiceType_AlignRight		= 64;
		const int dialogChoiceType_ItemPreview		= 128;

//---
	const int OVERLAY_MAX = 255;

	var string overlayID[OVERLAY_MAX];

	var int overlayListMapChoice[OVERLAY_MAX];		//Dialog choice number
	var int overlayListMapView[OVERLAY_MAX];

	var int overlayListColor[OVERLAY_MAX];
	var int overlayListColorSelected[OVERLAY_MAX];

	var int refreshOverlays; refreshOverlays = FALSE;
	var int refreshOverlayColors; refreshOverlayColors = FALSE;

	var int overlayChoice;

	var string spinnerID;

	//Default colors
	var int color;
	var string hexColor;

	var int dlgColor;
	var int dlgColorSelected;

	var int alignment; //alignment = _InfoManagerDefaultDialogAlignment;

//---

	var int len;
	var int index;
	var int index2;
	var int index3;

	var string s1;
	var string s2;
	var string s3;

	//Overlay
	var string overlayText;
	var string overlayFormat;
	var string overlayDialog;
	var string overlayConcat;

	var int overlayColor;
	var int overlayColorSelected;

	var zCViewText2 overlayChoiceTxt;

	var int overlayIndex;
	var int overlayPosX;
	var int overlayWidth;

	var int flagDialogChoiceStartsWithOverlay;
	var int flagAdd;
	var int k;

	var int overlayAlignment;
	var int overlayTab; overlayTab = 0;

	var int defaultPosX;

	var string dlgDescriptionClean;
	var string dlgDescriptionNoOverlays;

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

	var int symbID;

	var int itemPreviewNo;
	var int itemPreviewID;
	var int loopItemPreview;

	var C_NPC npc;

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
	if (EnhancedInfoManagerReady < cEIM_Initialized) {
		//Load all dialogues
		InfoManagerDialogInstPtrCount = 0;
		while (InfoManagerDialogInstPtrCount < dlg.Choices);
			infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr (MEM_InformationMan.npc, MEM_InformationMan.player, InfoManagerDialogInstPtrCount);
			MEM_WriteIntArray (_@ (InfoManagerDialogInstPtr), InfoManagerDialogInstPtrCount, infoPtr);

			InfoManagerDialogInstPtrCount += 1;
		end;

		//InfoManagerRefreshOverlays = cIM_RefreshOverlays;
		InfoManagerHighlightSelected = TRUE;
		EnhancedInfoManagerReady = cEIM_Initialized;
	};

	//if (InfoManagerRefreshOverlays == cIM_RefreshOverlays)
	if (InfoManagerHighlightSelected) {
		InfoManagerHighlightSelected = FALSE;

		InfoManagerAnswerIndicator = 0;

		InfoManagerSpinnerIndicatorL = 0;
		InfoManagerSpinnerIndicatorR = 0;

		overlayCount = 0;

		//Reset value on CollectInfos/CollectChoices
		InfoManagerSpinnerNumber = "";
		InfoManagerSpinnerNumberEditMode = FALSE;
		InfoManagerSpinnerID = "";

		//Flag all overlays for deletion
		if (dlg.listTextLines_numInArray > dlg.Choices) {
			//arr = _^ (_@ (dlg.listTextLines_array));

			if (arr.array) {
				i = dlg.Choices;
				while (i < dlg.listTextLines_numInArray);
					txt = _^ (MEM_ReadIntArray (arr.array, i));
					txt.enabledTimer = TRUE;
					txt.timer = floatnull;
					i += 1;
				end;
			};
		};

		dialogCachedCount = 0;
		//InfoManagerRefreshOverlays = cIM_RefreshNothing;
		refreshOverlays = TRUE;
		refreshOverlayColors = TRUE;

		horizontalScrolling = HSCROLL_IDLE;
		horizontalScrollingDisabled = HSCROLL_IDLE;

		//Reset
		MEM_WriteIntArray (_@ (overlayListMapChoice), 0, -1);
		MEM_WriteIntArray (_@ (overlayListMapView), 0, 0);
		MEM_WriteStringArray (_@s (overlayID), 0, "");

		//if (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectInfos"))
		//|| (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectChoices"))
		//{
		if (InfoManagerCollectInfos)
		|| (InfoManagerCollectChoices)
		{
			if (_InfoManagerRememberSelectedChoice == cIM_RememberSelectedChoice_All)
			|| ((_InfoManagerRememberSelectedChoice == cIM_RememberSelectedChoice_Spinners) && (InfoManagerSpinnerPossible))
			{
				if (InfoManagerModeInfoLastChoiceSelected != dlg.ChoiceSelected) {
					if (InfoManagerModeInfoLastChoiceSelected < dlg.choices) {
						//Restore previous cursor position
						dlg.ChoiceSelected = InfoManagerModeInfoLastChoiceSelected;
						//Show selected choice
						zCViewDialogChoice_ShowSelected ();
						//Force auto-scrolling update
						InfoManagerLastChoiceSelected = -1;
					};
				};
			};
		};
	};

	if (InfoManagerLastChoiceSelected != dlg.ChoiceSelected) {
		//Reset value when choice changes
		InfoManagerSpinnerNumber = "";
		InfoManagerSpinnerNumberEditMode = FALSE;

		//Auto-scrolling for disabled dialog choices
		InfoManager_SkipDisabledDialogChoices (-1);
	};

	//Horizontal text scrolling - reset if selection changed / if scrolling was reset
	if (horizontalScrolling) {
		if ((horizontalScrollingChoiceNumber != dlg.ChoiceSelected) || (horizontalScrolling == HSCROLL_RESET)) {
			if (horizontalScrolling == HSCROLL_RESET) {
				horizontalScrolling = HSCROLL_INIT;
				timerHorizontalScrolling = 0;
			} else {
				horizontalScrolling = HSCROLL_IDLE;
			};

			//timerHorizontalScrolling += MEM_Timer.frameTime;

			//Reset cached dialog --> this will update dialog choice text
			if (horizontalScrollingChoiceNumber >= 0 && horizontalScrollingChoiceNumber < DIALOG_MAX) {
				MEM_WriteStringArray (_@s (dialogCachedDescriptions), horizontalScrollingChoiceNumber, "");
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
			while (i < dlg.choices);

				properties = MEM_ReadIntArray (_@ (dialogProperties), i);
				if (properties & dialogChoiceType_Disabled) {
					//Reset cached dialog --> this will update dialog choice text
					if (i < DIALOG_MAX) {
						MEM_WriteStringArray (_@s (dialogCachedDescriptions), i, "");
					};
				};

				i += 1;
			end;
		};
	};

	var int retVal;

	var int choiceConditionEvaluated; choiceConditionEvaluated = FALSE;
	var int InfoManagerSpinnerReRunCondition; InfoManagerSpinnerReRunCondition = FALSE;

	var oCInfoChoice dlgChoice;
	var int list;
	var zCList l;

	if (dlg.listTextLines_array)
	&& (dlg.listTextLines_numInArray) {
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

		loop = dlg.Choices;
		if (loop > arr.numInArray) {
			loop = arr.numInArray;
		};

		while (i < loop);

			var int InfoManagerSpinnerLoop; InfoManagerSpinnerLoop = MEM_StackPos.position;

			//Recalculate Y pos
			txt = _^ (MEM_ReadIntArray (arr.array, i));

			//Get current fontame
			if (_InfoManagerDefaultFontDialogGrey) {
				dlgFontPtr = _InfoManagerDefaultFontDialogGrey;
			} else {
				dlgFontPtr = txt.font;
			};

			if (_InfoManagerDefaultFontDialogSelected) {
				dlgFontSelectedPtr = _InfoManagerDefaultFontDialogSelected;
			} else {
				dlgFontSelectedPtr = dlgFontPtr;
			};

			dlgDescription = "";
			descriptionAvailable = FALSE;

			infoPtr = 0;
			properties = 0;

			if (i < dialogCachedCount) {
				oldDescription = MEM_ReadStringArray (_@s (dialogCachedDescriptions), i);
			} else {
				oldDescription = "";
			};

			if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO) {
				//infoPtr = oCInfoManager_GetInfoUnimportant_ByPtr (MEM_InformationMan.npc, MEM_InformationMan.player, i);
				infoPtr = EIM_GetInfoPtr (i);

				if (infoPtr) {
					dlgInstance = _^ (infoPtr);

					//--> re-evaluate dialog conditions
					self = _^ (MEM_InformationMan.npc);
					other = _^ (MEM_InformationMan.player);

					retVal = FALSE;

					if (dlgInstance.conditions > -1) {
						MEM_CallByID (dlgInstance.conditions);
						retVal = MEMINT_PopInt();
					};
					//<--

					dlgDescription = dlgInstance.description;
					descriptionAvailable = TRUE;
				};
			} else

			//Choices - have to be extracted from oCInfo.listChoices_next
			//MEM_InformationMan.Info is oCInfo pointer
			if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {

				infoPtr = MEM_InformationMan.Info;

				if (infoPtr) {
					dlgInstance = _^ (infoPtr);

					//--> re-evaluate dialog conditions
					//Prevent multiple calls for each choice - if already evaluated!
					if (!choiceConditionEvaluated) {
						self = _^ (MEM_InformationMan.npc);
						other = _^ (MEM_InformationMan.player);

						retVal = FALSE;
						if (dlgInstance.conditions > -1) {
							MEM_CallByID (dlgInstance.conditions);
							retVal = MEMINT_PopInt();
						};

						choiceConditionEvaluated = TRUE;
					};
					//<--

					//infoPtr = 0;

					j = 0;
					list = dlgInstance.listChoices_next;
					while (list);
						l = _^ (list);

						//if our dialog option is dialog choice - put text to dlgDescription
						if (l.data) {
							if (i == j) {
								//choicePtr = l.data;
								dlgChoice = _^ (l.data);
								dlgDescription = dlgChoice.Text;
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

			//if (i >= dlg.LineStart)
			//&& (txt.pixelPositionY + dlg.offsetTextPixelY - dlg.sizeMargin_0[1] <= dlg.pixelSizeY)
			//{
			//Store in cache
			if (descriptionAvailable) {
				if (i >= dialogCachedCount) {
					if (i < DIALOG_MAX) {
						MEM_WriteStringArray (_@s (dialogCachedDescriptions), i, dlgDescription);
						dialogCachedCount += 1;
						InfoManagerUpdateState = cIM_UpdateState_2BChanged;
					};
				} else {
					//Compare with cached description
					if (!Hlp_StrCmp (oldDescription, dlgDescription)) {
						//Update cache
						MEM_WriteStringArray (_@s (dialogCachedDescriptions), i, dlgDescription);

						//description changed!
						InfoManagerUpdateState = cIM_UpdateState_2BChanged;
					};
				};
			};

			if (InfoManagerUpdateState == cIM_UpdateState_2BChanged)
			|| (refreshOverlays)
			{
				/*
				TODO: Potential for optimization:
				Atm we are removing all overlays for changed dialog choice and then code below re-evaluates description - since all of them are deleted, code will in some cases add new version of them.
				We should check what exactly was changed - and if for example only color/text is changed then we should only update colors/texts.
				*/

				//--> Remove old overlays for this dialog choice
				j = 0;
				while (j < overlayCount);
					if (MEM_ReadIntArray (_@ (overlayListMapChoice), j) == i) {
						overlayPtr = MEM_ReadIntArray (_@ (overlayListMapView), j);
						if (overlayPtr) {
							MEM_WriteIntArray (_@ (overlayListMapChoice), j, -1);
							MEM_WriteIntArray (_@ (overlayListMapView), j, 0);
							MEM_WriteStringArray (_@s (overlayID), j, "");

							tempTxt = _^ (overlayPtr);
							tempTxt.enabledTimer = TRUE;
							tempTxt.timer = floatnull;

							refreshOverlayColors = TRUE;
						};
					};

					j += 1;
				end;
				//<-- remove old overlays

				//Default values
				dlgColor = _InfoManagerDefaultColorDialogGrey;
				dlgColorSelected = _InfoManagerDefaultDialogColorSelected;

				alignment = _InfoManagerDefaultDialogAlignment;

				if (descriptionAvailable)
				{
					/* Extract font, font selected, color and color selected from dlgDescription.
					   Clear dlgDescription in process. */

					s1 = "";
					s2 = "";
					s3 = "";

					flagDialogChoiceStartsWithOverlay = FALSE;
					defaultPosX = dlg.sizeMargin_0[0];

					overlayWidth = 0;
					overlayIndex = 0;
					overlayDialog = "";

					if (_InfoManagerNumKeysNumbers) {
						dlgDescription = ConcatStrings (InfoManagerNumKeyString (i + 1), dlgDescription);
					};

					dlgDescriptionClean = Choice_GetCleanText (dlgDescription);
					dlgDescriptionNoOverlays = Choice_RemoveAllOverlays (dlgDescription);

					overlayConcat = "";

					itemPreviewNo = 0;
					loopItemPreview = MEM_StackPos.position;

					//Item preview?
					index = STR_IndexOf (dlgDescription, "item@");

					if (index > -1) {
						var string itemPreviewInstName;
						itemPreviewInstName = Choice_ExtractModifier (_@s (dlgDescription), "item@");

						//Update only for selected choice
						if (i == dlg.ChoiceSelected) {
							//By default self
							npc = Hlp_GetNpc (self);

							//Check if we have another Npc specified
							index = STR_IndexOf (itemPreviewInstName, ":");
							if (index > -1) {
								var string npcInstanceName; npcInstanceName = mySTR_SubStr (itemPreviewInstName, 0, index);
								itemPreviewInstName = mySTR_SubStr (itemPreviewInstName, index + 1, STR_Len (itemPreviewInstName) - (index + 1));

								symbID = MEM_GetSymbolIndex (npcInstanceName);

								if (symbID > -1) {
									npc = Hlp_GetNpc (symbID);
								};
							};

							itemPreviewID = -1;

							if (NPC_HasItemInstanceName (npc, itemPreviewInstName)) {
								itemPreviewID = Hlp_GetInstanceID (item);
							};

							itemPreviewNo += 1;
							if (itemPreviewNo == 1) {

								//Close item preview every time selection changes
								EIM_CloseItemPreview ();

								InfoManagerItemPreviewIDOne = itemPreviewID;
								InfoManagerItemPreviewNpcOne = Hlp_GetInstanceID (npc);
								//Reset second value
								InfoManagerItemPreviewNpcTwo = -1;
							} else
							{
								InfoManagerItemPreviewIDTwo = itemPreviewID;
								InfoManagerItemPreviewNpcTwo = Hlp_GetInstanceID (npc);
							};

							properties = properties | dialogChoiceType_ItemPreview;
						};

						//We can have 2 entries
						MEM_StackPos.position = loopItemPreview;
					};

					//Disable indicators?
					index = STR_IndexOf (dlgDescription, "indOff@");

					if (index > -1) {
						dlgDescription = Choice_RemoveModifier (dlgDescription, "indOff@");
						properties = properties | dialogChoiceType_IndicatorsOff;
					};

					//Is this answer dialog ?
					index = STR_IndexOf (dlgDescription, "a@");

					if (index > -1) {
						dlgDescription = Choice_RemoveModifier (dlgDescription, "a@");
						properties = properties | dialogChoiceType_Answer;
					};

					//Is this disabled dialog ?
					index = STR_IndexOf (dlgDescription, "d@");

					if (index > -1) {
						dlgDescription = Choice_RemoveModifier (dlgDescription, "d@");
						properties = properties | dialogChoiceType_Disabled;
					};

					//al@ align left
					index = STR_IndexOf (dlgDescriptionNoOverlays, "al@");
					if (index > -1) {
						alignment = ALIGN_LEFT;
					};

					//ac@ align center
					index = STR_IndexOf (dlgDescriptionNoOverlays, "ac@");
					if (index > -1) {
						alignment = ALIGN_CENTER;
					};

					//ar@ align right
					index = STR_IndexOf (dlgDescriptionNoOverlays, "ar@");
					if (index > -1) {
						alignment = ALIGN_RIGHT;
					};

					//var int originalPosX; originalPosX = txt.pixelPositionX;

					thisID = IntToString (i);

					var int overlayLoop; overlayLoop = MEM_StackPos.position;

					//o@ h@FF8000 :(1) ~Dobrá, co bych měl vědět o o@hs@FF8000:tomhle~ místě?
					//o@:Dobrá, co bych měl vědět o ~o@hs@FF8000:tomhle~ místě?
					index = STR_IndexOf (dlgDescription, "o@");
					index2 = STR_IndexOfFrom (dlgDescription, ":", index);
					index3 = STR_IndexOfFrom (dlgDescription, "~", index2);

					overlayFormat = "";
					overlayColor = -1;
					overlayColorSelected = -1;

					overlayAlignment = -1; //no alignment

					//Recalculate pos X
					//overlayPosX = originalPosX;
					if (alignment == ALIGN_LEFT) {
						txt.pixelPositionX = defaultPosX;
					} else
					if (alignment == ALIGN_CENTER) {
						txt.pixelPositionX = (dlg.pixelSizeX / 2) - (Font_GetStringWidthPtr (dlgDescriptionClean, dlgFontPtr) / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					} else
					if (alignment == ALIGN_RIGHT) {
						txt.pixelPositionX = dlg.pixelSizeX - Font_GetStringWidthPtr (dlgDescriptionClean, dlgFontPtr) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

						//posX cannot be < defaultPosX - otherwise dialog choice will disappear
						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					};

					overlayPosX = txt.pixelPositionX;

					if (STR_Len (overlayConcat))
					&& (overlayIndex > 0)
					{
						overlayPosX += Font_GetStringWidthPtr (overlayConcat, dlgFontPtr);
					};

					if ((index > -1) && (index2 > index) && (index3 > index2))
					{
						//Prefix Overlay  Suffix
						s1 = ""; s2 = ""; s3 = "";

						//""
						if (index > 0) {
							s1 = mySTR_SubStr (dlgDescription, 0, index);
						};

						if (index > -1) {
							len = STR_Len (dlgDescription);
							// h@FF8000 :(1) ~Dobrá, co bych měl vědět o o@hs@FF8000:tomhle~ místě?
							//:Dobrá, co bych měl vědět o ~o@hs@FF8000:tomhle~ místě?
							s2 = mySTR_SubStr (dlgDescription, index + 2, len - index - 2);
						};

						len = STR_Len (s2);
						index = STR_IndexOf (s2, "~");

						if (index > -1) {
							// h@FF8000 :(1)
							//:Dobrá, co bych měl vědět o
							s3 = mySTR_Prefix (s2, index);

							//Dobrá, co bych měl vědět o o@hs@FF8000:tomhle~ místě?
							//o@hs@FF8000:tomhle~ místě?
							s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
						};

						len = STR_Len (s3);
						index = STR_IndexOf (s3, ":");

						if (index > -1) {
							// h@FF8000
							//
							overlayFormat = mySTR_Prefix (s3, index);
							//(1)
							//Dobrá, co bych měl vědět o
							overlayText = mySTR_SubStr (s3, index + 1, (len - index - 1));
						};

						//Default color
						if (properties & dialogChoiceType_Disabled) {
							dlgColor = _InfoManagerDisabledColorDialogGrey;
							dlgColorSelected = _InfoManagerDisabledDialogColorSelected;

							overlayColor = _InfoManagerDisabledDialogColorSelected;
							overlayColorSelected = _InfoManagerDisabledColorDialogGrey;
						} else {
							overlayColor = _InfoManagerDefaultColorDialogGrey;
							overlayColorSelected = _InfoManagerDefaultDialogColorSelected;
						};

						//--> Extract overlay format modifiers
						//Extract alignment
						index = STR_IndexOf (overlayFormat, "al@");
						if (index > -1) {
							overlayAlignment = ALIGN_LEFT;
							overlayFormat = Choice_RemoveModifier (overlayFormat, "al@");
						};

						index = STR_IndexOf (overlayFormat, "ac@");
						if (index > -1) {
							overlayAlignment = ALIGN_CENTER;
							overlayFormat = Choice_RemoveModifier (overlayFormat, "ac@");
						};

						index = STR_IndexOf (overlayFormat, "ar@");
						if (index > -1) {
							overlayAlignment = ALIGN_RIGHT;
							overlayFormat = Choice_RemoveModifier (overlayFormat, "ar@");
						};

						index = STR_IndexOf (overlayFormat, "tab@");
						if (index > -1) {
							overlayAlignment = ALIGN_TAB;
							overlayTab = STR_ToInt (Choice_ExtractModifier (_@s (overlayFormat), "tab@"));
						};
						//<--

						//If dialog choice starts with overlay, then we have to treat this first overlay as a dialog choice
						if (STR_Len (s1) == 0)
						&& (overlayIndex == 0)
						&& (overlayAlignment == -1)
						{
							flagDialogChoiceStartsWithOverlay = TRUE;
							overlayConcat = ConcatStrings (overlayConcat, Choice_RemoveAllModifiers (overlayText));

							overlayFormat = STR_Trim (overlayFormat, " ");

							// h@FF8000
							if (STR_Len (overlayFormat) > 0)
							{
								//h@FF8000 (1)
								s1 = ConcatStrings (overlayFormat, " ");
								s1 = ConcatStrings (s1, overlayText);
								overlayFormat = "";
							} else {
								s1 = overlayText;
							};

							//Dobrá, co bych měl vědět o o@hs@FF8000:tomhle~ místě?
							//overlayText = s2; s2 = "";
							overlayText = "";
						};

						if (overlayIndex == 0)
						{
							//h@FF8000 (1)
							overlayDialog = s1;

							if (overlayAlignment == -1)
							&& (flagDialogChoiceStartsWithOverlay == FALSE)
							{
								overlayConcat = ConcatStrings (overlayConcat, Choice_RemoveAllModifiers (overlayDialog));
								overlayPosX += Font_GetStringWidthPtr (overlayConcat, dlgFontPtr);
							};
						};

						//--> Extract overlay format modifiers
						index = STR_IndexOf (overlayFormat, "h@");

						if (index > -1) {
							hexColor = Choice_ExtractModifier (_@s (overlayFormat), "h@");
							overlayColor = HEX2RGBA (hexColor);
						};

						//Extract color selected
						index = STR_IndexOf (overlayFormat, "hs@");

						if (index > -1) {
							hexColor = Choice_ExtractModifier (_@s (overlayFormat), "hs@");
							overlayColorSelected = HEX2RGBA (hexColor);
						};
						//<--

						//thisID += 1;
						thisID = ConcatStrings (thisID, ".1");

						flagAdd = TRUE;

						if (!STR_Len (overlayText)) {
							flagAdd = FALSE;
						} else {
								//Extract font name
								index = (STR_IndexOf (overlayText, "f@"));

								if (index > -1) {
									dlgFont = Choice_ExtractModifier (_@s (overlayText), "f@");
									dlgFontPtr = Print_GetFontPtr (dlgFont);
								};

								//Extract font selected name
								index = (STR_IndexOf (overlayText, "fs@"));

								if (index > -1) {
									dlgFontSelected = Choice_ExtractModifier (_@s (overlayText), "fs@");
									dlgFontSelectedPtr = Print_GetFontPtr (dlgFontSelected);
								};

								//Extract color grayed
								index = (STR_IndexOf (overlayText, "h@"));

								if (index > -1) {
									hexColor = Choice_ExtractModifier (_@s (overlayText), "h@");
									overlayColor = HEX2RGBA (hexColor);
								};

								//Extract color selected
								index = (STR_IndexOf (overlayText, "hs@"));

								if (index > -1) {
									hexColor = Choice_ExtractModifier (_@s (overlayText), "hs@");
									overlayColorSelected = HEX2RGBA (hexColor);
								};

								//al@ align left
								index = (STR_IndexOf (overlayText, "al@"));
								if (index > -1) {
									//alignment = ALIGN_LEFT;
									overlayAlignment = ALIGN_LEFT;
									overlayText = Choice_RemoveModifier (overlayText, "al@");
								};

								//ac@ align center
								index = (STR_IndexOf (overlayText, "ac@"));
								if (index > -1) {
									//alignment = ALIGN_CENTER;
									overlayAlignment = ALIGN_CENTER;
									overlayText = Choice_RemoveModifier (overlayText, "ac@");
								};

								//ar@ align right
								index = (STR_IndexOf (overlayText, "ar@"));
								if (index > -1) {
									//alignment = ALIGN_RIGHT;
									overlayAlignment = ALIGN_RIGHT;
									overlayText = Choice_RemoveModifier (overlayText, "ar@");
								};

								//spinner s@
								index = (STR_IndexOf (overlayText, "s@"));

								if (index > -1) {
									properties = properties | dialogChoiceType_Spinner;
									spinnerID = Choice_ExtractModifier (_@s (overlayText), "s@");
									MEM_WriteStringArray (_@s (dialogSpinnerID), i, spinnerID);
								};
						};

						k = 0;
						nextAvailableOverlayIndex = -1;

						while (k < overlayCount);
							if (nextAvailableOverlayIndex == -1) {
								if (MEM_ReadIntArray (_@ (overlayListMapChoice), k) == -1) {
									nextAvailableOverlayIndex = k;
								};
							};

							if (Hlp_StrCmp (MEM_ReadStringArray (_@s (overlayID), k), thisID)) {
								//Update overlay text and colors
								overlayChoice = MEM_ReadIntArray (_@ (overlayListMapView), k);

								//if (overlayChoice < dlg.listTextLines_numInArray)
								if (overlayChoice)
								{
									//overlayChoiceTxt = _^ (MEM_ReadIntArray (arr.array, overlayChoice));
									overlayChoiceTxt = _^ (overlayChoice);

									overlayChoiceTxt.text = overlayText;

									//In line with text

									if (overlayAlignment == -1) {
										overlayChoiceTxt.pixelPositionX = overlayPosX;
									} else
									//align left
									if (overlayAlignment == ALIGN_LEFT) {
										overlayChoiceTxt.pixelPositionX = defaultPosX;
									} else
									//align center
									if (overlayAlignment == ALIGN_CENTER) {
										overlayChoiceTxt.pixelPositionX = (dlg.pixelSizeX / 2) - (Font_GetStringWidthPtr (overlayText, dlgFontPtr) / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

										if (overlayChoiceTxt.pixelPositionX < defaultPosX) {
											overlayChoiceTxt.pixelPositionX = defaultPosX;
										};
									} else
									//align right
									if (overlayAlignment == ALIGN_RIGHT) {
										overlayChoiceTxt.pixelPositionX = dlg.pixelSizeX - Font_GetStringWidthPtr (overlayText, dlgFontPtr) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

										if (overlayChoiceTxt.pixelPositionX < defaultPosX) {
											overlayChoiceTxt.pixelPositionX = defaultPosX;
										};
									} else
									if (overlayAlignment == ALIGN_TAB) {
										overlayChoiceTxt.pixelPositionX = defaultPosX + Font_GetStringWidthPtr (InfoManagerTabSize, dlgFontPtr) * overlayTab;
									};
								};

								flagAdd = false;
								break;
							};

							k += 1;
						end;

						txt.enabledBlend = TRUE;
						txt.funcAlphaBlend = _InfoManagerAlphaBlendFunc;

						if (InfoManagerAnswerMode)
						&& (dlg.ChoiceSelected == i)
						&& (properties & dialogChoiceType_Answer)
						{
							flagAdd = FALSE;
						};

						//Prevent overflow
						if (overlayCount >= OVERLAY_MAX) {
							flagAdd = FALSE;
						};

						if (flagAdd) {
							if (nextAvailableOverlayIndex == -1) {
								nextAvailableOverlayIndex = overlayCount;
								overlayCount += 1;
							};

							//Create new zCViewText2 instance for overlay
							overlayPtr = create (zCViewText2@);
							overlayChoiceTxt = _^ (overlayPtr);

							overlayChoiceTxt.enabledColor = txt.enabledColor;
							overlayChoiceTxt.font = txt.font;

							overlayChoiceTxt.enabledBlend = txt.enabledBlend;
							overlayChoiceTxt.funcAlphaBlend = txt.funcAlphaBlend;

							//overlayChoiceTxt.text = overlayText;

							overlayChoiceTxt.text = overlayText;

							//In line with text

							if (overlayAlignment == -1) {
								overlayChoiceTxt.pixelPositionX = overlayPosX;
							} else
							//align left
							if (overlayAlignment == ALIGN_LEFT) {
								overlayChoiceTxt.pixelPositionX = defaultPosX;
							} else
							//align center
							if (overlayAlignment == ALIGN_CENTER) {
								overlayChoiceTxt.pixelPositionX = (dlg.pixelSizeX / 2) - (Font_GetStringWidthPtr (overlayText, dlgFontPtr) / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

								if (overlayChoiceTxt.pixelPositionX < defaultPosX) {
									overlayChoiceTxt.pixelPositionX = defaultPosX;
								};
							} else
							//align right
							if (overlayAlignment == ALIGN_RIGHT) {
								overlayChoiceTxt.pixelPositionX = dlg.pixelSizeX - Font_GetStringWidthPtr (overlayText, dlgFontPtr) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

								if (overlayChoiceTxt.pixelPositionX < defaultPosX) {
									overlayChoiceTxt.pixelPositionX = defaultPosX;
								};
							} else
							if (overlayAlignment == ALIGN_TAB) {
								overlayChoiceTxt.pixelPositionX = defaultPosX + Font_GetStringWidthPtr (InfoManagerTabSize, dlgFontPtr) * overlayTab;
							};

							//We will exploit this variable a little bit
							overlayChoiceTxt.timer = nextAvailableOverlayIndex;
							overlayChoiceTxt.enabledTimer = FALSE;

							//Insert indicator to dialog choices
							MEM_ArrayInsert (_@ (dlg.listTextLines_array), overlayPtr);

							//MEM_WriteIntArray (_@ (overlayID), nextAvailableOverlayIndex, thisID);
							MEM_WriteStringArray (_@s (overlayID), nextAvailableOverlayIndex, thisID);

							MEM_WriteIntArray (_@ (overlayListColor), nextAvailableOverlayIndex, overlayColor);
							MEM_WriteIntArray (_@ (overlayListColorSelected), nextAvailableOverlayIndex, overlayColorSelected);

							MEM_WriteIntArray (_@ (overlayListMapChoice), nextAvailableOverlayIndex, i);
							//MEM_WriteIntArray (_@ (overlayListMapView), nextAvailableOverlayIndex, dlg.listTextLines_numInArray - 1);
							MEM_WriteIntArray (_@ (overlayListMapView), nextAvailableOverlayIndex, overlayPtr);

							//-->
							overlayChoiceTxt.pixelPositionY = txt.pixelPositionY;

							//Update color
							if (i == dlg.ChoiceSelected) {
								overlayChoiceTxt.color = overlayColorSelected;
								overlayChoiceTxt.alpha = GetAlpha (overlayColorSelected);
							} else {
								overlayChoiceTxt.color = overlayColor;
								overlayChoiceTxt.alpha = GetAlpha (overlayColor);
							};
							//<--

							//Reset values for next overlay
							if (overlayCount < OVERLAY_MAX) {
								MEM_WriteIntArray (_@ (overlayListMapView), overlayCount, 0);
								MEM_WriteIntArray (_@ (overlayListMapChoice), overlayCount, -1);
							};
						};
						//};

						//Dobrá, co bych měl vědět o o@hs@FF8000:tomhle~ místě?
						if (STR_Len (s2) > 0) {

							//Treat rest of this dialogue as overlays
							index = STR_IndexOf (s2, "o@");

							overlayFormat = "";

							/*
							if (nextOverlayAlignment != -1) {
								if (nextOverlayAlignment == ALIGN_LEFT) {
									overlayFormat = "al@";
								} else
								if (nextOverlayAlignment == ALIGN_CENTER) {
									overlayFormat = "ac@";
								} else
								if (nextOverlayAlignment == ALIGN_RIGHT) {
									overlayFormat = "ar@";
								};
							};
							*/

							//convert to overlays
							if (index == -1) {
								s2 = ConcatStrings (":", s2);
								s2 = ConcatStrings (overlayFormat, s2);
								s2 = ConcatStrings ("o@", s2);
								s2 = ConcatStrings (s2, "~");
							} else {
								if (index > 0) {
									len = STR_Len (s2);
									//Dobrá, co bych měl vědět o
									s1 = mySTR_Prefix (s2, index);
									//o@hs@FF8000:tomhle~ místě?
									s3 = mySTR_SubStr (s2, index, len - index);

									s2 = s1;

									s2 = ConcatStrings (":", s2);
									s2 = ConcatStrings (overlayFormat, s2);
									s2 = ConcatStrings ("o@", s2);
									s2 = ConcatStrings (s2, "~");

									//o@:Dobrá, co bych měl vědět o ~o@hs@FF8000:tomhle~ místě?
									s2 = ConcatStrings (s2, s3);
								};
							};
						};

						dlgDescription = s2;

						if (overlayAlignment == -1) {
							overlayConcat = ConcatStrings (overlayConcat, overlayText);
						};

						overlayIndex += 1;
						MEM_StackPos.position = overlayLoop;
					};

					if (STR_Len (overlayDialog) > 0) {
						dlgDescription = overlayDialog;
					};

					//<-- Overlays
					if (properties & dialogChoiceType_Disabled) {
						dlgColor = _InfoManagerDisabledColorDialogGrey;
						dlgColorSelected = _InfoManagerDisabledDialogColorSelected;
					};

					//Extract font name
					index = STR_IndexOf (dlgDescription, "f@");

					if (index > -1) {
						dlgFont = Choice_ExtractModifier (_@s (dlgDescription), "f@");
						dlgFontPtr = Print_GetFontPtr (dlgFont);
					};

					//Extract font selected name
					index = STR_IndexOf (dlgDescription, "fs@");

					if (index > -1) {
						dlgFontSelected = Choice_ExtractModifier (_@s (dlgDescription), "fs@");
						dlgFontSelectedPtr = Print_GetFontPtr (dlgFontSelected);
					};

					//Extract color grayed
					index = STR_IndexOf (dlgDescription, "h@");

					if (index > -1) {
						hexColor = Choice_ExtractModifier (_@s (dlgDescription), "h@");
						dlgColor = HEX2RGBA (hexColor);
					};

					//Extract color selected
					index = STR_IndexOf (dlgDescription, "hs@");

					if (index > -1) {
						hexColor = Choice_ExtractModifier (_@s (dlgDescription), "hs@");
						dlgColorSelected = HEX2RGBA (hexColor);
					};

					//al@ align left
					index = STR_IndexOf (dlgDescription, "al@");
					if (index > -1) {
						alignment = ALIGN_LEFT;
						dlgDescription = Choice_RemoveModifier (dlgDescription, "al@");
					};

					//ac@ align center
					index = STR_IndexOf (dlgDescription, "ac@");
					if (index > -1) {
						alignment = ALIGN_CENTER;
						dlgDescription = Choice_RemoveModifier (dlgDescription, "ac@");
					};

					//ar@ align right
					index = STR_IndexOf (dlgDescription, "ar@");
					if (index > -1) {
						alignment = ALIGN_RIGHT;
						dlgDescription = Choice_RemoveModifier (dlgDescription, "ar@");
					};

					//spinner s@
					index = STR_IndexOf (dlgDescription, "s@");
					if (index > -1) {
						properties = properties | dialogChoiceType_Spinner;
						spinnerID = Choice_ExtractModifier (_@s (dlgDescription), "s@");
						MEM_WriteStringArray (_@s (dialogSpinnerID), i, spinnerID);
					};

					if (i == dlg.ChoiceSelected) {
						dlgFontPtr = dlgFontSelectedPtr;

						//Can we go into answer mode? If yes replace description with current answer
						//if (InfoManagerAnswerMode) {
						//	dlgDescription = ConcatStrings (InfoManagerAnswer, "_");
						//};

						txt.color = dlgColorSelected;
						txt.alpha = GetAlpha (dlgColorSelected);
					} else {
						txt.color = dlgColor;
						txt.alpha = GetAlpha (dlgColor);
					};

					//Replace dialog option text with 'cleared' dlgDescription
					txt.text = dlgDescription;

					//

					if (alignment == ALIGN_LEFT) {
						txt.pixelPositionX = defaultPosX;
					} else
					if (alignment == ALIGN_CENTER) {
						txt.pixelPositionX = (dlg.pixelSizeX / 2) - (Font_GetStringWidthPtr (dlgDescriptionClean, dlgFontPtr) / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					} else
					if (alignment == ALIGN_RIGHT) {
						txt.pixelPositionX = dlg.pixelSizeX - Font_GetStringWidthPtr (dlgDescriptionClean, dlgFontPtr) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					};
				};

				//Well ... spinners are quite complex :)
				//Condition function updates everything spinner-related
				//However first time condition runs InfoManagerSpinnerID is not setup ... so only on second run EIM will refresh dialogue / choice descriptions
				//There is 1 frame (maybe more) - where dialogue description won't be updated - so this condition below checks whether spinner is selected - if yes - we will re-evaluate condition one more time.
				if (properties & dialogChoiceType_Spinner) {
					if (i == dlg.ChoiceSelected) {
						if (!InfoManagerSpinnerReRunCondition) {
							InfoManagerSpinnerID = spinnerID;
							InfoManagerSpinnerReRunCondition = TRUE;

							//Reset for dialogue with choices
							choiceConditionEvaluated = FALSE;
							MEM_StackPos.position = InfoManagerSpinnerLoop;
						};
					};
				};

				if (alignment == ALIGN_LEFT) {
					properties = properties | dialogChoiceType_AlignLeft;
				} else
				if (alignment == ALIGN_CENTER) {
					properties = properties | dialogChoiceType_AlignCenter;
				} else
				if (alignment == ALIGN_RIGHT) {
					properties = properties | dialogChoiceType_AlignRight;
				};

				if (i < DIALOG_MAX) {
					MEM_WriteIntArray (_@ (dialogProperties), i, properties);
					MEM_WriteIntArray (_@ (dialogColor), i, dlgColor);
					MEM_WriteIntArray (_@ (dialogColorSelected), i, dlgColorSelected);

					InfoManagerUpdateState = cIM_UpdateState_Changed;
				};
			};
			//};

			//Recalculate offsetTextpy and posY for dialog items in case fonts changed
			if (i < dlg.Choices) {
				if (i == 0) {
					nextPosY = txt.pixelPositionY;
					dlg.offsetTextPixelY = 0;
				} else {
					txt.pixelPositionY = nextPosY;
				};

				if (i < dlg.LineStart) {
					dlg.offsetTextPixelY -= zCFont_GetFontY (dlgFontPtr);
				};

				//Apply new font (or re-apply old one)
				//txt.font = Print_GetFontPtr (dlgFont);
				txt.font = dlgFontPtr;

				//
				nextPosY += zCFont_GetFontY (dlgFontPtr);
			};

			i += 1;
		end;

		if (InfoManagerHighlightSelected)
		|| (InfoManagerLastChoiceSelected != dlg.ChoiceSelected)
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
			i = dlg.LineStart;

			while (i < dlg.choices);
				txt = _^ (MEM_ReadIntArray (arr.array, i));

/*
				MEM_Info (txt.text);

				var string m;
				m = ConcatStrings ("posy ", IntToString (txt.pixelPositionY));

				m = ConcatStrings (m, " offsetTextpy ");
				m = ConcatStrings (m, IntToString (dlg.offsetTextPixelY));

				m = ConcatStrings (m, " psizey ");
				m = ConcatStrings (m, IntToString (dlg.pixelSizeY));

				MEM_Info (m);
*/
				//Small optimization - work only with visible dialogue choices
				if (txt.pixelPositionY + dlg.offsetTextPixelY - dlg.sizeMargin_0[1] > dlg.pixelSizeY) {
					break;
				};

				if (i == dlg.ChoiceSelected) {
					color = MEM_ReadIntArray (_@ (dialogColorSelected), i);
					txt.color = color;
					txt.alpha = GetAlpha (color);

					//Horizontal scrolling - if dialogue text > dialogue window
					if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlg.pixelSizeX - dlg.sizeMargin_1[0])) {
						//Init scrolling
						horizontalScrolling = HSCROLL_INIT;
						timerHorizontalScrolling = 0;
						timerHorizontalScrolling += MEM_Timer.frameTime;
						horizontalScrollingChoiceNumber = dlg.ChoiceSelected;
					};
				} else {
					color = MEM_ReadIntArray (_@ (dialogColor), i);
					txt.color = color;
					txt.alpha = GetAlpha (color);

					//Check disabled dialogues --> do we need to scroll any horizontal text?
					properties = MEM_ReadIntArray (_@ (dialogProperties), i);

					if (horizontalScrollingDisabled == HSCROLL_IDLE) {
						if (properties & dialogChoiceType_Disabled) {
							//Horizontal scrolling - if dialogue text > dialogue window
							if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlg.pixelSizeX - dlg.sizeMargin_1[0])) {
								//Init scrolling
								horizontalScrollingDisabled = HSCROLL_INIT;
								timerHorizontalScrollingDisabled = 0;
								//timerHorizontalScrollingDisabled += MEM_Timer.frameTime;
							};
						};
					};
				};

				//Apply alpha function
				txt.enabledBlend = TRUE;
				txt.funcAlphaBlend = _InfoManagerAlphaBlendFunc;

				i += 1;
			end;

			//--> Update overlay colors
			i = 0;

			while (i < overlayCount);

				overlayPtr = MEM_ReadIntArray (_@ (overlayListMapView), i);

				if (overlayPtr) {
					tempTxt = _^ (overlayPtr);
					overlayChoice = MEM_ReadIntArray (_@ (overlayListMapChoice), tempTxt.timer);

					if (overlayChoice < dlg.listTextLines_numInArray) {
						//adjust posY
						overlayChoiceTxt = _^ (MEM_ReadIntArray(arr.array, overlayChoice));
						tempTxt.pixelPositionY = overlayChoiceTxt.pixelPositionY;

						//Update color
						if (dlg.ChoiceSelected == overlayChoice) {
							color = MEM_ReadIntArray (_@(overlayListColorSelected), tempTxt.timer);
							tempTxt.color = color;
							tempTxt.alpha = GetAlpha (color);
						} else {
							color = MEM_ReadIntArray (_@(overlayListColor), tempTxt.timer);
							tempTxt.color = color;
							tempTxt.alpha = GetAlpha (color);
						};
					};
				};

				i += 1;
			end;

			//<-- Overlays
		};

		//Special properties
		if (dlg.ChoiceSelected > -1)
		&& (dlg.ChoiceSelected < dlg.choices)
		&& (dlg.ChoiceSelected < DIALOG_MAX) {
			properties = (MEM_ReadIntArray (_@ (dialogProperties), dlg.ChoiceSelected));

			alignment = _InfoManagerDefaultDialogAlignment;

			if (properties & dialogChoiceType_AlignLeft) {
				alignment = ALIGN_LEFT;
			} else
			if (properties & dialogChoiceType_AlignCenter) {
				alignment = ALIGN_CENTER;
			} else
			if (properties & dialogChoiceType_AlignRight) {
				alignment = ALIGN_RIGHT;
			};

			//var int lastInfoManagerSpinnerPossible; lastInfoManagerSpinnerPossible = InfoManagerSpinnerPossible;

			InfoManagerSpinnerPossible = properties & dialogChoiceType_Spinner;

			//if (lastInfoManagerSpinnerPossible != InfoManagerSpinnerPossible) {
				//Reset value
			//	InfoManagerSpinnerNumber = "";
			//};

			if (InfoManagerSpinnerPossible) {
				//Get spinner ID
				InfoManagerSpinnerID = MEM_ReadStringArray (_@s (dialogSpinnerID), dlg.ChoiceSelected);

				//Dokazeme tu pridat novy 'dialog' s transparentnym textom '<>' ako overlay ???
				//Funguje !

				txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));

				if (!(properties & dialogChoiceType_IndicatorsOff)) {
					//Create spinner indicators
					if (!InfoManagerSpinnerIndicatorL) {

						txt.enabledBlend = TRUE;
						txt.funcAlphaBlend = _InfoManagerAlphaBlendFunc;

						//Create 1st zCViewText2 instance for our indicator
						InfoManagerSpinnerIndicatorL = create (zCViewText2@);
						MEM_ArrayInsert (_@ (dlg.listTextLines_array), InfoManagerSpinnerIndicatorL);

						//Create 2nd zCViewText2 instance for our indicator
						InfoManagerSpinnerIndicatorR = create (zCViewText2@);
						MEM_ArrayInsert (_@ (dlg.listTextLines_array), InfoManagerSpinnerIndicatorR);

						//'Animate' to update positions (non animated indicator will get it's position updated below
						if (_InfoManagerSpinnerIndicatorAnimation) {
							spinnedIndicatorL = _^ (InfoManagerSpinnerIndicatorL);
							spinnedIndicatorL.font = txt.font;

							spinnedIndicatorR = _^ (InfoManagerSpinnerIndicatorR);
							spinnedIndicatorR.font = txt.font;

							InfoManagerSpinnerIndicatorAniProgress = 0;
							InfoManagerSpinnerAnimate ();
						};

						timerSpinnerAnimation = TimerGT () + 10;
					};

					//Update properties

					//'Left' part of spinner indicator
					spinnedIndicatorL = _^ (InfoManagerSpinnerIndicatorL);

					if (!_InfoManagerSpinnerIndicatorAnimation) {
						spinnedIndicatorL.text = _InfoManagerSpinnerIndicatorString;
					};

					spinnedIndicatorL.enabledColor = txt.enabledColor;
					spinnedIndicatorL.font = txt.font;

					spinnedIndicatorL.enabledBlend = txt.enabledBlend;
					spinnedIndicatorL.funcAlphaBlend = txt.funcAlphaBlend;

					spinnedIndicatorL.color = _InfoManagerIndicatorColorDefault;
					spinnedIndicatorL.alpha = GetAlpha (_InfoManagerIndicatorColorDefault);

					spinnedIndicatorL.pixelPositionY = txt.pixelPositionY;

					//'Right' part of spinner indicator
					spinnedIndicatorR = _^ (InfoManagerSpinnerIndicatorR);

					if (!_InfoManagerSpinnerIndicatorAnimation) {
						//spinnedIndicatorR.text = _InfoManagerSpinnerIndicatorString;
					};

					spinnedIndicatorR.enabledColor = txt.enabledColor;
					spinnedIndicatorR.font = txt.font;

					spinnedIndicatorR.enabledBlend = txt.enabledBlend;
					spinnedIndicatorR.funcAlphaBlend = txt.funcAlphaBlend;

					spinnedIndicatorR.color = _InfoManagerIndicatorColorDefault;
					spinnedIndicatorR.alpha = GetAlpha (_InfoManagerIndicatorColorDefault);

					spinnedIndicatorR.pixelPositionY = txt.pixelPositionY;

					//Initial alignment
					InfoManagerSpinnerAlignment = alignment;
				};
			};

			InfoManagerItemPreviewMode = properties & dialogChoiceType_ItemPreview;

			if (InfoManagerItemPreviewMode) {
				//Open item preview only once dialogue is fully opened
				if (dlg.hasOpened) {
					if ((InfoManagerItemPreviewNpcOne > -1) && (InfoManagerItemPreviewIDOne > -1)) {
						//Enable item preview
						if (!InfoManagerItemPreviewModeOn) {
							InfoManagerItemPreviewModeOn = TRUE;

							//First time will have focus - in order to render item details
							//Npc_InvOpenPassive (var int slfInstance, var int itemInstanceID, var int hasInvFocus)
							Npc_InvOpenPassive (InfoManagerItemPreviewNpcOne, InfoManagerItemPreviewIDOne, TRUE);

							if ((InfoManagerItemPreviewNpcTwo > -1) && (InfoManagerItemPreviewIDTwo > -1)) {
								Npc_InvOpenPassive (InfoManagerItemPreviewNpcTwo, InfoManagerItemPreviewIDTwo, FALSE);
							};
						};
					};
				};
			} else {
				//Close item preview if not active anymore
				EIM_CloseItemPreview ();
			};

			InfoManagerAnswerPossible = properties & dialogChoiceType_Answer;

			if (InfoManagerAnswerPossible) {
				txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));

				//Add answer indicator
				if (!InfoManagerAnswerMode) {
					if (!(properties & dialogChoiceType_IndicatorsOff)) {
						if (!InfoManagerAnswerIndicator) {
							txt.enabledBlend = TRUE;
							txt.funcAlphaBlend = _InfoManagerAlphaBlendFunc;

							//Create new zCViewText2 instance for our indicator
							InfoManagerAnswerIndicator = create (zCViewText2@);
							answerIndicator = _^ (InfoManagerAnswerIndicator);

							//Insert indicator to dialog choices
							MEM_ArrayInsert (_@ (dlg.listTextLines_array), InfoManagerAnswerIndicator);
						};

						answerIndicator = _^ (InfoManagerAnswerIndicator);
						answerIndicator.font = txt.font;

						answerIndicator.enabledColor = txt.enabledColor;

						answerIndicator.enabledBlend = txt.enabledBlend;
						answerIndicator.funcAlphaBlend = txt.funcAlphaBlend;
						//answerIndicator.alpha = _InfoManagerIndicatorAlpha;

						answerIndicator.text = _InfoManagerAnswerIndicatorString;

						answerIndicator.color = _InfoManagerIndicatorColorDefault;
						answerIndicator.alpha = GetAlpha (_InfoManagerIndicatorColorDefault);

						answerIndicator.pixelPositionY = txt.pixelPositionY;

						InfoManagerAnswerAlignment = alignment;

						//Initial alignment

						if (InfoManagerAnswerAlignment == ALIGN_LEFT) || (InfoManagerAnswerAlignment == ALIGN_CENTER) {
							answerIndicator.pixelPositionX = dlg.pixelSizeX - Font_GetStringWidthPtr (answerIndicator.text, answerIndicator.font) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
						} else {
							answerIndicator.pixelPositionX = dlg.sizeMargin_0[0];
						};
					};
				};
			};

			//Remove if not required (or if we are already answering)
			if (!InfoManagerAnswerPossible) || (InfoManagerAnswerMode) {
				if (InfoManagerAnswerIndicator) {
					//InfoManagerRefreshOverlays = cIM_RefreshOverlays;
					InfoManagerHighlightSelected = TRUE;
				};
			};

			//Remove if not required
			if (!InfoManagerSpinnerPossible) {
				if (InfoManagerSpinnerIndicatorL) {
					//InfoManagerRefreshOverlays = cIM_RefreshOverlays;
					InfoManagerHighlightSelected = TRUE;
				};
			};
		};

//-- Horizontal auto-scrolling for selected dialogue choice

		var int c;
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
				txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));

				//Double check size - shall we trim?
				if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlg.pixelSizeX - dlg.sizeMargin_1[0])) {
					//Switch to pixel scrolling
					c = CtoB (STR_Left (txt.text, 1));
					charWidth = zCFont_GetWidth (txt.font, c);
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

					txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));

					if (txt.pixelPositionX > dlg.sizeMargin_0[0]) {
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
				i = dlg.LineStart;
				while (i < dlg.choices);
					txt = _^ (MEM_ReadIntArray (arr.array, i));

					//Small optimization - work only with visible dialogue choices
					if (txt.pixelPositionY + dlg.offsetTextPixelY - dlg.sizeMargin_0[1] > dlg.pixelSizeY) {
						break;
					};

					properties = MEM_ReadIntArray (_@ (dialogProperties), i);
					if (properties & dialogChoiceType_Disabled) {

						//Double check size - shall we trim?
						if (Font_GetStringWidthPtr (txt.text, txt.font) > (dlg.pixelSizeX - dlg.sizeMargin_1[0])) {
							//Switch to pixel scrolling
							c = CtoB (STR_Left (txt.text, 1));
							charWidth = zCFont_GetWidth (txt.font, c);
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
					i = dlg.LineStart;
					while (i < dlg.choices);
						txt = _^ (MEM_ReadIntArray (arr.array, i));

						//Small optimization - work only with visible dialogue choices
						if (txt.pixelPositionY + dlg.offsetTextPixelY - dlg.sizeMargin_0[1] > dlg.pixelSizeY) {
							break;
						};

						properties = MEM_ReadIntArray (_@ (dialogProperties), i);
						if (properties & dialogChoiceType_Disabled) {

							if (txt.pixelPositionX > dlg.sizeMargin_0[0]) {
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

//--

		if (InfoManagerSpinnerPossible) {
			if (!_InfoManagerSpinnerIndicatorAnimation) {
				if (InfoManagerSpinnerIndicatorL) {
					spinnedIndicatorL = _^ (InfoManagerSpinnerIndicatorL);
					spinnedIndicatorL.text = _InfoManagerSpinnerIndicatorString;

					//Adjust alignment of spinner indicator

					if (InfoManagerSpinnerAlignment == ALIGN_LEFT) || (InfoManagerSpinnerAlignment == ALIGN_CENTER) {
						spinnedIndicatorL.pixelPositionX = dlg.pixelSizeX - Font_GetStringWidthPtr (spinnedIndicatorL.text, spinnedIndicatorL.font) - dlg.offsetTextPixelX - dlg.sizeMargin_1[0];
					} else {
						spinnedIndicatorL.pixelPositionX = dlg.sizeMargin_0[0];
					};
				};
			} else {
				//Animation implemented without FrameFunctions
				timerSpinnerAnimation += MEM_Timer.frameTime;
				if (timerSpinnerAnimation > 10) {
					timerSpinnerAnimation = 0;

					InfoManagerSpinnerIndicatorAniProgress += 1;
					InfoManagerSpinnerAnimate ();
				};
			};
		};

		if (InfoManagerAnswerPossible) {
			if (InfoManagerAnswerMode) {
				//Replace description with current answer
				txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));
				dlgDescription = ConcatStrings (InfoManagerAnswer, "_");
				txt.text = dlgDescription;
			} else {
				if (InfoManagerAnswerIndicator) {
					answerIndicator = _^ (InfoManagerAnswerIndicator);

					if (InfoManagerAnswerAlignment == ALIGN_LEFT) || (InfoManagerAnswerAlignment == ALIGN_CENTER) {
						answerIndicator.pixelPositionX = dlg.pixelSizeX - Font_GetStringWidthPtr (answerIndicator.text, answerIndicator.font) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
					} else {
						answerIndicator.pixelPositionX = dlg.sizeMargin_0[0];
					};
				};
			};
		};

		InfoManagerLastChoiceSelected = dlg.ChoiceSelected;
		InfoManagerModeInfoLastChoiceSelected = dlg.ChoiceSelected;
	};

	InfoManagerCollectInfos = FALSE;
	InfoManagerCollectChoices = FALSE;
	InfoManagerCollectInfosAllDisabled = FALSE;
};

/*
 *
 */
func void _hook_oCInformationManager_CollectChoices_EIM () {
	EIM_Reset ();

	if (!MEM_Game.infoman) { return; };

	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	var int infoPtr; infoPtr = MEM_InformationMan.Info;
	if (!infoPtr) { return; };

	InfoManagerCollectChoices = TRUE;

	//We can't use first parameter - it is a lie !!! :)
	//infoPtr = MEM_ReadInt (ESP + 4);
	InfoManagerLastChoiceSelected = -1;

	var oCInfo dlgInstance;
	dlgInstance = _^ (infoPtr);

	self = _^ (MEM_InformationMan.npc);
	other = _^ (MEM_InformationMan.player);

	//--> re-evaluate dialog conditions
	var int retVal; retVal = FALSE;
	if (dlgInstance.conditions > -1) {
		MEM_CallByID (dlgInstance.conditions);
		retVal = MEMINT_PopInt();
	};
	//<--

	var int i; i = 0;

	if (dlgInstance.listChoices_next) {

		var oCInfoChoice dlgChoice;
		var int list;
		var zCList l;
		var zCList p;
		var zCList n;

		//Remove hidden@ choices
		list = dlgInstance.listChoices_next;

		while (list);
			l = _^ (list);

			if (l.data) {
				dlgChoice = _^ (l.data);

				if (Choice_IsHidden (dlgChoice.Text)) {
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
						list = dlgInstance.listChoices_next;
						continue;
					} else {
						if (i == 0) {
							dlgInstance.listChoices_next = 0;
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

		list = dlgInstance.listChoices_next;

		while (list);
			l = _^ (list);

			if (l.data) {
				dlgChoice = _^ (l.data);

				if (!Choice_IsDisabled (dlgChoice.Text)) {
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

	InfoManagerCollectInfos = TRUE;

	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	InfoManagerLastChoiceSelected = -1;

	var int count; count = 0;
	var int allDisabled; allDisabled = TRUE;

	while (infoPtr);
		list = _^ (infoPtr);

		if (list.data) {
			dlgInstance = _^ (list.data);
			if (dlgInstance.npc == slfInstance) {

				//Here we have to re-evaluate dialogue conditions.
				//Because we can have a situation where condition function updates description
				//and dialogues will no longer be hidden.

				self = _^ (MEM_InformationMan.npc);
				other = _^ (MEM_InformationMan.player);

				var int retVal; retVal = FALSE;

				if (dlgInstance.conditions > -1) {
					MEM_CallByID (dlgInstance.conditions);
					retVal = MEMINT_PopInt();
				};

				if (Choice_IsHidden (dlgInstance.description)) {
					//hide
					if (dlgInstance.permanent == 1) {
						dlgInstance.told = -2;
						dlgInstance.permanent = 0;
					} else {
						if (dlgInstance.told == 0) {
							dlgInstance.told = -1;
						};
					};
				} else {
					//restore
					if (dlgInstance.told == -1) {
						dlgInstance.told = 0;
					} else
					if (dlgInstance.told == -2) {
						dlgInstance.permanent = 1;
						dlgInstance.told = 0;
					};
				};

				if (retVal) {
					//Only if not told / permanent
					if ((dlgInstance.told == 0) || (dlgInstance.permanent == 1)) {
						if (!Choice_IsDisabled (dlgInstance.description)) {
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
		InfoManagerCollectInfosAllDisabled = TRUE;
	};
};

func void _hook_oCInformationManager_OnImportantBegin_EIM () {
	EIM_Reset ();
};

func void _hook_oCInformationManager_OnExit_EIM () {
	EIM_Reset ();
};

func void _hook_zCViewDialogChoice_HighlightSelected_EIM () {
	InfoManagerHighlightSelected = TRUE;
};

func void _hook_oCItemContainer_DrawCategory_EIM () {
	if (!ECX) { return; };
	if (!InfoManagerItemPreviewModeOn) { return; };

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

	CALL__thiscall (ECX, zCInputCallback__GetEnableHandleEvent_G2);
	var int retVal; retVal = CALL_RetValAsInt ();

	EAX = 0;

	if ((retVal) || (InfoManagerItemPreviewModeOn)) {
		EAX = 1;
	};
};

func void _hook_oCItemContainer_DrawItemInfo_PreRenderItem_EIM () {
	var int npcInventoryPtr; npcInventoryPtr = MEMINT_SwitchG1G2 (ESI, EBP);
	if (!npcInventoryPtr) { return; };

	var oCNpcInventory npcInventory; npcInventory = _^ (npcInventoryPtr);

	//If there is dialogue choice - move viewItemInfo above dialogue
	if (MEM_InformationMan.DlgChoice) {
		var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);

		if (dlg.hasOpened) || (gf (dlg.timeOpen, FLOATNULL))
		{
			var zCView v; v = _^ (npcInventory.inventory2_oCItemContainer_viewItemInfo);

			var int newX;
			var int newY;

			newX = v.vposx;
			newY = v.vposy - (8192 - dlg.virtualPositionY);

			zCView_SetPos (npcInventory.inventory2_oCItemContainer_viewItemInfo, newX, newY);
		};
	};
};

func void G12_EnhancedInfoManager_Init () {
	//Reset pointers
	InfoManagerSpinnerIndicatorL = 0;
	InfoManagerSpinnerIndicatorR = 0;

	InfoManagerAnswerIndicator = 0;

	//-- Load API values / init default values

	_InfoManagerDefaultDialogColorSelected = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDEFAULTDIALOGCOLORSELECTED", "FFFFFF");
	_InfoManagerDefaultColorDialogGrey = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDEFAULTCOLORDIALOGGREY", "C8C8C8");

	//--

	var string fontName;
	fontName = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGSELECTED", "");

	if (STR_Len (fontName)) {
		_InfoManagerDefaultFontDialogSelected = Print_GetFontPtr (fontName);
	} else {
		_InfoManagerDefaultFontDialogSelected = 0;
	};

	fontName = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGGREY", "");

	if (STR_Len (fontName)) {
		_InfoManagerDefaultFontDialogGrey = Print_GetFontPtr (fontName);
	} else {
		_InfoManagerDefaultFontDialogGrey = 0;
	};

	//--

	_InfoManagerDisabledDialogColorSelected = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDISABLEDDIALOGCOLORSELECTED", "808080");
	_InfoManagerDisabledColorDialogGrey = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDISABLEDCOLORDIALOGGREY", "666666");

	//--

	_InfoManagerDefaultDialogAlignment = API_GetSymbolIntValue ("INFOMANAGERDEFAULTDIALOGALIGNMENT", ALIGN_LEFT);

	//--

	_InfoManagerIndicatorColorDefault = API_GetSymbolHEX2RGBAValue ("INFOMANAGERINDICATORCOLORDEFAULT", "C8C8C8");

	//--

	_InfoManagerIndicatorAlpha = API_GetSymbolIntValue ("INFOMANAGERINDICATORALPHA", 255);

	_InfoManagerSpinnerIndicatorString = API_GetSymbolStringValue ("INFOMANAGERSPINNERINDICATORSTRING", "<-- -->");
	_InfoManagerAnswerIndicatorString = API_GetSymbolStringValue ("INFOMANAGERANSWERINDICATORSTRING", "...");

	_InfoManagerSpinnerIndicatorAnimation = API_GetSymbolIntValue ("INFOMANAGERSPINNERINDICATORANIMATION", 1);

	_InfoManagerNumKeysControls = API_GetSymbolIntValue ("INFOMANAGERNUMKEYSCONTROLS", 1);
	_InfoManagerNumKeysNumbers = API_GetSymbolIntValue ("INFOMANAGERNUMKEYSNUMBERS", 0);

	_InfoManagerAlphaBlendFunc = API_GetSymbolIntValue ("INFOMANAGERALPHABLENDFUNC", 3);

	_InfoManagerRememberSelectedChoice = API_GetSymbolIntValue ("INFOMANAGERREMEMBERSELECTEDCHOICE", cIM_RememberSelectedChoice_Spinners);
	//--

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
	//Reset pointers
	InfoManagerSpinnerIndicatorL = 0;
	InfoManagerSpinnerIndicatorR = 0;

	InfoManagerAnswerIndicator = 0;

	//-- Load API values / init default values

	_InfoManagerDefaultDialogColorSelected = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDEFAULTDIALOGCOLORSELECTED", "FFFFFF");
	_InfoManagerDefaultColorDialogGrey = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDEFAULTCOLORDIALOGGREY", "C8C8C8");

	//--

	var string fontName;
	fontName = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGSELECTED", "");

	if (STR_Len (fontName)) {
		_InfoManagerDefaultFontDialogSelected = Print_GetFontPtr (fontName);
	} else {
		_InfoManagerDefaultFontDialogSelected = 0;
	};

	fontName = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGGREY", "");

	if (STR_Len (fontName)) {
		_InfoManagerDefaultFontDialogGrey = Print_GetFontPtr (fontName);
	} else {
		_InfoManagerDefaultFontDialogGrey = 0;
	};

	//--

	_InfoManagerDisabledDialogColorSelected = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDISABLEDDIALOGCOLORSELECTED", "808080");
	_InfoManagerDisabledColorDialogGrey = API_GetSymbolHEX2RGBAValue ("INFOMANAGERDISABLEDCOLORDIALOGGREY", "666666");

	//--

	_InfoManagerDefaultDialogAlignment = API_GetSymbolIntValue ("INFOMANAGERDEFAULTDIALOGALIGNMENT", ALIGN_LEFT);

	//--

	_InfoManagerIndicatorColorDefault = API_GetSymbolHEX2RGBAValue ("INFOMANAGERINDICATORCOLORDEFAULT", "C8C8C8");

	//--

	_InfoManagerIndicatorAlpha = API_GetSymbolIntValue ("INFOMANAGERINDICATORALPHA", 255);

	_InfoManagerSpinnerIndicatorString = API_GetSymbolStringValue ("INFOMANAGERSPINNERINDICATORSTRING", "<-- -->");
	_InfoManagerAnswerIndicatorString = API_GetSymbolStringValue ("INFOMANAGERANSWERINDICATORSTRING", "...");

	_InfoManagerSpinnerIndicatorAnimation = API_GetSymbolIntValue ("INFOMANAGERSPINNERINDICATORANIMATION", 1);

	_InfoManagerNumKeysControls = API_GetSymbolIntValue ("INFOMANAGERNUMKEYSCONTROLS", 1);
	_InfoManagerNumKeysNumbers = API_GetSymbolIntValue ("INFOMANAGERNUMKEYSNUMBERS", 0);

	_InfoManagerAlphaBlendFunc = API_GetSymbolIntValue ("INFOMANAGERALPHABLENDFUNC", 3);

	_InfoManagerRememberSelectedChoice = API_GetSymbolIntValue ("INFOMANAGERREMEMBERSELECTEDCHOICE", cIM_RememberSelectedChoice_Spinners);
	//--

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