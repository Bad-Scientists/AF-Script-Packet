/*
 *	Super simple feature that adds number of topics to specific topic section in MENU_LOG
 *	Credits: idea came from: Neocromicon
 */

var int _refreshTopicSectionCount;
var string _refreshTopicSectionSetup;

func void Log_AddSectionCount (var string logMenuSectionName, var int count) {
	var string s;

	var int menuItemPtr;
	var zCMenuItemText menuItemText;

	//0x007D2E04 const zCMenuItemText::`vftable'{for `zCViewBase'}
	//menuItemPtr = MEM_GetMenuItemBystring (logMenuSectionName);
	menuItemPtr = zCMenuItem_GetByName (logMenuSectionName);

	if (!menuItemPtr) { return; };

	menuItemText = _^ (menuItemPtr);

	if (menuItemText._zCMenuItem_m_pInnerWindow) {
		s = ConcatStrings (menuItemText._zCMenuItem_m_parText, " (");
		s = ConcatStrings (s, IntToString (count));
		s = ConcatStrings (s, ")");

		s = STR_ReplaceAll (s, "\n", Print_LineSeperator);

		//Updating _zCMenuItem_m_listLines_array did not have any effect.
		//zCMenuItemText_SetText (menuItemPtr, s);

		//Also updating _zCMenuItem_m_parText didn't help.
		//menuItemText._zCMenuItem_m_parText = s;

		//The only way I found was by updating view

		//Seems like engine text lines are inserted from the bottom to the top from last one to first one ? (weird)
		//"Current\nMissions"; will be inserted to the view like this:
		//textLines_next[1] 'Current'
		//textLines_next[0] 'Missions'

		//Remove all text lines
		ViewPtr_DeleteText_Safe (menuItemText._zCMenuItem_m_pInnerWindow);

		//Update view (will insert new lines if it needs to)
		ViewPtr_SetTextMarginAndFontColor (menuItemText._zCMenuItem_m_pInnerWindow, s, -1, 0);
	};
};

//-- Frame function

func void FF_LogMenuAddSectionCount () {
	//MENU_ITEM_SEL_MISSIONS_ACT LOG_MISSION LOG_RUNNING|MENU_ITEM_SEL_MISSIONS_OLD LOG_MISSION LOG_SUCCESS
	var int sectionCount; sectionCount = STR_SplitCount (_refreshTopicSectionSetup, STR_PIPE);

	repeat (i, sectionCount); var int i;

		var string sectionSetup; sectionSetup = STR_Split (_refreshTopicSectionSetup, STR_PIPE, i);
		var int sectionOptionCount; sectionOptionCount = STR_SplitCount (sectionSetup, STR_SPACE);

		var string s;

		var string logMenuSectionName; logMenuSectionName = STR_EMPTY;

		var int logSection; logSection = -1;
		var int logStatus; logStatus = -1;

		if (sectionOptionCount > 0) {
			logMenuSectionName = STR_Split (sectionSetup, STR_SPACE, 0);
		};

		if (sectionOptionCount > 1) {
			s = STR_Split (sectionSetup, STR_SPACE, 1);
			if (!Hlp_StrCmp (s, "-1")) {
				logSection = API_GetSymbolIntValue (s, -1);
			};
		};

		if (sectionOptionCount > 2) {
			s = STR_Split (sectionSetup, STR_SPACE, 2);
			if (!Hlp_StrCmp (s, "-1")) {
				logStatus = API_GetSymbolIntValue (s, -1);
			};
		};

		//func int Log_GetNoOfTopics(var int logSection, var int logStatus) {
		var int countTopics; countTopics = Log_GetNoOfTopics (logSection, logStatus);
		Log_AddSectionCount (logMenuSectionName, countTopics);
	end;
};

//-- Hooks - adding/removing frame function

func void _event_MenuLeave__MenuLogAddSectionCount (var int eventType) {
	if (!ECX) { return; };
	var zCMenu menu; menu = _^ (ECX);

	if (Hlp_StrCmp (menu.name, "MENU_LOG")) {
		FF_Remove (FF_LogMenuAddSectionCount);
	};
};

func void _event_MenuEnter__MenuLogAddSectionCount (var int eventType) {
	if (!ECX) { return; };
	var zCMenu menu; menu = _^ (ECX);

	if (Hlp_StrCmp (menu.name, "MENU_LOG")) {
		_refreshTopicSectionCount = TRUE;
		FF_ApplyOnceExt (FF_LogMenuAddSectionCount, 0, -1);
	};
};

//-- Init

func void G12_MenuLogAddSectionCount_Init () {
	//-- Load API values / init default values
	_refreshTopicSectionSetup = API_GetSymbolStringValue ("MENUADDSECTIONCOUNT_SETUP", "MENU_ITEM_SEL_MISSIONS_ACT LOG_MISSION LOG_RUNNING|MENU_ITEM_SEL_MISSIONS_OLD LOG_MISSION LOG_SUCCESS|MENU_ITEM_SEL_MISSIONS_FAILED LOG_MISSION LOG_FAILED|MENU_ITEM_SEL_LOG LOG_NOTE -1");

	G12_MenuEvent_Init();

	MenuEnterEvent_AddListener(_event_MenuEnter__MenuLogAddSectionCount);
	MenuLeaveEvent_AddListener(_event_MenuLeave__MenuLogAddSectionCount);
};
