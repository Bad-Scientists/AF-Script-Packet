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
func void zCVob_SetSleeping (var int vobPtr, var int sleeping) {
	//0x005D7250 public: void __thiscall zCVob::SetSleeping(int)
	const int zCVob__SetSleeping_G1 = 6124112;
	
	//0x00602930 public: void __thiscall zCVob::SetSleeping(int)
	const int zCVob__SetSleeping_G2 = 6302000;
	
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (sleeping));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__SetSleeping_G1, zCVob__SetSleeping_G2));
		call = CALL_End();
	};
};

func int zCVob_HasParentVob (var int vobPtr) {
	//0x005EF620 public: int __thiscall zCVob::HasParentVob(void)const 
	const int zCVob__HasParentVob_G1 = 6223392;
	
	//
	const int zCVob__HasParentVob_G2 = 0;
	
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

	//CALL_RetValIsStruct (12);
	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (vecPtr), MEMINT_SwitchG1G2 (zVEC3__NormalizeSafe_G1, zVEC3__NormalizeSafe_G2));
		call = CALL_End();
	};

	MEM_CopyBytes(CALL_RetValAsPtr(), _@ (vec), 12);

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