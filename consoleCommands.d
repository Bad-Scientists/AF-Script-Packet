/*
 *	Modified version of LeGo CC_Active function, checks existence of both function and commandPrefix
 */
func int CC_Exists(var func function, var string commandPrefix) {
	if (!_CC_List) {
		return FALSE;
	};

	var int symID; symID = MEM_GetFuncID(function);

	commandPrefix = STR_Upper (commandPrefix);

	// Iterate over all registered CCs
	var zCArray a; a = _^(_CC_List);
	repeat(i, a.numInArray); var int i;
		var CCItem cc; cc = _^(MEM_ReadIntArray(a.array, i));
		if ((cc.fncID == symID) && (Hlp_StrCmp (cc.cmd, commandPrefix))) {
			return TRUE;
		};
	end;

	return FALSE;
};

/*
 *	Modified version of LeGo CC_Register function - allows multiple entries for same function (because of autocompletion :) )
 */
func void CC_RegisterMulti(var func function, var string commandPrefix, var string description) {
	//If function was already registered ... then we cannot use LeGo version - as it does not allow multiple console commands for same function :-/
	if (CC_Active(function)) {
		//Allow only unique entries
		if (CC_Exists (function, commandPrefix)) {
			return;
		};

		commandPrefix = STR_Upper (commandPrefix);

		CC_AutoComplete (commandPrefix, description);

		var int symID; symID = MEM_GetFuncID(function);

		// Create CC object
		var int ccPtr; ccPtr = create(CCItem@);
		var CCItem cc; cc = _^(ccPtr);
		cc.fncID = symID;
		cc.cmd = commandPrefix;

		// Add CC to 'list'
		MEM_ArrayInsert(_CC_List, ccPtr);
		return;
	};

	CC_Register (function, commandPrefix, description);
};

/*
 *	Function returns auto-completed command from CC_List
 */
func string CC_GetAutoCompletedQuery (var string query) {
	if (!_CC_List) { return query; };

	// Iterate over all registered CCs
	var zCArray a; a = _^(_CC_List);
	repeat(i, a.numInArray); var int i;
		var CCItem cc; cc = _^(MEM_ReadIntArray(a.array, i));
		if (STR_StartsWith (cc.cmd, query)) {
			return cc.cmd;
		};
	end;

	return query;
};
