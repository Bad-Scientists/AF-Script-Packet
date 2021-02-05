/*
Gothic standard flags
const int zCTrigger_bitfield_reactToOnTrigger  = ((1 << 1) - 1) << 0;			//1
const int zCTrigger_bitfield_reactToOnTouch    = ((1 << 1) - 1) << 1;			//2
const int zCTrigger_bitfield_reactToOnDamage   = ((1 << 1) - 1) << 2;			//4
const int zCTrigger_bitfield_respondToObject   = ((1 << 1) - 1) << 3;			//8
const int zCTrigger_bitfield_respondToPC       = ((1 << 1) - 1) << 4;			//16
const int zCTrigger_bitfield_respondToNPC      = ((1 << 1) - 1) << 5;			//32

const int zCTrigger_bitfield_startEnabled      = ((1 << 1) - 1) << (8 + 0);		//256
const int zCTrigger_bitfield_isEnabled         = ((1 << 1) - 1) << (8 + 1);		//512
const int zCTrigger_bitfield_sendUntrigger     = ((1 << 1) - 1) << (8 + 2);		//1024
*/

/*
 *	Flag forcing hooks to call additional event functions:
 *	    oCTriggerScript.scriptFunc + _OnTouch (var int triggerPtr, var int vobPtr)
 *	    oCTriggerScript.scriptFunc + _OnTrigger (var int triggerPtr)
 *	    oCTriggerScript.scriptFunc + _OnContact (var int triggerPtr)
 *	    oCTriggerScript.scriptFunc + _OnUnTouch (var int triggerPtr, var int vobPtr)
 *
 *		triggerPtr - pointer to trigger on which event was called on
 *		vobPtr - pointer to vob which triggered either _OnTouch / _OnUnTouch event
 */
 const int zCTrigger_bitfield_callEventFuncs	= ((1 << 1) - 1) << (8 + 3);		//2048

/*
 *	Flag for onContact event
		This is custom event that will be repeatedly triggered as long as oCTriggerScript is in contact with any vob.
		It is combination of _OnTouch and _OnTrigger event.
		When something touches oCTriggerScript object hook will setup oCTriggerScript._zCTrigger_triggerTarget to trigger itself.
		This will cause oCTriggerScript object to re-trigger itself in a loop as long as there is any object in oCTriggerScript._zCVob_touchVobList_numInArray.
		Hooked zCTrigger::OnTrigger function will call _OnContact event. (note: neither _OnTouch nor _OnTrigger event functions will be called with this flag)

		Should be used in combination with zCTrigger_bitfield_callEventFuncs flag

		Values in these variables should be same - both are used to setup fire delay:
			oCTriggerScript._zCTrigger_fireDelaySec
			oCTriggerScript._zCTrigger_retriggerWaitSec
 */
 
const int zCTrigger_bitfield_reactToOnContact	= ((1 << 1) - 1) << (8 + 4);		//4096

func int zCTrigger_CanBeActivatedNow (var int trigger, var int vobPtr) {
	//005E33B0  .text     Debug data           ?CanBeActivatedNow@zCTrigger@@MAEHPAVzCVob@@@Z
	const int zCTrigger__CanBeActivatedNow_G1 = 6173616;
	
	//0x00610220 protected: virtual int __thiscall zCTrigger::CanBeActivatedNow(class zCVob *)
	const int zCTrigger__CanBeActivatedNow_G2 = 6357536;

	if (!trigger) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@(vobPtr));
		CALL__thiscall(_@(trigger), MEMINT_SwitchG1G2 (zCTrigger__CanBeActivatedNow_G1, zCTrigger__CanBeActivatedNow_G2));

		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func void _hook_zCTrigger_OnTrigger () {
	var int symbID;
	const string cacheFunc = ""; const int cacheSymbID = 0;

	if (!ECX) { return; };

	if (Hlp_Is_oCTriggerScript (ECX)) {
		var string funcName; 
		var oCTriggerScript ts; ts = _^ (ECX);
		
		//reactOnContact
		if (ts._zCTrigger_bitfield & zCTrigger_bitfield_reactToOnContact) {
			//Default _zCTrigger_fireDelaySec (cannot be 0 for OnContact event!)
			ts._zCTrigger_fireDelaySec = divf(mkf(1), mkf(100));

			if (!ts._zCVob_touchVobList_numInArray) {
				ts._zCTrigger_fireDelaySec = FLOATNULL;
				ts._zCTrigger_triggerTarget = "";
				return;
			} else {
				if (ts._zCTrigger_retriggerWaitSec) {
					ts._zCTrigger_fireDelaySec = ts._zCTrigger_retriggerWaitSec;
				};
			};

			if (ts._zCTrigger_bitfield & zCTrigger_bitfield_callEventFuncs) {
				if (STR_Len (ts.scriptFunc)) {
					funcName = ConcatStrings (ts.scriptFunc, "_OnContact");

					if (Hlp_StrCmp (cacheFunc, funcName)) {
						symbID = cacheSymbID;
					} else {
						symbID = MEM_FindParserSymbol (funcName);

						if (symbID == -1) {
							//MEM_Info (ConcatStrings ("zCTrigger OnContact: Undefined symbol: ", funcName));
							return;
						};

						cacheFunc = funcName; cacheSymbID = symbID;
					};

					MEM_PushIntParam (ECX);
					MEM_CallByID (symbID);
				};
			};
		} else
		//reactOnTrigger
		if (ts._zCTrigger_bitfield & zCTrigger_bitfield_reactToOnTrigger) {
			if (ts._zCTrigger_bitfield & zCTrigger_bitfield_callEventFuncs) {
				if (STR_Len (ts.scriptFunc)) {
					funcName = ConcatStrings (ts.scriptFunc, "_OnTrigger");

					if (Hlp_StrCmp (cacheFunc, funcName)) {
						symbID = cacheSymbID;
					} else {
						symbID = MEM_FindParserSymbol (funcName);

						if (symbID == -1) {
							//MEM_Info (ConcatStrings ("zCTrigger OnTrigger: Undefined symbol: ", funcName));
							return;
						};

						cacheFunc = funcName; cacheSymbID = symbID;
					};

					MEM_PushIntParam (ECX);
					MEM_CallByID (symbID);
				};
			};
		};
	};
};

func void _hook_zCTrigger_OnTouch () {
	var int symbID;
	const string cacheFunc = ""; const int cacheSymbID = 0;

	if (!ECX) { return; };
	
	var int vobPtr; vobPtr = MEM_ReadInt (ESP + 4);

	if (!vobPtr) { return; };

	if (Hlp_Is_oCTriggerScript (ECX)) {
		var string funcName; 
		var oCTriggerScript ts; ts = _^ (ECX);

		//reactOnContact
		if (ts._zCTrigger_bitfield & zCTrigger_bitfield_reactToOnContact) {
			if (!zCTrigger_CanBeActivatedNow (ECX, vobPtr)) {
				return;
			};

			if (ts._zCVob_touchVobList_numInArray) {
				ts._zCTrigger_fireDelaySec = FLOATNULL;
				//Set this vob as triggerTarget
				ts._zCTrigger_triggerTarget = ts._zCObject_objectName;
			};

			if (ts._zCTrigger_bitfield & zCTrigger_bitfield_callEventFuncs) {
				if (STR_Len (ts.scriptFunc)) {
					funcName = ConcatStrings (ts.scriptFunc, "_OnContact");
				
					if (Hlp_StrCmp (cacheFunc, funcName)) {
						symbID = cacheSymbID;
					} else {
						symbID = MEM_FindParserSymbol (funcName);

						if (symbID == -1) {
							//MEM_Info (ConcatStrings ("zCTrigger OnContact: Undefined symbol: ", funcName));
							return;
						};

						cacheFunc = funcName; cacheSymbID = symbID;
					};

					MEM_PushIntParam (ECX);
					MEM_CallByID (symbID);
				};
			};
		} else
		//reactOnTouch
		if (ts._zCTrigger_bitfield & zCTrigger_bitfield_reactToOnTouch) {
			if (!zCTrigger_CanBeActivatedNow (ECX, vobPtr)) {
				return;
			};

			if (ts._zCTrigger_bitfield & zCTrigger_bitfield_callEventFuncs) {
				if (STR_Len (ts.scriptFunc)) {
					funcName = ConcatStrings (ts.scriptFunc, "_OnTouch");
				
					if (Hlp_StrCmp (cacheFunc, funcName)) {
						symbID = cacheSymbID;
					} else {
						symbID = MEM_FindParserSymbol (funcName);

						if (symbID == -1) {
							//MEM_Info (ConcatStrings ("zCTrigger OnTouch: Undefined symbol: ", funcName));
							return;
						};

						cacheFunc = funcName; cacheSymbID = symbID;
					};

					MEM_PushIntParam (ECX);
					MEM_PushIntParam (vobPtr);
					MEM_CallByID (symbID);
				};
			};
		};
	};
};

func void _hook_zCTrigger_OnUntouch () {
	var int symbID;
	const string cacheFunc = ""; const int cacheSymbID = 0;

	if (!ECX) { return; };

	var int vobPtr; vobPtr = MEM_ReadInt (ESP + 4);

	if (!vobPtr) { return; };

	if (Hlp_Is_oCTriggerScript (ECX)) {
		var string funcName; 
		var oCTriggerScript ts; ts = _^ (ECX);

		if (ts._zCTrigger_bitfield & zCTrigger_bitfield_reactToOnContact)
		|| (ts._zCTrigger_bitfield & zCTrigger_bitfield_reactToOnTouch)
		{
			if (ts._zCTrigger_bitfield & zCTrigger_bitfield_callEventFuncs) {
				if (STR_Len (ts.scriptFunc)) {
					funcName = ConcatStrings (ts.scriptFunc, "_OnUnTouch");

					if (Hlp_StrCmp (cacheFunc, funcName)) {
						symbID = cacheSymbID;
					} else {
						symbID = MEM_FindParserSymbol (funcName);

						if (symbID == -1) {
							//MEM_Info (ConcatStrings ("zCTrigger OnUntouch: Undefined symbol: ", funcName));
							return;
						};

						cacheFunc = funcName; cacheSymbID = symbID;
					};

					MEM_PushIntParam (ECX);
					MEM_PushIntParam (vobPtr);
					MEM_CallByID (symbID);
				};
			};
		};
	};
};

func void G12_EnhancedoCTriggerScript_Init () {
	const int once = 0;
	
	if (!once) {
		//Hooked zCTrigger::OnTrigger event
		HookEngine (zCTrigger__OnTrigger, 7, "_hook_zCTrigger_OnTrigger");
	
		//Hooked zCTrigger::OnTouch event
		HookEngine (zCTrigger__OnTouch, 7, "_hook_zCTrigger_OnTouch");

		//Hooked zCTrigger::OnUntouch event
		HookEngine (zCTrigger__OnUntouch, 10, "_hook_zCTrigger_OnUntouch");
		
		once = 1;
	};
};
