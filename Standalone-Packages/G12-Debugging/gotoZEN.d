/*
 *	Simple debugging feature that allows you to switch between ZEN worlds from console.
 */
func string CC_GotoZEN (var string param) {
	param = STR_TrimChar (param, CHR_SPACE);
	param = STR_Upper (param);

	var int count; count = STR_SplitCount (param, STR_SPACE);
	var string levelName; levelName = STR_EMPTY;
	var string vobName; vobName = STR_EMPTY;

	//Get first parameter
	if (count > 0) {
		levelName = STR_Split (param, STR_SPACE, 0);
		levelName = STR_TrimChar (levelName, CHR_SPACE);
		levelName = STR_Upper (levelName);

		//Get second parameter
		if (count > 1) {
			vobName = STR_Split (param, STR_SPACE, 1);
			vobName = STR_TrimChar (vobName, CHR_SPACE);
			vobName = STR_Upper (vobName);
		} else {
			//If second parameter was not supplied ... figure it out :)
			param = "GOTO ZEN ";
			param = ConcatStrings (param, levelName);

			vobName = CC_GetAutoCompletedQuery (param);

			if (STR_Len (vobName)) {
				var int cmdLen; cmdLen = STR_Len (param);
				var int qryLen; qryLen = STR_Len (vobName);

				vobName = STR_SubStr( vobName, cmdLen, qryLen - cmdLen);
				vobName = STR_TrimChar (vobName, CHR_SPACE);
				vobName = STR_Upper (vobName);
			};
		};
	};

	if ((STR_Len (levelName)) && (STR_Len (vobName))) {
		var string msg;
		msg = ConcatStrings ("oCGame_TriggerChangeLevel ", levelName);
		msg = ConcatStrings (msg, STR_SPACE);
		msg = ConcatStrings (msg, vobName);

		MEM_Info (msg);

		oCGame_TriggerChangeLevel (levelName, vobName);

		return "Done.";
	};

	return "ZEN not found.";
};

func void CC_GotoZEN_Init () {
	//Register basic call
	CC_Register (CC_GotoZEN, "goto ZEN", "Will teleport player to specific ZEN world.");

	//Register consequently all levels - using existing oCTriggerChangeLevel objects
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	if (!SearchVobsByClass ("oCTriggerChangeLevel", vobListPtr)) {
		MEM_Info ("CC_GotoZEN_Init: No oCTriggerChangeLevel objects found.");
		MEM_ArrayFree (vobListPtr);
		return;
	};

	var int vobPtr;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var int i; i = 0;

	var int count; count = vobList.numInArray;

	while (i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		if (vobPtr) {
			var oCTriggerChangeLevel trigger; trigger = _^ (vobPtr);
			var string autoCompletion;

			autoCompletion = "goto ZEN ";
			autoCompletion = ConcatStrings (autoCompletion, trigger.levelName);
			autoCompletion = ConcatStrings (autoCompletion, STR_SPACE);
			autoCompletion = ConcatStrings (autoCompletion, trigger.startVob);

			MEM_Info (ConcatStrings ("CC_GotoZEN_Init register: ", autoCompletion));

			//We have to use our own function to be able to register same function with different parameters
			CC_RegisterMulti (CC_GotoZEN, autoCompletion, "Will teleport player to specific ZEN world.");
		};

		i += 1;
	end;

	MEM_ArrayFree (vobListPtr);
};
