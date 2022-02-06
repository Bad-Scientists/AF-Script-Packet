/*
 *	Dependencies: vectors.d
 */

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
 *	Vob_RestoreCollBits - will apply collisions based on input bitfield values in collBits
 */
func void Vob_RestoreCollBits (var int vobPtr, var int collBits) {
	if (!vobPtr) { return; };
	var zCVob vob; vob = _^ (vobPtr);
	vob.bitfield[0] = (vob.bitfield[0] | collBits);
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


func int Hlp_Is_zCDecal (var int vobPtr) {
	if (!vobPtr) { return FALSE; };
	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	if (!visualPtr) { return FALSE; };
	var zCVisual visual; visual = _^ (visualPtr);

	//visual zCDecal

	//Ikarus constant for G1 has incorrect value ... G2A is not defined
	//0x007D3E04 const zCDecal::`vftable'
	const int zCDecal_vtbl_G1 = 8207876;

	//0x00832084 const zCDecal::`vftable'
	const int zCDecal_vtbl_G2 = 8593540;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCDecal_vtbl_G1, zCDecal_vtbl_G2)) {
		return TRUE;
	};

	return FALSE;
};

func int Hlp_Is_zCModel (var int vobPtr) {
	if (!vobPtr) { return FALSE; };
	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	if (!visualPtr) { return FALSE; };
	var zCVisual visual; visual = _^ (visualPtr);

	//visual zCModel

	//0x007D3FEC const zCModel::`vftable'
	const int zCModel_vtbl_G1 = 8208364;

	//0x0083234C const zCModel::`vftable'
	const int zCModel_vtbl_G2 = 8594252;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCModel_vtbl_G1, zCModel_vtbl_G2)) {
		return TRUE;
	};

	return FALSE;
};

func int Hlp_Is_zCProgMeshProto (var int vobPtr) {
	if (!vobPtr) { return FALSE; };
	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	if (!visualPtr) { return FALSE; };
	var zCVisual visual; visual = _^ (visualPtr);

	//visual zCProgMeshProto

	//0x007D45F4 const zCProgMeshProto::`vftable'
	const int zCProgMeshProto_vtbl_G1 = 8209908;

	//0x008329CC const zCProgMeshProto::`vftable'
	const int zCProgMeshProto_vtbl_G2 = 8595916;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCProgMeshProto_vtbl_G1, zCProgMeshProto_vtbl_G2)) {
		return TRUE;
	};

	return FALSE;
};

func int Hlp_Is_zCParticleFX (var int vobPtr) {
	if (!vobPtr) { return FALSE; };
	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	if (!visualPtr) { return FALSE; };
	var zCVisual visual; visual = _^ (visualPtr);

	//visual zCParticleFX

	//0x007D4214 const zCParticleFX::`vftable'
	const int zCParticleFX_vtbl_G1 = 8208916;

	//0x008325C4 const zCParticleFX::`vftable'
	const int zCParticleFX_vtbl_G2 = 8594884;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCParticleFX_vtbl_G1, zCParticleFX_vtbl_G2)) {
		return TRUE;
	};

	return FALSE;
};

func int Hlp_Is_zCMorphMesh (var int vobPtr) {
	if (!vobPtr) { return FALSE; };
	var int visualPtr; visualPtr = zCVob_GetVisual (vobPtr);

	if (!visualPtr) { return FALSE; };
	var zCVisual visual; visual = _^ (visualPtr);

	//visual zCMorphMesh

	//0x007D4144 const zCMorphMesh::`vftable'
	const int zCMorphMesh_vtbl_G1 = 8208708;

	//0x008324D4 const zCMorphMesh::`vftable'
	const int zCMorphMesh_vtbl_G2 = 8594644;

	if (visual._vtbl == MEMINT_SwitchG1G2 (zCMorphMesh_vtbl_G1, zCMorphMesh_vtbl_G2)) {
		return TRUE;
	};

	return FALSE;
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

func void Vob_ChangeDataByName (var string vobName, var int staticVob, var int collStat, var int collDyn, var int showVisual) {
	var int arr; arr = MEM_SearchAllVobsByName (vobName);

	var zCArray zarr; zarr = _^ (arr);

	var int onBits;
	var int offBits;

	onBits = ( showVisual * zCVob_bitfield0_showVisual + staticVob * zCVob_bitfield0_staticVob + collStat * zCVob_bitfield0_collDetectionStatic + collDyn * zCVob_bitfield0_collDetectionDynamic);
	offBits = (!showVisual * zCVob_bitfield0_showVisual + !staticVob * zCVob_bitfield0_staticVob + !collStat * zCVob_bitfield0_collDetectionStatic + !collDyn * zCVob_bitfield0_collDetectionDynamic);

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
func void zMAT4__PostRotateX (var int trafoPtr, var int degrees) {
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

func void zMAT4__PostRotateY (var int trafoPtr, var int degrees) {
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

func void zMAT4__PostRotateZ (var int trafoPtr, var int degrees) {
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

func void _Vob_SetDontWriteIntoArchive (var int vobPtr, var int value) {
	if (!vobPtr) { return; };

	var zCVob vob;
	vob = _^ (vobPtr);

	if (value) {
		vob.bitfield[4] = (vob.bitfield[4] | zCVob_bitfield4_dontWriteIntoArchive);
	} else {
		vob.bitfield[4] = (vob.bitfield[4] & ~ zCVob_bitfield4_dontWriteIntoArchive);
	};
};

/*
 *	Function updates dontWriteIntoArchive flag for vob and its subtree
 */
func void Vob_SetDontWriteIntoArchive (var int vobPtr, var int value) {
	if (!vobPtr) { return; };

	//Update vob data
	_Vob_SetDontWriteIntoArchive (vobPtr, value);

	var zCVob vob;
	vob = _^ (vobPtr);

	//Update child-data
	var int treePtr; treePtr = vob.globalVobTreeNode;

	//Loop through tree (will this work?)
	while (treePtr);
		//Get tree
		var zCTree tree; tree = _^ (treePtr);

		//Get first child
		var zCTree child; child = _^ (tree.firstChild);

		//Update data
		_Vob_SetDontWriteIntoArchive (child.data, value);

		//Get next child
		treePtr = tree.next;
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
