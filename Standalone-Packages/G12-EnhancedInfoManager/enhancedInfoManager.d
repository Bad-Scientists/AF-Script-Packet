/*
 *	Required LeGo initialization for frame functions in case you want to have Spinner indicator animated (InfoManagerSpinnerIndicatorAnimation)
 *		LeGo_Init (legoFlags | LeGo_FrameFunctions);
 *
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
 *	Modifiers:		Usage:						Explanation:
 *		f@		'f@font_15_white.tga TEST'			 - applies font_15_white.tga to greyed out dialog choice. Has to be separated by space.
 *		fs@		'fs@font_old_20_white.tga TEST'			 - applies font_old_20_white.tga to selected dialog choice. Has to be separated by space.
 *		h@		'h@00CC66 TEST'					 - applies color in hexcode to greyed out dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
 *		hs@		'hs@66FFB2 TEST'				 - applies color in hexcode to selected dialog choice. Has to be separated by space. Hex color format R G B A (alpha)
 *		a@		'a@TEST' 'a@ TEST'				 - enables answering mode. Does not have to be separated by space. (removes space after @ sign if there is any)
 *		s@		's@spinnerID TEST'				 - enables spinner mode. Has to be separated by space. Requires unique spinnerID after @ sign.
 *		d@		'd@'						 - disables dialog choice. Player will not be able to select such dialog choice. Does not have to be separated by space.
 *		al@		'al@'						 - aligns text to left. Does not have to be separated by space.
 *		ac@		'ac@'						 - aligns text to center. Does not have to be separated by space.
 *		ar@		'ar@'						 - aligns text to right. Does not have to be separated by space.
 *		o@		'o@format:TEST~'				 - adds text in between : ~ as an overlay with its own format (unique color or alignment). Don't use with fonts changing text height - this is not supported yet.
 *				'o@h@00CC66 hs@66FFB2:TEST~'
 *				'o@ar@ h@00CC66 hs@66FFB2:TEST~'
 *
 *		hidden@		'hidden@'					 - removes dialog choice from dialog box.
 *
 *	---> DEV NOTES <---
 *	Notes for us: keep in mind that some modifiers do have same naming: spinner 's@', color selected 'hs@', font selected 'fs@' --> that's why we have to work with modifiers in specific order.
 *	First take care of 'hs@', 'fs@' then 's@' !!!
 */

/*
 *	Variables which you can adjust as you need
 */

//Default dialog colors
const string InfoManagerDefaultDialogColorSelected = "FFFFFF";		//G1 standard dialog - white color FFFFFF
const string InfoManagerDefaultColorDialogGrey = "C8C8C8";		//G1 standard dialog - grey color C8C8C8

const string InfoManagerDefaultFontDialogSelected = "";			//Default font for selected dialog choice (if blank default Gothic version will be used)
const string InfoManagerDefaultFontDialogGrey = "";			//Default font for greyed (if blank default Gothic version will be used)

const string InfoManagerDisabledDialogColorSelected = "808080";		//Disabled color - selected
const string InfoManagerDisabledColorDialogGrey = "808080";		//Disabled color - grey

//Default text alignment
const int InfoManagerDefaultDialogAlignment = ALIGN_LEFT;		//ALIGN_CENTER, ALIGN_LEFT, ALIGN_RIGHT defined in LeGo

const int InfoManagerSpinnerPageSize = 5;				//Page Up/Page Down
var int InfoManagerSpinnerValueMin;					//Home
var int InfoManagerSpinnerValueMax;					//End

const string InfoManagerIndicatorColorDefault = "C8C8C8";		//Default color for 'answer' and 'spinner' indicator - if empty it will be same as underlying dialog
const int InfoManagerIndicatorAlpha = 255;				//Default alpha value for 'answer' and 'spinner' indicator

const string InfoManagerSpinnerIndicatorString = "<-- -->";		//Default spinner indicator (non animated)
const string InfoManagerAnswerIndicatorString = "...";			//Default answer indicator

const int InfoManagerSpinnerIndicatorAnimation = 1;			//Set to TRUE if you want animated spinner. Animated spinners require LeGo_FrameFunctions intialization !
									//LeGo_Init (yourBits | LeGo_FrameFunctions);

//Dialog 'NumKey' controls [WIP]
const int InfoManagerNumKeysControls = 1;				//Set to TRUE if you want to enable num key support for dialogs
const int InfoManagerNumKeysNumbers = 0;				//Set to TRUE if you want to add dialog numbers next to each dialog (formatted in function InfoManagerNumKeyString)

const int InfoManagerAlphaBlendFunc = ALPHA_FUNC_ADD;			//ALPHA_FUNC_NONE

const int cIM_RememberSelectedChoice_None	= 0;			//Does nothing (default vanilla behaviour)
const int cIM_RememberSelectedChoice_All	= 1;			//Moves cursor to last selected choice
const int cIM_RememberSelectedChoice_Spinners	= 2;			//Moves cursor to last selected choice only when used with spinners

const int InfoManagerRememberSelectedChoice = cIM_RememberSelectedChoice_Spinners;

/*
 *	Internal variables
 */

//Dialog 'Answering system'
var int InfoManagerAnswerPossible;
var int InfoManagerAnswerMode;
var string InfoManagerAnswer;

//Dialog 'Spiner system'
var int InfoManagerSpinnerPossible;
var int InfoManagerSpinnerValue;
var string InfoManagerSpinnerID;

var int InfoManagerChoiceDisabled;

var int InfoManagerRefreshOverlays;
const int cIM_RefreshNothing			= 0;
const int cIM_RefreshOverlays			= 1;
const int cIM_RefreshDialogColors		= 2;

//Variables used for elimination of unnecessary code runnings
var int InfoManagerLastChoiceSelected;
var int InfoManagerModeInfoLastChoiceSelected;

const int cIM_UpdateState_2BChanged	= 0;
const int cIM_UpdateState_Changed	= 1;

var int InfoManagerUpdateState;

instance zCViewText2@ (zCViewText2);

var int InfoManagerSpinnerIndicator;
var int InfoManagerAnswerIndicator;

//Split into it's own function to refresh content of InfoManagerSpinnerIndicatorString
func void InfoManagerSpinnerAnimate (var int animate) {
	var int aniStep;

	if (aniStep < 0) { aniStep = 0; };
	if (aniStep > 11) { aniStep = 0; };

	if (aniStep == 0) {
		InfoManagerSpinnerIndicatorString = "   <- ->   ";
	} else
	if (aniStep == 1) {
		InfoManagerSpinnerIndicatorString = "  <-  ->   ";
	} else
	if (aniStep == 2) {
		InfoManagerSpinnerIndicatorString = " <-   ->   ";
	} else
	if (aniStep == 3) {
		InfoManagerSpinnerIndicatorString = "<-    ->   ";
	} else
	if (aniStep == 4) {
		InfoManagerSpinnerIndicatorString = " <-   ->   ";
	} else
	if (aniStep == 5) {
		InfoManagerSpinnerIndicatorString = "  <-  ->   ";
	} else
	if (aniStep == 6) {
		InfoManagerSpinnerIndicatorString = "   <- ->   ";
	} else
	if (aniStep == 7) {
		InfoManagerSpinnerIndicatorString = "   <-  ->  ";
	} else
	if (aniStep == 8) {
		InfoManagerSpinnerIndicatorString = "   <-   -> ";
	} else
	if (aniStep == 9) {
		InfoManagerSpinnerIndicatorString = "   <-    ->";
	} else
	if (aniStep == 10) {
		InfoManagerSpinnerIndicatorString = "   <-   -> ";
	} else
	if (aniStep == 11) {
		InfoManagerSpinnerIndicatorString = "   <-  ->  ";
	} else
	if (aniStep == 12) {
		InfoManagerSpinnerIndicatorString = "   <- ->   ";
	};

	if (animate) { aniStep += 1; };
};

func void InfoManagerSpinnerAniFunction () {
	InfoManagerSpinnerAnimate (TRUE);

	//Remove if not required
	if (!InfoManagerSpinnerPossible) {
		FF_Remove (InfoManagerSpinnerAniFunction);
	} else {
		//Animate
		var zCViewText2 txtIndicator;
		if (InfoManagerSpinnerIndicator) {
			txtIndicator = _^ (InfoManagerSpinnerIndicator);
			txtIndicator.text = InfoManagerSpinnerIndicatorString;
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
	var int index1;	//" "

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
	var int index1;	//" "

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
	var int index1;	//" "

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
	var int index1;	//" "

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
	
	var string spinnerID;

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
	index2 = STR_IndexOf (s, ":");
	index3 = STR_IndexOf (s, "~");

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
	index2 = STR_IndexOf (s, ":");
	index3 = STR_IndexOf (s, "~");

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

func string Choice_RemoveAllModifiers (var string s) {
	var int lastLen; lastLen = -1;
	var int index; index = STR_IndexOf (s, "o@");
	var int len;

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

	//
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

	return s;
};

func string Choice_GetCleanText (var string s) {

//--- Remove overlays (will keep only text from 'inline' overlays)

	var int index; index = STR_IndexOf (s, "o@");
	var int index2; index2 = STR_IndexOf (s, ":");
	var int index3; index3 = STR_IndexOf (s, "~");

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
		index2; index2 = STR_IndexOf (s, ":");
		index3; index3 = STR_IndexOf (s, "~");

		if ((index > -1) && (index2 > index) && (index3 > index2)) {
		} else {
			break;
		};

		lastLen = len;
		loop += 1;
	end;

//--- Remove all other modifiers

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

	return s;
};

func string InfoManager_GetChoiceDescription (var int index) {
//	if (!MEM_InformationMan.IsWaitingForSelection) { return ""; };

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;
	
	if (!choiceView) { return ""; };

	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;

	var zCArray arr; arr = _^ (choiceView + 172);

	if (arr.array) {
		var int infoPtr;
		var oCInfo dlgInstance;

		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO)
		{
			var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
			var C_NPC her; her = _^ (MEM_InformationMan.player);

			infoPtr = oCInfoManager_GetInfoUnimportant (slf, her, index);

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

				if (dlgInstance.listChoices_next) {
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
	};
	
	return "";
};

func void InfoManager_SelectLastChoice () {
	var zCViewDialogChoice dlg;
	if (!MEM_InformationMan.DlgChoice) { return; };
	dlg = _^ (MEM_InformationMan.DlgChoice);
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
	
	if (key == KEY_UPARROW)
	//2057 - Wheel up
	|| (key == 2057)
	{
		nextChoiceIndex -= 1;
		
		if (nextChoiceIndex < 0) {
			nextChoiceIndex = dlg.Choices - 1;
		};
	};

	if (key == KEY_DOWNARROW)
	//2058 - Wheel down
	|| (key == 2058)
	{
		nextChoiceIndex += 1;
		
		if (nextChoiceIndex >= dlg.Choices) {
			nextChoiceIndex = 0;
		};
	};

	s = InfoManager_GetChoiceDescription (nextChoiceIndex);
	
	InfoManagerChoiceDisabled = FALSE;

	if (Choice_IsDisabled (s)) {
		//Auto-scrolling
		if (key == -1) {
			key = KEY_DOWNARROW;
			zCViewDialogChoice_SelectNext ();
			MEM_StackPos.position = loop;
		};
		
		InfoManagerChoiceDisabled = TRUE;

		//Prevent infinite loops
		if (nextChoiceIndex != lastChoiceIndex) {
			if (key == KEY_UPARROW) {
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
	
	var int cancel; cancel = FALSE;
	var int update; update = FALSE;

	var int key; key = MEM_ReadInt (ESP + 4);

	//Cancel mouse input in event handler
	//2050 - Left Mouse button
	//2052 - Right Mouse button
	//2057 - Wheel up
	//2058 - Wheel down

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

	//Cancel selection of dialog by KEY_TAB (causing auto-selection in combination with Alt + Tab)
	if (key == KEY_TAB) {
		cancel = TRUE;
	};

	//Work with input only in case InfoManager is waiting for an input
	if (MEM_InformationMan.IsWaitingForSelection) {

//--- Answers -->

		//InfoManagerAnswerPossible is set by _hook_oCInformationManager_Update_EnhancedInfoManager
		if (InfoManagerAnswerPossible) {

			//Cancel answer mode
			if (InfoManagerAnswerMode) {
				if (key == KEY_ESCAPE) {
					InfoManagerRefreshOverlays = cIM_RefreshOverlays;
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
				InfoManagerRefreshOverlays = cIM_RefreshOverlays;
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
					var int len;
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
					const int mem = 0;
					if (!mem) { mem = MEM_Alloc(1); };
					
					MEM_WriteByte (mem, 34);
					
					s = STR_FromChar (mem);
				} else { s = "'"; }; };

				if (key == KEY_GRAVE) { if (shift) { s = "~"; } else { s = "`"; }; };

//				if (key == KEY_BACKSLASH) { if (shift) { s = "|"; } else { s = "\"; }; };

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

				cancel = TRUE; //Cancel input
			};
		} else

//--- Spinner -->

		if (InfoManagerSpinnerPossible)
		{
			var int lastSpinnerValue; lastSpinnerValue = InfoManagerSpinnerValue;

			//Default value if not set
			if (InfoManagerSpinnerPageSize == 0) { InfoManagerSpinnerPageSize = 1; };

			//Home
			if (key == KEY_HOME) {
				InfoManagerSpinnerValue = InfoManagerSpinnerValueMin;
				cancel = TRUE;
			};

			//End
			if (key == KEY_END) {
				InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
				cancel = TRUE;
			};
			
			//Page Up
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
					InfoManagerSpinnerValue -= InfoManagerSpinnerPageSize;
				};
				
				cancel = TRUE;
			};

			//Page Down
			if (key == KEY_NEXT) {
				//1 --> 5 --> 10 --> 12 --> 1
				if (InfoManagerSpinnerValue < InfoManagerSpinnerValueMax) {
					InfoManagerSpinnerValue = (InfoManagerSpinnerValue / InfoManagerSpinnerPageSize) * InfoManagerSpinnerPageSize;
					InfoManagerSpinnerValue += InfoManagerSpinnerPageSize;

					if (InfoManagerSpinnerValue > InfoManagerSpinnerValueMax) {
						InfoManagerSpinnerValue = InfoManagerSpinnerValueMax;
					};
				} else {
					InfoManagerSpinnerValue += InfoManagerSpinnerPageSize;
				};

				cancel = TRUE;
			};
			
			if (key == KEY_LEFTARROW) || (key == KEY_A) {
				InfoManagerSpinnerValue -= 1;
				cancel = TRUE;
			};

			if (key == KEY_RIGHTARROW) || (key == KEY_D) {
				InfoManagerSpinnerValue += 1;
				cancel = TRUE; //Cancel input (just in case)
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
			if (InfoManagerNumKeysControls) {
				//Override Num Keys 
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

			//We have to refresh dialog colors
			InfoManagerRefreshOverlays = cIM_RefreshDialogColors;
		};

//--- Additional tweaks -->

		//Cancel KEY_GRAVE changes fight mode to fist mode, this caused some issues ... we will use it for a better purpose - move cursor to last dialog choice
		if (key == KEY_GRAVE) {
			InfoManager_SelectLastChoice ();
			InfoManager_SkipDisabledDialogChoices (-1);
			cancel = TRUE;
		};

		if (key == KEY_RETURN) {
			//Skip disabled dialog choices
			InfoManager_SkipDisabledDialogChoices (-1);
		};

		//G2A tweak - dialog confirmation with SPACE
		if (!InfoManagerAnswerPossible) {
			if (key == KEY_SPACE) { key = KEY_RETURN; update = TRUE; };
		};

		//Skip disabled dialog choices
		if (key == KEY_UPARROW)
		|| (key == KEY_DOWNARROW)
		//2057 - Wheel up
		|| (key == 2057)
		//2058 - Wheel down
		|| (key == 2058)
		{
			InfoManager_SkipDisabledDialogChoices (key);
		};
	};

	//Cancel input if InfoManager is waiting for anything
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
};

func void _hook_oCInformationManager_Update_EnhancedInfoManager ()
{
	if (MEM_InformationMan.IsDone) { return; };

	if (!MEM_InformationMan.DlgChoice) { return; };

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;
	
	if (!choiceView) { return; };

	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);

	if (!dlg.m_listLines_numInArray) { return; };

	var int i;
	var int j;
	var int loop;

	var zCArray arr;

	var zCViewText2 txt;
	var zCViewText2 txtIndicator;

	var int infoPtr;
	var int choicePtr;
	var oCInfo dlgInstance;

	const int cINFO_MGR_MODE_IMPORTANT	= 0;
	const int cINFO_MGR_MODE_INFO		= 1;
	const int cINFO_MGR_MODE_CHOICE		= 2;
	const int cINFO_MGR_MODE_TRADE		= 3;
	
/*
MEM_InformationMan.LastMethod:
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
	
	const int dialogChoiceType_Answer	= 1;
	const int dialogChoiceType_Spinner	= 2;
	const int dialogChoiceType_Disabled	= 4;
	const int dialogChoiceType_AlignLeft	= 8;
	const int dialogChoiceType_AlignCenter	= 16;
	const int dialogChoiceType_AlignRight	= 32;

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

	var string dlgColor; dlgColor = InfoManagerDefaultColorDialogGrey;
	var string dlgColorSelected; dlgColorSelected = InfoManagerDefaultDialogColorSelected;

	var int alignment; alignment = InfoManagerDefaultDialogAlignment;
	
	arr = _^ (choiceView + 172);

	if (InfoManagerRefreshOverlays == cIM_RefreshDialogColors) {
		InfoManagerRefreshOverlays = cIM_RefreshNothing;
		refreshOverlayColors = TRUE;
	};

	if (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectInfos"))
	|| (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectChoices"))
	|| (InfoManagerRefreshOverlays == cIM_RefreshOverlays)
	{
		InfoManagerAnswerIndicator = 0;
		InfoManagerSpinnerIndicator = 0;

		//
		overlayCount = 0;

		//Flag all overlays for deletion
		if (dlg.m_listLines_numInArray > dlg.Choices) {
			//arr = _^ (choiceView + 172);

			if (arr.array) {
				i = dlg.Choices;
				while (i < dlg.m_listLines_numInArray);
					txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
					txtIndicator.enabledTimer = TRUE;
					txtIndicator.timer = floatnull;
					i += 1;
				end;
			};
		};

		dialogCachedCount = 0;
		InfoManagerRefreshOverlays = cIM_RefreshNothing;
		refreshOverlays = TRUE;
		refreshOverlayColors = TRUE;

		//Reset
		MEM_WriteIntArray (_@ (overlayListMapChoice), 0, -1);
		MEM_WriteIntArray (_@ (overlayListMapView), 0, 0);
		MEM_WriteStringArray (_@s (overlayID), 0, "");

		if (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectInfos"))
		|| (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectChoices"))
		{
			if (InfoManagerRememberSelectedChoice == cIM_RememberSelectedChoice_All)
			|| ((InfoManagerRememberSelectedChoice == cIM_RememberSelectedChoice_Spinners) && (InfoManagerSpinnerPossible))
			{
				if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO) {
					if (InfoManagerModeInfoLastChoiceSelected != dlg.ChoiceSelected) {
						if (InfoManagerModeInfoLastChoiceSelected < dlg.choices) {
							//Restore previous cursor position
							dlg.ChoiceSelected = InfoManagerModeInfoLastChoiceSelected;
							//Force auto-scrolling update
							InfoManagerLastChoiceSelected = -1;
						};
					};
				};
			};
		};
	};

	if (InfoManagerLastChoiceSelected != dlg.ChoiceSelected) {
		//Auto-scrolling for disabled dialog choices
		InfoManager_SkipDisabledDialogChoices (-1);
	};

	//if (dlg.IsActivated)
	if (dlg.m_listLines_numInArray)
	&& (arr.array)
	{
		var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
		var C_NPC her; her = _^ (MEM_InformationMan.player);

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

		while (i < loop);

			//Recalculate Y pos
			txt = _^ (MEM_ReadIntArray (arr.array, i));
			
			dlgFont = Print_GetFontName (txt.font);

			//Get current fontame
			if (STR_Len (InfoManagerDefaultFontDialogGrey)) {
				dlgFont = InfoManagerDefaultFontDialogGrey;
			} else {
				dlgFont = Print_GetFontName (txt.font);
			};

			if (STR_Len (InfoManagerDefaultFontDialogSelected)) {
				dlgFontSelected = InfoManagerDefaultFontDialogSelected;
			} else {
				dlgFontSelected = dlgFont;
			};

			dlgDescription = "";
			descriptionAvailable = FALSE;

			infoPtr = 0;
			choicePtr = 0;
			properties = 0;

			if (i < dialogCachedCount) {
				oldDescription = MEM_ReadStringArray (_@s (dialogCachedDescriptions), i);
			} else {
				oldDescription = "";
			};

			if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO) {
				infoPtr = oCInfoManager_GetInfoUnimportant (slf, her, i);

				if (infoPtr) {
					dlgInstance = _^ (infoPtr);
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
					
					infoPtr = 0;

					if (dlgInstance.listChoices_next) {

						var oCInfoChoice dlgChoice;
						var int list; list = dlgInstance.listChoices_next;
						var zCList l;

						j = 0;
						while (list);
							l = _^ (list);
							
							//if our dialog option is dialog choice - put text to dlgDescription
							if (l.data) {
								if (i == j) {
									choicePtr = l.data;
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
			};

			//if (i >= dlg.LineStart)
			//&& (txt.posy + dlg.offsetTextpy - dlg.sizeMargin_0[1] <= dlg.psizey)
			//{
			//Store in cache
			if (descriptionAvailable)
			{
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
			
			
				//if (i < dlg.m_listLines_numInArray) {

				//	if (i < dlg.Choices) {

				//Default values
				dlgColor = InfoManagerDefaultColorDialogGrey;
				color = HEX2RGBA (dlgColor);

				dlgColorSelected = InfoManagerDefaultDialogColorSelected;
				colorSelected = HEX2RGBA (dlgColorSelected);

				alignment = InfoManagerDefaultDialogAlignment;

				if (infoPtr)
				|| (choicePtr)
				{
					var int len;
					var int index;
					var int index2;
					var int index3;

					/* Extract font, font selected, color and color selected from dlgDescription.
					   Clear dlgDescription in process. */

					var string s1; s1 = "";
					var string s2; s2 = "";
					var string s3; s3 = "";
					
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
					
					var int flagDialogChoiceStartsWithOverlay; flagDialogChoiceStartsWithOverlay = FALSE;
					var int flagAdd;
					var int k;

					var int overlayAlignment;

					var int textWidth;
					var int defaultPosX;

					defaultPosX = dlg.sizeMargin_0[0];

					overlayWidth = 0;
					overlayIndex = 0;
					overlayDialog = "";
					
					if (InfoManagerNumKeysNumbers) {
						dlgDescription = ConcatStrings (InfoManagerNumKeyString (i + 1), dlgDescription);
					};

					var string dlgDescriptionClean; dlgDescriptionClean = Choice_GetCleanText (dlgDescription);

					overlayConcat = "";

					//Is this answer dialog ?
					index = (STR_IndexOf (dlgDescription, "a@"));

					if (index > -1) {
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "a@");
						properties = properties | dialogChoiceType_Answer;
					};

					//Is this disabled dialog ?
					index = (STR_IndexOf (dlgDescription, "d@"));

					if (index > -1) {
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "d@");
						properties = properties | dialogChoiceType_Disabled;
					};

					//var int originalPosX; originalPosX = txt.posX;
					
					thisID = IntToString (i);
					
					var int overlayLoop; overlayLoop = MEM_StackPos.position;
					
					//o@ h@FF8000 :(1) ~Dobrá, co bych měl vědět o o@hs@FF8000:tomhle~ místě?
					//o@:Dobrá, co bych měl vědět o ~o@hs@FF8000:tomhle~ místě?
					index = STR_IndexOf (dlgDescription, "o@");
					index2 = STR_IndexOf (dlgDescription, ":");
					index3 = STR_IndexOf (dlgDescription, "~");
					
					overlayFormat = "";
					overlayColor = -1;
					overlayColorSelected = -1;

					overlayAlignment = -1; //no alignment
					
					//Recalculate pos X
					//overlayPosX = originalPosX;
					if (alignment == ALIGN_LEFT) {
						txt.posX = defaultPosX;
					} else
					if (alignment == ALIGN_CENTER) {
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.posX = (dlg.psizex / 2) - (textWidth / 2) - dlg.offsetTextpx - dlg.sizeMargin_0[0];
						
						if (txt.posX < defaultPosX) {
							txt.posX = defaultPosX;
						};
					} else
					if (alignment == ALIGN_RIGHT) {
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];

						if (txt.posX < defaultPosX) {
							txt.posX = defaultPosX;
						};
					};

					overlayPosX = txt.posX;
					
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
							dlgColor = InfoManagerDisabledColorDialogGrey;
							dlgColorSelected = InfoManagerDisabledDialogColorSelected;

							overlayColor = HEX2RGBA (InfoManagerDisabledDialogColorSelected);
							overlayColorSelected = HEX2RGBA (InfoManagerDisabledColorDialogGrey);
						} else {
							overlayColor = HEX2RGBA (InfoManagerDefaultColorDialogGrey);
							overlayColorSelected = HEX2RGBA (InfoManagerDefaultDialogColorSelected);
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
						
						flagAdd = true;
						
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

								//if (overlayChoice < dlg.m_listLines_numInArray)
								if (overlayChoice)
								{
									//overlayChoiceTxt = _^ (MEM_ReadIntArray (arr.array, overlayChoice));
									overlayChoiceTxt = _^ (overlayChoice);

									overlayChoiceTxt.text = overlayText;

									//In line with text
									
									if (overlayAlignment == -1) {
										overlayChoiceTxt.posX = overlayPosX;
									} else
									//align left
									if (overlayAlignment == ALIGN_LEFT) {
										overlayChoiceTxt.posX = defaultPosX;
									} else
									//align center
									if (overlayAlignment == ALIGN_CENTER) {
										textWidth = Print_GetStringWidth (overlayText, dlgFont);
										overlayChoiceTxt.posX = (dlg.psizex / 2) - (textWidth / 2) - dlg.offsetTextpx - dlg.sizeMargin_0[0];
										
										if (overlayChoiceTxt.posX < defaultPosX) {
											overlayChoiceTxt.posX = defaultPosX;
										};
									} else
									//align right
									if (overlayAlignment == ALIGN_RIGHT) {
										textWidth = Print_GetStringWidth (overlayText, dlgFont);
										overlayChoiceTxt.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];

										if (overlayChoiceTxt.posX < defaultPosX) {
											overlayChoiceTxt.posX = defaultPosX;
										};
									};
								};
								
								flagAdd = false;
								break;
							};
							
							k += 1;
						end;

						txt.enabledBlend = TRUE;
						txt.funcAlphaBlend = InfoManagerAlphaBlendFunc;
						
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
								txtIndicator.posX = overlayPosX;
							} else
							//align left
							if (overlayAlignment == ALIGN_LEFT) {
								txtIndicator.posX = defaultPosX;
							} else
							//align center
							if (overlayAlignment == ALIGN_CENTER) {
								textWidth = Print_GetStringWidth (overlayText, dlgFont);
								txtIndicator.posX = (dlg.psizex / 2) - (textWidth / 2) - dlg.offsetTextpx - dlg.sizeMargin_0[0];
								
								if (txtIndicator.posX < defaultPosX) {
									txtIndicator.posX = defaultPosX;
								};
							} else
							//align right
							if (overlayAlignment == ALIGN_RIGHT) {
								textWidth = Print_GetStringWidth (overlayText, dlgFont);
								txtIndicator.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];

								if (txtIndicator.posX < defaultPosX) {
									txtIndicator.posX = defaultPosX;
								};
							};

							//We will exploit this variable a little bit
							txtIndicator.timer = nextAvailableOverlayIndex;
							txtIndicator.enabledTimer = FALSE;

							//Insert indicator to dialog choices
							MEM_ArrayInsert (choiceView + 172, overlayPtr);

							//MEM_WriteIntArray (_@ (overlayID), nextAvailableOverlayIndex, thisID);
							MEM_WriteStringArray (_@s (overlayID), nextAvailableOverlayIndex, thisID);

							MEM_WriteIntArray (_@ (overlayListColor), nextAvailableOverlayIndex, overlayColor);
							MEM_WriteIntArray (_@ (overlayListColorSelected), nextAvailableOverlayIndex, overlayColorSelected);

							MEM_WriteIntArray (_@ (overlayListMapChoice), nextAvailableOverlayIndex, i);
							//MEM_WriteIntArray (_@ (overlayListMapView), nextAvailableOverlayIndex, dlg.m_listLines_numInArray - 1);
							MEM_WriteIntArray (_@ (overlayListMapView), nextAvailableOverlayIndex, overlayPtr);

							//-->
							txtIndicator.posY = txt.posY;

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
						dlgColor = InfoManagerDisabledColorDialogGrey;
						dlgColorSelected = InfoManagerDisabledDialogColorSelected;
					};
					
					//Extract font name
					index = (STR_IndexOf (dlgDescription, "f@"));

					if (index > -1) {
						dlgFont = Choice_GetModifierFont (dlgDescription);
						dlgDescription = Choice_RemoveModifierFont (dlgDescription);
					};

					//Extract font selected name
					index = (STR_IndexOf (dlgDescription, "fs@"));

					if (index > -1) {
						dlgFontSelected = Choice_GetModifierFontSelected (dlgDescription);
						dlgDescription = Choice_RemoveModifierFontSelected (dlgDescription);
					};

					//Extract color grayed
					index = (STR_IndexOf (dlgDescription, "h@"));

					if (index > -1) {
						dlgColor = Choice_GetModifierColor (dlgDescription);
						dlgDescription = Choice_RemoveModifierColor (dlgDescription);
					};
					
					//Extract color selected
					index = (STR_IndexOf (dlgDescription, "hs@"));

					if (index > -1) {
						dlgColorSelected = Choice_GetModifierColorSelected (dlgDescription);
						dlgDescription = Choice_RemoveModifierColorSelected (dlgDescription);
					};
					
					//al@ align left
					index = (STR_IndexOf (dlgDescription, "al@"));

					if (index > -1) {
						alignment = ALIGN_LEFT;
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "al@");
					};

					//ac@ align center
					index = (STR_IndexOf (dlgDescription, "ac@"));

					if (index > -1) {
						alignment = ALIGN_CENTER;
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "ac@");
					};

					//ar@ align right
					index = (STR_IndexOf (dlgDescription, "ar@"));
					
					if (index > -1) {
						alignment = ALIGN_RIGHT;
						dlgDescription = Choice_RemoveModifierByText (dlgDescription, "ar@");
					};

					//spinner s@
					index = (STR_IndexOf (dlgDescription, "s@"));

					if (index > -1) {
						properties = properties | dialogChoiceType_Spinner;
						spinnerID = Choice_GetModifierSpinnerID (dlgDescription);
						MEM_WriteStringArray (_@s (dialogSpinnerID), i, spinnerID);
						dlgDescription = Choice_RemoveModifierSpinner (dlgDescription);
					};
					
					//txtIndicator.posX = dlg.psizex - txt.posX - textWidth - dlg.offsetTextpx;
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
						txt.posX = defaultPosX;
					} else
					if (alignment == ALIGN_CENTER) {
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.posX = (dlg.psizex / 2) - (textWidth / 2) - dlg.offsetTextpx - dlg.sizeMargin_0[0];
						
						if (txt.posX < defaultPosX) {
							txt.posX = defaultPosX;
						};
					} else
					if (alignment == ALIGN_RIGHT) {
						textWidth = Print_GetStringWidth (dlgDescriptionClean, dlgFont);
						txt.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];

						if (txt.posX < defaultPosX) {
							txt.posX = defaultPosX;
						};
					};
				};
				//	};
				//};

				if (alignment == ALIGN_LEFT) {
					properties = properties | dialogChoiceType_AlignLeft;
				} else
				if (alignment == ALIGN_CENTER) {
					properties = properties | dialogChoiceType_AlignCenter;
				} else
				if (alignment == ALIGN_RIGHT) {
					properties = properties | dialogChoiceType_AlignRight;
				};

				MEM_WriteIntArray (_@ (dialogProperties), i, properties);
				MEM_WriteIntArray (_@ (dialogColor), i, color);
				MEM_WriteIntArray (_@ (dialogColorSelected), i, colorSelected);

				InfoManagerUpdateState = cIM_UpdateState_Changed;
			};
			//};

			//Recalculate offsetTextpy and posY for dialog items in case fonts changed
			if (i < dlg.Choices) {
				if (i == 0) {
					nextPosY = txt.posY;
					dlg.offsetTextpy = 0;
				} else {					
					txt.posY = nextPosY;
				};

				if (i < dlg.LineStart) {
					dlg.offsetTextpy -= Print_GetFontHeight (dlgFont);
				};
				
				//Apply new font (or re-apply old one)
				txt.font = Print_GetFontPtr (dlgFont);
				
				//
				nextPosY += Print_GetFontHeight (dlgFont);
			};

			i += 1;
		end;

		if (InfoManagerLastChoiceSelected != dlg.ChoiceSelected)
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
				m = ConcatStrings ("posy ", IntToString (txt.posy));

				m = ConcatStrings (m, " offsetTextpy ");
				m = ConcatStrings (m, IntToString (dlg.offsetTextpy));

				m = ConcatStrings (m, " psizey ");
				m = ConcatStrings (m, IntToString (dlg.psizey));
				
				MEM_Info (m);
*/
				//Small optimization - recolor only visible dialog choices
				if (txt.posy + dlg.offsetTextpy - dlg.sizeMargin_0[1] > dlg.psizey) {
					break;
				};
				
				if (i == dlg.ChoiceSelected) {
					colorSelected = MEM_ReadIntArray (_@ (dialogColorSelected), i);
					txt.color = colorSelected;
					txt.alpha = GetAlpha (colorSelected);
				} else {
					color = MEM_ReadIntArray (_@ (dialogColor), i);
					txt.color = color;
					txt.alpha = GetAlpha (color);
				};
				
				i += 1;
			end;			

			//--> Update overlay colors
			i = 0;

			while (i < overlayCount);

				overlayPtr = MEM_ReadIntArray (_@ (overlayListMapView), i);

				if (overlayPtr) {
					txtIndicator = _^ (overlayPtr);
					overlayChoice = MEM_ReadIntArray (_@ (overlayListMapChoice), txtIndicator.timer);
					
					if (overlayChoice < dlg.m_listLines_numInArray) {
						//adjust posY
						overlayChoiceTxt = _^ (MEM_ReadIntArray(arr.array, overlayChoice));
						txtIndicator.posY = overlayChoiceTxt.posY;

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
			
			//Special properties
			if (dlg.ChoiceSelected > -1)
			&& (dlg.ChoiceSelected < dlg.choices)
			&& (dlg.ChoiceSelected < DIALOG_MAX) {
				properties = (MEM_ReadIntArray (_@ (dialogProperties), dlg.ChoiceSelected));
				
				alignment = InfoManagerDefaultDialogAlignment;
				
				if (properties & dialogChoiceType_AlignLeft) {
					alignment = ALIGN_LEFT;
				} else
				if (properties & dialogChoiceType_AlignCenter) {
					alignment = ALIGN_CENTER;
				} else
				if (properties & dialogChoiceType_AlignRight) {
					alignment = ALIGN_RIGHT;
				};

				InfoManagerSpinnerPossible = properties & dialogChoiceType_Spinner;

				if (InfoManagerSpinnerPossible) {
					//Get spinner ID
					InfoManagerSpinnerID = MEM_ReadStringArray (_@s (dialogSpinnerID), dlg.ChoiceSelected);
					
					//Dokazeme tu pridat novy 'dialog' s transparentnym textom '<>' ako overlay ???
					//Funguje !
					
					txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));

					//Add spinner indicator if it does not exist anymore
					if (!InfoManagerSpinnerIndicator) {

						txt.enabledBlend = TRUE;
						txt.funcAlphaBlend = InfoManagerAlphaBlendFunc;

						//Create new zCViewText2 instance for our indicator
						InfoManagerSpinnerIndicator = create (zCViewText2@);
						txtIndicator = _^ (InfoManagerSpinnerIndicator);

						txtIndicator.enabledColor = txt.enabledColor;
						txtIndicator.font = txt.font;
						txtIndicator.posY = txt.posY;

						txtIndicator.enabledBlend = txt.enabledBlend;
						txtIndicator.funcAlphaBlend = txt.funcAlphaBlend;
						txtIndicator.alpha = InfoManagerIndicatorAlpha;

						//Insert indicator to dialog choices
						MEM_ArrayInsert (choiceView + 172, InfoManagerSpinnerIndicator); 

						if (InfoManagerSpinnerIndicatorAnimation) {
							FF_ApplyOnceExtGT (InfoManagerSpinnerAniFunction, 80, -1);
							InfoManagerSpinnerAnimate (FALSE);
						};
					};

					//
					txtIndicator = _^ (InfoManagerSpinnerIndicator);

					txtIndicator.text = InfoManagerSpinnerIndicatorString;
					txtIndicator.font = txt.font;

					if (STR_Len (InfoManagerIndicatorColorDefault)) {
						color = HEX2RGBA (InfoManagerIndicatorColorDefault);
						txtIndicator.color = color;
						txtIndicator.alpha = GetAlpha (color);
					} else {
						txtIndicator.color = txt.color;
						txtIndicator.alpha = txt.alpha;
					};
					
					txtIndicator.posY = txt.posY;

					dlgFont = Print_GetFontName (txt.font);
					textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);
					
					if (alignment == ALIGN_LEFT) || (alignment == ALIGN_CENTER) {
						txtIndicator.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];
					};
				};

				InfoManagerAnswerPossible = properties & dialogChoiceType_Answer;

				if (InfoManagerAnswerPossible) {

					txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));

					//Add answer indicator
					if (!InfoManagerAnswerMode) {
						if (!InfoManagerAnswerIndicator) {
							txt.enabledBlend = TRUE;
							txt.funcAlphaBlend = InfoManagerAlphaBlendFunc;

							//Create new zCViewText2 instance for our indicator
							InfoManagerAnswerIndicator = create (zCViewText2@);
							txtIndicator = _^ (InfoManagerAnswerIndicator);

							txtIndicator.enabledColor = txt.enabledColor;
							txtIndicator.font = txt.font;
							txtIndicator.posY = txt.posY;

							txtIndicator.enabledBlend = txt.enabledBlend;
							txtIndicator.funcAlphaBlend = txt.funcAlphaBlend;
							txtIndicator.alpha = InfoManagerIndicatorAlpha;
							
							txtIndicator.text = InfoManagerAnswerIndicatorString;

							//Insert indicator to dialog choices
							MEM_ArrayInsert (choiceView + 172, InfoManagerAnswerIndicator); 
						};

						txtIndicator = _^ (InfoManagerAnswerIndicator);
						txtIndicator.font = txt.font;

						if (STR_Len (InfoManagerIndicatorColorDefault)) {
							color = HEX2RGBA (InfoManagerIndicatorColorDefault);
							txtIndicator.color = color;
							txtIndicator.alpha = GetAlpha (color);
						} else {
							txtIndicator.color = txt.color;
							txtIndicator.alpha = txt.alpha;
						};						

						txtIndicator.posY = txt.posY;

						dlgFont = Print_GetFontName (txt.font);
						textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);
						
						if (alignment == ALIGN_LEFT) || (alignment == ALIGN_CENTER) {
							txtIndicator.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];
						};
					};
				};

				//Remove if not required (or if we are already answering)
				if (!InfoManagerAnswerPossible) || (InfoManagerAnswerMode) {
					if (InfoManagerAnswerIndicator) {
						InfoManagerRefreshOverlays = cIM_RefreshOverlays;
					};
				};

				//Remove if not required
				if (!InfoManagerSpinnerPossible) {
					if (InfoManagerSpinnerIndicator) {
						InfoManagerRefreshOverlays = cIM_RefreshOverlays;
					};
				};
			};
		};

		if (InfoManagerAnswerPossible)
		&& (InfoManagerAnswerMode) {
			//Replace description with current answer
			txt = _^ (MEM_ReadIntArray (arr.array, dlg.ChoiceSelected));
			dlgDescription = ConcatStrings (InfoManagerAnswer, "_");
			txt.text = dlgDescription;
		};

		InfoManagerLastChoiceSelected = dlg.ChoiceSelected;

		refreshOverlays = FALSE;

		if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO) {
			InfoManagerModeInfoLastChoiceSelected = dlg.ChoiceSelected;
		};
	};
};

//Remove hidden@ choices
func void _hook_oCInformationManager_CollectChoices () {
	var int infoPtr;

	//We can't use first parameter - it is a lie !!! :)
	//infoPtr = MEM_ReadInt (ESP + 4);
	InfoManagerLastChoiceSelected = -1;
	
	infoPtr = MEM_InformationMan.Info;

	if (!infoPtr) { return; };
	
	var oCInfo dlgInstance;
	dlgInstance = _^ (infoPtr);

	var int i; i = 0;

	if (dlgInstance.listChoices_next) {
		
		var oCInfoChoice dlgChoice;
		var int list; list = dlgInstance.listChoices_next;
		var zCList l;
		var zCList p;
		var zCList n;

		while (list);
			l = _^ (list);
			
			if (l.data) {
				dlgChoice = _^ (l.data);

				if (Choice_IsHidden (dlgChoice.Text)) {
					//Get next item
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
					list = dlgInstance.listChoices_next;
					continue;
				};
			};

			//remember previous
			p = _^ (list);

			list = l.next;
			i += 1;
		end;
	};
};

//Remove hidden@ dialogues
func void _hook_oCInformationManager_CollectInfos () {

	var oCNPC slf; slf = _^ (MEM_InformationMan.npc);
	var int slfInstance; slfInstance = Hlp_GetInstanceID (slf);

	var C_NPC selfBackup; selfBackup = Hlp_GetNPC (self);
	var C_NPC otherBackup; otherBackup = Hlp_GetNPC (other);

	self = _^ (MEM_InformationMan.npc);
	other = _^ (MEM_InformationMan.player);
	
	var oCInfo dlgInstance;
	var zCListSort list;

	var int infoPtr; infoPtr = MEM_InfoMan.infoList_next;

	InfoManagerLastChoiceSelected = -1;

	while (infoPtr);
		list = _^ (infoPtr);
		dlgInstance = _^ (list.data);
		if (dlgInstance.npc == slfInstance) {

			//Here we have to re-evaluate dialogue conditions.
			//Because we can have a situation where condition function updates description
			//and dialogues will no longer be hidden.

			var int retVal;
			MEM_CallByID (dlgInstance.conditions);
			retVal = MEMINT_PopInt();

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
		};

		infoPtr = list.next;
	end;

	self = Hlp_GetNPC (selfBackup);
	other = Hlp_GetNPC (otherBackup);
};

func void G12_EnhancedInfoManager_Init () {
	const int once = 0;
	if (!once) {
		HookEngine (zCViewDialogChoice__HandleEvent, 9, "_hook_zCViewDialogChoice_HandleEvent_EnhancedInfoManager");
		HookEngine (oCInformationManager__Update, 5, "_hook_oCInformationManager_Update_EnhancedInfoManager");

		HookEngine (oCInformationManager__CollectChoices, 5, "_hook_oCInformationManager_CollectChoices");
		HookEngine (oCInformationManager__CollectInfos, 7, "_hook_oCInformationManager_CollectInfos");

		once = 1;
	};
};
