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
 *						'o@h@00CC66 hs@66FFB2:TEST~'
 *						'o@ar@ h@00CC66 hs@66FFB2:TEST~'
 *
 *		hidden@			'hidden@'							 - removes dialog choice from dialog box.
 *
 *		indOff@			'indOff@'							 - does not create spinner / answer indicators
 *
 *	---> DEV NOTES <---
 *	Notes for us: keep in mind that some modifiers do have same naming: spinner 's@', color selected 'hs@', font selected 'fs@' --> that's why we have to work with modifiers in specific order.
 *	First take care of 'hs@', 'fs@' then 's@' !!!
 */

//-- Internal variables
var string _InfoManagerDefaultDialogColorSelected;
var string _InfoManagerDefaultColorDialogGrey;

var string _InfoManagerDefaultFontDialogSelected;
var string _InfoManagerDefaultFontDialogGrey;

var string _InfoManagerDisabledDialogColorSelected;
var string _InfoManagerDisabledColorDialogGrey;

var int _InfoManagerDefaultDialogAlignment;

var string _InfoManagerIndicatorColorDefault;
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

var int InfoManagerSpinnerIndicator;
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

func void oCInfoManager_Reset_EIM () {
	EnhancedInfoManagerReady = cEIM_Idle;
	InfoManagerDialogInstPtrCount = 0;
	InfoManagerCollectInfosAllDisabled = FALSE;
};

func int oCInfoManager_GetInfoPtr__EIM (var int index) {
	if ((index < 0) || (index >= InfoManagerDialogInstPtrCount)) {
		return 0;
	};

	return MEM_ReadIntArray (_@ (InfoManagerDialogInstPtr), index);
};

/*
 *	If you want, you can add your own 'animation' here :)
 */
func void InfoManagerSpinnerAnimate (var int animate) {
	var int aniStep;

	if (aniStep < 0) { aniStep = 0; };
	if (aniStep > 11) { aniStep = 0; };

	if (aniStep == 0) {
		_InfoManagerSpinnerIndicatorString = "   <- ->   ";
	} else
	if (aniStep == 1) {
		_InfoManagerSpinnerIndicatorString = "  <-  ->   ";
	} else
	if (aniStep == 2) {
		_InfoManagerSpinnerIndicatorString = " <-   ->   ";
	} else
	if (aniStep == 3) {
		_InfoManagerSpinnerIndicatorString = "<-    ->   ";
	} else
	if (aniStep == 4) {
		_InfoManagerSpinnerIndicatorString = " <-   ->   ";
	} else
	if (aniStep == 5) {
		_InfoManagerSpinnerIndicatorString = "  <-  ->   ";
	} else
	if (aniStep == 6) {
		_InfoManagerSpinnerIndicatorString = "   <- ->   ";
	} else
	if (aniStep == 7) {
		_InfoManagerSpinnerIndicatorString = "   <-  ->  ";
	} else
	if (aniStep == 8) {
		_InfoManagerSpinnerIndicatorString = "   <-   -> ";
	} else
	if (aniStep == 9) {
		_InfoManagerSpinnerIndicatorString = "   <-    ->";
	} else
	if (aniStep == 10) {
		_InfoManagerSpinnerIndicatorString = "   <-   -> ";
	} else
	if (aniStep == 11) {
		_InfoManagerSpinnerIndicatorString = "   <-  ->  ";
	} else
	if (aniStep == 12) {
		_InfoManagerSpinnerIndicatorString = "   <- ->   ";
	};

	if (animate) { aniStep += 1; };
};

func void InfoManagerSpinnerAniFunction () {
	InfoManagerSpinnerAnimate (TRUE);

	//If user exits dialogue with F8 with spinner saves/loads game then pointer to InfoManagerSpinnerIndicator is invalid
	if (MEM_InformationMan.IsDone) {
		InfoManagerSpinnerPossible = FALSE;
	};

	//Remove if not required
	if ((!InfoManagerSpinnerPossible) || (!InfoManagerSpinnerIndicator)) {
		//FF_Remove (InfoManagerSpinnerAniFunction);
	} else {
		//Animate
		var zCViewText2 txtIndicator;
		if (InfoManagerSpinnerIndicator) {
			txtIndicator = _^ (InfoManagerSpinnerIndicator);

			//if (STR_Len (InfoManagerSpinnerNumber)) {
			//	txtIndicator.text = InfoManagerSpinnerNumber;
			//} else {
				txtIndicator.text = _InfoManagerSpinnerIndicatorString;
			//};

			//Adjust alignment of spinner indicator
			var int textWidth;

			if (!MEM_InformationMan.DlgChoice) { return; };
			var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);

			textWidth = Print_GetStringWidthPtr (txtIndicator.text, txtIndicator.font);

			if (InfoManagerSpinnerAlignment == ALIGN_LEFT) || (InfoManagerSpinnerAlignment == ALIGN_CENTER) {
				txtIndicator.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
			} else {
				txtIndicator.pixelPositionX = dlg.sizeMargin_0[0];
			};
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

func int Choice_IsAnswer (var string s) {
	if (STR_IndexOf (s, "a@ ") > -1) {
		return TRUE;
	};

	return FALSE;
};

func int Choice_IsSpinner (var string s) {
	if (STR_IndexOf (s, "s@") > -1) {
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

func string Choice_GetModifierFont (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";

	len = STR_Len (s);
	index = STR_IndexOf (s, "f@");

	if (index == -1) {
		return "";
	};

	s1 = mySTR_SubStr (s, index + 2, len - 2);

	len = STR_Len (s1);
	index = STR_IndexOf (s1, " ");

	if (index == -1) {
		index = len;
	};

	return mySTR_Prefix (s1, index);
};

func string Choice_RemoveModifierFont (var string s) {
	var int len;
	var int index1;

	var string s1; s1 = "";
	var string s2; s2 = "";

	len = STR_Len (s);
	index1 = STR_IndexOf (s, "f@");

	if (index1 == -1) {
		return s;
	};

	if (index1 > 0) {
		s1 = mySTR_SubStr (s, 0, index1);
	};

	s2 = mySTR_SubStr (s, index1 + 2, len - 2);

	len = STR_Len (s2);
	index1 = STR_IndexOf (s2, " ");

	if (index1 == -1) {
		index1 = len;
	};

	if (index1 == len) {
		s2 = "";
	} else {
		s2 = mySTR_SubStr (s2, index1 + 1, (len - index1 - 1));
	};

	return ConcatStrings (s1, s2);
};

func string Choice_GetModifierFontSelected (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";

	len = STR_Len (s);
	index = STR_IndexOf (s, "fs@");

	if (index == -1) {
		return "";
	};

	s1 = mySTR_SubStr (s, index + 3, len - 3);

	len = STR_Len (s1);
	index = STR_IndexOf (s1, " ");

	if (index == -1) {
		index = len;
	};

	return mySTR_Prefix (s1, index);
};

func string Choice_RemoveModifierFontSelected (var string s) {
	var int len;
	var int index1;

	var string s1; s1 = "";
	var string s2; s2 = "";

	len = STR_Len (s);
	index1 = STR_IndexOf (s, "fs@");

	if (index1 == -1) {
		return s;
	};

	if (index1 > 0) {
		s1 = mySTR_SubStr (s, 0, index1);
	};

	s2 = mySTR_SubStr (s, index1 + 3, len - 3);

	len = STR_Len (s2);
	index1 = STR_IndexOf (s2, " ");

	if (index1 == -1) {
		index1 = len;
	};

	if (index1 == len) {
		s2 = "";
	} else {
		s2 = mySTR_SubStr (s2, index1 + 1, (len - index1 - 1));
	};

	return ConcatStrings (s1, s2);
};

func string Choice_GetModifierColor (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";

	len = STR_Len (s);
	index = STR_IndexOf (s, "h@");

	if (index == -1) {
		return "";
	};

	s1 = mySTR_SubStr (s, index + 2, len - 2);

	len = STR_Len (s1);
	index = STR_IndexOf (s1, " ");

	if (index == -1) {
		index = len;
	};

	return mySTR_Prefix (s1, index);
};

func string Choice_RemoveModifierColor (var string s) {
	var int len;
	var int index1;

	var string s1; s1 = "";
	var string s2; s2 = "";

	len = STR_Len (s);
	index1 = STR_IndexOf (s, "h@");

	if (index1 == -1) {
		return s;
	};

	if (index1 > 0) {
		s1 = mySTR_SubStr (s, 0, index1);
	};

	s2 = mySTR_SubStr (s, index1 + 2, len - 2);

	len = STR_Len (s2);
	index1 = STR_IndexOf (s2, " ");

	if (index1 == -1) {
		index1 = len;
	};

	if (index1 == len) {
		s2 = "";
	} else {
		s2 = mySTR_SubStr (s2, index1 + 1, (len - index1 - 1));
	};

	return ConcatStrings (s1, s2);
};

func string Choice_GetModifierColorSelected (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";

	len = STR_Len (s);
	index = STR_IndexOf (s, "hs@");

	if (index == -1) {
		return "";
	};

	s1 = mySTR_SubStr (s, index + 3, len - 3);

	len = STR_Len (s1);
	index = STR_IndexOf (s1, " ");

	if (index == -1) {
		index = len;
	};

	return mySTR_Prefix (s1, index);
};

func string Choice_RemoveModifierColorSelected (var string s) {
	var int len;
	var int index1;

	var string s1; s1 = "";
	var string s2; s2 = "";

	len = STR_Len (s);
	index1 = STR_IndexOf (s, "hs@");

	if (index1 == -1) {
		return s;
	};

	if (index1 > 0) {
		s1 = mySTR_SubStr (s, 0, index1);
	};

	s2 = mySTR_SubStr (s, index1 + 3, len - 3);

	len = STR_Len (s2);
	index1 = STR_IndexOf (s2, " ");

	if (index1 == -1) {
		index1 = len;
	};

	if (index1 == len) {
		s2 = "";
	} else {
		s2 = mySTR_SubStr (s2, index1 + 1, (len - index1 - 1));
	};

	return ConcatStrings (s1, s2);
};

func int Choice_GetModifierTab (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";

	len = STR_Len (s);
	index = STR_IndexOf (s, "tab@");

	if (index == -1) {
		return 0;
	};

	s1 = mySTR_SubStr (s, index + 4, len - 4);

	len = STR_Len (s1);
	index = STR_IndexOf (s1, " ");

	if (index == -1) {
		index = len;
	};

	s1 = mySTR_Prefix (s1, index);

	if (!STR_IsNumeric (s1)) { return 0; };

	return STR_ToInt (s1);
};

func string Choice_RemoveModifierTab (var string s) {
	var int len;
	var int index1;

	var string s1; s1 = "";
	var string s2; s2 = "";

	len = STR_Len (s);
	index1 = STR_IndexOf (s, "tab@");

	if (index1 == -1) {
		return s;
	};

	if (index1 > 0) {
		s1 = mySTR_SubStr (s, 0, index1);
	};

	s2 = mySTR_SubStr (s, index1 + 4, len - 4);

	len = STR_Len (s2);
	index1 = STR_IndexOf (s2, " ");

	if (index1 == -1) {
		index1 = len;
	};

	if (index1 == len) {
		s2 = "";
	} else {
		s2 = mySTR_SubStr (s2, index1 + 1, (len - index1 - 1));
	};

	return ConcatStrings (s1, s2);
};

/*
 *	Removes modifier by text (removes also space after modifier!), for example: "a@", "a@ "
 *		Choice_RemoveModifierByText (s, "a@")
 */
func string Choice_RemoveModifierByText (var string s, var string modifier) {
	var int len;
	var int index1;
	var int index2;

	var string s1; s1 = "";
	var string s2; s2 = "";

	len = STR_Len (s);

	index1 = STR_IndexOf (s, modifier);
	index2 = STR_IndexOf (s, ConcatStrings (modifier, " "));

	if (index1 == index2) {
		modifier = ConcatStrings (modifier, " ");
	};

	if (index1 == -1) {
		return s;
	};

	if (index1 > 0) {
		s1 = mySTR_SubStr (s, 0, index1);
	};

	s2 = mySTR_SubStr (s, index1 + STR_Len (modifier), len - STR_Len (modifier));

	return ConcatStrings (s1, s2);
};

//spinner s@
func string Choice_GetModifierSpinnerID (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";
	var string s2; s2 = "";

	var string spinnerID; spinnerID = "";

	len = STR_Len (s);
	index = STR_IndexOf (s, "s@");

	if (index > -1) {
		if (index > 0) {
			s1 = mySTR_SubStr (s, 0, index);
		};

		len = STR_Len (s);
		s2 = mySTR_SubStr (s, index + 2, len - 2);

		index = STR_IndexOf (s2, " ");
		len = STR_Len (s2);

		if (index == -1) {
			index = len;
		};

		spinnerID = mySTR_Prefix (s2, index);
	};

	return spinnerID;
};

func string Choice_RemoveModifierSpinner (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";
	var string s2; s2 = "";

	len = STR_Len (s);
	index = STR_IndexOf (s, "s@");

	if (index == -1) {
		return s;
	};

	if (index > 0) {
		s1 = mySTR_SubStr (s, 0, index);
	};

	s2 = mySTR_SubStr (s, index + 2, len - 2);

	index = STR_IndexOf (s2, " ");
	len = STR_Len (s2);

	if (index == -1) {
		index = len;
	};

	if (index == len) {
		s2 = "";
	} else {
		s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
	};

	return ConcatStrings (s1, s2);
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
	s = Choice_RemoveModifierByText (s, "indOff@");

	s = Choice_RemoveModifierFont (s);
	s = Choice_RemoveModifierFontSelected (s);
	s = Choice_RemoveModifierColor (s);
	s = Choice_RemoveModifierColorSelected (s);
	s = Choice_RemoveModifierByText (s, "a@");
	s = Choice_RemoveModifierByText (s, "d@");
	s = Choice_RemoveModifierSpinner (s);

	s = Choice_RemoveModifierByText (s, "al@");
	s = Choice_RemoveModifierByText (s, "ac@");
	s = Choice_RemoveModifierByText (s, "ar@");
	s = Choice_RemoveModifierByText (s, "tab@");

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
	s = Choice_RemoveModifierByText (s, "indOff@");

	s = Choice_RemoveModifierFont (s);
	s = Choice_RemoveModifierFontSelected (s);
	s = Choice_RemoveModifierColor (s);
	s = Choice_RemoveModifierColorSelected (s);
	s = Choice_RemoveModifierByText (s, "a@");
	s = Choice_RemoveModifierByText (s, "d@");
	s = Choice_RemoveModifierSpinner (s);

	s = Choice_RemoveModifierByText (s, "al@");
	s = Choice_RemoveModifierByText (s, "ac@");
	s = Choice_RemoveModifierByText (s, "ar@");
	s = Choice_RemoveModifierByText (s, "tab@");

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

					If (Hlp_StrCmp (Choice_GetModifierSpinnerID (dlgChoice.text), spinnerID)) {
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
			infoPtr = oCInfoManager_GetInfoPtr__EIM (index);

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

func void _hook_zCViewDialogChoice_HandleEvent_EnhancedInfoManager () {
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

func void _hook_oCInformationManager_Update_EnhancedInfoManager () {
	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

	if (!MEM_Game.infoman) { return; };

	//Don't run if done
	if (MEM_InformationMan.IsDone) { return; };

	//Don't run if opening / in dialogue / ending
	if (MEM_InformationMan.IsWaitingForOpen) { return; };
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
	var zCViewText2 txtIndicator;

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

//---
	const int OVERLAY_MAX = 255;

	var string overlayID[OVERLAY_MAX];

	var int overlayListMapChoice[OVERLAY_MAX];		//Dialog choice number
	var int overlayListMapView[OVERLAY_MAX];

	var int overlayListColor[OVERLAY_MAX];
	var int overlayListColorSelected[OVERLAY_MAX];

	var int refreshOverlays; refreshOverlays = FALSE;
	var int refreshOverlayColors; refreshOverlayColors = FALSE;

	var int color;
	var int colorSelected;

	var int overlayChoice;

	//Default colors
	var string spinnerID;

	var string dlgColor; dlgColor = _InfoManagerDefaultColorDialogGrey;
	var string dlgColorSelected; dlgColorSelected = _InfoManagerDefaultDialogColorSelected;

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
	var int overlayShiftX;
	var int overlayWidth;

	var int flagDialogChoiceStartsWithOverlay;
	var int flagAdd;
	var int k;

	var int overlayAlignment;
	var int overlayTab; overlayTab = 0;

	var int textWidth;
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
		InfoManagerSpinnerIndicator = 0;

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
					txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
					txtIndicator.enabledTimer = TRUE;
					txtIndicator.timer = floatnull;
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
						//Highlight selected - this will make sure ChoiceSelected is visible
						zCViewDialogChoice_HighlightSelected ();
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

			timerHorizontalScrolling += MEM_Timer.frameTime;

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
			timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			//Reset cached dialog --> this will update dialog choice text

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
			if (STR_Len (_InfoManagerDefaultFontDialogGrey)) {
				dlgFont = _InfoManagerDefaultFontDialogGrey;
			} else {
				dlgFont = Print_GetFontName (txt.font);
			};

			if (STR_Len (_InfoManagerDefaultFontDialogSelected)) {
				dlgFontSelected = _InfoManagerDefaultFontDialogSelected;
			} else {
				dlgFontSelected = dlgFont;
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
				infoPtr = oCInfoManager_GetInfoPtr__EIM (i);

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

							txtIndicator = _^ (overlayPtr);
							txtIndicator.enabledTimer = TRUE;
							txtIndicator.timer = floatnull;

							refreshOverlayColors = TRUE;
						};
					};

					j += 1;
				end;
				//<-- remove old overlays

				//Default values
				dlgColor = _InfoManagerDefaultColorDialogGrey;
				color = HEX2RGBA (dlgColor);

				dlgColorSelected = _InfoManagerDefaultDialogColorSelected;
				colorSelected = HEX2RGBA (dlgColorSelected);

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

					//Disable indicators?
					index = STR_IndexOf (dlgDescription, "indOff@");

					if (index > -1) {
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "indOff@");
						properties = properties | dialogChoiceType_IndicatorsOff;
					};

					//Is this answer dialog ?
					index = STR_IndexOf (dlgDescription, "a@");

					if (index > -1) {
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "a@");
						properties = properties | dialogChoiceType_Answer;
					};

					//Is this disabled dialog ?
					index = STR_IndexOf (dlgDescription, "d@");

					if (index > -1) {
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "d@");
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
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.pixelPositionX = (dlg.pixelSizeX / 2) - (textWidth / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					} else
					if (alignment == ALIGN_RIGHT) {
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

						//posX cannot be < defaultPosX - otherwise dialog choice will disappear
						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					};

					overlayPosX = txt.pixelPositionX;

					if (STR_Len (overlayConcat) > 0)
					&& (overlayIndex > 0)
					{
						//
						overlayShiftX = STR_SplitCount (overlayConcat, " ");
						overlayPosX += Print_GetStringWidth (overlayConcat, dlgFont) - overlayShiftX + 1;
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

							overlayColor = HEX2RGBA (_InfoManagerDisabledDialogColorSelected);
							overlayColorSelected = HEX2RGBA (_InfoManagerDisabledColorDialogGrey);
						} else {
							overlayColor = HEX2RGBA (_InfoManagerDefaultColorDialogGrey);
							overlayColorSelected = HEX2RGBA (_InfoManagerDefaultDialogColorSelected);
						};

						//--> Extract overlay format modifiers
						//Extract alignment
						index = STR_IndexOf (overlayFormat, "al@");
						if (index > -1) {
							overlayAlignment = ALIGN_LEFT;
							overlayFormat = Choice_RemoveModifierByText (overlayFormat, "al@");
						};

						index = STR_IndexOf (overlayFormat, "ac@");
						if (index > -1) {
							overlayAlignment = ALIGN_CENTER;
							overlayFormat = Choice_RemoveModifierByText (overlayFormat, "ac@");
						};

						index = STR_IndexOf (overlayFormat, "ar@");
						if (index > -1) {
							overlayAlignment = ALIGN_RIGHT;
							overlayFormat = Choice_RemoveModifierByText (overlayFormat, "ar@");
						};

						index = STR_IndexOf (overlayFormat, "tab@");
						if (index > -1) {
							overlayAlignment = ALIGN_TAB;
							overlayTab = Choice_GetModifierTab (overlayFormat);
							overlayFormat = Choice_RemoveModifierTab (overlayFormat);
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
								overlayConcat = ConcatStrings (overlayConcat, Choice_RemoveAllModifiers (s1));

								overlayShiftX = STR_SplitCount (overlayConcat, " ");
								overlayPosX += Print_GetStringWidth (overlayConcat, dlgFont) - overlayShiftX + 1;
							};
						};

						//--> Extract overlay format modifiers
						index = STR_IndexOf (overlayFormat, "h@");

						if (index > -1) {
							overlayColor = HEX2RGBA (Choice_GetModifierColor (overlayFormat));
							overlayFormat = Choice_RemoveModifierColor (overlayFormat);
						};

						//Extract color selected
						index = STR_IndexOf (overlayFormat, "hs@");

						if (index > -1) {
							overlayColorSelected = HEX2RGBA (Choice_GetModifierColorSelected (overlayFormat));
							overlayFormat = Choice_RemoveModifierColorSelected (overlayFormat);
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
									dlgFont = Choice_GetModifierFont (overlayText);
									overlayText = Choice_RemoveModifierFont (overlayText);
								};

								//Extract font selected name
								index = (STR_IndexOf (overlayText, "fs@"));

								if (index > -1) {
									dlgFontSelected = Choice_GetModifierFontSelected (overlayText);
									overlayText = Choice_RemoveModifierFontSelected (overlayText);
								};

								//Extract color grayed
								index = (STR_IndexOf (overlayText, "h@"));

								if (index > -1) {
									dlgColor = Choice_GetModifierColor (overlayText);
									overlayText = Choice_RemoveModifierColor (overlayText);
									overlayColor = HEX2RGBA (dlgColor);
								};

								//Extract color selected
								index = (STR_IndexOf (overlayText, "hs@"));

								if (index > -1) {
									dlgColorSelected = Choice_GetModifierColorSelected (overlayText);
									overlayText = Choice_RemoveModifierColorSelected (overlayText);
									overlayColorSelected = HEX2RGBA (dlgColorSelected);
								};

								//al@ align left
								index = (STR_IndexOf (overlayText, "al@"));
								if (index > -1) {
									//alignment = ALIGN_LEFT;
									overlayAlignment = ALIGN_LEFT;
									overlayText = Choice_RemoveModifierByText (overlayText, "al@");
								};

								//ac@ align center
								index = (STR_IndexOf (overlayText, "ac@"));
								if (index > -1) {
									//alignment = ALIGN_CENTER;
									overlayAlignment = ALIGN_CENTER;
									overlayText = Choice_RemoveModifierByText (overlayText, "ac@");
								};

								//ar@ align right
								index = (STR_IndexOf (overlayText, "ar@"));
								if (index > -1) {
									//alignment = ALIGN_RIGHT;
									overlayAlignment = ALIGN_RIGHT;
									overlayText = Choice_RemoveModifierByText (overlayText, "ar@");
								};

								//spinner s@
								index = (STR_IndexOf (overlayText, "s@"));

								if (index > -1) {
									properties = properties | dialogChoiceType_Spinner;
									spinnerID = Choice_GetModifierSpinnerID (overlayText);
									MEM_WriteStringArray (_@s (dialogSpinnerID), i, spinnerID);
									overlayText = Choice_RemoveModifierSpinner (overlayText);
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
										textWidth = Print_GetStringWidth (overlayText, dlgFont);
										overlayChoiceTxt.pixelPositionX = (dlg.pixelSizeX / 2) - (textWidth / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

										if (overlayChoiceTxt.pixelPositionX < defaultPosX) {
											overlayChoiceTxt.pixelPositionX = defaultPosX;
										};
									} else
									//align right
									if (overlayAlignment == ALIGN_RIGHT) {
										textWidth = Print_GetStringWidth (overlayText, dlgFont);
										overlayChoiceTxt.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

										if (overlayChoiceTxt.pixelPositionX < defaultPosX) {
											overlayChoiceTxt.pixelPositionX = defaultPosX;
										};
									} else
									if (overlayAlignment == ALIGN_TAB) {
										textWidth = Print_GetStringWidth (InfoManagerTabSize, dlgFont) * overlayTab;
										overlayChoiceTxt.pixelPositionX = defaultPosX + textWidth;
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
							txtIndicator = _^ (overlayPtr);

							txtIndicator.enabledColor = txt.enabledColor;
							txtIndicator.font = txt.font;

							txtIndicator.enabledBlend = txt.enabledBlend;
							txtIndicator.funcAlphaBlend = txt.funcAlphaBlend;

							txtIndicator.text = overlayText;

							//In line with text
							if (overlayAlignment == -1) {
								txtIndicator.pixelPositionX = overlayPosX;
							} else
							//align left
							if (overlayAlignment == ALIGN_LEFT) {
								txtIndicator.pixelPositionX = defaultPosX;
							} else
							//align center
							if (overlayAlignment == ALIGN_CENTER) {
								textWidth = Print_GetStringWidth (overlayText, dlgFont);
								txtIndicator.pixelPositionX = (dlg.pixelSizeX / 2) - (textWidth / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

								if (txtIndicator.pixelPositionX < defaultPosX) {
									txtIndicator.pixelPositionX = defaultPosX;
								};
							} else
							//align right
							if (overlayAlignment == ALIGN_RIGHT) {
								textWidth = Print_GetStringWidth (overlayText, dlgFont);
								txtIndicator.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

								if (txtIndicator.pixelPositionX < defaultPosX) {
									txtIndicator.pixelPositionX = defaultPosX;
								};
							} else
							if (overlayAlignment == ALIGN_TAB) {
								textWidth = Print_GetStringWidth (InfoManagerTabSize, dlgFont) * overlayTab;
								txtIndicator.pixelPositionX = defaultPosX + textWidth;
							};

							//We will exploit this variable a little bit
							txtIndicator.timer = nextAvailableOverlayIndex;
							txtIndicator.enabledTimer = FALSE;

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
							txtIndicator.pixelPositionY = txt.pixelPositionY;

							//Update color
							if (i == dlg.ChoiceSelected) {
								txtIndicator.color = overlayColorSelected;
								txtIndicator.alpha = GetAlpha (overlayColorSelected);
							} else {
								txtIndicator.color = overlayColor;
								txtIndicator.alpha = GetAlpha (overlayColor);
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
						dlgFont = Choice_GetModifierFont (dlgDescription);
						dlgDescription = Choice_RemoveModifierFont (dlgDescription);
					};

					//Extract font selected name
					index = STR_IndexOf (dlgDescription, "fs@");

					if (index > -1) {
						dlgFontSelected = Choice_GetModifierFontSelected (dlgDescription);
						dlgDescription = Choice_RemoveModifierFontSelected (dlgDescription);
					};

					//Extract color grayed
					index = STR_IndexOf (dlgDescription, "h@");

					if (index > -1) {
						dlgColor = Choice_GetModifierColor (dlgDescription);
						dlgDescription = Choice_RemoveModifierColor (dlgDescription);
					};

					//Extract color selected
					index = STR_IndexOf (dlgDescription, "hs@");

					if (index > -1) {
						dlgColorSelected = Choice_GetModifierColorSelected (dlgDescription);
						dlgDescription = Choice_RemoveModifierColorSelected (dlgDescription);
					};

					//al@ align left
					index = STR_IndexOf (dlgDescription, "al@");
					if (index > -1) {
						alignment = ALIGN_LEFT;
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "al@");
					};

					//ac@ align center
					index = STR_IndexOf (dlgDescription, "ac@");
					if (index > -1) {
						alignment = ALIGN_CENTER;
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "ac@");
					};

					//ar@ align right
					index = STR_IndexOf (dlgDescription, "ar@");
					if (index > -1) {
						alignment = ALIGN_RIGHT;
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "ar@");
					};

					//spinner s@
					index = STR_IndexOf (dlgDescription, "s@");
					if (index > -1) {
						properties = properties | dialogChoiceType_Spinner;
						spinnerID = Choice_GetModifierSpinnerID (dlgDescription);
						MEM_WriteStringArray (_@s (dialogSpinnerID), i, spinnerID);
						dlgDescription = Choice_RemoveModifierSpinner (dlgDescription);
					};

					//txtIndicator.pixelPositionX = dlg.pixelSizeX - txt.pixelPositionX - textWidth - dlg.offsetTextPixelX;
					//

					if (STR_Len (dlgColor) > 0) {
						color = HEX2RGBA (dlgColor);
					};

					if (STR_Len (dlgColorSelected) > 0) {
						colorSelected = HEX2RGBA (dlgColorSelected);
					};

					if (i == dlg.ChoiceSelected) {
						if (STR_Len (dlgFontSelected) > 0) {
							dlgFont = dlgFontSelected;
						};

						//Can we go into answer mode? If yes replace description with current answer
						//if (InfoManagerAnswerMode) {
						//	dlgDescription = ConcatStrings (InfoManagerAnswer, "_");
						//};

						txt.color = colorSelected;
						txt.alpha = GetAlpha (colorSelected);
					} else {
						txt.color = color;
						txt.alpha = GetAlpha (color);
					};

					//Replace dialog option text with 'cleared' dlgDescription
					txt.text = dlgDescription;

					//
					if (alignment == ALIGN_LEFT) {
						txt.pixelPositionX = defaultPosX;
					} else
					if (alignment == ALIGN_CENTER) {
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.pixelPositionX = (dlg.pixelSizeX / 2) - (textWidth / 2) - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

						if (txt.pixelPositionX < defaultPosX) {
							txt.pixelPositionX = defaultPosX;
						};
					} else
					if (alignment == ALIGN_RIGHT) {
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];

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
					MEM_WriteIntArray (_@ (dialogColor), i, color);
					MEM_WriteIntArray (_@ (dialogColorSelected), i, colorSelected);

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
					dlg.offsetTextPixelY -= Print_GetFontHeight (dlgFont);
				};

				//Apply new font (or re-apply old one)
				txt.font = Print_GetFontPtr (dlgFont);

				//
				nextPosY += Print_GetFontHeight (dlgFont);
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
			//Small optimization - recolor only visible dialog choices
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
				//Small optimization - recolor only visible dialog choices
				if (txt.pixelPositionY + dlg.offsetTextPixelY - dlg.sizeMargin_0[1] > dlg.pixelSizeY) {
					break;
				};

				if (i == dlg.ChoiceSelected) {
					colorSelected = MEM_ReadIntArray (_@ (dialogColorSelected), i);
					txt.color = colorSelected;
					txt.alpha = GetAlpha (colorSelected);

					dlgFont = Print_GetFontName (txt.font);
					textWidth = Print_GetStringWidth (txt.text, dlgFont);

					//Horizontal scrolling - if dialogue text > dialogue window
					if (textWidth > dlg.pixelSizeX) {
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
					if (properties & dialogChoiceType_Disabled) {
						dlgFont = Print_GetFontName (txt.font);
						textWidth = Print_GetStringWidth (txt.text, dlgFont);

						//Horizontal scrolling - if dialogue text > dialogue window
						if (textWidth > dlg.pixelSizeX) {
							//Init scrolling
							horizontalScrollingDisabled = HSCROLL_INIT;
							timerHorizontalScrollingDisabled = 0;
							timerHorizontalScrollingDisabled += MEM_Timer.frameTime;
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
					txtIndicator = _^ (overlayPtr);
					overlayChoice = MEM_ReadIntArray (_@ (overlayListMapChoice), txtIndicator.timer);

					if (overlayChoice < dlg.listTextLines_numInArray) {
						//adjust posY
						overlayChoiceTxt = _^ (MEM_ReadIntArray(arr.array, overlayChoice));
						txtIndicator.pixelPositionY = overlayChoiceTxt.pixelPositionY;

						//Update color
						if (dlg.ChoiceSelected == overlayChoice) {
							colorSelected = MEM_ReadIntArray (_@(overlayListColorSelected), txtIndicator.timer);
							txtIndicator.color = colorSelected;
							txtIndicator.alpha = GetAlpha (colorSelected);
						} else {
							color = MEM_ReadIntArray (_@(overlayListColor), txtIndicator.timer);
							txtIndicator.color = color;
							txtIndicator.alpha = GetAlpha (color);
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
					//Add spinner indicator if it does not exist anymore
					if (!InfoManagerSpinnerIndicator) {

						txt.enabledBlend = TRUE;
						txt.funcAlphaBlend = _InfoManagerAlphaBlendFunc;

						//Create new zCViewText2 instance for our indicator
						InfoManagerSpinnerIndicator = create (zCViewText2@);
						txtIndicator = _^ (InfoManagerSpinnerIndicator);

						txtIndicator.enabledColor = txt.enabledColor;
						txtIndicator.font = txt.font;
						txtIndicator.pixelPositionY = txt.pixelPositionY;

						txtIndicator.enabledBlend = txt.enabledBlend;
						txtIndicator.funcAlphaBlend = txt.funcAlphaBlend;
						txtIndicator.alpha = _InfoManagerIndicatorAlpha;

						//Insert indicator to dialog choices
						MEM_ArrayInsert (_@ (dlg.listTextLines_array), InfoManagerSpinnerIndicator);

						//if (_InfoManagerSpinnerIndicatorAnimation) {
						//	FF_ApplyOnceExtGT (InfoManagerSpinnerAniFunction, 80, -1);
						//	InfoManagerSpinnerAnimate (FALSE);
						//};
					};

					//
					txtIndicator = _^ (InfoManagerSpinnerIndicator);

					txtIndicator.text = _InfoManagerSpinnerIndicatorString;
					txtIndicator.font = txt.font;

					if (STR_Len (_InfoManagerIndicatorColorDefault)) {
						color = HEX2RGBA (_InfoManagerIndicatorColorDefault);
						txtIndicator.color = color;
						txtIndicator.alpha = GetAlpha (color);
					} else {
						txtIndicator.color = txt.color;
						txtIndicator.alpha = txt.alpha;
					};

					txtIndicator.pixelPositionY = txt.pixelPositionY;

					//dlgFont = Print_GetFontName (txt.font);
					//textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);

					//if (alignment == ALIGN_LEFT) || (alignment == ALIGN_CENTER) {
					//	txtIndicator.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
					//};

					InfoManagerSpinnerAlignment = alignment;

					//Initial alignment
					dlgFont = Print_GetFontName (txtIndicator.font);
					textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);

					if (InfoManagerSpinnerAlignment == ALIGN_LEFT) || (InfoManagerSpinnerAlignment == ALIGN_CENTER) {
						txtIndicator.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
					} else {
						txtIndicator.pixelPositionX = dlg.sizeMargin_0[0];
					};
				};
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
							txtIndicator = _^ (InfoManagerAnswerIndicator);

							txtIndicator.enabledColor = txt.enabledColor;
							txtIndicator.font = txt.font;
							txtIndicator.pixelPositionY = txt.pixelPositionY;

							txtIndicator.enabledBlend = txt.enabledBlend;
							txtIndicator.funcAlphaBlend = txt.funcAlphaBlend;
							txtIndicator.alpha = _InfoManagerIndicatorAlpha;

							txtIndicator.text = _InfoManagerAnswerIndicatorString;

							//Insert indicator to dialog choices
							MEM_ArrayInsert (_@ (dlg.listTextLines_array), InfoManagerAnswerIndicator);
						};

						txtIndicator = _^ (InfoManagerAnswerIndicator);
						txtIndicator.font = txt.font;

						if (STR_Len (_InfoManagerIndicatorColorDefault)) {
							color = HEX2RGBA (_InfoManagerIndicatorColorDefault);
							txtIndicator.color = color;
							txtIndicator.alpha = GetAlpha (color);
						} else {
							txtIndicator.color = txt.color;
							txtIndicator.alpha = txt.alpha;
						};

						txtIndicator.pixelPositionY = txt.pixelPositionY;

						InfoManagerAnswerAlignment = alignment;

						//Initial alignment
						dlgFont = Print_GetFontName (txtIndicator.font);
						textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);

						if (InfoManagerAnswerAlignment == ALIGN_LEFT) || (InfoManagerAnswerAlignment == ALIGN_CENTER) {
							txtIndicator.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
						} else {
							txtIndicator.pixelPositionX = dlg.sizeMargin_0[0];
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
				if (InfoManagerSpinnerIndicator) {
					//InfoManagerRefreshOverlays = cIM_RefreshOverlays;
					InfoManagerHighlightSelected = TRUE;
				};
			};
		};

		//Horizontal auto-scrolling for dialog text

		//First wait for a moment ...
		if (horizontalScrolling == HSCROLL_INIT) {
			timerHorizontalScrolling = 0;
			timerHorizontalScrolling += MEM_Timer.frameTime;

			if (timerHorizontalScrolling >= 2000) {
				timerHorizontalScrolling -= 2000;
				horizontalScrolling = HSCROLL_SCROLL;
			};
		};

		//Scroll text
		if (horizontalScrolling == HSCROLL_SCROLL) {
			timerHorizontalScrolling += MEM_Timer.frameTime;

			if (timerHorizontalScrolling >= 90) {
				timerHorizontalScrolling -= 90;

				//we cannot really change txt.pixelPositionX if txt.pixelPositionX < defaultPosX then dialogue choice wont render ...
				//so the only option to scroll text is to trim it ...
				txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));

				dlgFont = Print_GetFontName (txt.font);
				textWidth = Print_GetStringWidth (txt.text, dlgFont);

				//Double check size - shall we trim?
				if (textWidth > dlg.pixelSizeX) {
					txt.text = mySTR_SubStr (txt.text, 1, STR_Len (txt.text) - 1);
				} else {
					//If text was scrolled completely ... wait
					horizontalScrolling = HSCROLL_WAIT;
				};
			};
		};

		//Wait for a moment - and reset scrolling
		if (horizontalScrolling == HSCROLL_WAIT) {
			timerHorizontalScrolling += MEM_Timer.frameTime;

			if (timerHorizontalScrolling >= 4000) {
				timerHorizontalScrolling -= 4000;
				//This will force an update
				horizontalScrolling = HSCROLL_RESET;
			};
		};

		//Horizontal auto-scrolling for disabled dialog text

		//First wait for a moment ...
		if (horizontalScrollingDisabled == HSCROLL_INIT) {
			timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			if (timerHorizontalScrollingDisabled >= 2000) {
				timerHorizontalScrollingDisabled -= 2000;
				horizontalScrollingDisabled = HSCROLL_SCROLL;
			};
		};

		//Scroll text
		if (horizontalScrollingDisabled == HSCROLL_SCROLL) {
			timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			if (timerHorizontalScrollingDisabled >= 90) {
				timerHorizontalScrollingDisabled -= 90;

				//we cannot really change txt.pixelPositionX if txt.pixelPositionX < defaultPosX then dialogue choice wont render ...
				//so the only option to scroll text is to trim it ...

				//loop through all dialogues
				var int wasSomethingScrolled; wasSomethingScrolled = FALSE;

				//Small optimization - recolor only visible dialog choices
				i = dlg.LineStart;

				while (i < dlg.choices);

					properties = MEM_ReadIntArray (_@ (dialogProperties), i);
					if (properties & dialogChoiceType_Disabled) {

						txt = _^ (MEM_ReadIntArray (arr.array, i));

						dlgFont = Print_GetFontName (txt.font);
						textWidth = Print_GetStringWidth (txt.text, dlgFont);

						//Double check size - shall we trim?
						if (textWidth > dlg.pixelSizeX) {
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
		};

		//Wait for a moment - and reset scrolling
		if (horizontalScrollingDisabled == HSCROLL_WAIT) {
			timerHorizontalScrollingDisabled += MEM_Timer.frameTime;

			if (timerHorizontalScrollingDisabled >= 4000) {
				timerHorizontalScrollingDisabled -= 4000;
				//This will force an update
				horizontalScrollingDisabled = HSCROLL_RESET;
			};
		};

		//--

		if (InfoManagerSpinnerPossible) {
			if (!_InfoManagerSpinnerIndicatorAnimation) {
				if (InfoManagerSpinnerIndicator) {
					txtIndicator = _^ (InfoManagerSpinnerIndicator);

					//if (STR_Len (InfoManagerSpinnerNumber)) {
					//	txtIndicator.text = InfoManagerSpinnerNumber;
					//} else {
						txtIndicator.text = _InfoManagerSpinnerIndicatorString;
					//};

					//Adjust alignment of spinner indicator
					dlgFont = Print_GetFontName (txtIndicator.font);
					textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);

					if (InfoManagerSpinnerAlignment == ALIGN_LEFT) || (InfoManagerSpinnerAlignment == ALIGN_CENTER) {
						txtIndicator.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
					} else {
						txtIndicator.pixelPositionX = dlg.sizeMargin_0[0];
					};
				};
			} else {
				//Animation implemented without FrameFunctions
				timerSpinnerAnimation += MEM_Timer.frameTime;
				if (timerSpinnerAnimation > 80) {
					timerSpinnerAnimation -= 80;
					InfoManagerSpinnerAniFunction ();
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
					txtIndicator = _^ (InfoManagerAnswerIndicator);
					dlgFont = Print_GetFontName (txtIndicator.font);
					textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);

					if (InfoManagerAnswerAlignment == ALIGN_LEFT) || (InfoManagerAnswerAlignment == ALIGN_CENTER) {
						txtIndicator.pixelPositionX = dlg.pixelSizeX - textWidth - dlg.offsetTextPixelX - dlg.sizeMargin_0[0];
					} else {
						txtIndicator.pixelPositionX = dlg.sizeMargin_0[0];
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
func void _hook_oCInformationManager_CollectChoices () {
	oCInfoManager_Reset_EIM ();

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
func void _hook_oCInformationManager_CollectInfos () {
	oCInfoManager_Reset_EIM ();

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

func void _hook_oCInformationManager_OnImportantBegin () {
	oCInfoManager_Reset_EIM ();
};

func void _hook_oCInformationManager_OnExit () {
	oCInfoManager_Reset_EIM ();
};

func void _hook_zCViewDialogChoice_HighlightSelected () {
	InfoManagerHighlightSelected = TRUE;
};

func void G12_EnhancedInfoManager_Init () {
	//Reset pointers
	InfoManagerSpinnerIndicator = 0;
	InfoManagerAnswerIndicator = 0;

	//-- Load API values / init default values
	_InfoManagerDefaultDialogColorSelected = API_GetSymbolStringValue ("INFOMANAGERDEFAULTDIALOGCOLORSELECTED", "FFFFFF");
	_InfoManagerDefaultColorDialogGrey = API_GetSymbolStringValue ("INFOMANAGERDEFAULTCOLORDIALOGGREY", "C8C8C8");

	_InfoManagerDefaultFontDialogSelected = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGSELECTED", "");
	_InfoManagerDefaultFontDialogGrey = API_GetSymbolStringValue ("INFOMANAGERDEFAULTFONTDIALOGGREY", "");

	_InfoManagerDisabledDialogColorSelected = API_GetSymbolStringValue ("INFOMANAGERDISABLEDDIALOGCOLORSELECTED", "808080");
	_InfoManagerDisabledColorDialogGrey = API_GetSymbolStringValue ("INFOMANAGERDISABLEDCOLORDIALOGGREY", "666666");

	_InfoManagerDefaultDialogAlignment = API_GetSymbolIntValue ("INFOMANAGERDEFAULTDIALOGALIGNMENT", ALIGN_LEFT);

	_InfoManagerIndicatorColorDefault = API_GetSymbolStringValue ("INFOMANAGERINDICATORCOLORDEFAULT", "C8C8C8");
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
		HookEngine (zCViewDialogChoice__HandleEvent, 9, "_hook_zCViewDialogChoice_HandleEvent_EnhancedInfoManager");
		HookEngine (oCInformationManager__Update, 5, "_hook_oCInformationManager_Update_EnhancedInfoManager");

		HookEngine (oCInformationManager__CollectChoices, 5, "_hook_oCInformationManager_CollectChoices");
		HookEngine (oCInformationManager__CollectInfos, 7, "_hook_oCInformationManager_CollectInfos");

		//0x0072D0A0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G1 = 7524512;

		//0x00661DB0 protected: void __fastcall oCInformationManager::OnImportantBegin(void)
		const int oCInformationManager__OnImportantBegin_G2 = 6692272;

		HookEngine (MEMINT_SwitchG1G2 (oCInformationManager__OnImportantBegin_G1, oCInformationManager__OnImportantBegin_G2), 6, "_hook_oCInformationManager_OnImportantBegin");

		//0x0072E360 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G1 = 7529312;

		//0x006630D0 protected: void __fastcall oCInformationManager::OnExit(void)
		const int oCInformationManager__OnExit_G2 = 6697168;

		HookEngine (MEMINT_SwitchG1G2 (oCInformationManager__OnExit_G1, oCInformationManager__OnExit_G2), 6, "_hook_oCInformationManager_OnExit");

		//0x007594A0 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G1 = 7705760;

		//0x0068F620 protected: void __fastcall zCViewDialogChoice::HighlightSelected(void)
		const int zCViewDialogChoice__HighlightSelected_G2 = 6878752;

		HookEngine (MEMINT_SwitchG1G2 (zCViewDialogChoice__HighlightSelected_G1, zCViewDialogChoice__HighlightSelected_G2), 9, "_hook_zCViewDialogChoice_HighlightSelected");

		//TODO: investigate potential performance improvement - if we would sort all infos by both .npc and .nr then we could in theory improve performance (infos without npc would have to be at the beginning of the list)
		//0x006647E0 private: static int __cdecl oCInfoManager::CompareInfos(class oCInfo *,class oCInfo *)

		once = 1;
	};
};
