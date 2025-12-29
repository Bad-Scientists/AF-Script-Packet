/*
class zCVisual {
	var int _vtbl;
	var int _zCObject_refCtr;
	var int _zCObject_hashIndex;
	var int _zCObject_hashNext;
	var string _zCObject_objectName;

	var int nextLODVisual;	//zCVisual*
	var int prevLODVisual;	//zCVisual*
	var int lodFarDistance;	//zREAL
	var int lodNearFadeOutDistance;	//zREAL
};
*/

//zCVisualAnimate seems to be same as zCVisual
//class zCVisualAnimate : public zCVisual {
//};
class zCVisualAnimate {
	//class zCVisual {
	var int _vtbl; //0

	//class zCObject {
	var int refCtr; //4	int refCtr;
	var int hashIndex; //8	unsigned short hashIndex;
	var int hashNext; //12	zCObject* hashNext;
	var string objectName; //16	zSTRING objectName
	//};

	var int nextLODVisual; //36	zCVisual* nextLODVisual;
	var int prevLODVisual; //40	zCVisual* prevLODVisual;
	var int lodFarDistance; //44	float lodFarDistance;
	var int lodNearFadeOutDistance; //48	float lodNearFadeOutDistance;
	//};

	/*
	class zCArray {
 T *parray;
 int numAlloc;
 int numInArray;
	};
	*/
	//static properties
	//static zCArray<zCVisual*>& s_visualClassList;
	//var int s_visualClassList_array; //52	zCVisual*
	//var int s_visualClassList_numAlloc; //56
	//var int s_visualClassList_numInArray; //60
};

class zTMdl_StartedVobFX {
	var int vob; //zCVob*
	var int vobFXHandle; //float
};

class zCModel {

	//class zCVisualAnimate : public zCVisual {
	//class zCVisual {
	var int _vtbl; //0

	////class zCObject {
	var int refCtr; //4	int refCtr;
	var int hashIndex; //8	unsigned short hashIndex;
	var int hashNext; //12	zCObject* hashNext;
	var string objectName; //16	zSTRING objectName
	////};

	var int nextLODVisual; //36	zCVisual* nextLODVisual;
	var int prevLODVisual; //40	zCVisual* prevLODVisual;
	var int lodFarDistance; //44	float lodFarDistance;
	var int lodNearFadeOutDistance; //48	float lodNearFadeOutDistance;

	/*
	class zCArray {
		T *parray;
		int numAlloc;
		int numInArray;
	};
	*/
	//static properties
	//static zCArray<zCVisual*>& s_visualClassList;
	//var int s_visualClassList_array; //	zCVisual*
	//var int s_visualClassList_numAlloc; //
	//var int s_visualClassList_numInArray; //
	//};
	//};

	/*
	enum {
		zMDL_DYNLIGHT_SCALEPRELIT = 0,
		zMDL_DYNLIGHT_EXACT = 1
	};
	*/

	/*
	enum {
		zMDL_STARTANI_DEFAULT,
		zMDL_STARTANI_ISNEXTANI,
		zMDL_STARTANI_FORCE
	};
	*/

	/*
	struct zTMdl_NodeVobAttachment {
		zCVob* vob;
		zCModelNodeInst* mnode;
	};
	*/

	/*
	struct zTMdl_StartedVobFX {
		zCVob* vob;
		float vobFXHandle;
	};
	*/

	/*
	struct zTAniMeshLibEntry {
		zCModelAniActive* ani;
		zCModelMeshLib* meshLib;
	};
	*/

	/*
	struct zTMeshLibEntry {
		zCModelTexAniState texAniState;
		zCModelMeshLib* meshLib;
	};
	*/

	var int numActiveAnis; //52	int numActiveAnis;
	var int aniChannels[zMDL_MAX_ANIS_PARALLEL];	//56	zCModelAniActive* aniChannels[zMDL_MAX_ANIS_PARALLEL]; //zMDL_MAX_ANIS_PARALLEL = 6
	var int activeAniList; //80	zCModelAniActive* activeAniList;

//--> G2A only
	//zCArray<int> m_listOfVoiceHandles;
	var int m_listOfVoiceHandles_array; //84	zCModelPrototype*
	var int m_listOfVoiceHandles_numAlloc; //88
	var int m_listOfVoiceHandles_numInArray;	//92
//<--

	var int homeVob; //96	zCVob* homeVob;

	//zCArray<zCModelPrototype*> modelProtoList;
	var int modelProtoList_array; //100	zCModelPrototype*
	var int modelProtoList_numAlloc; //104
	var int modelProtoList_numInArray; //108

	//zCArray<zCModelNodeInst*> nodeList;
	var int nodeList_array; //112	zCModelNodeInst*
	var int nodeList_numAlloc; //116
	var int nodeList_numInArray; //120

	//zCArray<zCMeshSoftSkin*> meshSoftSkinList;
	var int meshSoftSkinList_array; //124	zCMeshSoftSkin*
	var int meshSoftSkinList_numAlloc; //128
	var int meshSoftSkinList_numInArray; //132

	//zCArraySort<zTAniAttachment*> aniAttachList;
	var int aniAttachList_array; //136	zTAniAttachment*
	var int aniAttachList_numAlloc; //140
	var int aniAttachList_numInArray; //144
	var int aniAttachList_compare; //148	int (*Compare)(const T* ele1,const T* ele2);

//-->	NOT SURE IF THIS CONVERSION TO PRIMITIVE TYPES IS CORRECT :-/

	//zCArray<zTMdl_NodeVobAttachment>attachedVobList;
	/*
	struct zTMdl_NodeVobAttachment {
		zCVob* vob;
		zCModelNodeInst* mnode;
	};
	*/
	var int attachedVobList_array; //152	zTMdl_NodeVobAttachment
	var int attachedVobList_numAlloc; //156
	var int attachedVobList_numInArray; //160

	//zCArray<zTMdl_StartedVobFX> startedVobFX;
	/*
	struct zTMdl_StartedVobFX {
		zCVob* vob;
		float vobFXHandle;
	};
	*/
	var int startedVobFX_array; //164	zTMdl_StartedVobFX
	var int startedVobFX_numAlloc; //168
	var int startedVobFX_numInArray; //172

	//zCArray<zTAniMeshLibEntry> aniMeshLibList;
	/*
	struct zTAniMeshLibEntry {
		zCModelAniActive* ani;
		zCModelMeshLib* meshLib;
	};
	*/
	var int aniMeshLibList_array; //176	zTAniMeshLibEntry
	var int aniMeshLibList_numAlloc; //180
	var int aniMeshLibList_numInArray; //184

//<--

	//zCArray<zTMeshLibEntry*> meshLibList;
	var int meshLibList_array; //188	zTMeshLibEntry*
	var int meshLibList_numAlloc; //192
	var int meshLibList_numInArray; //196

	var int lastTimeBBox3DTreeUpdate; //200	int lastTimeBBox3DTreeUpdate;

	//zCArray<zCModelAniEvent*> occuredAniEvents;
	var int occuredAniEvents_array; //204	zCModelAniEvent**
	var int occuredAniEvents_numAlloc; //208
	var int occuredAniEvents_numInArray; //212

	/*
	struct zTBBox3D {
		zVEC3 mins;
		zVEC3 maxs;
	};
	*/
	//zTBBox3D bbox3D;
	var int bbox3D_mins[3]; //216
	var int bbox3D_maxs[3]; //228

	//zTBBox3D bbox3DLocalFixed;
	var int bbox3DLocalFixed_mins[3]; //240
	var int bbox3DLocalFixed_maxs[3]; //252

	//zTBBox3D bbox3DCollDet;
	var int bbox3DCollDet_mins[3]; //264
	var int bbox3DCollDet_maxs[3]; //276

	var int modelDistanceToCam; //288	float modelDistanceToCam;

//--> G2A only
	var int n_bIsInMobInteraction; //292	int n_bIsInMobInteraction;
//<--

	var int fatness; //296	float fatness;

	/*
	class zVEC3 {
		float n[3];
	};
	*/
	var int modelScale[3]; //300	zVEC3 modelScale;
	var int aniTransScale[3]; //312	zVEC3 aniTransScale;
	var int rootPosLocal[3]; //324	zVEC3 rootPosLocal;
	var int vobTrans[3]; //336	zVEC3 vobTrans;

//--> G2A only
	var int vobTransRing[3]; //348	zVEC3 vobTransRing;

	var int newAniStarted; //360	int newAniStarted;
	var int m_bSmoothRootNode; //364	int m_bSmoothRootNode;
	var int relaxWeight; //368	float relaxWeight;
	var int m_bDrawHandVisualsOnly; //372	int m_bDrawHandVisualsOnly;
//<--

	/*
	class zCQuat {
		float q[4];
	};
	*/
	var int vobRot[4]; //376	zCQuat vobRot;

	var int modelVelocity[3]; //392	zVEC3 modelVelocity;
	var int actVelRingPos; //404	int actVelRingPos;

	//zVEC3 modelVelRing[zMDL_VELRING_SIZE];	//	zMDL_VELRING_SIZE = 8
	var int modelVelRing_0[8]; //408
	var int modelVelRing_1[8]; //440
	var int modelVelRing_2[8]; //472

	var int zCModel_bitfield; //504
	/*
	group {
	unsigned char isVisible : 1;
	unsigned char isFlying : 1;
	unsigned char randAnisEnabled : 1;
	unsigned char lerpSamples : 1;
	unsigned char modelScaleOn : 1;
	unsigned char doVobRot : 1;
	unsigned char nodeShadowEnabled : 1;
	unsigned char dynLightMode : 1;
	};
	*/

	var int timeScale; //508	float timeScale;
	var int aniHistoryListl; //512	zCModelAni** aniHistoryList;
};

// sizeof C0h
class zCModelNode {
	var int parentNode; //zCModelNode* // sizeof 04h offset 00h
	var string nodeName; //zSTRING // sizeof 14h offset 04h
	var int visual; //zCVisual* // sizeof 04h offset 18h
	var int trafo[16]; //zMAT4 // sizeof 40h offset 1Ch
	var int nodeRotAxis[3]; //zVEC3 // sizeof 0Ch offset 5Ch
	var int nodeRotAngle; //float // sizeof 04h offset 68h
	var int translation[3]; //zVEC3 // sizeof 0Ch offset 6Ch
	var int trafoObjToWorld[16]; //zMAT4 // sizeof 40h offset 78h
	var int nodeTrafoList; //zMAT4* // sizeof 04h offset B8h
	var int lastInstNode; //zCModelNodeInst* // sizeof 04h offset BCh
};

// sizeof 198h
class zCModelNodeInst {
	/*
	enum {
		zMDL_BLEND_STATE_FADEIN,
		zMDL_BLEND_STATE_CONST,
		zMDL_BLEND_STATE_FADEOUT
	};
	*/

	// sizeof 20h
	/*
	struct zTNodeAni {
		zCModelAniActive* modelAni; // sizeof 04h offset 00h
		float weight; // sizeof 04h offset 04h
		float weightSpeed; // sizeof 04h offset 08h
		int blendState; // sizeof 04h offset 0Ch
		zCQuat quat; // sizeof 10h offset 10h
	};
	*/

	var int parentNode; //0 zCModelNodeInst* // sizeof 04h offset 00h
	var int protoNode; //4 zCModelNode* // sizeof 04h offset 04h
	var int nodeVisual; //8 zCVisual* // sizeof 04h offset 08h
	var int trafo[16]; //12 zMAT4 // sizeof 40h offset 0Ch
	var int trafoObjToCam[16]; //76 zMAT4 // sizeof 40h offset 4Ch

	/*
	struct zTBBox3D {
		zVEC3 mins;
		zVEC3 maxs;
	};
	*/
	//zTBBox3D bbox3D; // sizeof 18h offset 8Ch
	var int bbox3D_mins[3]; //140
	var int bbox3D_maxs[3]; //152

	// sizeof 28h
	/*
	class zCModelTexAniState {
		enum {
			zMDL_MAX_ANI_CHANNELS = 2,
			zMDL_MAX_TEX = 4
		};

		int numNodeTex; // sizeof 04h offset 00h
		zCTexture** nodeTexList; // sizeof 04h offset 04h
		int actAniFrames[zMDL_MAX_ANI_CHANNELS][zMDL_MAX_TEX]; // sizeof 20h offset 08h
	};
	*/

	//zCModelTexAniState texAniState; // sizeof 28h offset A4h
	var int texAniState_numNodeTex; //164 int // sizeof 04h offset 00h
	var int texAniState_nodeTexList; //168 zCTexture** // sizeof 04h offset 04h
	//int actAniFrames[zMDL_MAX_ANI_CHANNELS][zMDL_MAX_TEX]; // sizeof 20h offset 08h
	var int texAniState_actAniFrames_0[zMDL_MAX_TEX]; //172
	var int texAniState_actAniFrames_1[zMDL_MAX_TEX]; //188

	// sizeof 20h
	/*
	struct zTNodeAni {
		zCModelAniActive* modelAni; // sizeof 04h offset 00h
		float weight; // sizeof 04h offset 04h
		float weightSpeed; // sizeof 04h offset 08h
		int blendState; // sizeof 04h offset 0Ch
		zCQuat quat; // sizeof 10h offset 10h
	};
	*/

 //zTNodeAni nodeAniList[zMDL_MAX_ANIS_PARALLEL]; // sizeof C0h offset CCh
	var int nodeAniList_0_modelAni;
	var int nodeAniList_0_weight;
	var int nodeAniList_0_weightSpeed;
	var int nodeAniList_0_blendState;
	var int nodeAniList_0_quat[4];

	var int nodeAniList_1_modelAni;
	var int nodeAniList_1_weight;
	var int nodeAniList_1_weightSpeed;
	var int nodeAniList_1_blendState;
	var int nodeAniList_1_quat[4];

	var int nodeAniList_2_modelAni;
	var int nodeAniList_2_weight;
	var int nodeAniList_2_weightSpeed;
	var int nodeAniList_2_blendState;
	var int nodeAniList_2_quat[4];

	var int nodeAniList_3_modelAni;
	var int nodeAniList_3_weight;
	var int nodeAniList_3_weightSpeed;
	var int nodeAniList_3_blendState;
	var int nodeAniList_3_quat[4];

	var int nodeAniList_4_modelAni;
	var int nodeAniList_4_weight;
	var int nodeAniList_4_weightSpeed;
	var int nodeAniList_4_blendState;
	var int nodeAniList_4_quat[4];

	var int nodeAniList_5_modelAni;
	var int nodeAniList_5_weight;
	var int nodeAniList_5_weightSpeed;
	var int nodeAniList_5_blendState;
	var int nodeAniList_5_quat[4];

	var int numNodeAnis; //396 int // sizeof 04h offset 18Ch
	var int masterAni; //400 int // sizeof 04h offset 190h
	var int masterAniSpeed; //404 float // sizeof 04h offset 194h
};

//class zCDecal : public zCVisual {
//};
class zCDecal {
	var int _vtbl; //0

	//class zCObject {
	var int refCtr; //4	int refCtr;
	var int hashIndex; //8	unsigned short hashIndex;
	var int hashNext; //12	zCObject* hashNext;
	var string objectName; //16	zSTRING objectName
	//};

	var int nextLODVisual; //36	zCVisual* nextLODVisual;
	var int prevLODVisual; //40	zCVisual* prevLODVisual;
	var int lodFarDistance; //44	float lodFarDistance;
	var int lodNearFadeOutDistance; //48	float lodNearFadeOutDistance;

	var int decalMaterial; //52	zCMaterial* decalMaterial;
	var int xdim; //56	float xdim;
	var int ydim; //60	float ydim;
	var int xoffset; //64	float xoffset;
	var int yoffset; //68	float yoffset;
	var int decal2Sided; //72	int decal2Sided;

	var int ignoreDayLight; //76	int ignoreDayLight;
	var int m_bOnTop; //80	int m_bOnTop;

	//static properties
	//static zCMesh*& decalMesh1Sided;
	//static zCMesh*& decalMesh2Sided;
};

// sizeof 1Ch
class zCParticleEmitterVars {
	var int ppsScaleKeysActFrame; //float ppsScaleKeysActFrame; // sizeof 04h offset 00h
	var int ppsNumParticlesFraction; //float ppsNumParticlesFraction; // sizeof 04h offset 04h
	var int ppsTotalLifeTime; //float ppsTotalLifeTime; // sizeof 04h offset 08h
	var int ppsDependentEmitterCreated; //int ppsDependentEmitterCreated; // sizeof 04h offset 0Ch
	var int shpScaleKeysActFrame; //float shpScaleKeysActFrame; // sizeof 04h offset 10h
	var int uniformValue; //float uniformValue; // sizeof 04h offset 14h
	var int uniformDelta; //float uniformDelta; // sizeof 04h offset 18h
};

const int bitfield_zCParticleFX_emitterIsOwned = 1;
const int bitfield_zCParticleFX_dontKillPFXWhenDone = 2;
const int bitfield_zCParticleFX_dead = 4;
const int bitfield_zCParticleFX_isOneShotFX = 8;
const int bitfield_zCParticleFX_forceEveryFrameUpdate = 16;
//G2A only
const int bitfield_zCParticleFX_renderUnderWaterOnly = 32;

// sizeof B8h
class zCParticleFX {
//class zCParticleFX : public zCVisual {
//class zCVisual {
//class zCVisual : public zCObject {

	var int _vtbl; //0
	var int _zCObject_refCtr; //4
	var int _zCObject_hashIndex; //8
	var int _zCObject_hashNext; //12
	var string _zCObject_objectName; //16
//};

	var int nextLODVisual;	//36 zCVisual*
	var int prevLODVisual;	//40 zCVisual*
	var int lodFarDistance;	//44 zREAL
	var int lodNearFadeOutDistance;	//48 zREAL
//};

	//zCParticleFX

/*
	// sizeof 0Ch
	class zCStaticPfxList {
	public:
		zCParticleFX* pfxListHead; // sizeof 04h offset 00h
		zCParticleFX* pfxListTail; // sizeof 04h offset 04h
		int numInList; // sizeof 04h offset 08h

		zCStaticPfxList() {}
		void InsertPfxHead( zCParticleFX* ) zCall( 0x005AD280 );
		void RemovePfx( zCParticleFX* ) zCall( 0x005AD2C0 );
		void TouchPfx( zCParticleFX* ) zCall( 0x005AD330 );
		void ProcessList() zCall( 0x005AD3F0 );
		int IsInList( zCParticleFX* ) zCall( 0x005ADB70 );

		// user API
		#include "zCParticleFX_zCStaticPfxList.inl"
	};
*/

	var int firstPart; //zTParticle* // sizeof 04h offset 34h

	//zCParticleEmitterVars emitterVars; // sizeof 1Ch offset 38h
	var int emitterVars_ppsScaleKeysActFrame; //float ppsScaleKeysActFrame; // sizeof 04h offset 00h
	var int emitterVars_ppsNumParticlesFraction; //float ppsNumParticlesFraction; // sizeof 04h offset 04h
	var int emitterVars_ppsTotalLifeTime; //float ppsTotalLifeTime; // sizeof 04h offset 08h
	var int emitterVars_ppsDependentEmitterCreated; //int ppsDependentEmitterCreated; // sizeof 04h offset 0Ch
	var int emitterVars_shpScaleKeysActFrame; //float shpScaleKeysActFrame; // sizeof 04h offset 10h
	var int emitterVars_uniformValue; //float uniformValue; // sizeof 04h offset 14h
	var int emitterVars_uniformDelta; //float uniformDelta; // sizeof 04h offset 18h

	var int emitter; //zCParticleEmitter* // sizeof 04h offset 54h
	var int bbox3DWorld[6]; //zTBBox3D // sizeof 18h offset 58h
	var int connectedVob; //zCVob* // sizeof 04h offset 70h
	var int bboxUpdateCtr; //int // sizeof 04h offset 74h

	var int bitfield;
	/*
	group {
		unsigned char emitterIsOwned : 1; // sizeof 01h offset bit
		unsigned char dontKillPFXWhenDone : 1; // sizeof 01h offset bit
		unsigned char dead : 1; // sizeof 01h offset bit
		unsigned char isOneShotFX : 1; // sizeof 01h offset bit
		unsigned char forceEveryFrameUpdate : 1; // sizeof 01h offset bit
		unsigned char renderUnderWaterOnly : 1; // sizeof 01h offset bit
	};
	*/
	var int nextPfx; //zCParticleFX* // sizeof 04h offset 7Ch
	var int prevPfx; //zCParticleFX* // sizeof 04h offset 80h
	var int privateTotalTime; //float // sizeof 04h offset 84h
	var int lastTimeRendered; //float // sizeof 04h offset 88h
	var int timeScale; //float // sizeof 04h offset 8Ch
	var int localFrameTimeF; //float // sizeof 04h offset 90h
	var int quadMark; //zCQuadMark* // sizeof 04h offset 94h
	var int quadMarkBBox3DWorld[6]; //zTBBox3D // sizeof 18h offset 98h
	var int m_BboxYRangeInv; //float // sizeof 04h offset B0h
	var int m_bVisualNeverDies; //int // sizeof 04h offset B4h
};
