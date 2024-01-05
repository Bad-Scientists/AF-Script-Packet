// sizeof 44h
class zCCSBlock {
	//class zCCSBlockBase {
	//public zCObject {
	var int _vtbl; //0

	var int refCtr; //4 int
	var int hashIndex; //8 unsigned short
	var int hashNext; //12 zCObject*
	var string objectName; //16 zSTRING
	//};
	//};

	//zCArray<zCCSBlockPosition> blocks; // sizeof 0Ch offset 24h
	var int blocks_array; // zCCSBlockPosition
	var int blocks_numAlloc;
	var int blocks_numInArray;

	var string roleName; //zSTRING // sizeof 14h offset 30h
};
