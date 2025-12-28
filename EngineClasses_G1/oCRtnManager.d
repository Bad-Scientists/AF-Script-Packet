//As always no idea if this is correct conversion to primitive types :)
class oCRtnManager {
/*
	struct TRtn_WayBoxLimit {
	public:
	int begin;
	zTBBox3D bbox;
	float value;
	oCNpc* npc;

	// user API
	#include "oCRtnManager_TRtn_WayBoxLimit.inl"
	};
*/

/*
	struct TRtn_WayBox {
	public:
	zTBBox3D bbox;
	oCNpc* npc;
	int found;

	// user API
	#include "oCRtnManager_TRtn_WayBox.inl"
	};
*/

	var int indexStart[3];	//int // sizeof 0Ch offset 00h
	var int indexEnd[3];	//int // sizeof 0Ch offset 0Ch
	var int world;		//zCWorld* // sizeof 04h offset 18h
	var int nextEntryNode;	//zCListSort<oCRtnEntry>* // sizeof 04h offset 1Ch

	//zCListSort<oCRtnEntry> rtnList; // sizeof 0Ch offset 20h
	var int rtnList_compare;
	var int rtnList_data;	//oCRtnEntry*
	var int rtnList_next;

	//zCListSort<TRtn_WayBox> wayboxListX; // sizeof 0Ch offset 2Ch
	var int wayboxListX_compare;
	var int wayboxListX_data;
	var int wayboxListX_next;

	//zCListSort<TRtn_WayBox> wayboxListY; // sizeof 0Ch offset 38h
	var int wayboxListY_compare;
	var int wayboxListY_data;
	var int wayboxListY_next;

	//zCListSort<TRtn_WayBox> wayboxListZ; // sizeof 0Ch offset 44h
	var int wayboxListZ_compare;
	var int wayboxListZ_datal;
	var int wayboxListZ_next;

	//zCList<oCNpc> activeList; // sizeof 08h offset 50h
	var int activeList_data;
	var int activeList_next;

	//zCArraySort<TRtn_WayBoxLimit*> wayboxList[3]; // sizeof 30h offset 58h
	var int wayboxList0_array;
	var int wayboxList0_numAlloc;
	var int wayboxList0_numInArray;
	var int wayboxList0_compare;

	var int wayboxList1_array;
	var int wayboxList1_numAlloc;
	var int wayboxList1_numInArray;
	var int wayboxList1_compare;

	var int wayboxList2_array;
	var int wayboxList2_numAlloc;
	var int wayboxList2_numInArray;
	var int wayboxList2_compare;
};
