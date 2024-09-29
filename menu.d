/*
 *	Menu
 */

/*
 *	oCLogTopic functions
 */

/*
 *	Log_GetTopic
 *	 - returns topic pointer
 */
func int Log_GetTopic (var string topicName) {
	var zCList l;
	var int list; list = oCLogManager_Ptr;
	topicName = STR_Upper(topicName);

	while (list);
		l = _^ (list);

		if (l.data) {
			var oCLogTopic logTopic; logTopic = _^ (l.data);

			if (Hlp_StrCmp (logTopic.m_strDescription, topicName)) {
				return l.data;
			};
		};

		list = l.next;
	end;

	return 0;
};

/*
 *	Log_GetTopicStatus
 *	 - returns topic status
 */
func int Log_GetTopicStatus (var string topicName) {
	var int ptr; ptr = Log_GetTopic (topicName);
	if (!ptr) { return LOG_STATUS_INVALID; };

	var oCLogTopic logTopic; logTopic = _^ (ptr);
	return logTopic.m_enuStatus;
};

/*
 *	Log_GetTopicSection
 *	 - returns topic section
 */
func int Log_GetTopicSection (var string topicName) {
	var int ptr; ptr = Log_GetTopic (topicName);
	if (!ptr) { return LOG_SECTION_INVALID; };

	var oCLogTopic logTopic; logTopic = _^ (ptr);
	return logTopic.m_enuSection;
};

/*
 *	Log_GetNoOfEntries
 *	 - returns no of entries in the topic
 */
func int Log_GetNoOfEntries (var string topicName) {
	var int ptr; ptr = Log_GetTopic (topicName);
	if (!ptr) { return 0; };

	var oCLogTopic logTopic; logTopic = _^ (ptr);

	if (!logTopic.m_lstEntries_next) { return 0; };

	var zCList l;
	var int list; list = logTopic.m_lstEntries_next;

	var int count; count = 0;

	while (list);
		l = _^ (list);

		if (l.data) {
			count += 1;
		};

		list = l.next;
	end;

	return count;
};

/*
 *	Log_GetEntryByIndex
 *	 - returns enry by index
 */
func string Log_GetEntryByIndex (var string topicName, var int index) {
	var int ptr; ptr = Log_GetTopic (topicName);
	if (!ptr) { return STR_EMPTY; };

	var oCLogTopic logTopic; logTopic = _^ (ptr);

	if (!logTopic.m_lstEntries_next) { return STR_EMPTY; };

	var zCList l;
	var int list; list = logTopic.m_lstEntries_next;

	var int count; count = 0;

	while (list);
		l = _^ (list);

		if (l.data) {
			if (count == index) {
				var string entry; entry = MEM_ReadString (l.data);
				return entry;
			};
			count += 1;
		};

		list = l.next;
	end;

	return STR_EMPTY;
};

/*
 *	Log_GetNoOfTopics
 *	 - returns no of topics in specific section with specified status
 */
func int Log_GetNoOfTopics(var int logSection, var int logStatus) {
	var zCList l;
	var int list; list = oCLogManager_Ptr;

	var int count; count = 0;

	while (list);
		l = _^ (list);

		if (l.data) {
			var oCLogTopic logTopic; logTopic = _^ (l.data);

			if ((logTopic.m_enuSection == logSection) || (logSection == -1)) {
				if ((logTopic.m_enuStatus == logStatus) || (logStatus == -1)) {
					count += 1;
				};
			};
		};

		list = l.next;
	end;

	return count;
};

/*
 *	zCMenuItem functions
 */

/*
 *	zCMenuItem_GetByName
 *	 - same as MEM_GetMenuItemBystring ?
 */
func int zCMenuItem_GetByName (var string menuItemName) {
	//0x004D17A0 public: static class zCMenuItem * __cdecl zCMenuItem::GetByName(class zSTRING const &)
	const int zCMenuItem__GetByName_G1 = 5052320;

	//0x004DE5F0 public: static class zCMenuItem * __cdecl zCMenuItem::GetByName(class zSTRING const &)
	const int zCMenuItem__GetByName_G2 = 5105136;

	CALL_zStringPtrParam (menuItemName);
	CALL__cdecl (MEMINT_SwitchG1G2(zCMenuItem__GetByName_G1, zCMenuItem__GetByName_G2));

	return CALL_RetValAsPtr ();
};
