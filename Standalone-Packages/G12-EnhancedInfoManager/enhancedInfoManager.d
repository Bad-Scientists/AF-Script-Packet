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

const string InfoManagerIndicatorColorDefault = "";		//Default color for 'answer' and 'spinner' indicator - if empty it will be same as underlying dialog
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
								dlgChoice = MEM_PtrToInst (l.data);
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
		} else {
			InfoManagerChoiceDisabled = TRUE;
		};

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
	var zCViewDialogChoice dlg; dlg = _^ (MEM_InformationMan.DlgChoice);

	var int choiceView; choiceView = MEM_InformationMan.DlgChoice;
	
	if (!choiceView) { return; };

	var int i;
	var zCArray arr;

	var zCViewText2 txtIndicator;

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
	//Remove added 'Indicator' dialogs
	if (Hlp_StrCmp (MEM_InformationMan.LastMethod, "CollectInfos")) {
		//TODO: figure out better method
		if (InfoManagerAnswerIndicator) {
			//Is there an extra dialog ?
			if (dlg.m_listLines_numInArray > dlg.Choices) {
				arr = _^ (choiceView + 172);

				if (arr.array) {
					i = 0;
					while (i < dlg.m_listLines_numInArray);
						if (MEM_ReadIntArray (arr.array, i) == InfoManagerAnswerIndicator) {
							txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
							txtIndicator.remove = TRUE;
							break;
						};
						i += 1;
					end;
					
					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.remove = TRUE;
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
							txtIndicator.remove = TRUE;
							break;
						};
						i += 1;
					end;

					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.remove = TRUE;
				};
			};

			InfoManagerSpinnerIndicator = 0;
		};
	};

	var int InfoManagerIndicatorColor;

	if (dlg.IsActivated) {
		//Auto-scrolling for disabled dialog choices
		InfoManager_SkipDisabledDialogChoices (-1);

		if (InfoManagerUpdateState == cIM2BChanged)
		|| (InfoManagerLastChoiceSelected != dlg.ChoiceSelected) {
			//Reset by default, script will figure out whether Answer is possible below, when it updates all dialog descriptions
			InfoManagerAnswerPossible = FALSE;
			//Reset by default, script will figure out whether Spinning is poosible below, when it updates all dialog descriptions
			InfoManagerSpinnerPossible = FALSE;

			arr = _^ (choiceView + 172);
			if (arr.array) {
				var int nextPosY; nextPosY = 0;

				//loop counter for dialog options in zCViewDialogChoice
				i = 0;
				var int p;
				
				var string dlgFont;
				
				var zCViewText2 txt;
				p = MEM_StackPos.position;
				
				if (i < dlg.Choices) {
					txt = _^ (MEM_ReadIntArray(arr.array, i));
					
					//Get current fontame
					dlgFont = Print_GetFontName (txt.font);

					//Get current dialog instance
					var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
					var C_NPC her; her = _^ (MEM_InformationMan.player);
					
					var int infoPtr; infoPtr = 0;

					var oCInfo dlgInstance;
					
					const int cINFO_MGR_MODE_IMPORTANT	= 0;
					const int cINFO_MGR_MODE_INFO		= 1;
					const int cINFO_MGR_MODE_CHOICE		= 2;
					const int cINFO_MGR_MODE_TRADE		= 3;

					//'Standard' dialog options
					if (MEM_InformationMan.Mode == cINFO_MGR_MODE_INFO)
					{
						infoPtr = oCInfoManager_GetInfoUnimportant (slf, her, i);
					} else
					//Choices - have to be extracted from oCInfo.listChoices_next
					//MEM_InformationMan.Info is oCInfo pointer
					if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {
						infoPtr = MEM_InformationMan.Info;
					};

					if (infoPtr) {
						var int len;
						var int index;
						
						var string dlgDescription;
						
						//Default colors
						var string dlgColor; dlgColor = InfoManagerDefaultColorDialogGrey;
						var string dlgColorSelected; dlgColorSelected = InfoManagerDefaultDialogColorSelected;

						var string dlgFontSelected; dlgFontSelected = "";
						
						//Get description from dialogInstance.description
						dlgInstance = _^ (infoPtr);
						dlgDescription = dlgInstance.description;

						//Choices
						if (MEM_InformationMan.Mode == cINFO_MGR_MODE_CHOICE) {
							if (dlgInstance.listChoices_next) {
								//loop counter for all Choices
								var int j; j = 0;
								
								var oCInfoChoice dlgChoice;
								var int list; list = dlgInstance.listChoices_next;
								var zCList l;

								while (list);
									l = _^ (list);
									
									//if our dialog option is dialog choice - put text to dlgDescription
									if (l.data) {
										if (i == j) {
											dlgChoice = MEM_PtrToInst (l.data);
											dlgDescription = dlgChoice.Text;
										};
									};
									
									list = l.next;
									j += 1;
								end;
							};
						};
						
						/* Extract font, font selected, color and color selected from dlgDescription.
						   Clear dlgDescription in process. */

						var string s1;
						var string s2;

						//Disabled dialog choices
						var int disabledChoice; disabledChoice = -1;

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
						var int textWidth;

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

						var int answerDialog; answerDialog = -1;
						
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
							
							answerDialog = i;
							dlgDescription = ConcatStrings (s1, s2);
						};
						
						var int spinnerDialog; spinnerDialog = -1;
						var string spinnerDialogID; spinnerDialogID = "";

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
						
						//txtIndicator.posx = dlg.psizex - txt.posx - textWidth - dlg.offsetTextpx;
						//
						if (disabledChoice == i) {
							dlgColorSelected = InfoManagerDisabledDialogColorSelected;
							dlgColor = InfoManagerDisabledColorDialogGrey;
						};

						//Apply dlgColor and dlgColorSelected
						//Is current dialog choice selected one ?
						if (i == dlg.ChoiceSelected) {
							if (answerDialog == i) {
								InfoManagerAnswerPossible = TRUE;

								//Add answer indicator
								if (!InfoManagerAnswerMode) {
									if (!InfoManagerAnswerIndicator) {
										txt.useAlpha = TRUE;
										txt.alphaFunc = 1;
										txt.alpha = 255;

										//Create new zCViewText2 instance for our indicator
										InfoManagerAnswerIndicator = create (zCViewText2@);
										txtIndicator = _^ (InfoManagerAnswerIndicator);

										//Insert indicator to dialog choices
										MEM_ArrayInsert (choiceView + 172, InfoManagerAnswerIndicator); 

										txtIndicator.validcolor = txt.validcolor;

										txtIndicator.useAlpha = txt.useAlpha;
										txtIndicator.alphaFunc = txt.alphaFunc;
										txtIndicator.alpha = 128;
										
										txtIndicator.text = InfoManagerAnswerIndicatorString;
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
									txt.useAlpha = TRUE;
									txt.alphaFunc = 1;
									txt.alpha = InfoManagerIndicatorAlpha;

									//Create new zCViewText2 instance for our indicator
									InfoManagerSpinnerIndicator = create (zCViewText2@);
									txtIndicator = _^ (InfoManagerSpinnerIndicator);

									//Insert indicator to dialog choices
									MEM_ArrayInsert (choiceView + 172, InfoManagerSpinnerIndicator); 

									txtIndicator.validcolor = txt.validcolor;

									txtIndicator.useAlpha = txt.useAlpha;
									txtIndicator.alphaFunc = txt.alphaFunc;
									txtIndicator.alpha = 255; //128

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
							txt.posx = txt.posx + dlg.offsetTextpx;
						} else
						if (alignment == ALIGN_CENTER) {
							textWidth = Print_GetStringWidth (dlgDescription, dlgFont);
							txt.posx = (dlg.psizex / 2) - (textWidth / 2) - dlg.offsetTextpx - dlg.sizeMargin_0;
						} else
						if (alignment == ALIGN_RIGHT) {
							textWidth = Print_GetStringWidth (dlgDescription, dlgFont);
							txt.posx = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0;
						};
					};
				
					//Recalculate offsetTextpy and posY for dialog items in case fonts changed
					if (i == 0) {
						nextPosY = txt.posY;
						dlg.offsetTextpy = 0;
					} else {					
						txt.posY = nextPosY;
					};

					//---
					var int newFont; newFont = Print_GetFontPtr (dlgFont);

					//Adjust X, Y pos in case dialog with indicators is selected
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

								txtIndicator.posy = txt.posy;

								textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);
								txtIndicator.posx = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0;
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
								
								txtIndicator.posy = txt.posy;

								txtIndicator.text = InfoManagerSpinnerIndicatorString;

								textWidth = Print_GetStringWidth (txtIndicator.text, dlgFont);
								txtIndicator.posx = dlg.psizex - textWidth - dlg.offsetTextpx - dlg.sizeMargin_0;
							};
						};
					};
					
					//---

					if (i < dlg.LineStart) {
						dlg.offsetTextpy -= Print_GetFontHeight (dlgFont);
					};
					
					//Apply new font (or re-apply old one)
					txt.font = newFont;
					
					//
					nextPosY += Print_GetFontHeight (dlgFont);

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
			//Is there an extra dialog ?
			if (dlg.m_listLines_numInArray > dlg.Choices) {
				arr = _^ (choiceView + 172);

				if (arr.array) {
					i = 0;
					while (i < dlg.m_listLines_numInArray);
						if (MEM_ReadIntArray (arr.array, i) == InfoManagerAnswerIndicator) {
							txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
							txtIndicator.remove = TRUE;
							break;
						};
						i += 1;
					end;

					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.remove = TRUE;
				};
			};
			InfoManagerAnswerIndicator = 0;
		};
	};

	//Remove if not required
	if (!InfoManagerSpinnerPossible) {
		if (InfoManagerSpinnerIndicator) {
			//Is there an extra dialog ?
			if (dlg.m_listLines_numInArray > dlg.Choices) {
				arr = _^ (choiceView + 172);

				if (arr.array) {
					i = 0;
					while (i < dlg.m_listLines_numInArray);
						if (MEM_ReadIntArray (arr.array, i) == InfoManagerSpinnerIndicator) {
							txtIndicator = _^ (MEM_ReadIntArray (arr.array, i));
							txtIndicator.remove = TRUE;
							break;
						};
						i += 1;
					end;

					//txtIndicator = _^ (MEM_ReadIntArray (arr.array, dlg.m_listLines_numInArray - 1));
					//add remove flag - Gothic will take care of the rest
					//txtIndicator.remove = TRUE;
				};
			};

			InfoManagerSpinnerIndicator = 0;
		};
	};
};

func void G12_EnhancedInfoManager_Init () {
	const int once = 0;
	if (!once) {
		HookEngine (zCViewDialogChoice__HandleEvent, 9, "_hook_zCViewDialogChoice_HandleEvent_EnhancedInfoManager");
		HookEngine (oCInformationManager__Update, 5, "_hook_oCInformationManager_Update_EnhancedInfoManager");
		once = 1;
	};
};
