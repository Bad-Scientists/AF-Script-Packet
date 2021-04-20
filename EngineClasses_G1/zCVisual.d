//007D4054  .rdata    Debug data           ??_7zCVisualAnimate@@6B@
//007DB4D4  .rdata    Debug data           ??_7zCVisual@@6B@

//zCVisualAnimate seems to be same as zCVisual
//class zCVisualAnimate : public zCVisual {
//};
class zCVisualAnimate {
	var int _vtbl;					//0

	//class zCObject {
	var int refCtr;					//4	int refCtr;
	var int hashIndex;				//8	unsigned short hashIndex;
	var int hashNext;				//12	zCObject* hashNext;
	var string objectName;				//16	zSTRING objectName 
	//};

	var int nextLODVisual;				//36	zCVisual* nextLODVisual;
	var int prevLODVisual;				//40	zCVisual* prevLODVisual;
	var int lodFarDistance;				//44	float lodFarDistance;
	var int lodNearFadeOutDistance;			//48	float lodNearFadeOutDistance;

	/*
	class zCArray {
		T *parray;
		int numAlloc;
		int numInArray; 
	};
	*/
	//static properties
	//static zCArray<zCVisual*>& s_visualClassList; 
	//var int s_visualClassList_array;		//52	zCVisual*
	//var int s_visualClassList_numAlloc;		//56
	//var int s_visualClassList_numInArray;		//60
};

class zCModel {

	//class zCVisual {
	var int _vtbl;					//0

	////class zCObject {
	var int refCtr;					//4	int refCtr;
	var int hashIndex;				//8	unsigned short hashIndex;
	var int hashNext;				//12	zCObject* hashNext;
	var string objectName;				//16	zSTRING objectName 
	////};

	var int nextLODVisual;				//36	zCVisual* nextLODVisual;
	var int prevLODVisual;				//40	zCVisual* prevLODVisual;
	var int lodFarDistance;				//44	float lodFarDistance;
	var int lodNearFadeOutDistance;			//48	float lodNearFadeOutDistance;

	/*
	class zCArray {
		T *parray;
		int numAlloc;
		int numInArray; 
	};
	*/
	//static properties
	//static zCArray<zCVisual*>& s_visualClassList; 
	//var int s_visualClassList_array;		//	zCVisual*
	//var int s_visualClassList_numAlloc;		//
	//var int s_visualClassList_numInArray;		//
	//};

	//class zCVisualAnimate : public zCVisual {
	//}; 

	/*
	enum {
	zMDL_DYNLIGHT_SCALEPRELIT = 0,
	zMDL_DYNLIGHT_EXACT       = 1
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

	var int numActiveAnis;				//52	int numActiveAnis;
	var int aniChannels[zMDL_MAX_ANIS_PARALLEL];	//56	zCModelAniActive* aniChannels[zMDL_MAX_ANIS_PARALLEL]; //zMDL_MAX_ANIS_PARALLEL = 6
	var int activeAniList;				//80	zCModelAniActive* activeAniList;
	var int homeVob;				//84	zCVob* homeVob;

	//zCArray<zCModelPrototype*> modelProtoList;
	var int modelProtoList_array;			//88	zCModelPrototype*
	var int modelProtoList_numAlloc;		//92
	var int modelProtoList_numInArray;		//96

	//zCArray<zCModelNodeInst*> nodeList;
	var int nodeList_array;				//100	zCModelNodeInst*
	var int nodeList_numAlloc;			//104
	var int nodeList_numInArray;			//108

	//zCArray<zCMeshSoftSkin*> meshSoftSkinList;
	var int meshSoftSkinList_array;			//112	zCMeshSoftSkin*
	var int meshSoftSkinList_numAlloc;		//116
	var int meshSoftSkinList_numInArray;		//120

	//zCArraySort<zTAniAttachment*> aniAttachList;
	var int aniAttachList_array;			//124	zTAniAttachment*
	var int aniAttachList_numAlloc;			//128
	var int aniAttachList_numInArray;		//132
	var int aniAttachList_compare;			//136	int (*Compare)(const T* ele1,const T* ele2);

//-->	NOT SURE IF THIS CONVERSION TO PRIMITIVE TYPES IS CORRECT :-/

	//zCArray<zTMdl_NodeVobAttachment>attachedVobList;
	/*
	struct zTMdl_NodeVobAttachment {
		zCVob* vob;
		zCModelNodeInst* mnode;
	};
	*/
	var int attachedVobList_array;			//140	zTMdl_NodeVobAttachment
	var int attachedVobList_numAlloc;		//144
	var int attachedVobList_numInArray;		//148

	//zCArray<zTMdl_StartedVobFX> startedVobFX;
	/*
	struct zTMdl_StartedVobFX {
		zCVob* vob;
		float vobFXHandle;
	};
	*/
	var int startedVobFX_array;			//152	zTMdl_StartedVobFX
	var int startedVobFX_numAlloc;			//156
	var int startedVobFX_numInArray;		//160

	//zCArray<zTAniMeshLibEntry> aniMeshLibList;
	/*
	struct zTAniMeshLibEntry {
		zCModelAniActive* ani;
		zCModelMeshLib* meshLib;
	};
	*/
	var int aniMeshLibList_array;			//164	zTAniMeshLibEntry
	var int aniMeshLibList_numAlloc;		//168
	var int aniMeshLibList_numInArray;		//172

//<--

	//zCArray<zTMeshLibEntry*> meshLibList;
	var int meshLibList_array;			//176	zTMeshLibEntry*
	var int meshLibList_numAlloc;			//180
	var int meshLibList_numInArray;			//184

	var int lastTimeBBox3DTreeUpdate;		//188	int lastTimeBBox3DTreeUpdate;

	//zCArray<zCModelAniEvent*> occuredAniEvents;
	var int occuredAniEvents_array;			//192	zCModelAniEvent**
	var int occuredAniEvents_numAlloc;		//196
	var int occuredAniEvents_numInArray;		//200

	/*
	struct zTBBox3D {
		zVEC3 mins;
		zVEC3 maxs;
	};
	*/
	//zTBBox3D bbox3D;
	var int bbox3D_mins[3];				//204
	var int bbox3D_maxs[3];				//216

	//zTBBox3D bbox3DLocalFixed;
	var int bbox3DLocalFixed_mins[3];		//228
	var int bbox3DLocalFixed_maxs[3];		//240

	//zTBBox3D bbox3DCollDet;
	var int bbox3DCollDet_mins[3];			//252
	var int bbox3DCollDet_maxs[3];			//264

	var int modelDistanceToCam;			//276	float modelDistanceToCam;
	var int fatness;				//280	float fatness;

	/*
	class zVEC3 {
		float n[3]; 
	};
	*/
	var int modelScale[3];				//284	zVEC3 modelScale;
	var int aniTransScale[3];			//296	zVEC3 aniTransScale;
	var int rootPosLocal[3];			//308	zVEC3 rootPosLocal;
	var int vobTrans[3];				//320	zVEC3 vobTrans;

	/*
	class zCQuat {
		float q[4];
	};
	*/
	var int vobRot[4];				//332	zCQuat vobRot;

	var int modelVelocity[3];			//348	zVEC3 modelVelocity;
	var int actVelRingPos;				//360	int actVelRingPos;

	//zVEC3 modelVelRing[zMDL_VELRING_SIZE];	//	zMDL_VELRING_SIZE = 8
	var int modelVelRing_0[8];			//364
	var int modelVelRing_1[8];			//396
	var int modelVelRing_2[8];			//428

	var int zCModel_bitfield;			//460
	/*
	group {
	unsigned char isVisible         : 1;
	unsigned char isFlying          : 1;
	unsigned char randAnisEnabled   : 1;
	unsigned char lerpSamples       : 1;
	unsigned char modelScaleOn      : 1;
	unsigned char doVobRot          : 1;
	unsigned char nodeShadowEnabled : 1;
	unsigned char dynLightMode      : 1;
	};
	*/
	
	var int timeScale;				//464	float timeScale;
	var int aniHistoryListl;			//468	zCModelAni** aniHistoryList;
};
