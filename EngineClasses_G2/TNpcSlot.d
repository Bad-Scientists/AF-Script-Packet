// sizeof 38h
class TNpcSlot {
	var string name;	//zSTRING	// sizeof 14h    offset 00h
	var int inInventory;	//int		// sizeof 04h    offset 14h
	var int tmpLevel;	//int		// sizeof 04h    offset 18h
	var string itemName;	//zSTRING	// sizeof 14h    offset 1Ch
	var int vob;		//oCVob*	// sizeof 04h    offset 30h
	var int bitfield;
	//int wasVobTreeWhenInserted : 1;	// sizeof 01h    offset bit
};
