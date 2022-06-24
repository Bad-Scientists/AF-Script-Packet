/*
 *	Removes flags from oCItem pointer
 *		itemPtr			item pointer
 *		removeFlags		flag(s) to be removed
 */
func void oCItem_RemoveFlags (var int itemPtr, var int removeFlags) {
	if (!itemPtr) { return; };
	var oCItem itm; itm = _^ (itemPtr);
	itm.flags = (itm.flags & ~ (removeFlags));
};

/*
 *	Adds flags to oCItem pointer
 *		itemPtr			item pointer
 *		addFlags		flag(s) to be added
 */
func void oCItem_AddFlags (var int itemPtr, var int addFlags) {
	if (!itemPtr) { return; };
	var oCItem itm; itm = _^ (itemPtr);
	itm.flags = (itm.flags | (addFlags));
};

func void oCItem_SetLightingSwell (var int value) {
	//0x00670DC0 public: static void __cdecl oCItem::SetLightingSwell(int)
	const int oCItem__SetLightingSwell_G1 = 6753728;

	//0x00711270 public: static void __cdecl oCItem::SetLightingSwell(int)
	const int oCItem__SetLightingSwell_G2 = 7410288;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (value));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCItem__SetLightingSwell_G1, oCItem__SetLightingSwell_G2));
		call = CALL_End ();
	};
};

func int oCItem_GetLightingSwell () {
	//0x00670DD0 public: static int __cdecl oCItem::GetLightingSwell(void)
	const int oCItem__GetLightingSwell_G1 = 6753744;

	//0x00711280 public: static int __cdecl oCItem::GetLightingSwell(void)
	const int oCItem__GetLightingSwell_G2 = 7410304;

	var int retVal;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__cdecl (MEMINT_SwitchG1G2 (oCItem__GetLightingSwell_G1, oCItem__GetLightingSwell_G2));
		call = CALL_End ();
	};

	return +retVal;
};


/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		flag			flag to be tested?
 */
func int oCItem_HasFlag (var int itemPtr, var int flag){
	//0x00671FC0 public: int __thiscall oCItem::HasFlag(int)
	const int oCItem__HasFlag_G1 = 6758336;

	//0x007126D0 public: int __thiscall oCItem::HasFlag(int)
	const int oCItem__HasFlag_G2 = 7415504;

	if (!itemPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (flag));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2(oCItem__HasFlag_G1, oCItem__HasFlag_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt();
};

/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		flag			flag to be set?
 */
func void oCItem_SetFlag (var int itemPtr, var int flag){
	//0x00672000 public: void __thiscall oCItem::SetFlag(int)
	const int oCItem__SetFlag_G1 = 6758400;

	//0x00712710 public: void __thiscall oCItem::SetFlag(int)
	const int oCItem__SetFlag_G2 = 7415568;

	if (!itemPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (flag));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2(oCItem__SetFlag_G1, oCItem__SetFlag_G2));
		call = CALL_End();
	};
};

/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		flag			flag to be removed?
 */
func void oCItem_ClearFlag (var int itemPtr, var int flag){
	//0x00671FE0 public: void __thiscall oCItem::ClearFlag(int)
	const int oCItem__ClearFlag_G1 = 6758368;

	//0x007126F0 public: void __thiscall oCItem::ClearFlag(int)
	const int oCItem__ClearFlag_G2 = 7415536;

	if (!itemPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (flag));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2(oCItem__ClearFlag_G1, oCItem__ClearFlag_G2));
		call = CALL_End();
	};
};

/*
 *	TODO: test this one
 *    		itemPtr			item pointer?
 *    		qty			quantity?
 */
func int oCItem_SplitItemPtr (var int itemPtr, var int qty){
	//0x00672440 public: class oCItem * __thiscall oCItem::SplitItem(int)
	const int oCItem__SplitItem_G1 = 6759488;

	//0x00712BA0 public: class oCItem * __thiscall oCItem::SplitItem(int)
	const int oCItem__SplitItem_G2 = 7416736;

	if (!itemPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (qty));
		CALL__thiscall (_@ (itemPtr), MEMINT_SwitchG1G2 (oCItem__SplitItem_G1, oCItem__SplitItem_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr();
};

func string GetItemTextByIndex (var int itemPtr, var int index) {
	if (!Hlp_Is_oCItem (itemPtr)) { return ""; };

	//Safety check for index boundaries
	if ((index < 0) || (index >= ITM_TEXT_MAX)) { return ""; };

	var oCItem itm; itm = _^ (itemPtr);

	return MEM_ReadStringArray (_@s(itm.text), index);
};

func int GetItemCountValue (var int itemPtr, var string text) {
	if (!Hlp_Is_oCItem (itemPtr)) { return 0; };

	var oCItem itm; itm = _^ (itemPtr);

	//Check item texts - return count value - search by 'text'
	repeat (i, ITM_TEXT_MAX); var int i;
		if (Hlp_StrCmp (GetItemTextByIndex (itemPtr, i), text)) { return MEM_ReadIntArray (_@ (itm.count[0]), i); };
	end;

	return 0;
};

func int oCItem_GetCondAttr (var int itemPtr, var int index) {
	if (!Hlp_Is_oCItem (itemPtr)) { return 0; };

	//Safety check for index boundaries
	if ((index < 0) || (index >= ITM_COND_MAX)) { return 0; };

	var oCItem itm; itm = _^ (itemPtr);

	return MEM_ReadIntArray (_@(itm.cond_atr[0]), index);
};

func int oCItem_GetCondValue (var int itemPtr, var int index) {
	if (!Hlp_Is_oCItem (itemPtr)) { return 0; };

	//Safety check for index boundaries
	if ((index < 0) || (index >= ITM_COND_MAX)) { return 0; };

	var oCItem itm; itm = _^ (itemPtr);

	return MEM_ReadIntArray (_@(itm.cond_value[0]), index);
};
