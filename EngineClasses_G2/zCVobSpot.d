// sizeof 128h

class zCVobSpot {
//class zCVobSpot : public zCVob {
//zCObject {
	var int _vtbl;
	var int _zCObject_refCtr;
	var int _zCObject_hashIndex;
	var int _zCObject_hashNext;
	var string _zCObject_objectName;
//}
	var int globalVobTreeNode; // 0x0024 zCTree<zCVob>*
	var int lastTimeDrawn; // 0x0028 zTFrameCtr
	var int lastTimeCollected; // 0x002C zDWORD
//zCArray<zCBspLeaf*> {
	var int vobLeafList_array; // 0x0030 zCBspLeaf**
	var int vobLeafList_numAlloc; // 0x0034 int
	var int vobLeafList_numInArray; // 0x0038 int
//}
	var int trafoObjToWorld[16]; // 0x003C zMATRIX4
//zTBBox3D {
	var int bbox3D_mins[3]; // 0x007C zPOINT3
	var int bbox3D_maxs[3]; // 0x0088 zPOINT3
//}
//zTBSphere3D {
	var int bsphere3D_center[3]; // 0x0094 zPOINT3
	var int bsphere3D_radius; // 0x00A0 zVALUE
//}
//zCArray<zCVob*> {
	var int touchVobList_array; // 0x00A4 zCVob**
	var int touchVobList_numAlloc; // 0x00A8 int
	var int touchVobList_numInArray; // 0x00AC int
//}
	var int type; // 0x00B0 zTVobType
	var int groundShadowSizePacked; // 0x00B4 zDWORD
	var int homeWorld; // 0x00B8 zCWorld*
	var int groundPoly; // 0x00BC zCPolygon*
	var int callback_ai; // 0x00C0 zCAIBase*
	var int trafo; // 0x00C4 zMATRIX4*
	var int visual; // 0x00C8 zCVisual*
	var int visualAlpha; // 0x00CC zREAL
	var int m_fVobFarClipZScale; // 0x00D0 zREAL
	var int m_AniMode; // 0x00D4 zTAnimationMode
	var int m_aniModeStrength; // 0x00D8 zREAL
	var int m_zBias; // 0x00DC int
	var int rigidBody; // 0x00E0 zCRigidBody*
	var int lightColorStat; // 0x00E4 zCOLOR
	var int lightColorDyn; // 0x00E8 zCOLOR
	var int lightDirectionStat[3]; // 0x00EC zVEC3
	var int vobPresetName; // 0x00F8 zSTRING*
	var int eventManager; // 0x00FC zCEventManager*
	var int nextOnTimer; // 0x0100 zREAL
	var int bitfield[5]; // 0x0104 zCVob_bitfieldX_Xxx
	var int m_poCollisionObjectClass; // 0x0118 zCCollisionObjectDef*
	var int m_poCollisionObject; // 0x011C zCCollisionObject*

	var int timerEnd; //float  // sizeof 04h offset 120h
	var int inUseVob; //zCVob*  // sizeof 04h offset 124h
};
