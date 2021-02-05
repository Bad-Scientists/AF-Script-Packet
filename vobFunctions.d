func int oCMob_GetModel (var int mobPtr) {
	//0067AD00  .text     Debug data           ?GetModel@oCMOB@@UAEPAVzCModel@@XZ
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
	//00563EF0  .text     Debug data           ?GetVisualName@zCModel@@UAE?AVzSTRING@@XZ
	const int zCModel__GetVisualName_G1 = 5652208;
	
	//0x0057DF60 public: virtual class zSTRING __thiscall zCModel::GetVisualName(void)
	const int zCModel__GetVisualName_G2 = 5758816;

	if (!modelPtr) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (modelPtr, MEMINT_SwitchG1G2 (zCModel__GetVisualName_G1, zCModel__GetVisualName_G2));
	return CALL_RetValAszstring ();
};

func string zCVob_GetVisualName (var int vobPtr) {
	if (!vobPtr) { return ""; };

	var zCVob vob; vob = _^ (vobPtr);
	
	if (!vob.visual) { return ""; };
	
	var zCObject visualObj;
	visualObj = _^ (vob.visual);
	
	return visualObj.objectName;
};
	
func string Vob_GetVisualName (var int vobPtr){
	if (!vobPtr) { return ""; };

	//in case of oCMob we need to get visual from object model
	if (Hlp_Is_oCMob (vobPtr)){
		var int modelPtr; modelPtr = oCMob_GetModel (vobPtr);
		return zCModel_GetVisualName (modelPtr);
	};

	return zCVob_GetVisualName (vobPtr);
};
