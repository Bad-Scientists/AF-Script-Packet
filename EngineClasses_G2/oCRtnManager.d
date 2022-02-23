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

	var int indexStart[3];	//int
	var int indexEnd[3];	//int
	var int world;		//zCWorld*
	var int nextEntryNode;	//zCListSort<oCRtnEntry>*

	//zCListSort<oCRtnEntry> rtnList;
	var int rtnList_compare;
	var int rtnList_data;	//oCRtnEntry*
	var int rtnList_next;

	//zCListSort<TRtn_WayBox> wayboxListX;
	var int wayboxListX_compare;
	var int wayboxListX_data;
	var int wayboxListX_next;

	//zCListSort<TRtn_WayBox> wayboxListY;
	var int wayboxListY_compare;
	var int wayboxListY_data;
	var int wayboxListY_next;

	//zCListSort<TRtn_WayBox> wayboxListZ;
	var int wayboxListZ_compare;
	var int wayboxListZ_datal;
	var int wayboxListZ_next;

	//zCList<oCNpc> activeList;
	var int activeList_data;
	var int activeList_next;

	//zCArraySort<TRtn_WayBoxLimit*> wayboxList[3];
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
