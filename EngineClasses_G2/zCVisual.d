/*
class zCVisual {
    var int    _vtbl;
    var int    _zCObject_refCtr;
    var int    _zCObject_hashIndex;
    var int    _zCObject_hashNext;
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
	//var int s_visualClassList_array;		//52	zCVisual*
	//var int s_visualClassList_numAlloc;		//56
	//var int s_visualClassList_numInArray;		//60
};

class zCModel {

	//class zCVisualAnimate : public zCVisual {
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

//--> G2A only
	//zCArray<int> m_listOfVoiceHandles;
	var int m_listOfVoiceHandles_array;		//84	zCModelPrototype*
	var int m_listOfVoiceHandles_numAlloc;		//88
	var int m_listOfVoiceHandles_numInArray;	//92
//<--

	var int homeVob;				//96	zCVob* homeVob;

	//zCArray<zCModelPrototype*> modelProtoList;
	var int modelProtoList_array;			//100	zCModelPrototype*
	var int modelProtoList_numAlloc;		//104
	var int modelProtoList_numInArray;		//108

	//zCArray<zCModelNodeInst*> nodeList;
	var int nodeList_array;				//112	zCModelNodeInst*
	var int nodeList_numAlloc;			//116
	var int nodeList_numInArray;			//120

	//zCArray<zCMeshSoftSkin*> meshSoftSkinList;
	var int meshSoftSkinList_array;			//124	zCMeshSoftSkin*
	var int meshSoftSkinList_numAlloc;		//128
	var int meshSoftSkinList_numInArray;		//132

	//zCArraySort<zTAniAttachment*> aniAttachList;
	var int aniAttachList_array;			//136	zTAniAttachment*
	var int aniAttachList_numAlloc;			//140
	var int aniAttachList_numInArray;		//144
	var int aniAttachList_compare;			//148	int (*Compare)(const T* ele1,const T* ele2);

//-->	NOT SURE IF THIS CONVERSION TO PRIMITIVE TYPES IS CORRECT :-/

	//zCArray<zTMdl_NodeVobAttachment>attachedVobList;
	/*
	struct zTMdl_NodeVobAttachment {
		zCVob* vob;
		zCModelNodeInst* mnode;
	};
	*/
	var int attachedVobList_array;			//152	zTMdl_NodeVobAttachment
	var int attachedVobList_numAlloc;		//156
	var int attachedVobList_numInArray;		//160

	//zCArray<zTMdl_StartedVobFX> startedVobFX;
	/*
	struct zTMdl_StartedVobFX {
		zCVob* vob;
		float vobFXHandle;
	};
	*/
	var int startedVobFX_array;			//164	zTMdl_StartedVobFX
	var int startedVobFX_numAlloc;			//168
	var int startedVobFX_numInArray;		//172

	//zCArray<zTAniMeshLibEntry> aniMeshLibList;
	/*
	struct zTAniMeshLibEntry {
		zCModelAniActive* ani;
		zCModelMeshLib* meshLib;
	};
	*/
	var int aniMeshLibList_array;			//176	zTAniMeshLibEntry
	var int aniMeshLibList_numAlloc;		//180
	var int aniMeshLibList_numInArray;		//184

//<--

	//zCArray<zTMeshLibEntry*> meshLibList;
	var int meshLibList_array;			//188	zTMeshLibEntry*
	var int meshLibList_numAlloc;			//192
	var int meshLibList_numInArray;			//196

	var int lastTimeBBox3DTreeUpdate;		//200	int lastTimeBBox3DTreeUpdate;

	//zCArray<zCModelAniEvent*> occuredAniEvents;
	var int occuredAniEvents_array;			//204	zCModelAniEvent**
	var int occuredAniEvents_numAlloc;		//208
	var int occuredAniEvents_numInArray;		//212

	/*
	struct zTBBox3D {
		zVEC3 mins;
		zVEC3 maxs;
	};
	*/
	//zTBBox3D bbox3D;
	var int bbox3D_mins[3];				//216
	var int bbox3D_maxs[3];				//228

	//zTBBox3D bbox3DLocalFixed;
	var int bbox3DLocalFixed_mins[3];		//240
	var int bbox3DLocalFixed_maxs[3];		//252

	//zTBBox3D bbox3DCollDet;
	var int bbox3DCollDet_mins[3];			//264
	var int bbox3DCollDet_maxs[3];			//276

	var int modelDistanceToCam;			//288	float modelDistanceToCam;

//--> G2A only
	var int n_bIsInMobInteraction;			//292	int n_bIsInMobInteraction;
//<--

	var int fatness;				//296	float fatness;

	/*
	class zVEC3 {
		float n[3]; 
	};
	*/
	var int modelScale[3];				//300	zVEC3 modelScale;
	var int aniTransScale[3];			//312	zVEC3 aniTransScale;
	var int rootPosLocal[3];			//324	zVEC3 rootPosLocal;
	var int vobTrans[3];				//336	zVEC3 vobTrans;

//--> G2A only
	var int vobTransRing[3];			//348	zVEC3 vobTransRing;

	var int newAniStarted;				//360	int newAniStarted;
	var int m_bSmoothRootNode;			//364	int m_bSmoothRootNode;
	var int relaxWeight;				//368	float relaxWeight;
	var int m_bDrawHandVisualsOnly;			//372	int m_bDrawHandVisualsOnly;
//<--

	/*
	class zCQuat {
		float q[4];
	};
	*/
	var int vobRot[4];				//376	zCQuat vobRot;

	var int modelVelocity[3];			//392	zVEC3 modelVelocity;
	var int actVelRingPos;				//404	int actVelRingPos;

	//zVEC3 modelVelRing[zMDL_VELRING_SIZE];	//	zMDL_VELRING_SIZE = 8
	var int modelVelRing_0[8];			//408
	var int modelVelRing_1[8];			//440
	var int modelVelRing_2[8];			//472

	var int zCModel_bitfield;			//504
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
	
	var int timeScale;				//508	float timeScale;
	var int aniHistoryListl;			//512	zCModelAni** aniHistoryList;
};

//class zCDecal : public zCVisual {
//};
class zCDecal {
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

	var int decalMaterial;				//52	zCMaterial* decalMaterial;
	var int xdim;					//56	float xdim;
	var int ydim;					//60	float ydim;
	var int xoffset;				//64	float xoffset;
	var int yoffset;				//68	float yoffset;
	var int decal2Sided;				//72	int decal2Sided;

	var int ignoreDayLight;				//76	int ignoreDayLight;
	var int m_bOnTop;				//80	int m_bOnTop;
    
	// static properties
	//static zCMesh*& decalMesh1Sided;
	//static zCMesh*& decalMesh2Sided;
};
