/*
	enum zTVFXState {
		zVFXSTATE_UNDEF,
		zVFXSTATE_OPEN,
		zVFXSTATE_INIT,
		zVFXSTATE_INVESTNEXT,
		zVFXSTATE_CAST,
		zVFXSTATE_STOP,
		zVFXSTATE_COLLIDE
	};

	enum TEmTrajectoryMode {
		EM_TRJ_UNDEF,
		EM_TRJ_FIXED,
		EM_TRJ_TARGET,
		EM_TRJ_LINE = 4,
		EM_TRJ_SPLINE = 8,
		EM_TRJ_RANDOM = 16,
		EM_TRJ_CIRCLE = 32,
		EM_TRJ_FOLLOW = 64
	};

	enum TTrjLoopMode {
		TRJ_LOOP_NONE,
		TRJ_LOOP_RESTART,
		TRJ_LOOP_PINGPONG,
		TRJ_LOOP_HALT
	};

	enum TEaseFunc {
		TEASEFUNC_LINEAR,
		TEASEFUNC_SINE,
		TEASEFUNC_EXP
	};

	// sizeof 1Ch
	struct zSVisualFXColl {
		zCVob* foundVob; // sizeof 04h offset 00h
		zVEC3 foundContactPoint; // sizeof 0Ch offset 04h
		zVEC3 foundNormal; // sizeof 0Ch offset 10h
	};

	// sizeof 5Ch
	class oCTrajectory {
		zCArray<zCPositionKey*> keyList; // sizeof 0Ch offset 00h
		zCKBSpline* spl; // sizeof 04h offset 0Ch
		int mode; // sizeof 04h offset 10h
		float length; // sizeof 04h offset 14h
		zMAT4 res; // sizeof 40h offset 18h
		int lastKey; // sizeof 04h offset 58h
	};
*/

class oCVisualFX {
//class zCEffect {
//class zCVob {
	var int _vtbl; //0

//class zCObject {
	var int refCtr; //4	int refCtr;
	var int hashIndex; //8	unsigned short hashIndex;
	var int hashNext; //12	zCObject* hashNext;
	var string objectName; //16	zSTRING objectName

//};

//class zCVob : public zCObject {

	/*
	enum zTVobCharClass {
	zVOB_CHAR_CLASS_NONE,
	zVOB_CHAR_CLASS_PC,
	zVOB_CHAR_CLASS_NPC
	};

	enum zTMovementMode {
	zVOB_MOVE_MODE_NOTINBLOCK,
	zVOB_MOVE_MODE_INBLOCK,
	zVOB_MOVE_MODE_INBLOCK_NOCD
	};

	enum {
	zVOB_CDMODE_EXACT,
	zVOB_CDMODE_SPEEDBOX,
	zVOB_CDMODE_ALL
	};

	enum zTDynShadowType {
	zDYN_SHADOW_TYPE_NONE,
	zDYN_SHADOW_TYPE_BLOB,
	zDYN_SHADOW_TYPE_COUNT
	};


	struct zTCollisionContext {
	zCArray<zCCollisionObject*> otherCollObjectList;
	zCArray<zCVob*> otherCollVobList;
	*/
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

/*
	struct zTModelLimbColl {
	zCVob* hitVob;
	zCList<zCModelNodeInst> hitModelNodeList;
	zVEC3 approxCollisionPos;
*/

//class zCEffect {

	var string visName_S; //zSTRING // sizeof 14h offset 100h
	var string visSize_S; //zSTRING // sizeof 14h offset 114h
	var int visAlpha; //float // sizeof 04h offset 128h
	var string visAlphaBlendFunc_S; //zSTRING // sizeof 14h offset 12Ch
	var int visTexAniFPS; //float // sizeof 04h offset 140h
	var int visTexAniIsLooping; //int // sizeof 04h offset 144h
	var string emTrjMode_S; //zSTRING // sizeof 14h offset 148h
	var string emTrjOriginNode_S; //zSTRING // sizeof 14h offset 15Ch
	var string emTrjTargetNode_S; //zSTRING // sizeof 14h offset 170h
	var int emTrjTargetRange; //float // sizeof 04h offset 184h
	var int emTrjTargetAzi; //float // sizeof 04h offset 188h
	var int emTrjTargetElev; //float // sizeof 04h offset 18Ch
	var int emTrjNumKeys; //int // sizeof 04h offset 190h
	var int emTrjNumKeysVar; //int // sizeof 04h offset 194h
	var int emTrjAngleElevVar; //float // sizeof 04h offset 198h
	var int emTrjAngleHeadVar; //float // sizeof 04h offset 19Ch
	var int emTrjKeyDistVar; //float // sizeof 04h offset 1A0h
	var string emTrjLoopMode_S; //zSTRING // sizeof 14h offset 1A4h
	var string emTrjEaseFunc_S; //zSTRING // sizeof 14h offset 1B8h
	var int emTrjEaseVel; //float // sizeof 04h offset 1CCh
	var int emTrjDynUpdateDelay; //float // sizeof 04h offset 1D0h
	var int emTrjDynUpdateTargetOnly; //int // sizeof 04h offset 1D4h
	var string emFXCreate_S; //zSTRING // sizeof 14h offset 1D8h
	var string emFXInvestOrigin_S; //zSTRING // sizeof 14h offset 1ECh
	var string emFXInvestTarget_S; //zSTRING // sizeof 14h offset 200h
	var int emFXTriggerDelay; //float // sizeof 04h offset 214h
	var int emFXCreatedOwnTrj; //int // sizeof 04h offset 218h
	var string emActionCollDyn_S; //zSTRING // sizeof 14h offset 21Ch
	var string emActionCollStat_S; //zSTRING // sizeof 14h offset 230h
	var string emFXCollStat_S; //zSTRING // sizeof 14h offset 244h
	var string emFXCollDyn_S; //zSTRING // sizeof 14h offset 258h
	var string emFXCollStatAlign_S; //zSTRING // sizeof 14h offset 26Ch
	var string emFXCollDynAlign_S; //zSTRING // sizeof 14h offset 280h
	var int emFXLifeSpan; //float // sizeof 04h offset 294h
	var int emCheckCollision; //int // sizeof 04h offset 298h
	var int emAdjustShpToOrigin; //int // sizeof 04h offset 29Ch
	var int emInvestNextKeyDuration; //float // sizeof 04h offset 2A0h
	var int emFlyGravity; //float // sizeof 04h offset 2A4h
	var string emSelfRotVel_S; //zSTRING // sizeof 14h offset 2A8h
 //const int VFX_NUM_USERSTRINGS = 3;
	var string userString[3]; //zSTRING ; // sizeof 3Ch offset 2BCh
	var string lightPresetName; //zSTRING // sizeof 14h offset 2F8h
	var string sfxID; //zSTRING // sizeof 14h offset 30Ch
	var int sfxIsAmbient; //int // sizeof 04h offset 320h
	var int sendAssessMagic; //int // sizeof 04h offset 324h
	var int secsPerDamage; //float // sizeof 04h offset 328h
	var int dScriptEnd; //unsigned char // sizeof 01h offset 32Ch
	var int visSize[3]; //zVEC3 // sizeof 0Ch offset 330h
	var int emTrjMode; //int // sizeof 04h offset 33Ch
	var int emActionCollDyn; //int // sizeof 04h offset 340h
	var int emActionCollStat; //int // sizeof 04h offset 344h
	var int emSelfRotVel[3]; //zVEC3 // sizeof 0Ch offset 348h
	var int emTrjEaseFunc; //TEaseFunc // sizeof 04h offset 354h
	var int emTrjLoopMode; //TTrjLoopMode // sizeof 04h offset 358h
	var int fxState; //zTVFXState // sizeof 04h offset 35Ch
	var int root; //oCVisualFX* // sizeof 04h offset 360h
	var int parent; //oCVisualFX* // sizeof 04h offset 364h
	var int fxInvestOrigin; //oCVisualFX* // sizeof 04h offset 368h
	var int fxInvestTarget; //oCVisualFX* // sizeof 04h offset 36Ch
	var int ai; //oCVisualFXAI* // sizeof 04h offset 370h
	var int fxInvestOriginInitialized; //int // sizeof 04h offset 374h
	var int fxInvestTargetInitialized; //int // sizeof 04h offset 378h
	var int fxInvestStopped; //int // sizeof 04h offset 37Ch

 //zCArray<oCVisualFX*> fxList; // sizeof 0Ch offset 380h
	var int fxList_array; //oCVisualFX*
	var int fxList_numAlloc; //int
	var int fxList_numInArray;//int

 //zCArray<oCVisualFX*> childList; // sizeof 0Ch offset 38Ch
	var int childList_array; //oCVisualFX*
	var int childList_numAlloc; //int
	var int childList_numInArray;//int

 //zCArray<oCEmitterKey*> emKeyList; // sizeof 0Ch offset 398h
	var int emKeyList_array; //oCEmitterKey*
	var int emKeyList_numAlloc; //int
	var int emKeyList_numInArray;//int

 //zCArray<zCVob*> vobList; // sizeof 0Ch offset 3A4h
	var int vobList_array; //zCVob*
	var int vobList_numAlloc; //int
	var int vobList_numInArray;//int

 //zCArray<zCVob*> ignoreVobList; // sizeof 0Ch offset 3B0h
	var int ignoreVobList_array; //zCVob*
	var int ignoreVobList_numAlloc; //int
	var int ignoreVobList_numInArray;//int

 //zCArray<zCVob*> allowedCollisionVobList; // sizeof 0Ch offset 3BCh
	var int allowedCollisionVobList_array; //zCVob*
	var int allowedCollisionVobList_numAlloc; //int
	var int allowedCollisionVobList_numInArray;//int

 //zCArray<zCVob*> collidedVobs; // sizeof 0Ch offset 3C8h
	var int collidedVobs_array; //zCVob*
	var int collidedVobs_numAlloc; //int
	var int collidedVobs_numInArray;//int

 //zCArray<zSVisualFXColl> queuedCollisions; // sizeof 0Ch offset 3D4h
	var int queuedCollisions_array; //zSVisualFXColl
	var int queuedCollisions_numAlloc; //int
	var int queuedCollisions_numInArray;//int

//oCTrajectory trajectory; // sizeof 5Ch offset 3E0h
 //zCArray<zCPositionKey*> keyList; // sizeof 0Ch offset 00h
	var int trajectory_keyList_array; //zCPositionKey*
	var int trajectory_keyList_numAlloc; //int
	var int trajectory_keyList_numInArray;//int

	var int trajectory_spl; //zCKBSpline* // sizeof 04h offset 0Ch
	var int trajectory_mode; //int // sizeof 04h offset 10h
	var int trajectory_length; //float // sizeof 04h offset 14h
	var int trajectory_res[16]; //zMAT4 // sizeof 40h offset 18h
	var int trajectory_lastKey; //int // sizeof 04h offset 58h
//

	var int earthQuake; //zCEarthquake* // sizeof 04h offset 43Ch
	var int screenFX; //zCVobScreenFX* // sizeof 04h offset 440h
	var int screenFXTime; //float // sizeof 04h offset 444h
	var int screenFXDir; //int // sizeof 04h offset 448h
	var int orgNode; //zCModelNodeInst* // sizeof 04h offset 44Ch
	var int targetNode; //zCModelNodeInst* // sizeof 04h offset 450h
	var int lastSetVisual; //zCVisual* // sizeof 04h offset 454h
	var int origin; //zCVob* // sizeof 04h offset 458h
	var int inflictor; //zCVob* // sizeof 04h offset 45Ch
	var int target; //zCVob* // sizeof 04h offset 460h
	var int light; //zCVobLight* // sizeof 04h offset 464h
	var int lightRange; //float // sizeof 04h offset 468h
	var int sfx; //zCSoundFX* // sizeof 04h offset 46Ch
	var int sfxHnd; //int // sizeof 04h offset 470h
	var string fxName; //zSTRING // sizeof 14h offset 474h
	var int fxBackup; //oCEmitterKey* // sizeof 04h offset 488h
	var int lastSetKey; //oCEmitterKey* // sizeof 04h offset 48Ch
	var int actKey; //oCEmitterKey* // sizeof 04h offset 490h
	var int level; //int // sizeof 04h offset 494h
	var int collisionOccured; //int // sizeof 04h offset 498h
	var int collisionCtr; //int // sizeof 04h offset 49Ch
	var int showVisual; //int // sizeof 04h offset 4A0h
	var int isChild; //int // sizeof 04h offset 4A4h
	var int isDeleted; //int // sizeof 04h offset 4A8h
	var int initialized; //int // sizeof 04h offset 4ACh
	var int shouldDelete; //int // sizeof 04h offset 4B0h
	var int lightning; //int // sizeof 04h offset 4B4h
	var int queueSetLevel; //int // sizeof 04h offset 4B8h
	var int frameTime; //float // sizeof 04h offset 4BCh
	var int collisionTime; //float // sizeof 04h offset 4C0h
	var int deleteTime; //float // sizeof 04h offset 4C4h
	var int damageTime; //float // sizeof 04h offset 4C8h
	var int targetPos[3]; //zVEC3 // sizeof 0Ch offset 4CCh
	var int lastTrjDir[3]; //zVEC3 // sizeof 0Ch offset 4D8h
	var int keySize[3]; //zVEC3 // sizeof 0Ch offset 4E4h
	var int actSize[3]; //zVEC3 // sizeof 0Ch offset 4F0h
	var int castEndSize[3]; //zVEC3 // sizeof 0Ch offset 4FCh
	var int nextLevelTime; //float // sizeof 04h offset 508h
	var int easeTime; //float // sizeof 04h offset 50Ch
	var int age; //float // sizeof 04h offset 510h
	var int trjUpdateTime; //float // sizeof 04h offset 514h
	var int emTrjDist; //float // sizeof 04h offset 518h
	var int trjSign; //float // sizeof 04h offset 51Ch
	var int levelTime; //float // sizeof 04h offset 520h
	var int lifeSpanTimer; //float // sizeof 04h offset 524h
	var int damage; //float // sizeof 04h offset 528h
	var int damageType; //int // sizeof 04h offset 52Ch
	var int spellType; //int // sizeof 04h offset 530h
	var int spellTargetTypes; //int // sizeof 04h offset 534h
	var int savePpsValue; //float // sizeof 04h offset 538h
	var int saveVisSizeStart[2]; //zVEC2 // sizeof 08h offset 53Ch
 //const int VFX_MAX_POS_SAMPLES = 10;
 //zVEC3 transRing[VFX_MAX_POS_SAMPLES]; // sizeof 78h offset 544h
	var int transRing0[3];
	var int transRing1[3];
	var int transRing2[3];
	var int transRing3[3];
	var int transRing4[3];
	var int transRing5[3];
	var int transRing6[3];
	var int transRing7[3];
	var int transRing8[3];
	var int transRing9[3];

	var int ringPos; //int // sizeof 04h offset 5BCh
	var int emTrjFollowHitLastCheck; //int // sizeof 04h offset 5C0h
	var int bIsProjectile; //int // sizeof 04h offset 5C4h
};
