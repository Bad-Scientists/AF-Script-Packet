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

func string oCItem_GetInstanceName (var int itemInstance) {
	var int symbPtr; symbPtr = MEM_GetSymbolByIndex (itemInstance);

	if (symbPtr) {
		var zCPar_symbol symb; symb = _^ (symbPtr);
		return symb.name;
	};

	return "";
};

func void oCItem_SetLightingSwell (var int itemPtr, var int value) {
	//0x00670DC0 public: static void __cdecl oCItem::SetLightingSwell(int)
	const int oCItem__SetLightingSwell_G1 = 6753728;

	//0x00711270 public: static void __cdecl oCItem::SetLightingSwell(int)
	const int oCItem__SetLightingSwell_G2 = 6753728;

	CALL_IntParam (value);
	CALL_PtrParam (itemPtr);
	CALL__cdecl (MEMINT_SwitchG1G2 (oCItem__SetLightingSwell_G1, oCItem__SetLightingSwell_G2));
};