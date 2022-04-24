/*
 *	PrintPos
 *	 - will print to zSpy position of focused object.
 */

 func string CC_PrintPos (var string param) {
	var oCNpc her; her = Hlp_GetNpc (hero);

	param = STR_Upper (param);
	param = STR_Trim (param, " ");

	var int count; count = STR_SplitCount (param, " ");
	var string objectName; objectName = "";

	if (count > 0) {
		objectName = STR_Split (param, " ", 0);
		objectName = STR_Trim (objectName, " ");
	};

	var string msg;

	if (her.focus_vob) {
		var int posPtr;
		posPtr = zCVob_GetPositionWorld (her.focus_vob);

		if (posPtr) {
			var int pos[3];
			MEM_CopyBytes (posPtr, _@(pos), 12);

			var int oldErrorLevel; oldErrorLevel = zERROR_GetFilterLevel ();
			zERROR_SetFilterLevel (1);

			msg = "const float pos";
			if (STR_Len (objectName)) {
				msg = ConcatStrings (msg, "_");
				msg = ConcatStrings (msg, objectName);
			};

			msg = ConcatStrings (msg, "[3] = {");
			msg = ConcatStrings (msg, toStringF (pos[0]));
			msg = ConcatStrings (msg, ", ");
			msg = ConcatStrings (msg, toStringF (pos[1]));
			msg = ConcatStrings (msg, ", ");
			msg = ConcatStrings (msg, toStringF (pos[2]));
			msg = ConcatStrings (msg, "};");

			MEM_Info (msg);

			zERROR_SetFilterLevel (oldErrorLevel);
		};

		MEM_Free (posPtr);
	} else {
		msg = "Nothing in focus.";
	};

	return msg;
};

func void CC_PrintPos_Init () {
	CC_Register (CC_PrintPos, "print pos", "Will print to zSpy position of focused object.");
};
