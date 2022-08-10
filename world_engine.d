func string oCWorld_GetWorldFilename () {
	//0x0063B680 public: class zSTRING __thiscall oCWorld::GetWorldFilename(void)
	const int oCWorld__GetWorldFilename_G1 = 6534784;

	//0x0068DE60 public: class zSTRING __thiscall oCWorld::GetWorldFilename(void)
	const int oCWorld__GetWorldFilename_G2 = 6872672;

	CALL_RetValIszString ();
	CALL__thiscall (_@(MEM_World), MEMINT_SwitchG1G2 (oCWorld__GetWorldFilename_G1, oCWorld__GetWorldFilename_G2));
	return CALL_RetValAszstring ();
};

func void zCWorld_RemoveVob (var int vobPtr) {
	//0x006D6EF0 public: virtual void __thiscall oCWorld::RemoveVob(class zCVob *)
	const int oCWorld__RemoveVob_G1 = 7171824;

	//0x007800C0 public: virtual void __thiscall oCWorld::RemoveVob(class zCVob *)
	const int oCWorld__RemoveVob_G2 = 7864512;

	if (!vobPtr) { return; };

	var int worldPtr;
	//worldPtr = _@ (MEM_World);
	worldPtr = MEM_Game._zCSession_world;

	CALL_PtrParam (vobPtr);
	CALL__thiscall (worldPtr, MEMINT_SwitchG1G2 (oCWorld__RemoveVob_G1, oCWorld__RemoveVob_G2));
};

/*
 *	Author: Mud-freak
 */
func int oCWorld_AddVobAsChild (var int vobPtr, var int parentPtr) {
	//0x006D6CA0 public: virtual class zCTree<class zCVob> * __thiscall oCWorld::AddVobAsChild(class zCVob *,class zCTree<class zCVob> *)
	//const int oCWorld__AddVobAsChild_G1 = 7171232;

	//0x0077FE30 public: virtual class zCTree<class zCVob> * __thiscall oCWorld::AddVobAsChild(class zCVob *,class zCTree<class zCVob> *)
	//const int oCWorld__AddVobAsChild_G2 = 7863856;

	if (!vobPtr) {
		return 0;
	};

	// Adjust bits
	var zCVob vob; vob = _^(vobPtr);
//	vob.bitfield[0] = vob.bitfield[0] & (-67108865); //0xFBFFFFFF
//	vob.bitfield[0] = vob.bitfield[0] & ~zCVob_bitfield0_collDetectionStatic & ~zCVob_bitfield0_collDetectionDynamic;

	// Get parent vob tree
	var int vobTreePtr;
	if (parentPtr) {
		var zCVob parent; parent = _^(parentPtr);
		vobTreePtr = parent.globalVobTreeNode;
	} else {
		vobTreePtr = _@(MEM_Vobtree); // Global vob tree
	};

	// Insert into world
	const int oCWorld__AddVobAsChild_G1 = 7171232; //0x6D6CA0
	const int oCWorld__AddVobAsChild_G2 = 7863856; //0x77FE30

	var int worldPtr; worldPtr = MEM_Game._zCSession_world;
	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(vobTreePtr));
		CALL_PtrParam(_@(vobPtr));

		CALL_PutRetValTo(0);

		CALL__thiscall(_@(worldPtr), MEMINT_SwitchG1G2(oCWorld__AddVobAsChild_G1, oCWorld__AddVobAsChild_G2));
		call = CALL_End();
	};

	//return vobPtr;

	// Set bits
	//vob.bitfield[0] = vob.bitfield[0] | zCVob_bitfield0_collDetectionStatic | zCVob_bitfield0_collDetectionDynamic;
	//vob.bitfield[2] = vob.bitfield[2] & ~zCVob_bitfield2_sleepingMode; // zCVob::SetSleeping(vobPtr, 1);

	// Decrease reference counter... why is that necessary?
	vob._zCObject_refCtr -= 1;
	if (vob._zCObject_refCtr <= 0) {
		const int _scalar_deleting_destructor_offset = 12; // Same for G1 and G2
		CALL_IntParam(1);
		CALL__thiscall(vobPtr, MEM_ReadInt(vob._vtbl+_scalar_deleting_destructor_offset));
	};

	return vobPtr;
};

/*
 *	zCWorld_TraceRayFirstHit
 */
func int zCWorld_TraceRayFirstHit (var int posPtr, var int dirPtr, var int ignoreListPtr, var int flags) {
	//0x005F40C0 public: int __fastcall zCWorld::TraceRayFirstHit(class zVEC3 const &,class zVEC3 const &,class zCArray<class zCVob *> const *,int)
	const int zCWorld__TraceRayFirstHit_G1 = 6242496;

	//0x00621960 public: int __fastcall zCWorld::TraceRayFirstHit(class zVEC3 const &,class zVEC3 const &,class zCArray<class zCVob *> const *,int)
	const int zCWorld__TraceRayFirstHit_G2 = 6429024;

	var int worldPtr; worldPtr = MEM_Game._zCSession_world;

	if (!posPtr) { return 0; };
	if (!dirPtr) { return 0; };
	if (!worldPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam(_@(flags));
		CALL_PtrParam(_@(ignoreListPtr));
		CALL_PtrParam(_@(dirPtr));

		CALL_PutRetValTo (_@ (retVal));

		CALL__fastcall(_@(worldPtr), _@(posPtr), MEMINT_SwitchG1G2(zCWorld__TraceRayFirstHit_G1, zCWorld__TraceRayFirstHit_G2));
		call = CALL_End();
	};

	return + retVal;
};

//0x0051EBE0 protected: void __fastcall zCBspBase::CollectVobsInBBox3D_I(class zCArray<class zCVob *> &,struct zTBBox3D const &)const

/*
 *	Wld_CollectVobsInBBox3D
 */
func int Wld_CollectVobsInBBox3D (var int posPtr, var int bboxPtr) {
	//0x0051E7C0 public: void __fastcall zCBspBase::CollectVobsInBBox3D(class zCArray<class zCVob *> &,struct zTBBox3D const &)const
	const int zCBspBase__CollectVobsInBBox3D_G1 = 5367744;

	//0x00531110 public: void __fastcall zCBspBase::CollectVobsInBBox3D(class zCArray<class zCVob *> &,struct zTBBox3D const &)const
	const int zCBspBase__CollectVobsInBBox3D_G2 = 5443856;

	var int bspRoot; bspRoot = MEM_World.bspTree_bspRoot;
	if (!bspRoot) { return 0; };

	//Create array
	var int arrPtr; arrPtr = MEM_ArrayCreate ();

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (bboxPtr));
		CALL__fastcall (_@ (bspRoot), _@ (arrPtr), MEMINT_SwitchG1G2 (zCBspBase__CollectVobsInBBox3D_G1, zCBspBase__CollectVobsInBBox3D_G2));
		call = CALL_End();
	};

	return + arrPtr;
};

/*
 *	Wld_CollectVobsInRange
 */
func int Wld_CollectVobsInRange (var int posPtr, var int rangeF) {
	var int bbox[6]; //zTBBox3D

	if (!posPtr) { return 0; };

	MEM_CopyBytes (posPtr, _@ (bbox), 12);
	MEM_CopyBytes (_@ (bbox), _@ (bbox) + 12, 12);

	bbox[0] = subf (bbox[0], rangeF);
	bbox[1] = subf (bbox[1], rangeF);
	bbox[2] = subf (bbox[2], rangeF);

	bbox[3] = addf (bbox[3], rangeF);
	bbox[4] = addf (bbox[4], rangeF);
	bbox[5] = addf (bbox[5], rangeF);

	return + Wld_CollectVobsInBBox3D (posPtr, _@ (bbox));
};
