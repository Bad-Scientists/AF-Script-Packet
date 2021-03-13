/*
 *	Required LeGo initialization for frame functions in case you want to have Spinner indicator animated (InfoManagerSpinnerIndicatorAnimation)
 *		LeGo_Init (legoFlags | LeGo_FrameFunctions);
 *
 *	How to enable this feature:
 *
 *	func void Init_Global () {
 *		...
 *		InfoManagerNumKeys = TRUE;
 *		InfoManagerSpinnerIndicatorAnimation = TRUE;
 *		G12_EnhancedInfoManager_Init ();
 *	};
 *
 *
 */


/*
 *	Variables which you can adjust as you need
 */

//Default dialog colors
const string InfoManagerDefaultDialogColorSelected = "FFFFFF";	//G1 standard dialog - white color FFFFFF
const string InfoManagerDefaultColorDialogGrey = "C8C8C8";	//G1 standard dialog - grey color C8C8C8

const string InfoManagerDisabledDialogColorSelected = "808080";	//Disabled color - selected
const string InfoManagerDisabledColorDialogGrey = "808080";	//Disabled color - grey

//Default text alignment
const int InfoManagerDefaultDialogAlignment = ALIGN_LEFT;	//ALIGN_CENTER, ALIGN_LEFT, ALIGN_RIGHT defined in LeGo

const int InfoManagerSpinnerPageSize = 5;			//Page Up/Page Down
var int InfoManagerSpinnerValueMin;				//Home
var int InfoManagerSpinnerValueMax;				//End

const string InfoManagerIndicatorColorDefault = "C8C8C8";		//Default color for 'answer' and 'spinner' indicator - if empty it will be same as underlying dialog
const int InfoManagerIndicatorAlpha = 255;			//Default alpha value for 'answer' and 'spinner' indicator

const string InfoManagerSpinnerIndicatorString = "<-- -->";	//Default spinner indicator (non animated)
const string InfoManagerAnswerIndicatorString = "...";		//Default answer indicator

const int InfoManagerSpinnerIndicatorAnimation = 1;		//Set to TRUE if you want animated spinner. Animated spinners require LeGo_FrameFunctions intialization !
								//LeGo_Init (yourBits | LeGo_FrameFunctions);

//Dialog 'NumKey' controls [WIP]
const int InfoManagerNumKeysControls = 1;			//Set to TRUE if you want to enable num key support for dialogs
const int InfoManagerNumKeysNumbers = 0;			//Set to TRUE if you want to add dialog numbers next to each dialog (formatted in function InfoManagerNumKeyString)

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
var int InfoManagerListLines;

//Variables used for elimination of unnecessary code runnings
var int InfoManagerLastChoiceSelected;
var int InfoManagerUpdateState;
	const int cIM2BChanged	= 0;
	const int cIMChanged	= 1;

instance zCViewText2@ (zCViewText2);

var int InfoManagerSpinnerIndicator;
var int InfoManagerAnswerIndicator;

func void InfoManagerSpinnerAniFunction () {
	var int aniStep;

	aniStep += 1;
	if (aniStep > 11) {
		aniStep = 0;
	};

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

	//Remove if not required
	if (!InfoManagerSpinnerPossible) {
		FF_Remove (InfoManagerSpinnerAniFunction);
	};
};

//
func string InfoManagerNumKeyString (var int index) {
	if (index < 1) || (index > 9) { return ""; };

	var string s; s = "(";
	s = ConcatStrings (s, IntToString (index));
	s = ConcatStrings (s, ") ");

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

func string Choice_GetColor (var string s) {
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

func string Choice_RemoveColor (var string s) {
	var int len;
	var int index1;	//" "
	var int index2; //"@"

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
	index2 = STR_IndexOf (s2, "@");

	if (index2 < index1)
	&& (index1 > 0) {
		index1 = index2;
	};

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

func string Choice_GetColorSelected (var string s) {
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

func string Choice_RemoveColorSelected (var string s) {
	var int len;
	var int index1;	//" "
	var int index2; //"@"

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
	index2 = STR_IndexOf (s2, "@");

	if (index2 < index1)
	&& (index1 > 0) {
		index1 = index2;
	};

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

func string Choice_RemoveModifier (var string s, var string modifier) {
	var int len;
	var int index;

	var string s1; s1 = "";
	var string s2; s2 = "";
	
	len = STR_Len (s);
	index = STR_IndexOf (s, modifier);

	if (index == -1) {
		return s;
	};

	if (index > 0) {
		s1 = mySTR_SubStr (s, 0, index);
	};

	s2 = mySTR_SubStr (s, index + STR_Len (modifier), len - STR_Len (modifier));
	
	return ConcatStrings (s1, s2);
};

func string Choice_RemoveAnswer (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";
	var string s2; s2 = "";
	
	len = STR_Len (s);
	index = STR_IndexOf (s, "a@ ");

	if (index == -1) {
		return s;
	};

	if (index > 0) {
		s1 = mySTR_SubStr (s, 0, index);
	};

	s2 = mySTR_SubStr (s, index + 3, len - 3);
	
	return ConcatStrings (s1, s2);
};

func string Choice_RemoveDisabled (var string s) {
	var int len;
	var int index;

	var string s1; s1 = "";
	var string s2; s2 = "";
	
	len = STR_Len (s);
	index = STR_IndexOf (s, "d@ ");

	if (index == -1) {
		return s;
	};

	if (index > 0) {
		s1 = mySTR_SubStr (s, 0, index);
	};

	s2 = mySTR_SubStr (s, index + 3, len - 3);
	
	return ConcatStrings (s1, s2);
};

func string Choice_RemoveSpinner (var string s) {
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

func string Choice_RemoveModifiers (var string s) {
	//
	s = Choice_RemoveColor (s);
	s = Choice_RemoveColorSelected (s);
	s = Choice_RemoveAnswer (s);
	s = Choice_RemoveDisabled (s);
	s = Choice_RemoveSpinner (s);

	return s;
};


func string InfoManager_GetChoiceDescription (var int index) {
	if (!MEM_InformationMan.IsWaitingForSelection) { return ""; };

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
	InfoManagerUpdateState = cIM2BChanged;
	
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
			if (key == KEY_ESCAPE) {
				InfoManagerAnswerMode = FALSE;
				InfoManagerAnswer = "";
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
				InfoManagerRefreshOverlays = TRUE;
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
			if (InfoManagerSpinnerValue != lastSpinnerValue) {
				InfoManagerRefreshOverlays = TRUE;
			};
		} else
		{

//--- Num Keys control [WIP] -->

			if (InfoManagerNumKeysControls)
			{
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
		};

//--- Additional tweaks -->

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
	if (!MEM_InformationMan.DlgChoice) { return; };

	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;
	
	if (!choiceView) { return; };

	var int i;
	var int j;
	var zCArray arr;

	var zCViewText2 txt;
	var zCViewText2 txtIndicator;

	var int infoPtr;
	var oCInfo dlgInstance;

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
	//Disabled dialog choices
	var int disabledChoice;

	var int overlayCount;
	var int overlayPtr;
	
	var int thisID; thisID = 0;

	const int OVERLAY_MAX = 255;

	var int overlayID[OVERLAY_MAX];			//

	var int overlayListMapChoice[OVERLAY_MAX];	//
	var int overlayListMapView[OVERLAY_MAX];	//

	var int overlayListColor[OVERLAY_MAX];		//
	var int overlayListColorSelected[OVERLAY_MAX];	//

	//If number of lines in list changed at any point ... refresh all overlays
	if (InfoManagerListLines != dlg.m_listLines_numInArray) {
		InfoManagerRefreshOverlays = TRUE;
	};

	//Remove added 'Indicator' dialogs
	if (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectInfos"))
	|| (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectChoices"))
	|| (InfoManagerRefreshOverlays)
	{
		//TODO: figure out better method
		//TODO: this might not be required
		/*
		if (InfoManagerAnswerIndicator) {
			//Is there an extra dialog ?
			
			if (dlg.m_listLines_numInArray > dlg.Choices) {
				arr = _^ (choiceView + 172);

				if (arr.array) {
					i = 0;
					while (i < dlg.m_listLines_numInArray);
						if (MEM_ReadIntArray (arr.array, i) == InfoManagerAnswerIndicator) {
							txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
							txtIndicator.enabledTimer = TRUE;
							txtIndicator.timer = floatnull;
							break;
						};
						i += 1;
					end;
					
					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.enabledTimer = TRUE;
				};
			};

			InfoManagerAnswerIndicator = 0;
		};

		//Is there an extra dialog ?
		if (InfoManagerSpinnerIndicator) {
			if (dlg.m_listLines_numInArray > dlg.Choices) {
				arr = _^ (choiceView + 172);

				if (arr.array) {
					i = 0;
					while (i < dlg.m_listLines_numInArray);
						if (MEM_ReadIntArray (arr.array, i) == InfoManagerSpinnerIndicator) {
							txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
							txtIndicator.enabledTimer = TRUE;
							txtIndicator.timer = floatnull;
							break;
						};
						i += 1;
					end;

					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.enabledTimer = TRUE;
				};
			};

			InfoManagerSpinnerIndicator = 0;
		};
		*/
		
		InfoManagerAnswerIndicator = 0;
		InfoManagerSpinnerIndicator = 0;

		//
		overlayCount = 0;

		if (dlg.m_listLines_numInArray > dlg.Choices) {
			arr = _^ (choiceView + 172);

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

		InfoManagerRefreshOverlays = FALSE;
	};

	var int InfoManagerIndicatorColor;

	if (dlg.IsActivated)
	&& (dlg.m_listLines_numInArray) {
		//Auto-scrolling for disabled dialog choices
		InfoManager_SkipDisabledDialogChoices (-1);

		if (InfoManagerUpdateState == cIM2BChanged)
		|| (InfoManagerLastChoiceSelected != dlg.ChoiceSelected) {
			//Reset by default, script will figure out whether Answer is possible below, when it updates all dialog descriptions
			InfoManagerAnswerPossible = FALSE;
			//Reset by default, script will figure out whether Spinning is possible below, when it updates all dialog descriptions
			InfoManagerSpinnerPossible = FALSE;

			//Get current dialog instance
			var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
			var C_NPC her; her = _^ (MEM_InformationMan.player);

			arr = _^ (choiceView + 172);
			if (arr.array) {
				var int nextPosY; nextPosY = 0;

				//loop counter for dialog options in zCViewDialogChoice
				i = 0;
				var int p;
				
				var string dlgFont;
				
				p = MEM_StackPos.position;
				
				//if (i < dlg.Choices) {
				if (i < dlg.m_listLines_numInArray) {
					overlayPtr = 0;
					disabledChoice = -1;

					txt = _^ (MEM_ReadIntArray(arr.array, i));
					
					//Get current fontame
					dlgFont = Print_GetFontName (txt.font);

					infoPtr = 0;

					var int answerDialog; answerDialog = -1;
					var int spinnerDialog; spinnerDialog = -1;
					var string spinnerDialogID; spinnerDialogID = "";

					var string dlgDescription; dlgDescription = "";
					
					const int cINFO_MGR_MODE_IMPORTANT	= 0;
					const int cINFO_MGR_MODE_INFO		= 1;
					const int cINFO_MGR_MODE_CHOICE		= 2;
					const int cINFO_MGR_MODE_TRADE		= 3;

					//'Standard' dialog options
					if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO)
					{
						infoPtr = oCInfoManager_GetInfoUnimportant (slf, her, i);
						
						if (infoPtr) {
							//Get description from dialoginstance.description
							dlgInstance = _^ (infoPtr);
							dlgDescription = dlgInstance.description;
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
								j = 0;
								
								var oCInfoChoice dlgChoice;
								var int list; list = dlgInstance.listChoices_next;
								var zCList l;

								while (list);
									l = _^ (list);
									
									//if our dialog option is dialog choice - put text to dlgDescription
									if (l.data) {
										if (i == j) {
											dlgChoice = _^ (l.data);
											dlgDescription = dlgChoice.Text;
										};
									};
									
									list = l.next;
									j += 1;
								end;
							};
						};
					};

					if (infoPtr) {
						var int len;
						var int index;
						var int index2;
						var int index3;
						
						//Default colors
						var string dlgColor; dlgColor = InfoManagerDefaultColorDialogGrey;
						var string dlgColorSelected; dlgColorSelected = InfoManagerDefaultDialogColorSelected;

						var string dlgFontSelected; dlgFontSelected = "";
						
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
						
						var int overlayChoice;
						var zCViewText2 overlayChoiceTxt;
						
						var int overlayIndex;
						var int overlayPosX;
						var int overlayShiftX;
						var int overlayWidth;
						
						var int flagAdd;
						var int k;

						var int overlayAlignment;

						var int textWidth;
						var int defaultPosX;

						defaultPosX = dlg.sizeMargin_0[0];

						overlayWidth = 0;
						overlayIndex = 0;
						overlayDialog = "";
						
						overlayConcat = "";

						//Is this answer dialog ?
						index = (STR_IndexOf (dlgDescription, "a@"));

						if (index > -1) {
							answerDialog = i;

							if (i == dlg.ChoiceSelected) {
								if (answerDialog == i) {
									InfoManagerAnswerPossible = TRUE;
								};
							};
						};
						
						var int overlayLoop; overlayLoop = MEM_StackPos.position;
						
						//Mám dopis pro Velkého mága o@h@00CC66 hs@66FFB2:Kruhu~ ohně.
						//o@:Overlay test ~Proč jsi mi pomohl?
						//o@hs@FF8000@ar:[10/100]~Proč jsi mi pomohl?
						index = STR_IndexOf (dlgDescription, "o@");
						index2 = STR_IndexOf (dlgDescription, ":");
						index3 = STR_IndexOf (dlgDescription, "~");
						
						overlayFormat = "";
						overlayColor = -1;
						overlayColorSelected = -1;

						overlayAlignment = -1; //no alignment

						//Recalculate pos X
						overlayPosX = txt.posX;
						
						if (STR_Len (overlayConcat) > 0) {
							//
							overlayShiftX = STR_SplitCount (overlayConcat, " ");
							overlayPosX += Print_GetStringWidth (overlayConcat, dlgFont) - overlayShiftX + 1;
						};

						if ((index > -1) && (index2 > index) && (index3 > index2))
						{
							s1 = ""; s2 = ""; s3 = "";

							if (index > 0) {
								//'Mám dopis pro Velkého mága '
								//''
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};
							
							if (index > -1) {
								len = STR_Len (dlgDescription);
								//'1 h@00CC66 hs@66FFB2:Kruhu~ ohně.'
								//'2:Overlay test ~Proč jsi mi pomohl?'
								s2 = mySTR_SubStr (dlgDescription, index + 2, len - index - 2);
							};

							len = STR_Len (s2);
							index = STR_IndexOf (s2, "~");

							if (index > -1) {
								//'h@00CC66 hs@66FFB2:Kruhu'
								//'2:Overlay test '
								s3 = mySTR_Prefix (s2, index);

								//' ohně.'
								//'Proč jsi mi pomohl?'
								s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
							};

							len = STR_Len (s3);
							index = STR_IndexOf (s3, ":");

							if (index > -1) {
								//'h@00CC66 hs@66FFB2'
								//'2'
								overlayFormat = mySTR_Prefix (s3, index);
								//'Kruhu'
								//'Overlay test '
								overlayText = mySTR_SubStr (s3, index + 1, (len - index - 1));
							};

							//Default color
							overlayColor = HEX2RGBA (InfoManagerDefaultColorDialogGrey);
							overlayColorSelected = HEX2RGBA (InfoManagerDefaultDialogColorSelected);

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
							//<--

							//If dialog choice starts with overlay, then we have to treat this first overlay as a dialog choice
							if (STR_Len (s1) == 0)
							&& (overlayIndex == 0)
							&& (overlayAlignment == -1)
							{
								//'Overlay test '
								if (STR_Len (overlayFormat) > 0)
								{
									s1 = ConcatStrings (overlayFormat, " ");
									s1 = ConcatStrings (s1, overlayText);
									overlayFormat = "";
								} else {
									s1 = overlayText;
								};

								overlayConcat = ConcatStrings (overlayConcat, Choice_RemoveModifiers (s1));

								//'Proč jsi mi pomohl?'
								overlayText = s2; s2 = "";
							};

							if (overlayIndex == 0)
							{
								overlayDialog = s1;

								if (overlayAlignment == -1) {
									overlayConcat = Choice_RemoveModifiers (s1);
								};
								
								overlayShiftX = STR_SplitCount (overlayConcat, " ");
								overlayPosX += Print_GetStringWidth (overlayConcat, dlgFont) - overlayShiftX + 1;
							};

							//--> Extract overlay format modifiers
							index = STR_IndexOf (overlayFormat, "h@");

							if (index > -1) {
								overlayColor = HEX2RGBA (Choice_GetColor (overlayFormat));
								overlayFormat = Choice_RemoveColor (overlayFormat);
							};
							
							//Extract color selected
							index = STR_IndexOf (overlayFormat, "hs@");

							if (index > -1) {
								overlayColorSelected = HEX2RGBA (Choice_GetColorSelected (overlayFormat));
								overlayFormat = Choice_RemoveColorSelected (overlayFormat);
							};
							//<--

							thisID += 1;
							
							flagAdd = true;
							
							k = 0;
							while (k < overlayCount);
								if (MEM_ReadIntArray (_@ (overlayID), k) == thisID) {
									//Update overlay text and colors
									overlayChoice = MEM_ReadIntArray (_@ (overlayListMapView), k);

									if (overlayChoice < dlg.m_listLines_numInArray)
									{
										overlayChoiceTxt = _^ (MEM_ReadIntArray (arr.array, overlayChoice));

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
									
									//
									flagAdd = false;
									break;
								};
								
								k += 1;
							end;

							txt.enabledBlend = TRUE;
							txt.funcAlphaBlend = 1;
							txt.alpha = 255;
							
							if (InfoManagerAnswerMode)
							&& (answerDialog == i)
							{
								flagAdd = FALSE;
							};

							//Prevent overflow
							if (overlayCount >= OVERLAY_MAX) {
								flagAdd = FALSE;
							};

							if (flagAdd)
							{
								//Create new zCViewText2 instance for overlay
								overlayPtr = create (zCViewText2@);
								txtIndicator = _^ (overlayPtr);

								txtIndicator.enabledColor = txt.enabledColor;
								txtIndicator.font = txt.font;

								txtIndicator.enabledBlend = txt.enabledBlend;
								txtIndicator.funcAlphaBlend = txt.funcAlphaBlend;
								txtIndicator.alpha = 255;
								
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
								txtIndicator.timer = overlayCount;

								//Insert indicator to dialog choices
								MEM_ArrayInsert (choiceView + 172, overlayPtr); 

								MEM_WriteIntArray (_@ (overlayID), overlayCount, thisID);

								MEM_WriteIntArray (_@ (overlayListColor), overlayCount, overlayColor);
								MEM_WriteIntArray (_@ (overlayListColorSelected), overlayCount, overlayColorSelected);

								MEM_WriteIntArray (_@ (overlayListMapChoice), overlayCount, i);
								MEM_WriteIntArray (_@ (overlayListMapView), overlayCount, dlg.m_listLines_numInArray - 1);

								overlayCount += 1;
							};
							//};

							overlayIndex += 1;
							
							if (STR_Len (s2) > 0) {
								index = STR_IndexOf (s2, "o@");
								
								if (index == -1) {
									s2 = ConcatStrings ("o@:", s2);
									s2 = ConcatStrings (s2, "~");
								} else {
									if (index > 0) {
										len = STR_Len (s2);
										s1 = mySTR_Prefix (s2, index);
										s3 = mySTR_SubStr (s2, index, len - index);
										
										s2 = ConcatStrings ("o@:", s1);
										s2 = ConcatStrings (s2, "~");

										s2 = ConcatStrings (s2, s3);
									};
								};
							};
							
							dlgDescription = s2;

							if (overlayAlignment == -1) {
								overlayConcat = ConcatStrings (overlayConcat, overlayText);
							};

							MEM_StackPos.position = overlayLoop;
						};

						if (STR_Len (overlayDialog) > 0) {
							dlgDescription = overlayDialog;
						};

						//<-- Overlays
						
						index = (STR_IndexOf (dlgDescription, "d@ "));

						if (index > -1) {
							s1 = ""; s2 = "";

							len = STR_Len (dlgDescription);
							len -= 3;
							
							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							s2 = mySTR_SubStr (dlgDescription, index + 3, len);
							
							dlgDescription = ConcatStrings (s1, s2);

							disabledChoice = i;
							
							zCViewDialogChoice_RemoveChoice (_@ (txt));
						};

						//Extract font name
						index = (STR_IndexOf (dlgDescription, "f@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 2, len - 2);

							index = STR_IndexOf (s2, " ");
							len = STR_Len (s2);

							if (index == -1) {
								index = len;
							};

							dlgFont = mySTR_Prefix (s2, index);
							
							if (index == len) {
								s2 = "";
							} else {							
								s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
							};
							
							dlgDescription = ConcatStrings (s1, s2);
						};

						//Extract font selected name
						index = (STR_IndexOf (dlgDescription, "fs@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 3, len - 3);

							index = STR_IndexOf (s2, " ");
							len = STR_Len (s2);

							if (index == -1) {
								index = len;
							};

							dlgFontSelected = mySTR_Prefix (s2, index);
							
							if (index == len) {
								s2 = "";
							} else {							
								s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
							};
							
							dlgDescription = ConcatStrings (s1, s2);
						};

						//Extract color grayed
						index = (STR_IndexOf (dlgDescription, "h@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 2, len - 2);

							index = STR_IndexOf (s2, " ");
							len = STR_Len (s2);

							if (index == -1) {
								index = len;
							};

							dlgColor = mySTR_Prefix (s2, index);
							
							if (index == len) {
								s2 = "";
							} else {							
								s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
							};
							
							dlgDescription = ConcatStrings (s1, s2);
						};
						
						//Extract color selected
						index = (STR_IndexOf (dlgDescription, "hs@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 3, len - 3);

							index = STR_IndexOf (s2, " ");
							len = STR_Len (s2);

							if (index == -1) {
								index = len;
							};

							dlgColorSelected = mySTR_Prefix (s2, index);
							
							if (index == len) {
								s2 = "";
							} else {							
								s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
							};
							
							dlgDescription = ConcatStrings (s1, s2);
						};
						
						var int alignment; alignment = InfoManagerDefaultDialogAlignment;

						//al@ align left
						index = (STR_IndexOf (dlgDescription, "al@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 3, len - 3);

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
							
							alignment = ALIGN_LEFT;
							dlgDescription = ConcatStrings (s1, s2);
						};

						//ac@ align center
						index = (STR_IndexOf (dlgDescription, "ac@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 3, len - 3);

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
							
							alignment = ALIGN_CENTER;
							dlgDescription = ConcatStrings (s1, s2);
						};

						//ar@ align right
						index = (STR_IndexOf (dlgDescription, "ar@"));
						
						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 3, len - 3);

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
							
							alignment = ALIGN_RIGHT;
							dlgDescription = ConcatStrings (s1, s2);
						};

						//answer
						index = (STR_IndexOf (dlgDescription, "a@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 2, len - 2);

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
							
							dlgDescription = ConcatStrings (s1, s2);
						};
						
						//spinner s@
						index = (STR_IndexOf (dlgDescription, "s@"));

						if (index > -1) {
							s1 = ""; s2 = "";

							if (index > 0) {
								s1 = mySTR_SubStr (dlgDescription, 0, index);
							};

							len = STR_Len (dlgDescription);
							s2 = mySTR_SubStr (dlgDescription, index + 2, len - 2);

							index = STR_IndexOf (s2, " ");
							len = STR_Len (s2);

							if (index == -1) {
								index = len;
							};

							spinnerDialogID = mySTR_Prefix (s2, index);

							if (index == len) {
								s2 = "";
							} else {							
								s2 = mySTR_SubStr (s2, index + 1, (len - index - 1));
							};
							
							spinnerDialog = i;
							dlgDescription = ConcatStrings (s1, s2);
						};
						
						//txtIndicator.posX = dlg.psizex - txt.posX - textWidth - dlg.offsetTextpx;
						//
						if (disabledChoice == i) {
							dlgColorSelected = InfoManagerDisabledDialogColorSelected;
							dlgColor = InfoManagerDisabledColorDialogGrey;
						};

						//Apply dlgColor and dlgColorSelected
						//Is current dialog choice selected one ?
						if (i == dlg.ChoiceSelected) {
							//if (answerDialog == i) {
							//	InfoManagerAnswerPossible = TRUE;
							if (InfoManagerAnswerPossible) {

								//Add answer indicator
								if (!InfoManagerAnswerMode) {
									if (!InfoManagerAnswerIndicator) {
										txt.enabledBlend = TRUE;
										txt.funcAlphaBlend = 1;
										txt.alpha = 255;

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
								};
							};

							if (spinnerDialog == i) {
								InfoManagerSpinnerPossible = TRUE;
								InfoManagerSpinnerID = spinnerDialogID;
								
								//Dokazeme tu pridat novy 'dialog' s transparentnym textom '<>' ako overlay ???
								//Funguje !
								
								//Add spinner indicator
								if (!InfoManagerSpinnerIndicator) {
									txt.enabledBlend = TRUE;
									txt.funcAlphaBlend = 1;
									txt.alpha = 255;

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
									};
								};
							};

							if (STR_Len (dlgColorSelected) > 0) {
								txt.color = HEX2RGBA (dlgColorSelected);
							};
							
							if (STR_Len (dlgFontSelected) > 0) {
								dlgFont = dlgFontSelected;
							};

							//Can we go into answer mode? If yes replace description with current answer
							if (InfoManagerAnswerMode) {
								dlgDescription = ConcatStrings (InfoManagerAnswer, "_");
							};
						} else
						{
							if (STR_Len (dlgColor) > 0) {
								txt.color = HEX2RGBA (dlgColor);
							};
						};

						if (InfoManagerNumKeysNumbers) {
							dlgDescription = ConcatStrings (InfoManagerNumKeyString (i + 1), dlgDescription);
						};

						//Replace dialog option text with 'cleared' dlgDescription
						txt.text = dlgDescription;
						
						//
						if (alignment == ALIGN_LEFT) {
							txt.posX = defaultPosX;
						} else
						if (alignment == ALIGN_CENTER) {
							textWidth = Print_GetStringWidth (dlgDescription, dlgFont);
							txt.posX = (dlg.psizex / 2) - (textWidth / 2) - dlg.offsetTextpx - dlg.sizeMargin_0[0];
							
							if (txt.posX < defaultPosX) {
								txt.posX = defaultPosX;
							};
						} else
						if (alignment == ALIGN_RIGHT) {
							textWidth = Print_GetStringWidth (dlgDescription, dlgFont);
							txt.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];

							if (txt.posX < defaultPosX) {
								txt.posX = defaultPosX;
							};
						};
					};
				
					//Recalculate offsetTextpy and posY for dialog items in case fonts changed
					if (i < dlg.Choices) {
						if (i == 0) {
							nextPosY = txt.posY;
							dlg.offsetTextpy = 0;
						} else {					
							txt.posY = nextPosY;
						};
					};
					
					//MEM_WriteIntArray (_@ (listPosY), i, nextPosY);

					//---
					var int newFont; newFont = Print_GetFontPtr (dlgFont);

					//Adjust X, Y pos in case dialog with indicators is selected
					//if (i < dlg.Choices) {
					if (i == dlg.ChoiceSelected) {
						if (InfoManagerAnswerIndicator) {
							txtIndicator = _^ (InfoManagerAnswerIndicator);

							if (answerDialog == i) {
								txtIndicator.font = newFont;
								
								if (STR_Len (InfoManagerIndicatorColorDefault) == 0) {
									InfoManagerIndicatorColor = HEX2RGBA (dlgColor);
								} else {
									InfoManagerIndicatorColor = HEX2RGBA (InfoManagerIndicatorColorDefault);
								};
								
								txtIndicator.color = InfoManagerIndicatorColor;

								txtIndicator.posY = txt.posY;

								textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);
								txtIndicator.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];
							};
						};

						if (InfoManagerSpinnerIndicator) {
							txtIndicator = _^ (InfoManagerSpinnerIndicator);

							if (spinnerDialog == i) {
								txtIndicator.font = newFont;

								if (STR_Len (InfoManagerIndicatorColorDefault) == 0) {
									InfoManagerIndicatorColor = HEX2RGBA (dlgColor);
								} else {
									InfoManagerIndicatorColor = HEX2RGBA (InfoManagerIndicatorColorDefault);
								};
								
								txtIndicator.color = InfoManagerIndicatorColor;
								
								txtIndicator.posY = txt.posY;

								txtIndicator.text = InfoManagerSpinnerIndicatorString;

								textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);
								txtIndicator.posX = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0[0];
							};
						};
					};
					//};
					
					overlayPtr = 0;

					if (i >= dlg.Choices) {
						overlayPtr = MEM_ReadIntArray(arr.array, i);
					};

					//--> Overlay
					if (overlayPtr)
					&& (overlayPtr != InfoManagerAnswerIndicator)
					&& (overlayPtr != InfoManagerSpinnerIndicator)
					{
						txtIndicator = _^ (overlayPtr);
						overlayChoice = MEM_ReadIntArray (_@ (overlayListMapChoice), txtIndicator.timer);
						
						if (overlayChoice < dlg.m_listLines_numInArray) {
							var int color;

							//adjust posY
							overlayChoiceTxt = _^ (MEM_ReadIntArray(arr.array, overlayChoice));
							txtIndicator.posY = overlayChoiceTxt.posY;

							//Update color
							if (dlg.ChoiceSelected == overlayChoice) {
								color = MEM_ReadIntArray (_@(overlayListColorSelected), txtIndicator.timer);
								txtIndicator.color = color;

								//if (STR_Len (overlayColorSelected) > 0) {
								//	txtIndicator.color = HEX2RGBA (overlayColorSelected);
								//} else {
								//	txtIndicator.color = overlayChoiceTxt.color;										
								//};
							} else {
								color = MEM_ReadIntArray (_@(overlayListColor), txtIndicator.timer);
								txtIndicator.color = color;
								//if (STR_Len (overlayColor) > 0) {
								//	txtIndicator.color = HEX2RGBA (overlayColor);
								//} else {
								//	//Default color (underlaying
								//	txtIndicator.color = overlayChoiceTxt.color;										
								//};
							};
						};
					};
					//<-- Overlays

					if (i < dlg.Choices) {
						if (i < dlg.LineStart) {
							dlg.offsetTextpy -= Print_GetFontHeight (dlgFont);
						};
						
						//Apply new font (or re-apply old one)
						txt.font = newFont;
						
						//
						nextPosY += Print_GetFontHeight (dlgFont);
					};

					i += 1;
					MEM_StackPos.position = p;
				};
			} else {
				InfoManagerUpdateState = cIMChanged;
				InfoManagerLastChoiceSelected = dlg.ChoiceSelected;
			};
		};
	};
		/*
	} else
	{
		InfoManagerUpdateState = cIM2BChanged;
	};
	*/

	//Remove if not required (or if we are already answering)
	if (!InfoManagerAnswerPossible) || (InfoManagerAnswerMode) {
		if (InfoManagerAnswerIndicator) {
			InfoManagerRefreshOverlays = TRUE;

			/*
			//Is there an extra dialog ?
			if (dlg.m_listLines_numInArray > dlg.Choices) {
				arr = _^ (choiceView + 172);

				if (arr.array) {
					i = 0;
					while (i < dlg.m_listLines_numInArray);
						if (MEM_ReadIntArray (arr.array, i) == InfoManagerAnswerIndicator) {
							txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
							txtIndicator.enabledTimer = TRUE;
							txtIndicator.timer = floatnull;
							break;
						};
						i += 1;
					end;

					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.enabledTimer = TRUE;
				};
			};

			InfoManagerAnswerIndicator = 0;
			*/
		};
	};

	//Remove if not required
	if (!InfoManagerSpinnerPossible) {
		if (InfoManagerSpinnerIndicator) {
			InfoManagerRefreshOverlays = TRUE;
			
			/*
			//Is there an extra dialog ?
			if (dlg.m_listLines_numInArray > dlg.Choices) {
				arr = _^ (choiceView + 172);

				if (arr.array) {
					i = 0;
					while (i < dlg.m_listLines_numInArray);
						if (MEM_ReadIntArray (arr.array, i) == InfoManagerSpinnerIndicator) {
							txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
							txtIndicator.enabledTimer = TRUE;
							txtIndicator.timer = floatnull;
							break;
						};
						i += 1;
					end;

					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.enabledTimer = TRUE;
				};
			};

			InfoManagerSpinnerIndicator = 0;
			*/
		};
	};

	InfoManagerListLines = dlg.m_listLines_numInArray;
};

//Remove hidden@ choices
func void _hook_oCInformationManager_CollectChoices () {
	var int infoPtr;

	//We can't use first parameter - it is a lie !!! :)
	//infoPtr = MEM_ReadInt (ESP + 4);
	
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
