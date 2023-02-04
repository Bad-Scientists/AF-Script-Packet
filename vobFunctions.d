/*
 *	Vob functions
 */

func void zCObject_Release (var int ptr) {
	//0x0042AC30 public: int __thiscall zCObject::Release(void)
	const int zCObject__Release_G1 = 4369456;

	//0x0040C310 public: int __thiscall zCObject::Release(void)
	const int zCObject__Release_G2 = 4244240;

	if (!Hlp_Is_zCObject (ptr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (zCObject__Release_G1, zCObject__Release_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func int oCMob_GetModel (var int mobPtr) {
	//0x0067AD00 public: virtual class zCModel * __thiscall oCMOB::GetModel(void)
	const int oCMOB__GetModel_G1 = 6794496;

	//0x0071BEE0 public: virtual class zCModel * __thiscall oCMOB::GetModel(void)
	const int oCMOB__GetModel_G2 = 7454432;

	if (!mobPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (mobPtr), MEMINT_SwitchG1G2 (oCMOB__GetModel_G1, oCMOB__GetModel_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr();
};

func string zCModel_GetVisualName (var int modelPtr) {
	//0x00563EF0 public: virtual class zSTRING __thiscall zCModel::GetVisualName(void)
	const int zCModel__GetVisualName_G1 = 5652208;

	//0x0057DF60 public: virtual class zSTRING __thiscall zCModel::GetVisualName(void)
	const int zCModel__GetVisualName_G2 = 5758816;

	if (!modelPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__GetVisualName_G1, zCModel__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCDecal_GetVisualName (var int vobPtr) {
	//0x00542430 public: virtual class zSTRING __thiscall zCDecal::GetVisualName(void)
	const int zCDecal__GetVisualName_G1 = 5514288;

	//0x00556B80 public: virtual class zSTRING __thiscall zCDecal::GetVisualName(void)
	const int zCDecal__GetVisualName_G2 = 5598080;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCDecal__GetVisualName_G1, zCDecal__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCProgMeshProto_GetVisualName (var int vobPtr) {
	//0x005A5230 public: virtual class zSTRING __thiscall zCProgMeshProto::GetVisualName(void)
	const int zCProgMeshProto__GetVisualName_G1 = 5919280;

	//0x005C7130 public: virtual class zSTRING __thiscall zCProgMeshProto::GetVisualName(void)
	const int zCProgMeshProto__GetVisualName_G2 = 6058288;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCProgMeshProto__GetVisualName_G1, zCProgMeshProto__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCParticleFX_GetVisualName (var int vobPtr) {
	//0x0058DE10 public: virtual class zSTRING __thiscall zCParticleFX::GetVisualName(void)
	const int zCParticleFX__GetVisualName_G1 = 5824016;

	//0x005ADD30 public: virtual class zSTRING __thiscall zCParticleFX::GetVisualName(void)
	const int zCParticleFX__GetVisualName_G2 = 5954864;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCParticleFX__GetVisualName_G1, zCParticleFX__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCMorphMesh_GetVisualName (var int vobPtr) {
	//0x005868F0 public: virtual class zSTRING __thiscall zCMorphMesh::GetVisualName(void)
	const int zCMorphMesh__GetVisualName_G1 = 5794032;

	//0x005A6290 public: virtual class zSTRING __thiscall zCMorphMesh::GetVisualName(void)
	const int zCMorphMesh__GetVisualName_G2 = 5923472;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCMorphMesh__GetVisualName_G1, zCMorphMesh__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCPolyStrip_GetVisualName (var int vobPtr) {
	//0x004C0DD0 public: virtual class zSTRING __thiscall zCPolyStrip::GetVisualName(void)
	const int zCPolyStrip__GetVisualName_G1 = 4984272;

	//0x004CA110 public: virtual class zSTRING __thiscall zCPolyStrip::GetVisualName(void)
	const int zCPolyStrip__GetVisualName_G2 = 5021968;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCPolyStrip__GetVisualName_G1, zCPolyStrip__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCFlash_GetVisualName (var int vobPtr) {
	//0x004C0EA0 public: virtual class zSTRING __thiscall zCFlash::GetVisualName(void)
	const int zCFlash__GetVisualName_G1 = 4984480;

	//0x004CA1E0 public: virtual class zSTRING __thiscall zCFlash::GetVisualName(void)
	const int zCFlash__GetVisualName_G2 = 5022176;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCFlash__GetVisualName_G1, zCFlash__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCMesh_GetVisualName (var int vobPtr) {
	//0x0054FBC0 public: virtual class zSTRING __thiscall zCMesh::GetVisualName(void)
	const int zCMesh__GetVisualName_G1 = 5569472;

	//0x00567020 public: virtual class zSTRING __thiscall zCMesh::GetVisualName(void)
	const int zCMesh__GetVisualName_G2 = 5664800;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCMesh__GetVisualName_G1, zCMesh__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCQuadMark_GetVisualName (var int vobPtr) {
	//0x005AB980 public: virtual class zSTRING __thiscall zCQuadMark::GetVisualName(void)
	const int zCQuadMark__GetVisualName_G1 = 5945728;

	//0x005D0AB0 public: virtual class zSTRING __thiscall zCQuadMark::GetVisualName(void)
	const int zCQuadMark__GetVisualName_G2 = 6097584;

	if (!vobPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCQuadMark__GetVisualName_G1, zCQuadMark__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func int zCVob_GetVisual (var int vobPtr) {
	//0x005E9A70 public: class zCVisual * __thiscall zCVob::GetVisual(void)const
	const int zCVob__GetVisual_G1 = 6199920;

	//0x00616B20 public: class zCVisual * __thiscall zCVob::GetVisual(void)const
	const int zCVob__GetVisual_G2 = 6384416;

	if (!vobPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__GetVisual_G1, zCVob__GetVisual_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

/*
 *	Wrapper function for getting Visual
 *	 - returns visual name
 *	 - works with zCDecal, zCModel, zCProgMeshProto visual types
 */
func string Visual_GetVisualName (var int visualPtr) {
/*
	if (!vobPtr) { return ""; };

	var zCVob vob; vob = _^ (vobPtr);

	if (!vob.visual) { return ""; };

	var zCObject visualObj;
	visualObj = _^ (vob.visual);

	return visualObj.objectName;
*/

	if (!visualPtr) { return ""; };
	var zCVisual visual; visual = _^ (visualPtr);

	//visual zCDecal

	//Ikarus constant for G1 has incorrect value ... G2A is not defined
	//0x007D3E04 const zCDecal::`vftable'
	const int zCDecal_vtbl_G1 = 8207876;

	//0x00832084 const zCDecal::`vftable'
	const int zCDecal_vtbl_G2 = 8593540;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCDecal_vtbl_G1, zCDecal_vtbl_G2)) {
		return zCDecal_GetVisualName (visualPtr);
	};

	//visual zCModel

	//0x007D3FEC const zCModel::`vftable'
	const int zCModel_vtbl_G1 = 8208364;

	//0x0083234C const zCModel::`vftable'
	const int zCModel_vtbl_G2 = 8594252;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCModel_vtbl_G1, zCModel_vtbl_G2)) {
		return zCModel_GetVisualName (visualPtr);
	};

	//visual zCProgMeshProto

	//0x007D45F4 const zCProgMeshProto::`vftable'
	const int zCProgMeshProto_vtbl_G1 = 8209908;

	//0x008329CC const zCProgMeshProto::`vftable'
	const int zCProgMeshProto_vtbl_G2 = 8595916;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCProgMeshProto_vtbl_G1, zCProgMeshProto_vtbl_G2)) {
		return zCProgMeshProto_GetVisualName (visualPtr);
	};

	//visual zCParticleFX

	//0x007D4214 const zCParticleFX::`vftable'
	const int zCParticleFX_vtbl_G1 = 8208916;

	//0x008325C4 const zCParticleFX::`vftable'
	const int zCParticleFX_vtbl_G2 = 8594884;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCParticleFX_vtbl_G1, zCParticleFX_vtbl_G2)) {
		return zCParticleFX_GetVisualName (visualPtr);
	};

	//visual zCMorphMesh

	//0x007D4144 const zCMorphMesh::`vftable'
	const int zCMorphMesh_vtbl_G1 = 8208708;

	//0x008324D4 const zCMorphMesh::`vftable'
	const int zCMorphMesh_vtbl_G2 = 8594644;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCMorphMesh_vtbl_G1, zCMorphMesh_vtbl_G2)) {
		return zCMorphMesh_GetVisualName (visualPtr);
	};

	//visual zCPolyStrip

	//0x007D42EC const zCPolyStrip::`vftable'
	const int zCPolyStrip_vtbl_G1 = 8209132;

	//0x008326B4 const zCPolyStrip::`vftable'
	const int zCPolyStrip_vtbl_G2 = 8595124;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCPolyStrip_vtbl_G1, zCPolyStrip_vtbl_G2)) {
		return zCPolyStrip_GetVisualName (visualPtr);
	};

	//visual zCFlash

	//0x007D292C const zCFlash::`vftable'
	const int zCFlash_vtbl_G1 = 8202540;

	//0x00830A64 const zCFlash::`vftable'
	const int zCFlash_vtbl_G2 = 8587876;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCFlash_vtbl_G1, zCFlash_vtbl_G2)) {
		return zCFlash_GetVisualName (visualPtr);
	};

	//visual zCMesh

	//0x007D3F6C const zCMesh::`vftable'
	const int zCMesh_vtbl_G1 = 8208236;

	//0x008322BC const zCMesh::`vftable'
	const int zCMesh_vtbl_G2 = 8594108;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCMesh_vtbl_G1, zCMesh_vtbl_G2)) {
		return zCMesh_GetVisualName (visualPtr);
	};

	//visual zCQuadMark

	//0x007D467C const zCQuadMark::`vftable'
	const int zCQuadMark_vtbl_G1 = 8210044;

	//0x00832A64 const zCQuadMark::`vftable'
	const int zCQuadMark_vtbl_G2 = 8596068;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCQuadMark_vtbl_G1, zCQuadMark_vtbl_G2)) {
		return zCQuadMark_GetVisualName (visualPtr);
	};

	//Since I am not sure if this works properly - couple of prints that might help in the future
	MEM_Info ("AFSP TODO: Investigate visual vtbl:");
	MEM_Info (IntToString (visual._vtbl));

	return visual._zCObject_objectName;
};

func string Vob_GetVisualName (var int vobPtr){
	if (!vobPtr) { return ""; };

	//in case of oCMob we need to get visual from object model
	//if (Hlp_Is_oCMob (vobPtr)){
	//	var int modelPtr; modelPtr = oCMob_GetModel (vobPtr);
	//	return zCModel_GetVisualName (modelPtr);
	//};

	//B_Msg_Add (zCDecal_GetVisualName (vobPtr));

	if (!vobPtr) { return ""; };
	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	return Visual_GetVisualName (visualPtr);
};

/*
 *	zCVob_GetName
 *	 - returns vob name
 */
func string zCVob_GetName (var int vobPtr) {
	if (!Hlp_Is_zCVob (vobPtr)) { return ""; };
	var zCVob vob; vob = _^ (vobPtr);
	return vob._zCObject_objectName;
};

/*
 *	Will draw BBox3D on Vob
 */
func void zCVob_SetDrawBBox3D (var int vobPtr, var int enabled) {
	//0x00645030 public: void __thiscall zCVob::SetDrawBBox3D(int)
	const int zCVob__SetDrawBBox3D_G1 = 6574128;

	//0x006CFFE0 public: void __thiscall zCVob::SetDrawBBox3D(int)
	const int zCVob__SetDrawBBox3D_G2 = 7143392;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (enabled));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetDrawBBox3D_G1, zCVob__SetDrawBBox3D_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void zCVob_Move (var int vobPtr, var int x, var int y, var int z) {
	//0x005EDDE0 public: void __thiscall zCVob::Move(float,float,float)
	const int zCVob__Move_G1 = 6217184;

	//0x0061B2E0 public: void __thiscall zCVob::Move(float,float,float)
	const int zCVob__Move_G2 = 6402784;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (x));
		CALL_FloatParam (_@ (y));
		CALL_FloatParam (_@ (z));

		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__Move_G1, zCVob__Move_G2));
		call = CALL_End();
	};
};

/*
 *	Vob_GetCollBits will return collision bitfield values
 */
func int Vob_GetCollBits (var int vobPtr) {
	if (!vobPtr) { return 0; };
	var zCVob vob; vob = _^ (vobPtr);
	return (vob.bitfield[0] & (zCVob_bitfield0_collDetectionStatic + zCVob_bitfield0_collDetectionDynamic));
};

/*
 *	Vob_AddCollBits - will add collisions based on input bitfield values in collBits
 */
func void Vob_AddCollBits (var int vobPtr, var int collBits) {
	if (!vobPtr) { return; };
	var zCVob vob; vob = _^ (vobPtr);
	vob.bitfield[0] = (vob.bitfield[0] | collBits);
};

/*
 *	Vob_RemoveCollBits - will remove collisions based on input bitfield values in collBits
 */
func void Vob_RemoveCollBits (var int vobPtr, var int collBits) {
	if (!vobPtr) { return; };
	var zCVob vob; vob = _^ (vobPtr);
	vob.bitfield[0] = (vob.bitfield[0] & ~ collBits);
};

/*
 *	Rotates vob on its X axis
 */
func void zCVob_RotateLocalX (var int vobPtr, var int x) {
	//0x005EE1A0 public: void __thiscall zCVob::RotateLocalX(float)
	const int zCVob__RotateLocalX_G1 = 6218144;

	//0x0061B6B0 public: void __thiscall zCVob::RotateLocalX(float)
	const int zCVob__RotateLocalX_G2 = 6403760;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (x));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__RotateLocalX_G1, zCVob__RotateLocalX_G2));
		call = CALL_End();
	};
};

/*
 *	Rotates vob on its Y axis
 */
func void zCVob_RotateLocalY (var int vobPtr, var int y) {
	//0x005EE210 public: void __thiscall zCVob::RotateLocalY(float)
	const int zCVob__RotateLocalY_G1 = 6218256;

	//0x0061B720 public: void __thiscall zCVob::RotateLocalY(float)
	const int zCVob__RotateLocalY_G2 = 6403872;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (y));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__RotateLocalY_G1, zCVob__RotateLocalY_G2));
		call = CALL_End();
	};
};

/*
 *	Rotates vob on its Z axis
 */
func void zCVob_RotateLocalZ (var int vobPtr, var int z) {
	//0x005EE280 public: void __thiscall zCVob::RotateLocalZ(float)
	const int zCVob__RotateLocalZ_G1 = 6218368;

	//0x0061B790 public: void __thiscall zCVob::RotateLocalZ(float)
	const int zCVob__RotateLocalZ_G2 = 6403984;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (z));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__RotateLocalZ_G1, zCVob__RotateLocalZ_G2));
		call = CALL_End();
	};
};

/*
 *	Rotates vob on its X Y Z axes
 */
func void zCVob_RotateLocalXYZ (var int vobPtr, var int x, var int y, var int z) {
	if (!vobPtr) { return; };

        zCVob_RotateLocalX (vobPtr, x);
        zCVob_RotateLocalY (vobPtr, y);
        zCVob_RotateLocalZ (vobPtr, z);
};

/*
 *
 */
func void zCVob_SetPhysicsEnabled (var int vobPtr, var int enabled) {
	//0x005EFC20 public: void __thiscall zCVob::SetPhysicsEnabled(int)
	const int zCVob__SetPhysicsEnabled_G1 = 6224928;

	//0x0061D190 public: void __thiscall zCVob::SetPhysicsEnabled(int)
	const int zCVob__SetPhysicsEnabled_G2 = 6410640;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (enabled));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetPhysicsEnabled_G1, zCVob__SetPhysicsEnabled_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void zCVob_SetSleeping (var int vobPtr, var int sleepingMode) {
	//0x005D7250 public: void __thiscall zCVob::SetSleeping(int)
	const int zCVob__SetSleeping_G1 = 6124112;

	//0x00602930 public: void __thiscall zCVob::SetSleeping(int)
	const int zCVob__SetSleeping_G2 = 6302000;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (sleepingMode));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetSleeping_G1, zCVob__SetSleeping_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func int zCVob_IsSleeping (var int vobPtr) {
	if (!vobPtr) { return 0; };

/*
	enum zTVobSleepingMode {
		zVOB_SLEEPING,			//0
		zVOB_AWAKE,			//1
		zVOB_AWAKE_DOAI_ONLY		//2
	};
*/

	var zCVob vob; vob = _^ (vobPtr);
	return ((vob.bitfield[2] & zCVob_bitfield2_sleepingMode) == 0);

	//Put in sleeping mode
	//vob.bitfield[2] = (vob.bitfield[2] & ~ zCVob_bitfield2_sleepingMode) | 0;

	//Remove from sleeping mode
	//vob.bitfield[2] = (vob.bitfield[2] & ~ zCVob_bitfield2_sleepingMode) | 1;
};

func int zCVob_HasParentVob (var int vobPtr) {
	//0x005EF620 public: int __thiscall zCVob::HasParentVob(void)const
	const int zCVob__HasParentVob_G1 = 6223392;

	//0x0061CBA0 public: int __thiscall zCVob::HasParentVob(void)const
	const int zCVob__HasParentVob_G2 = 6409120;

	if (!vobPtr) { return FALSE; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__HasParentVob_G1, zCVob__HasParentVob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};


//0x005D6E10 public: virtual void __thiscall zCVob::SetVisual(class zCVisual *)
//0x006024F0 public: virtual void __thiscall zCVob::SetVisual(class zCVisual *)

func void zCVob_SetVisual (var int vobPtr, var string visualName) {
	//0x005D6FA0 public: virtual void __thiscall zCVob::SetVisual(class zSTRING const &)
	const int zCVob__SetVisual_G1 = 6123424;

	//0x00602680 public: virtual void __thiscall zCVob::SetVisual(class zSTRING const &)
	const int zCVob__SetVisual_G2 = 6301312;

	if (!vobPtr) { return; };

	CALL_zStringPtrParam (visualName);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__SetVisual_G1, zCVob__SetVisual_G2));
};

func int zCVob_GetVelocity (var int vobPtr) {
	//0x005EFC50 public: class zVEC3 __thiscall zCVob::GetVelocity(void)
	const int zCVob__GetVelocity_G1 = 6224976;

	//0x0061D1C0 public: class zVEC3 __thiscall zCVob::GetVelocity(void)
	const int zCVob__GetVelocity_G2 = 6410688;

	if (!vobPtr) { return 0; };

	CALL_RetValIsStruct (12);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetVelocity_G1, zCVob__GetVelocity_G2));
	return CALL_RetValAsPtr ();
};

func int Vob_IsMoving (var int vobPtr) {
/*
	This does not work ;-/

	if (!itemPtr) { return 0; };
	var oCItem itm; itm = _^ (itemPtr);
	return + (itm._zCVob_bitfield[1] & zCVob_bitfield1_isInMovementMode);
*/

/*
	if (!vobPtr) { return FALSE; };

	var int vecPtr; vecPtr = zCVob_GetVelocity (vobPtr);

	if (!vecPtr) { return FALSE; };

	var int vec[3];

	copyVector (vecPtr, _@ (vec));

	return + (magVector (_@ (vec)));
*/
	//0x004AC6C0 public: class zVEC3 & __thiscall zVEC3::NormalizeSafe(void)
	const int zVEC3__NormalizeSafe_G1 = 4900544;

	//0x00498A20 public: class zVEC3 & __thiscall zVEC3::NormalizeSafe(void)
	const int zVEC3__NormalizeSafe_G2 = 4819488;

	var int vec[3];
	var int vecPtr; vecPtr = zCVob_GetVelocity (vobPtr);

	//only supported in disposable calls
	//CALL_RetValIsStruct (12);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (vecPtr), MEMINT_SwitchG1G2 (zVEC3__NormalizeSafe_G1, zVEC3__NormalizeSafe_G2));
		call = CALL_End();
	};

	MEM_CopyBytes (CALL_RetValAsPtr(), _@ (vec), 12);

	MEM_Free (vecPtr);

	return + (magVector (_@ (vec)));
};

/*
 *
 */
func void Vob_TriggerVobByName (var string vobName) {
	var int arr; arr = MEM_SearchAllVobsByName (vobName);

	var zCArray zarr; zarr = _^ (arr);

	var int vobPtr;

	repeat (i, zarr.numInArray); var int i;
		vobPtr = MEM_ReadIntArray(zarr.array, i);
		MEM_TriggerVob (vobPtr);
	end;

	MEM_ArrayFree (arr);
};

/*
 *
 */
func void Vob_UnTriggerVobByName (var string vobName) {
	var int arr; arr = MEM_SearchAllVobsByName (vobName);

	var zCArray zarr; zarr = _^ (arr);

	var int vobPtr;

	repeat (i, zarr.numInArray); var int i;
		vobPtr = MEM_ReadIntArray(zarr.array, i);
		MEM_UntriggerVob (vobPtr);
	end;

	MEM_ArrayFree (arr);
};

/*
 *
 */
func void Vob_ChangeDataByPtr (var int vobPtr, var int staticVob, var int collStat, var int collDyn, var int showVisual) {
	if (!vobPtr) { return; };

	var int onBits; onBits = ( showVisual * zCVob_bitfield0_showVisual + staticVob * zCVob_bitfield0_staticVob + collStat * zCVob_bitfield0_collDetectionStatic + collDyn * zCVob_bitfield0_collDetectionDynamic);
	var int offBits; offBits = (!showVisual * zCVob_bitfield0_showVisual + !staticVob * zCVob_bitfield0_staticVob + !collStat * zCVob_bitfield0_collDetectionStatic + !collDyn * zCVob_bitfield0_collDetectionDynamic);

	var zCVob vob; vob = _^ (vobPtr);

	vob.bitfield[0] = vob.bitfield[0] | (onBits);
	vob.bitfield[0] = vob.bitfield[0] & ~ (offBits);
};

/*
 *
 */
func void Vob_ChangeDataByName (var string vobName, var int staticVob, var int collStat, var int collDyn, var int showVisual) {
	var int arr; arr = MEM_SearchAllVobsByName (vobName);

	var zCArray zarr; zarr = _^ (arr);

	var int onBits; onBits = ( showVisual * zCVob_bitfield0_showVisual + staticVob * zCVob_bitfield0_staticVob + collStat * zCVob_bitfield0_collDetectionStatic + collDyn * zCVob_bitfield0_collDetectionDynamic);
	var int offBits; offBits = (!showVisual * zCVob_bitfield0_showVisual + !staticVob * zCVob_bitfield0_staticVob + !collStat * zCVob_bitfield0_collDetectionStatic + !collDyn * zCVob_bitfield0_collDetectionDynamic);

	var zCVob vob;
	var int vobPtr;

	repeat (i, zarr.numInArray); var int i;
		vobPtr = MEM_ReadIntArray (zarr.array, i);
		vob = _^ (vobPtr);

		vob.bitfield[0] = vob.bitfield[0] | (onBits);
		vob.bitfield[0] = vob.bitfield[0] & ~ (offBits);
	end;

	MEM_ArrayFree (arr);
};

/*
 *
 */
func void Vob_MoveToVob (var string moveVobName, var string toVobName) {
	var zcVob toVob;

	var int moveVobPtr; moveVobPtr = MEM_SearchVobByName (moveVobName);
	if (!moveVobPtr) { return; };

	var int toVobPtr; toVobPtr = MEM_SearchVobByName (toVobName);
	if (!toVobPtr) { return; };

	toVob = _^ (toVobPtr);

	//AlignVobAt (moveVobPtr, _@(toVob.trafoObjToWorld));
	MEM_PushIntParam (moveVobPtr);
	MEM_PushIntParam (_@(toVob.trafoObjToWorld));
	MEM_Call (AlignVobAt);
};

/*
 *
 */
func void Vob_PlayEffect (var string vobName, var string effectName)
{
	var int arr; arr = MEM_SearchAllVobsByName (vobName);
	var zCArray zarr; zarr = MEM_PtrToInst(arr);

	var int vobPtr;
	var zCVob vob;

	repeat (i, zarr.numInArray); var int i;
		vobPtr = MEM_ReadIntArray (zarr.array, i);
		vob = _^ (vobPtr);

		Wld_PlayEffect (effectName, vob, vob, 0, 0, 0, FALSE);

	end;

	MEM_ArrayFree (arr);
};

//0x005EF090 public: void __thiscall zCVob::SetHeadingLocal(class zVEC3 const &)
//0x005EF150 public: void __thiscall zCVob::SetHeadingWorld(class zVEC3 const &)

//0x005EF640 public: void __thiscall zCVob::SetHeadingAtWorld(class zVEC3 const &)


//0x005EE760 public: void __thiscall zCVob::SetTrafoObjToWorld(class zMAT4 const &)

func int zCVob_GetPositionWorld (var int vobPtr) {
	//0x0051B3C0 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
	const int zCVob__GetPositionWorld_G1 = 5354432;

	//0x0052DC90 public: class zVEC3 __thiscall zCVob::GetPositionWorld(void)const
	const int zCVob__GetPositionWorld_G2 = 5430416;

	if (!vobPtr) { return 0; };

	CALL_RetValIsStruct (12);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetPositionWorld_G1, zCVob__GetPositionWorld_G2));
	return CALL_RetValAsPtr ();
};

//Wrapper function that frees allocated memory
//return TRUE if everything went ok
func int zCVob_GetPositionWorldToPos (var int vobPtr, var int posPtr) {
	if (!posPtr) { return FALSE; };

	var int vobPosPtr; vobPosPtr = zCVob_GetPositionWorld (vobPtr);
	if (!vobPosPtr) { return FALSE; };

	MEM_CopyBytes (vobPosPtr, posPtr, 12);
	MEM_Free (vobPosPtr);

	return TRUE;
};

func int zCVob_GetAtVectorWorld (var int vobPtr) {
	//0x0051B3E0 public: class zVEC3 __thiscall zCVob::GetAtVectorWorld(void)const
	const int zCVob__GetAtVectorWorld_G1 = 5354464;

	//0x0052DCB0 public: class zVEC3 __thiscall zCVob::GetAtVectorWorld(void)const
	const int zCVob__GetAtVectorWorld_G2 = 5430448;

	if (!vobPtr) { return 0; };

	CALL_RetValIsStruct (12);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetAtVectorWorld_G1, zCVob__GetAtVectorWorld_G2));
	return CALL_RetValAsPtr ();
};

func int zCVob_GetUpVectorWorld (var int vobPtr) {
	//0x0051B400 public: class zVEC3 __thiscall zCVob::GetUpVectorWorld(void)const
	const int zCVob__GetUpVectorWorld_G1 = 5354496;

	//0x0052DCD0 public: class zVEC3 __thiscall zCVob::GetUpVectorWorld(void)const
	const int zCVob__GetUpVectorWorld_G2 = 5430480;

	if (!vobPtr) { return 0; };

	CALL_RetValIsStruct (12);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetUpVectorWorld_G1, zCVob__GetUpVectorWorld_G2));
	return CALL_RetValAsPtr ();
};

func int zCVob_GetRightVectorWorld (var int vobPtr) {
	//0x0051B420 public: class zVEC3 __thiscall zCVob::GetRightVectorWorld(void)const
	const int zCVob__GetRightVectorWorld_G1 = 5354528;

	//0x0052DCF0 public: class zVEC3 __thiscall zCVob::GetRightVectorWorld(void)const
	const int zCVob__GetRightVectorWorld_G2 = 5430512;

	if (!vobPtr) { return 0; };

	CALL_RetValIsStruct (12);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetRightVectorWorld_G1, zCVob__GetRightVectorWorld_G2));
	return CALL_RetValAsPtr ();
};

//
func void zCVob_SetPositionWorld (var int vobPtr, var int vecPtr) {
	//0x005EE650 public: void __thiscall zCVob::SetPositionWorld(class zVEC3 const &)
	const int zCVob__SetPositionWorld_G1 = 6219344;

	//0x0061BB70 public: void __thiscall zCVob::SetPositionWorld(class zVEC3 const &)
	const int zCVob__SetPositionWorld_G2 = 6404976;

	if (!vobPtr) || (!vecPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vecPtr));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetPositionWorld_G1, zCVob__SetPositionWorld_G2));
		call = CALL_End();
	};
};

func void zMAT4_SetAtVector (var int trafoPtr, var int vecPtr) {
	//0x00497390 public: void __thiscall zMAT4::SetAtVector(class zVEC3 const &)
	const int zMAT4__SetAtVector_G1 = 4813712;

	//0x0056B960 public: void __thiscall zMAT4::SetAtVector(class zVEC3 const &)
	const int zMAT4__SetAtVector_G2 = 5683552;

	if (!trafoPtr) { return; };
	if (!vecPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vecPtr));
		CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2 (zMAT4__SetAtVector_G1, zMAT4__SetAtVector_G2));
		call = CALL_End();
	};
};

func void zMAT4_SetUpVector (var int trafoPtr, var int vecPtr)
{
	//0x004973B0 public: void __thiscall zMAT4::SetUpVector(class zVEC3 const &)
	const int zMAT4__SetUpVector_G1 = 4813744;

	//0x004B9D90 public: void __thiscall zMAT4::SetUpVector(class zVEC3 const &)
	const int zMAT4__SetUpVector_G2 = 4955536;

	if (!trafoPtr) { return; };
	if (!vecPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vecPtr));
		CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2 (zMAT4__SetUpVector_G1, zMAT4__SetUpVector_G2));
		call = CALL_End();
	};
};

func void zMAT4_SetRightVector (var int trafoPtr, var int vecPtr)
{
	//0x004973D0 public: void __thiscall zMAT4::SetRightVector(class zVEC3 const &)
	const int zMAT4__SetRightVector_G1 = 4813776;

	//0x004B9DB0 public: void __thiscall zMAT4::SetRightVector(class zVEC3 const &)
	const int zMAT4__SetRightVector_G2 = 4955568;

	if (!trafoPtr) { return; };
	if (!vecPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vecPtr));
		CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2 (zMAT4__SetRightVector_G1, zMAT4__SetRightVector_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func void zMAT4_PostRotateX (var int trafoPtr, var int degrees) {
	//0x00507A40 public: void __thiscall zMAT4::PostRotateX(float)
	const int zMAT4__PostRotateX_G1 = 5274176;

	//0x00517730 public: void __thiscall zMAT4::PostRotateX(float)
	const int zMAT4__PostRotateX_G2 = 5338928;

	if (!trafoPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (degrees));
		CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2(zMAT4__PostRotateX_G1, zMAT4__PostRotateX_G2));
		call = CALL_End();
	};
};

func void zMAT4_PostRotateY (var int trafoPtr, var int degrees) {
	//0x00507A90 public: void __thiscall zMAT4::PostRotateY(float)
	const int zMAT4__PostRotateY_G1 = 5274256;

	//0x00517780 public: void __thiscall zMAT4::PostRotateY(float)
	const int zMAT4__PostRotateY_G2 = 5339008;

	if (!trafoPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (degrees));
		CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2(zMAT4__PostRotateY_G1, zMAT4__PostRotateY_G2));
		call = CALL_End();
	};
};

func void zMAT4_PostRotateZ (var int trafoPtr, var int degrees) {
	//0x00507AE0 public: void __thiscall zMAT4::PostRotateZ(float)
	const int zMAT4__PostRotateZ_G1 = 5274336;

	//0x005177D0 public: void __thiscall zMAT4::PostRotateZ(float)
	const int zMAT4__PostRotateZ_G2 = 5339088;

	if (!trafoPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_FloatParam (_@ (degrees));
		CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2(zMAT4__PostRotateZ_G1, zMAT4__PostRotateZ_G2));
		call = CALL_End();
	};
};

/*
 *
 */
func string zMAT4_GetDescriptionRot (var int trafoPtr) {
	//0x00506090 public: class zSTRING __thiscall zMAT4::GetDescriptionRot(void)const
	const int zMAT4__GetDescriptionRot_G1 = 5267600;

	//0x00515CA0 public: class zSTRING __thiscall zMAT4::GetDescriptionRot(void)const
	const int zMAT4__GetDescriptionRot_G2 = 5332128;

	if (!trafoPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2 (zMAT4__GetDescriptionRot_G1, zMAT4__GetDescriptionRot_G2));
	return STR_Trim (CALL_RetValAszstring (), " ");
};

/*
 *
 */
func string zMAT4_GetDescriptionPos (var int trafoPtr) {
	//0x00506260 public: class zSTRING __thiscall zMAT4::GetDescriptionPos(void)const
	const int zMAT4__GetDescriptionPos_G1 = 5268064;

	//0x00515EE0 public: class zSTRING __thiscall zMAT4::GetDescriptionPos(void)const
	const int zMAT4__GetDescriptionPos_G2 = 5332704;

	if (!trafoPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2 (zMAT4__GetDescriptionPos_G1, zMAT4__GetDescriptionPos_G2));
	return STR_Trim (CALL_RetValAszstring (), " ");
};

/*
 *
 */
func void zMAT4_SetByDescriptionRot (var int trafoPtr, var string desc) {
	//0x005063F0 public: void __thiscall zMAT4::SetByDescriptionRot(class zSTRING &)
	const int zMAT4__SetByDescriptionRot_G1 = 5268464;

	//0x005160E0 public: void __thiscall zMAT4::SetByDescriptionRot(class zSTRING &)
	const int zMAT4__SetByDescriptionRot_G2 = 5333216;

	if (!trafoPtr) { return; };

	CALL_zStringPtrParam (desc);
	CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2 (zMAT4__SetByDescriptionRot_G1, zMAT4__SetByDescriptionRot_G2));
};

/*
 *
 */
func void zMAT4_SetByDescriptionPos (var int trafoPtr, var string desc) {
	//0x00506550 public: void __thiscall zMAT4::SetByDescriptionPos(class zSTRING &)
	const int zMAT4__SetByDescriptionPos_G1 = 5268816;

	//0x00516240 public: void __thiscall zMAT4::SetByDescriptionPos(class zSTRING &)
	const int zMAT4__SetByDescriptionPos_G2 = 5333568;

	if (!trafoPtr) { return; };

	CALL_zStringPtrParam (desc);
	CALL__thiscall (_@ (trafoPtr), MEMINT_SwitchG1G2 (zMAT4__SetByDescriptionPos_G1, zMAT4__SetByDescriptionPos_G2));
};

/*
 *
 */
func void zCVob_GetTrafo (var int vobPtr, var int trafoPtr) {
	if (!trafoPtr) { return; };

	if (Hlp_Is_zCVob (vobPtr)) {
		var zCVob vob; vob = _^ (vobPtr);
		MEM_CopyBytes (_@ (vob.trafoObjToWorld), trafoPtr, 64);
	};
};

/*
 *
 */
func void zCVob_SetTrafo (var int vobPtr, var int trafoPtr) {
	//0x005EE6B0 public: void __thiscall zCVob::SetTrafo(class zMAT4 const &)
	const int zCVob__SetTrafo_G1 = 6219440;

	//0x0061BBD0 public: void __thiscall zCVob::SetTrafo(class zMAT4 const &)
	const int zCVob__SetTrafo_G2 = 6405072;

	if (!vobPtr) { return; };
	if (!trafoPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (trafoPtr));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetTrafo_G1, zCVob__SetTrafo_G2));
		call = CALL_End();
	};
};

/*
 *	Created by Showdown & Lehona
 *	Original post: https://forum.worldofplayers.de/forum/threads/1299679-Skriptpaket-Ikarus-4/page11?p=24735929&viewfull=1#post24735929
 *	I just added G1 address
 */
func void SetRainThroughVobs (var int bool) {
	const int Raincheck_G1 = 6000805;
	const int Raincheck_G2 = 6169210;

	MemoryProtectionOverride (MEMINT_SwitchG1G2(Raincheck_G1, Raincheck_G2), 4);

	if (!bool) {
		MEM_WriteByte (MEMINT_SwitchG1G2 (Raincheck_G1, Raincheck_G2), 224);
	} else {
		MEM_WriteByte (MEMINT_SwitchG1G2 (Raincheck_G1, Raincheck_G2), 226);
	};
};

/*
 *	Check if vob pointer is in active voblist array
 */
func int VobPtr_IsInActiveVobList (var int vobPtr) {
	if (!vobPtr) { return 0; };

	var int i; i = 0;
	var int loop; loop = MEM_World.activeVobList_numInArray;

	while (i < loop);
		var int ptr; ptr = MEM_ReadIntArray(MEM_World.activeVobList_array, i);

		if (vobPtr == ptr) {
			return TRUE;
		};

		i += 1;
	end;

	return FALSE;
};

/*
 *
 */
func int zCVob_GetRigidBody (var int vobPtr) {
	//0x005D37A0 public: class zCRigidBody * __thiscall zCVob::GetRigidBody(void)
	const int zCVob__GetRigidBody_G1 = 6109088;

	//0x005FE960 public: class zCRigidBody * __thiscall zCVob::GetRigidBody(void)
	const int zCVob__GetRigidBody_G2 = 6285664;

	if (!vobPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__GetRigidBody_G1, zCVob__GetRigidBody_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func void zCRigidBody_SetVelocity (var int rigidBodyPtr, var int vecPtr) {
	//0x00595380 public: void __thiscall zCRigidBody::SetVelocity(class zVEC3 const &)
	const int zCRigidBody__SetVelocity_G1 = 5854080;

	//0x005B66D0 public: void __thiscall zCRigidBody::SetVelocity(class zVEC3 const &)
	const int zCRigidBody__SetVelocity_G2 = 5990096;

	if (!rigidBodyPtr) || (!vecPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (vecPtr));
		CALL__thiscall (_@ (rigidBodyPtr), MEMINT_SwitchG1G2 (zCRigidBody__SetVelocity_G1, zCRigidBody__SetVelocity_G2));
		call = CALL_End();
	};
};

func void Vob_SetBitfield (var int vobPtr, var int bitfield, var int value) {
	if (!vobPtr) { return; };
	var zCVob vob; vob = _^ (vobPtr);

	//Basically true/false values
	if (bitfield == zCVob_bitfield0_showVisual)
	|| (bitfield == zCVob_bitfield0_drawBBox3D)
	|| (bitfield == zCVob_bitfield0_visualAlphaEnabled)
	|| (bitfield == zCVob_bitfield0_physicsEnabled)
	|| (bitfield == zCVob_bitfield0_staticVob)
	|| (bitfield == zCVob_bitfield0_ignoredByTraceRay)
	|| (bitfield == zCVob_bitfield0_collDetectionStatic)
	|| (bitfield == zCVob_bitfield0_collDetectionDynamic)
	|| (bitfield == zCVob_bitfield0_castDynShadow)
	|| (bitfield == zCVob_bitfield0_lightColorStatDirty)
	|| (bitfield == zCVob_bitfield0_lightColorDynDirty)
	{
		if ((value == 0) || (value == 1)) {
			value = bitfield * value;
		};

		vob.bitfield[0] = (vob.bitfield[0] & ~ bitfield) | value;
		return;
	};

	if (bitfield == zCVob_bitfield1_isInMovementMode)
	{
		vob.bitfield[1] = (vob.bitfield[1] & ~ bitfield) | value;
		return;
	};

	if (bitfield == zCVob_bitfield2_sleepingMode)
	|| (bitfield == zCVob_bitfield2_mbHintTrafoLocalConst)
	|| (bitfield == zCVob_bitfield2_mbInsideEndMovementMethod)
	{
		vob.bitfield[2] = (vob.bitfield[2] & ~ bitfield) | value;
		return;
	};

	if (bitfield == zCVob_bitfield3_visualCamAlign)
	{
		vob.bitfield[3] = (vob.bitfield[3] & ~ bitfield) | value;
		return;
	};

	if (bitfield == zCVob_bitfield4_collButNoMove)
	{
		vob.bitfield[4] = (vob.bitfield[4] & ~ bitfield) | value;
		return;
	};

	if (bitfield == zCVob_bitfield4_dontWriteIntoArchive)
	{
		if ((value == 0) || (value == 1)) {
			value = bitfield * value;
		};

		vob.bitfield[4] = (vob.bitfield[4] & ~ bitfield) | value;
		return;
	};
};

func int Vob_GetBitfield (var int vobPtr, var int bitfield) {
	if (!vobPtr) { return 0; };
	var zCVob vob; vob = _^ (vobPtr);

	//Basically true/false values
	if (bitfield == zCVob_bitfield0_showVisual)
	|| (bitfield == zCVob_bitfield0_drawBBox3D)
	|| (bitfield == zCVob_bitfield0_visualAlphaEnabled)
	|| (bitfield == zCVob_bitfield0_physicsEnabled)
	|| (bitfield == zCVob_bitfield0_staticVob)
	|| (bitfield == zCVob_bitfield0_ignoredByTraceRay)
	|| (bitfield == zCVob_bitfield0_collDetectionStatic)
	|| (bitfield == zCVob_bitfield0_collDetectionDynamic)
	|| (bitfield == zCVob_bitfield0_castDynShadow)
	|| (bitfield == zCVob_bitfield0_lightColorStatDirty)
	|| (bitfield == zCVob_bitfield0_lightColorDynDirty)
	{
		return (vob.bitfield[0] & bitfield);
	};

	if (bitfield == zCVob_bitfield1_isInMovementMode)
	{
		return (vob.bitfield[1] & bitfield);
	};

	if (bitfield == zCVob_bitfield2_sleepingMode)
	|| (bitfield == zCVob_bitfield2_mbHintTrafoLocalConst)
	|| (bitfield == zCVob_bitfield2_mbInsideEndMovementMethod)
	{
		return (vob.bitfield[2] & bitfield);
	};

	if (bitfield == zCVob_bitfield3_visualCamAlign)
	{
		return (vob.bitfield[3] & bitfield);
	};

	if (bitfield == zCVob_bitfield4_collButNoMove)
	|| (bitfield == zCVob_bitfield4_dontWriteIntoArchive)
	{
		return (vob.bitfield[4] & bitfield);
	};

	return 0;
};

/*
 *	Function updates bitfields for vob and all it's children
 */
func void VobTree_SetBitfield (var int vobPtr, var int bitfield, var int value) {
	if (!vobPtr) { return; };

	Vob_SetBitfield (vobPtr, bitfield, value);

	var zCVob vob; vob = _^ (vobPtr);

	//Loop through all child objects
	var zCTree tree;
	var int treePtr; treePtr = vob.globalVobTreeNode;
	if (treePtr) {
		tree = _^ (treePtr);
		treePtr = tree.firstChild;
	};

	//Loop through tree (will this work?)
	while (treePtr);
		var zCTree child; child = _^ (treePtr);

		if (child.data) {
			//Update data
			Vob_SetBitfield (child.data, bitfield, value);
		};

		//Get next child
		treePtr = child.next;
	end;
};

func int zCVob_GetBBox3DLocal (var int vobPtr) {
	//0x005EDCF0 public: struct zTBBox3D __thiscall zCVob::GetBBox3DLocal(void)const
	const int zCVob__GetBBox3DLocal_G1 = 6216944;

	//0x0061B1F0 public: struct zTBBox3D __thiscall zCVob::GetBBox3DLocal(void)const
	const int zCVob__GetBBox3DLocal_G2 = 6402544;

	if (!vobPtr) { return 0; };

	//CALL_RetValIsStruct only supported in disposable calls
	CALL_RetValIsStruct (24);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetBBox3DLocal_G1, zCVob__GetBBox3DLocal_G2));
	return CALL_RetValAsPtr ();
};

func void zCVob_SetBBox3DLocal (var int vobPtr, var int bboxPtr) {
	//0x005EDC40 public: void __thiscall zCVob::SetBBox3DLocal(struct zTBBox3D const &)
	const int zCVob__SetBBox3DLocal_G1 = 6216768;

	//0x0061B140 public: void __thiscall zCVob::SetBBox3DLocal(struct zTBBox3D const &)
	const int zCVob__SetBBox3DLocal_G2 = 6402368;

	if (!bboxPtr) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (bboxPtr));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetBBox3DLocal_G1, zCVob__SetBBox3DLocal_G2));
		call = CALL_End();
	};
};

func int zCVob_GetBBox3DWorld (var int vobPtr) {
	if (!vobPtr) { return 0; };

	var zCVob vob; vob = _^ (vobPtr);
	return _@ (vob.bbox3D_mins[0]);
};

func void zCVob_SetBBox3DWorld (var int vobPtr, var int bboxPtr) {
	//0x005EDBE0 public: void __thiscall zCVob::SetBBox3DWorld(struct zTBBox3D const &)
	const int zCVob__SetBBox3DWorld_G1 = 6216672;

	//0x0061B0E0 public: void __thiscall zCVob::SetBBox3DWorld(struct zTBBox3D const &)
	const int zCVob__SetBBox3DWorld_G2 = 6402272;

	if (!vobPtr) { return; };
	if (!bboxPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (bboxPtr));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetBBox3DWorld_G1, zCVob__SetBBox3DWorld_G2));
		call = CALL_End();
	};
};

func int zCVob_GetDistanceToVob (var int vobPtr1, var int vobPtr2) {
	//0x005EE400 public: float __thiscall zCVob::GetDistanceToVob(class zCVob &)
	const int zCVob__GetDistanceToVob_G1 = 6218752;

	//0x0061B910 public: float __thiscall zCVob::GetDistanceToVob(class zCVob &)
	const int zCVob__GetDistanceToVob_G2 = 6404368;

	if (!vobPtr1) { return FLOATNULL; };
	if (!vobPtr2) { return FLOATNULL; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_RetValIsFloat ();
		CALL_PtrParam (_@ (vobPtr2));
		CALL__thiscall (_@ (vobPtr1), MEMINT_SwitchG1G2 (zCVob__GetDistanceToVob_G1, zCVob__GetDistanceToVob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsFloat ();
};

/*
 *
 */
func void Vob_SetAlpha (var int vobPtr, var int visualAlpha) {
	if (!vobPtr) { return; };

	var zCVob vob; vob = _^ (vobPtr);
	vob.bitfield[0] = vob.bitfield[0] | zCVob_bitfield0_visualAlphaEnabled;
	vob.visualAlpha = divf (mkf (visualAlpha), mkf (100));
};

func void VobTree_SetAlpha (var int vobPtr, var int visualAlpha) {
	if (!vobPtr) { return; };

	Vob_SetAlpha (vobPtr, visualAlpha);

	var zCVob vob; vob = _^ (vobPtr);

	//Loop through all child objects
	var zCTree tree;
	var int treePtr; treePtr = vob.globalVobTreeNode;
	if (treePtr) {
		tree = _^ (treePtr);
		treePtr = tree.firstChild;
	};

	//Loop through tree (will this work?)
	while (treePtr);
		var zCTree child; child = _^ (treePtr);

		//Update data
		if (child.data) {
			Vob_SetAlpha (child.data, visualAlpha);
		};

		//Get next child
		treePtr = child.next;
	end;
};

/*
 *	zCModel_SearchNode
 *	 - returns pointer to node
 */
func int zCModel_SearchNode (var int modelPtr, var string nodeName) {
	//0x00563F80 public: class zCModelNodeInst * __thiscall zCModel::SearchNode(class zSTRING const &)
	const int zCModel__SearchNode_G1 = 5652352;

	//0x0057DFF0 public: class zCModelNodeInst * __thiscall zCModel::SearchNode(class zSTRING const &)
	const int zCModel__SearchNode_G2 = 5758960;

	if (!modelPtr) { return 0; };

	CALL_zStringPtrParam (nodeName);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__SearchNode_G1, zCModel__SearchNode_G2));

	return CALL_RetValAsPtr ();
};

/*
 *	zCModel_GetBBox3DNodeWorld
 */
func void zCModel_GetBBox3DNodeWorld (var int modelPtr, var int modelNodeInstPtr, var int bboxPtr) {
	//0x0055F870 public: struct zTBBox3D __thiscall zCModel::GetBBox3DNodeWorld(class zCModelNodeInst *)
	const int zCModel__GetBBox3DNodeWorld_G1 = 5634160;

	//0x005790F0 public: struct zTBBox3D __thiscall zCModel::GetBBox3DNodeWorld(class zCModelNodeInst *)
	const int zCModel__GetBBox3DNodeWorld_G2 = 5738736;

	if (!modelPtr) { return; };
	if (!modelNodeInstPtr) { return; };
	if (!bboxPtr) { return; };

	CALL_RetValIsStruct (24);
	CALL_PtrParam (modelNodeInstPtr);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__GetBBox3DNodeWorld_G1, zCModel__GetBBox3DNodeWorld_G2));

	var int bboxPosPtr; bboxPosPtr = CALL_RetValAsPtr ();
	MEM_CopyBytes (bboxPosPtr, bboxPtr, 24);
	MEM_Free (bboxPosPtr);
};

/*
 *	zCModel_GetNodePositionWorld
 *	 - returns true if node was found, posPtr is updated with position
 */
func int zCModel_GetNodePositionWorld (var int modelPtr, var int nodePtr, var int posPtr) {
	//0x0055F8C0 public: class zVEC3 __thiscall zCModel::GetNodePositionWorld(class zCModelNodeInst *)
	const int zCModel__GetNodePositionWorld_G1 = 5634240;

	//0x00579140 public: class zVEC3 __thiscall zCModel::GetNodePositionWorld(class zCModelNodeInst *)
	const int zCModel__GetNodePositionWorld_G2 = 5738816;

	if (!modelPtr) { return FALSE; };
	if (!nodePtr) { return FALSE; };

	CALL_RetValIsStruct (12);
	CALL_PtrParam (nodePtr);
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__GetNodePositionWorld_G1, zCModel__GetNodePositionWorld_G2));

	var int vobPosPtr; vobPosPtr = CALL_RetValAsPtr ();
	MEM_CopyBytes (vobPosPtr, posPtr, 12);
	MEM_Free (vobPosPtr);

	return TRUE;
};

/*
 *	zCVob_GetTrafoModelNodeToWorld
 *	 - updates trafoPtr with trafo of the node, if node does not exist then with trafo of object itself
 */
func void zCVob_GetTrafoModelNodeToWorld (var int vobPtr, var int modelNodeInstPtr, var int trafoPtr) {
	//0x005D84D0 public: class zMAT4 __thiscall zCVob::GetTrafoModelNodeToWorld(class zCModelNodeInst *)
	const int zCVob__GetTrafoModelNodeToWorld_G1 = 6128848;

	//0x00604A50 public: class zMAT4 __thiscall zCVob::GetTrafoModelNodeToWorld(class zCModelNodeInst *)
	const int zCVob__GetTrafoModelNodeToWorld_G2 = 6310480;

	if (!vobPtr) { return; };
	if (!modelNodeInstPtr) { return; };

	CALL_RetValIsStruct (64);
	CALL_PtrParam (modelNodeInstPtr);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetTrafoModelNodeToWorld_G1, zCVob__GetTrafoModelNodeToWorld_G2));

	var int vobTrafoPtr; vobTrafoPtr = CALL_RetValAsPtr ();
	MEM_CopyBytes (vobTrafoPtr, trafoPtr, 64);
	MEM_Free (vobTrafoPtr);
};

/*
 *	zCVob_GetTrafoModelNodeToWorldByName
 *	 - updates trafoPtr with trafo of the node, if node does not exist then with trafo of object itself
 */
func void zCVob_GetTrafoModelNodeToWorldByName (var int vobPtr, var string nodeName, var int trafoPtr) {
	//0x005D83E0 public: class zMAT4 __thiscall zCVob::GetTrafoModelNodeToWorld(class zSTRING const &)
	const int zCVob__GetTrafoModelNodeToWorld_G1 = 6128608;

	//0x00604960 public: class zMAT4 __thiscall zCVob::GetTrafoModelNodeToWorld(class zSTRING const &)
	const int zCVob__GetTrafoModelNodeToWorld_G2 = 6310240;

	if (!vobPtr) { return; };

	CALL_RetValIsStruct (64);
	CALL_zStringPtrParam (nodeName);
	CALL__thiscall (vobPtr, MEMINT_SwitchG1G2 (zCVob__GetTrafoModelNodeToWorld_G1, zCVob__GetTrafoModelNodeToWorld_G2));
	var int vobTrafoPtr; vobTrafoPtr = CALL_RetValAsPtr ();
	MEM_CopyBytes (vobTrafoPtr, trafoPtr, 64);
	MEM_Free (vobTrafoPtr);
};

/*
 *	zCVob_GetTrafoModelNode
 *	 - updates trafoPtr with trafo of the node, if node does not exist function returns value FALSE
 */
func int zCVob_GetTrafoModelNode (var int vobPtr, var string nodeName, var int trafoPtr) {
	if (!Hlp_VobVisual_Is_zCModel (vobPtr)) { return FALSE; };

	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	if (!zCModel_SearchNode (visualPtr, nodeName)) { return FALSE; };

	zCVob_GetTrafoModelNodeToWorldByName (vobPtr, nodeName, trafoPtr);

	return TRUE;
};

func void zCModel_SetDrawSkeleton (var int enabled) {
	//0x00873C20 private: static int zCModel::s_drawSkeleton
	const int zCModel__s_drawSkeleton_G1 = 8862752;

	//0x008D8A84 private: static int zCModel::s_drawSkeleton
	const int zCModel__s_drawSkeleton_G2 = 9276036;

	//var int s_drawSkeleton; s_drawSkeleton = MEMINT_SwitchG1G2 (zCModel__s_drawSkeleton_G1, zCModel__s_drawSkeleton_G2);
	MEM_WriteInt (MEMINT_SwitchG1G2 (zCModel__s_drawSkeleton_G1, zCModel__s_drawSkeleton_G2), enabled);
};

func void zCVob_SetCollDet (var int vobPtr, var int enabled) {
	//0x00645050 public: void __thiscall zCVob::SetCollDet(int)
	const int zCVob__SetCollDet_G1 = 6574160;

	//0x006D0000 public: void __thiscall zCVob::SetCollDet(int)
	const int zCVob__SetCollDet_G2 = 7143424;

	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (enabled));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetCollDet_G1, zCVob__SetCollDet_G2));
		call = CALL_End ();
	};
};

func void zCVob_SetAI (var int vobPtr, var int ai) {
	//0x005D3730 public: void __thiscall zCVob::SetAI(class zCAIBase *)
	const int zCVob__SetAI_G1 = 6108976;

	//0x005FE8F0 public: void __thiscall zCVob::SetAI(class zCAIBase *)
	const int zCVob__SetAI_G2 = 6285552;

	if (!ai) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (ai));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetAI_G1, zCVob__SetAI_G2));
		call = CALL_End ();
	};
};

func int zCVob_GetAI (var int vobPtr) {
	if (!vobPtr) { return 0; };

	var zCVob vob; vob = _^ (vobPtr);
	return vob.callback_ai;
};

func void zCVob_SetAICallback (var int vobPtr, var int cbai) {
	zCVob_SetAI (vobPtr, cbai);
};

func int zCVob_GetAICallback (var int vobPtr) {
	return + zCVob_GetAI (vobPtr);
};

func string Vob_GetDescriptionRot (var int vobPtr) {
	var int trafo[16];
	zCVob_GetTrafo (vobPtr, _@ (trafo));
	return zMAT4_GetDescriptionRot (_@ (trafo));
};

func string Vob_GetDescriptionPos (var int vobPtr) {
	var int trafo[16];
	zCVob_GetTrafo (vobPtr, _@ (trafo));
	return zMAT4_GetDescriptionPos (_@ (trafo));
};

func void Vob_SetByDescriptionRot (var int vobPtr, var string desc) {
	var int trafo[16];
	zCVob_GetTrafo (vobPtr, _@ (trafo));
	zMAT4_SetByDescriptionRot (_@ (trafo), desc);
	zCVob_SetTrafo (vobPtr, _@ (trafo));
};

func void Vob_SetByDescriptionPos (var int vobPtr, var string desc) {
	var int trafo[16];
	zCVob_GetTrafo (vobPtr, _@ (trafo));
	zMAT4_SetByDescriptionPos (_@ (trafo), desc);
	zCVob_SetTrafo (vobPtr, _@ (trafo));
};

func int zCMesh_SharePoly (var int ptr, var int index) {
	//0x00551F10 public: class zCPolygon * __thiscall zCMesh::SharePoly(int)const
	const int zCMesh__SharePoly_G1 = 5578512;

	//0x00569760 public: class zCPolygon * __thiscall zCMesh::SharePoly(int)const
	const int zCMesh__SharePoly_G2 = 5674848;

	if (!ptr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (index));
		CALL__thiscall (_@ (ptr), MEMINT_SwitchG1G2 (zCMesh__SharePoly_G1, zCMesh__SharePoly_G2));
		call = CALL_End();
	};

	return Call_RetValAsPtr ();
};

func int zCVob_GetHomeWorld (var int vobPtr) {
	//0x0073F4D0 public: class zCWorld * __thiscall zCVob::GetHomeWorld(void)const
	const int zCVob__GetHomeWorld_G1 = 7599312;

	//0x006742A0 public: class zCWorld * __thiscall zCVob::GetHomeWorld(void)const
	const int zCVob__GetHomeWorld_G2 = 6767264;

	if (!vobPtr) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__GetHomeWorld_G1, zCVob__GetHomeWorld_G2));
		call = CALL_End();
	};

	return Call_RetValAsPtr ();
};
