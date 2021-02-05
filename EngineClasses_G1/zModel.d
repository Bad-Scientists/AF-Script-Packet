class zCModelAni {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16	8193786

/*
	enum {
		zMDL_ANI_FLAG_VOB_ROT  = 1,
		zMDL_ANI_FLAG_VOB_POS  = 2,
		zMDL_ANI_FLAG_END_SYNC = 4,
		zMDL_ANI_FLAG_FLY      = 8,
		zMDL_ANI_FLAG_IDLE     = 16
	};
*/

	var string aniName;			//	zSTRING
	var string ascName;			//	zSTRING
	var int aniID;
	var string aliasName;			//	zSTRING

	//zCList<zCModelAni> combAniList;
	var int combAniList_data;
	var int combAniList_next;
	
	var int layer;
	var int blendInSpeed;			//	float
	var int blendOutSpeed;			//	float

	//zTBBox3D aniBBox3DObjSpace;
	var int aniBBox3DObjSpace_mins[3];
	var int aniBBox3DObjSpace_maxs[3];
	
	var int collisionVolumeScale;		//	float
	var int nextAni;			//	zCModelAni*
	
	var string nextAniName;			//	zSTRING
	var int aniEvents;			//	zCModelAniEvent*

	var int fpsRate;			//	float
	var int fpsRateSource;			//	float

	var int rootNodeIndex;

	//zCArray<int> nodeIndexList;
	//zCModelNode** nodeList;
	var int nodeList_array;			//	zCModelNode**
	var int nodeList_numAlloc;		//	int
	var int nodeList_numInArray;		//	int

/*
not finished:

	zTMdl_AniSample* aniSampleMatrix;
	float samplePosRangeMin;
	float samplePosScaler;
	group {
	int numFrames         : 16;
	int numNodes          : 16;
	zTMdl_AniType aniType : 6;
	zTMdl_AniDir aniDir   : 2;
	int numAniEvents      : 6;
	};
	group {
	byte flagVobRot      : 1;
	byte flagVobPos      : 1;
	byte flagEndSync     : 1;
	byte flagFly         : 1;
	byte flagIdle        : 1;
	byte flagInPlace     : 1;
	byte flagStaticCycle : 1;
	}
	aniFlags; 
*/
};