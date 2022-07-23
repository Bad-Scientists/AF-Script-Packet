/*
 *	PrintPos
 *	 - will print to zSpy position of focused object.
 */

func string CC_PrintTrafoWrapper (var string param, var int printTrafo) {
	param = STR_Trim (param, " ");

	var oCNpc her; her = Hlp_GetNpc (hero);

	var int count; count = STR_SplitCount (param, " ");
	var string objectName; objectName = "";

	if (count > 0) {
		objectName = STR_Split (param, " ", 0);
		objectName = STR_Trim (objectName, " ");
	};

	var string msg;

	if (her.focus_vob) {
		var int oldErrorLevel; oldErrorLevel = zERROR_GetFilterLevel ();
		zERROR_SetFilterLevel (1);

		//Print Trafo
		if (printTrafo) {
			msg = "const string descRot";

			if (STR_Len (objectName)) {
				msg = ConcatStrings (msg, "_");
				msg = ConcatStrings (msg, objectName);
			};

			msg = ConcatStrings (msg, " = ");
			msg = ConcatStrings (msg, BtoC(34));
			msg = ConcatStrings (msg, Vob_GetDescriptionRot (her.focus_vob));
			msg = ConcatStrings (msg, BtoC(34));
			msg = ConcatStrings (msg, ";");

			MEM_Info (msg);

			msg = "const string descPos";

			if (STR_Len (objectName)) {
				msg = ConcatStrings (msg, "_");
				msg = ConcatStrings (msg, objectName);
			};

			msg = ConcatStrings (msg, " = ");
			msg = ConcatStrings (msg, BtoC(34));
			msg = ConcatStrings (msg, Vob_GetDescriptionPos (her.focus_vob));
			msg = ConcatStrings (msg, BtoC(34));
			msg = ConcatStrings (msg, ";");

			MEM_Info (msg);
		} else
		//Print Pos
		{
			var int pos[3];
			if (zCVob_GetPositionWorldToPos (her.focus_vob, _@ (pos))) {
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
			};
		};

		zERROR_SetFilterLevel (oldErrorLevel);
	} else {
		msg = "Nothing in focus.";
	};

	return msg;
};

func string CC_PrintPos (var string param) {
	return CC_PrintTrafoWrapper (param, 0);
};

func string CC_PrintTrafo (var string param) {
	return CC_PrintTrafoWrapper (param, 1);
};

func void CC_PrintPos_Init () {
	CC_Register (CC_PrintPos, "print pos", "Will print to zSpy position of focused object.");
	CC_Register (CC_PrintTrafo, "print trafo", "Will print to zSpy position & rotation of focused object.");
};
