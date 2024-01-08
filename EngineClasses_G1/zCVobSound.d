// sizeof 104h
class zCZone {
	//zCVob
	//zCObject
	var int _vtbl; //0
	var int refCtr; //4 int
	var int hashIndex; //8 unsigned short
	var int hashNext; //12 zCObject*
	var string objectName; //16 zSTRING
	//};
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
	//zCArray<zCVob*> {
	var int touchVobList_array; // 0x0094 zCVob**
	var int touchVobList_numAlloc; // 0x0098 int
	var int touchVobList_numInArray; // 0x009C int
	//}
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

//class zCZone

	var int world; //zCWorld* // sizeof 04h offset 100h
};

const int bitfield_zCVobSound_soundStartOn = 1; // sizeof 01h offset bit
const int bitfield_zCVobSound_soundIsRunning = 2; // sizeof 01h offset bit
const int bitfield_zCVobSound_soundIsAmbient3D = 4; // sizeof 01h offset bit
const int bitfield_zCVobSound_soundHasObstruction = 8; // sizeof 01h offset bit
const int bitfield_zCVobSound_soundVolType = 16; // sizeof 01h offset bit
const int bitfield_zCVobSound_soundAllowedToRun = 32; // sizeof 01h offset bit
const int bitfield_zCVobSound_soundAutoStart = 64; // sizeof 01h offset bit

// sizeof 14Ch
class zCVobSound {
	//zCZone {
	//zCVob
	//zCObject
	var int _vtbl; //0
	var int refCtr; //4 int
	var int hashIndex; //8 unsigned short
	var int hashNext; //12 zCObject*
	var string objectName; //16 zSTRING
	//};
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
	//zCArray<zCVob*> {
	var int touchVobList_array; // 0x0094 zCVob**
	var int touchVobList_numAlloc; // 0x0098 int
	var int touchVobList_numInArray; // 0x009C int
	//}
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

//class zCZone

	var int world; //zCWorld* // sizeof 04h offset 100h

//class zCVobSound {
	/*
	enum zTSoundVolType {
		SV_SPHERE = 0,
		SV_ELLIPSOID
	};

	enum zTSoundMode {
		SM_LOOPING,
		SM_ONCE,
		SM_RANDOM
	};
	*/

	var string soundName; //zSTRING // sizeof 14h offset 104h
	var int soundRadius; //float // sizeof 04h offset 118h
	var int soundMode; //zTSoundMode // sizeof 04h offset 11Ch

	var int bitfield_zCVobSound;
	/*
	group {
		unsigned char soundStartOn : 1; // sizeof 01h offset bit
		unsigned char soundIsRunning : 1; // sizeof 01h offset bit
		unsigned char soundIsAmbient3D : 1; // sizeof 01h offset bit
		unsigned char soundHasObstruction : 1; // sizeof 01h offset bit
		unsigned char soundVolType : 1; // sizeof 01h offset bit
		unsigned char soundAllowedToRun : 1; // sizeof 01h offset bit
		unsigned char soundAutoStart : 1; // sizeof 01h offset bit
	};
	*/

	var int soundRandDelay; //float // sizeof 04h offset 124h
	var int soundRandDelayVar; //float // sizeof 04h offset 128h
	var int soundVolume; //float // sizeof 04h offset 12Ch
	var int soundConeAngle; //float // sizeof 04h offset 130h
	var int sfx; //zCSoundFX* // sizeof 04h offset 134h
	var int sfxHandle; //int // sizeof 04h offset 138h
	var int soundRandTimer; //float // sizeof 04h offset 13Ch
	var int obstruction0; //float // sizeof 04h offset 140h
	var int obstruction1; //float // sizeof 04h offset 144h
	var int obstructionFrameTime; //float // sizeof 04h offset 148h
};
