/*
 *	Super simple feature that adds number of topics to specific topic section in MENU_LOG
 *	Idea: Neocromicon
 */

var int refreshTopicSectionCount;

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
	//Prevent redundant counting of topics - it's enough to get number updated whenever menu is opened
	var int countRunning;
	var int countSuccess;
	var int countFailed;
	var int countNotes;
	var int countAchievements;

	if (refreshTopicSectionCount) {
		countRunning = Log_GetNoOfTopics (LOG_MISSION, LOG_RUNNING);
		countSuccess = Log_GetNoOfTopics (LOG_MISSION, LOG_SUCCESS);
		countFailed = Log_GetNoOfTopics (LOG_MISSION, LOG_FAILED);
		countNotes = Log_GetNoOfTopics (LOG_NOTE, -1);
		countAchievements = Log_GetNoOfTopics (LOG_ACHIEVEMENT, -1);

		refreshTopicSectionCount = FALSE;
	};

	Log_AddSectionCount ("MENU_ITEM_SEL_MISSIONS_ACT", countRunning);
	Log_AddSectionCount ("MENU_ITEM_SEL_MISSIONS_OLD", countSuccess);
	Log_AddSectionCount ("MENU_ITEM_SEL_MISSIONS_FAILED", countFailed);
	Log_AddSectionCount ("MENU_ITEM_SEL_LOG", countNotes);
	Log_AddSectionCount ("MENU_ITEM_SEL_ACHIEVEMENTS", countAchievements);
};

//-- Hooks - adding/removing frame function

func void _hook_zCMenu_Leave__LogMenuAddSectionCount () {
	if (!ECX) { return; };
	var zCMenu menu; menu = _^ (ECX);

	if (Hlp_StrCmp (menu.name, "MENU_LOG")) {
		FF_Remove (FF_LogMenuAddSectionCount);
	};
};

func void _hook_zCMenu_Enter__LogMenuAddSectionCount () {
	if (!ECX) { return; };
	var zCMenu menu; menu = _^ (ECX);

	if (Hlp_StrCmp (menu.name, "MENU_LOG")) {
		refreshTopicSectionCount = TRUE;
		FF_ApplyOnceExt (FF_LogMenuAddSectionCount, 0, -1);
	};
};

//-- Init

func void G12_MenuLogAddSectionCount_Init () {
	const int once = 0;

	if (!once) {
		//0x004CEB90 public: virtual void __thiscall zCMenu::Enter(void)
		const int zCMenu__Enter_G1 = 5041040;

		//0x004DB780 public: virtual void __thiscall zCMenu::Enter(void)
		const int zCMenu__Enter_G2 = 5093248;

		//G1 7 G2 NoTR 6
		HookEngine (MEMINT_SwitchG1G2 (zCMenu__Enter_G1, zCMenu__Enter_G2), MEMINT_SwitchG1G2 (7, 6), "_hook_zCMenu_Enter__LogMenuAddSectionCount");

		//0x004CEBF0 public: virtual void __thiscall zCMenu::Leave(void)
		const int zCMenu__Leave_G1 = 5041136;

		//0x004DB910 public: virtual void __thiscall zCMenu::Leave(void)
		const int zCMenu__Leave_G2 = 5093648;

		HookEngine (MEMINT_SwitchG1G2 (zCMenu__Leave_G1, zCMenu__Leave_G2), 9, "_hook_zCMenu_Leave__LogMenuAddSectionCount");
		once = 1;
	};
};
