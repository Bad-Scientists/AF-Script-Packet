// sizeof 108h
class zCVobSpot {
//class zCVobSpot
	//public zCVob {
	//public zCObject
	var int _vtbl;			//0

	var int _zCObject_refCtr;			//4 int
	var int _zCObject_hashIndex;		//8 unsigned short
	var int _zCObject_hashNext;		//12 zCObject*
	var string _zCObject_objectName;	//16 zSTRING
	//};

	var int globalVobTreeNode; // 0x0024 zCTree<zCVob>*
	var int lastTimeDrawn; // 0x0028 zTFrameCtr
	var int lastTimeCollected; // 0x002C zDWORD
// zCArray<zCBspLeaf*> vobLeafList {
	var int vobLeafList_array; // 0x0030 zCBspLeaf**
	var int vobLeafList_numAlloc; // 0x0034 int
	var int vobLeafList_numInArray; // 0x0038 int
// }
	var int trafoObjToWorld[16]; // 0x003C zMATRIX4
// zTBBox3D bbox3D {
	var int bbox3D_mins[3]; // 0x007C zPOINT3
	var int bbox3D_maxs[3]; // 0x0088 zPOINT3
// }
// zCArray<zCVob*> touchVobList {
	var int touchVobList_array; // 0x0094 zCVob**
	var int touchVobList_numAlloc; // 0x0098 int
	var int touchVobList_numInArray; // 0x009C int
// }
	var int type; // 0x00A0 zTVobType
	var int groundShadowSizePacked; // 0x00A4 zDWORD
	var int homeWorld; // 0x00A8 zCWorld*
	var int groundPoly; // 0x00AC zCPolygon*
	var int callback_ai; // 0x00B0 zCAIBase*
	var int trafo; // 0x00B4 zMATRIX4*
	var int visual; // 0x00B8 zCVisual*
	var int visualAlpha; // 0x00BC zREAL
	var int rigidBody; // 0x00C0 zCRigidBody*
	var int lightColorStat; // 0x00C4 zCOLOR
	var int lightColorDyn; // 0x00C8 zCOLOR
	var int lightDirectionStat[3]; // 0x00CC zVEC3
	var int vobPresetName; // 0x00D8 zSTRING*
	var int eventManager; // 0x00DC zCEventManager*
	var int nextOnTimer; // 0x00E0 zREAL
	var int bitfield[5]; // 0x00E4 zCVob_bitfieldX_Xxx
	var int m_poCollisionObjectClass; // 0x00F8 zCCollisionObjectDef*
	var int m_poCollisionObject; // 0x00FC zCCollisionObject*

//zCVobSpot
	var int timerEnd;	//float timerEnd; // sizeof 04h offset 100h
	var int inUseVob;	//zCVob* inUseVob; // sizeof 04h offset 104h
};
