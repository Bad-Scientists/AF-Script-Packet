// sizeof 3Ch
class zCConDat {
	var string hint; //zSTRING // sizeof 14h offset 00h
	var string name; //zSTRING // sizeof 14h offset 14h
	var int type; //int // sizeof 04h offset 28h
	var int adr; //void* // sizeof 04h offset 2Ch
	var int ele; //int // sizeof 04h offset 30h
	var int var; //int // sizeof 04h offset 34h
	var int next; //zCConDat* // sizeof 04h offset 38h
};
