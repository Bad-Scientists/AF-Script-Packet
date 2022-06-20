/*
 *	marvin command: lock pickLockStr keyInstance
 *	 - if you don't want to change pickLockStr then use minus sign instead of pickLockStr combination
 *	   lock pickLockStr - keyInstance
 */
func string CC_Lock (var string param) {
	param = STR_Trim (param, " ");

	var string msg;
	var oCNpc her; her = Hlp_GetNPC (hero);

	if (her.focus_vob) {
		if (Hlp_Is_oCMobLockable (her.focus_vob)) {
			var string pickLockStr; pickLockStr = "";
			var string keyInstance; keyInstance = "";

			var int count; count = STR_SplitCount (param, " ");
			if (count > 0) {
				pickLockStr = STR_Split (param, " ", 0);
			};

			if (count > 1) {
				keyInstance = STR_Split (param, " ", 1);
			};

			if (Hlp_StrCmp (pickLockStr, "-")) {
				pickLockStr = "";
			};

			//Lock
			var oCMobLockable mob; mob = _^ (her.focus_vob);
			mob.bitfield = (mob.bitfield | oCMobLockable_bitfield_locked);

			//Get name
			msg = ConcatStrings ("Mob: '", mob._zCObject_objectName);
			msg = ConcatStrings (msg, "'");

			msg = ConcatStrings (msg, " locked with pickLockStr combination: ");
			msg = ConcatStrings (msg, pickLockStr);

			msg = ConcatStrings (msg, " and keyInstance: ");
			msg = ConcatStrings (msg, keyInstance);

			mob.pickLockStr = pickLockStr;
			mob.keyInstance = keyInstance;
		} else {
			msg = "hero.focus_vob is not oCMobLockable object.";
		};
	} else {
		msg = "Nothing in focus.";
	};

	return msg;
};

func string CC_UnLock (var string param) {
	var string msg;
	var oCNpc her; her = Hlp_GetNPC (hero);

	if (her.focus_vob) {
		if (Hlp_Is_oCMobLockable (her.focus_vob)) {
			//Unlock
			var oCMobLockable mob; mob = _^ (her.focus_vob);
			mob.bitfield = (mob.bitfield & ~ oCMobLockable_bitfield_locked);

			//Get name
			msg = ConcatStrings ("Mob: '", mob._zCObject_objectName);
			msg = ConcatStrings (msg, "'");

			//Get key
			msg = ConcatStrings (msg, ", key: '");
			msg = ConcatStrings (msg, mob.keyInstance);
			msg = ConcatStrings (msg, "'");

			//Get picklock combination
			msg = ConcatStrings (msg, ", pickLockStr: '");
			msg = ConcatStrings (msg, mob.pickLockStr);
			msg = ConcatStrings (msg, "'");

			msg = ConcatStrings (msg, " unlocked.");

			if (STR_Len (mob.keyInstance)) {
				var int keyIsValid; keyIsValid = MEM_FindParserSymbol (mob.keyInstance);
				if (keyIsValid == -1) {
					msg = ConcatStrings (msg, " Invalid key - item does not exist!");
				};
			};
		} else {
			msg = "hero.focus_vob is not oCMobLockable object.";
		};
	} else {
		msg = "Nothing in focus.";
	};

	return msg;
};

func void CC_UnLock_Init () {
	CC_Register (CC_Lock, "lock", "Lock mob in focus.");
	CC_Register (CC_UnLock, "unlock", "Unlock mob in focus.");
};
