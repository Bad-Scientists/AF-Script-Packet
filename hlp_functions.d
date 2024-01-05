/*
 *
 */
func int Hlp_Is_zCObject (var int ptr) {
	//0x00873E70 private: static class zCClassDef zCObject::classDef
	const int zCObject__classDef_G1 = 8863344;

	//0x008D8CD8 private: static class zCClassDef zCObject::classDef
	const int zCObject__classDef_G2 = 9276632;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCObject__classDef_G1, zCObject__classDef_G2));
};

func int Hlp_Is_zCTrigger (var int ptr) {
	//0x008D7B78 private: static class zCClassDef zCTrigger::classDef
	const int zCTrigger__classDef_G1 = 9272184;

	//0x009A3D70 private: static class zCClassDef zCTrigger::classDef
	const int zCTrigger__classDef_G2 = 10108272;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCTrigger__classDef_G1, zCTrigger__classDef_G2));
};

func int Hlp_Is_oCTriggerScript (var int ptr) {
	//0x0085ED08 private: static class zCClassDef oCTriggerScript::classDef
	const int oCTriggerScript__classDef_G1 = 8776968;

	//0x008C2E48 private: static class zCClassDef oCTriggerScript::classDef
	const int oCTriggerScript__classDef_G2 = 9186888;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCTriggerScript__classDef_G1, oCTriggerScript__classDef_G2));
};

func int Hlp_Is_zCEventManager (var int ptr) {
	//0x008DC690 private: static class zCClassDef zCEventManager::classDef
	const int zCEventManager__classDef_G1 = 9291408;

	//0x00AB3948 private: static class zCClassDef zCEventManager::classDef
	const int zCEventManager__classDef_G2 = 11221320;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEventManager__classDef_G1, zCEventManager__classDef_G2));
};

func int Hlp_Is_zCCSCutsceneContext (var int ptr) {
	//0x0085E288 private: static class zCClassDef zCCSCutsceneContext::classDef
	const int zCCSCutsceneContext__classDef_G1 = 8774280;

	//0x008C2120 private: static class zCClassDef zCCSCutsceneContext::classDef
	const int zCCSCutsceneContext__classDef_G2 = 9183520;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCCSCutsceneContext__classDef_G1, zCCSCutsceneContext__classDef_G2));
};

func int Hlp_Is_zCEvMsgCutscene (var int ptr) {
	//0x0085E2F8 private: static class zCClassDef zCEvMsgCutscene::classDef
	const int zCEvMsgCutscene__classDef_G1 = 8774392;

	//0x008C2190 private: static class zCClassDef zCEvMsgCutscene::classDef
	const int zCEvMsgCutscene__classDef_G2 = 9183632;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEvMsgCutscene__classDef_G1, zCEvMsgCutscene__classDef_G2));
};

func int Hlp_Is_oCNpcMessage (var int ptr) {
	//0x008DBEF8 private: static class zCClassDef oCNpcMessage::classDef
	const int oCNpcMessage__classDef_G1 = 9289464;

	//0x00AB2B60 private: static class zCClassDef oCNpcMessage::classDef
	const int oCNpcMessage__classDef_G2 = 11217760;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCNpcMessage__classDef_G1, oCNpcMessage__classDef_G2));
};

func int Hlp_Is_oCMsgAttack (var int ptr) {
	//0x008DBE18 private: static class zCClassDef oCMsgAttack::classDef
	const int oCMsgAttack__classDef_G1 = 9289240;

	//0x00AB2A70 private: static class zCClassDef oCMsgAttack::classDef
	const int oCMsgAttack__classDef_G2 = 11217520;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgAttack__classDef_G1, oCMsgAttack__classDef_G2));
};

func int Hlp_Is_oCMsgState (var int ptr) {
	//0x008DBE88 private: static class zCClassDef oCMsgState::classDef
	const int oCMsgState__classDef_G1 = 9289352;

	//0x00AB2AE0 private: static class zCClassDef oCMsgState::classDef
	const int oCMsgState__classDef_G2 = 11217632;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgState__classDef_G1, oCMsgState__classDef_G2));
};

func int Hlp_Is_oCMsgManipulate (var int ptr) {
	//0x008DBC58 private: static class zCClassDef oCMsgManipulate::classDef
	const int oCMsgManipulate__classDef_G1 = 9288792;

	//0x00AB2860 private: static class zCClassDef oCMsgManipulate::classDef
	const int oCMsgManipulate__classDef_G2 = 11216992;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgManipulate__classDef_G1, oCMsgManipulate__classDef_G2));
};

func int Hlp_Is_oCMsgUseItem (var int ptr) {
	//0x008DBCC8 private: static class zCClassDef oCMsgUseItem::classDef
	const int oCMsgUseItem__classDef_G1 = 9288904;

	//0x00AB28E8 private: static class zCClassDef oCMsgUseItem::classDef
	const int oCMsgUseItem__classDef_G2 = 11217128;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgUseItem__classDef_G1, oCMsgUseItem__classDef_G2));
};

func int Hlp_Is_oCMsgDamage (var int ptr) {
	//0x008DBDA8 private: static class zCClassDef oCMsgDamage::classDef
	const int oCMsgDamage__classDef_G1 = 9289128;

	//0x00AB29F0 private: static class zCClassDef oCMsgDamage::classDef
	const int oCMsgDamage__classDef_G2 = 11217392;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgDamage__classDef_G1, oCMsgDamage__classDef_G2));
};

func int Hlp_Is_oCMsgConversation (var int ptr) {
	//0x008DBD38 private: static class zCClassDef oCMsgConversation::classDef
	const int oCMsgConversation__classDef_G1 = 9289016;

	//0x00AB2980 private: static class zCClassDef oCMsgConversation::classDef
	const int oCMsgConversation__classDef_G2 = 11217280;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgConversation__classDef_G1, oCMsgConversation__classDef_G2));
};

func int Hlp_Is_zCEventCore (var int ptr) {
	//0x008D7348 private: static class zCClassDef zCEventCore::classDef
	const int zCEventCore__classDef_G1 = 9270088;

	//0x009A3548 private: static class zCClassDef zCEventCore::classDef
	const int zCEventCore__classDef_G2 = 10106184;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEventCore__classDef_G1, zCEventCore__classDef_G2));
};

func int Hlp_Is_oCMsgMovement (var int ptr) {
	//0x008DBFD8 private: static class zCClassDef oCMsgMovement::classDef
	const int oCMsgMovement__classDef_G1 = 9289688;

	//0x00AB2C50 private: static class zCClassDef oCMsgMovement::classDef
	const int oCMsgMovement__classDef_G2 = 11218000;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgMovement__classDef_G1, oCMsgMovement__classDef_G2));
};

func int Hlp_Is_oCMsgWeapon (var int ptr) {
	//0x008DC048 private: static class zCClassDef oCMsgWeapon::classDef
	const int oCMsgWeapon__classDef_G1 = 9289800;

	//0x00AB2CC0 private: static class zCClassDef oCMsgWeapon::classDef
	const int oCMsgWeapon__classDef_G2 = 11218112;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgWeapon__classDef_G1, oCMsgWeapon__classDef_G2));
};

func int Hlp_Is_oCMsgMagic (var int ptr) {
	//0x008DBF68 private: static class zCClassDef oCMsgMagic::classDef
	const int oCMsgMagic__classDef_G1 = 9289576;

	//0x00AB2BE0 private: static class zCClassDef oCMsgMagic::classDef
	const int oCMsgMagic__classDef_G2 = 11217888;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMsgMagic__classDef_G1, oCMsgMagic__classDef_G2));
};

func int Hlp_Is_oCMobMsg (var int ptr) {
	//0x008DAD30 private: static class zCClassDef oCMobMsg::classDef
	const int oCMobMsg__classDef_G1 = 9284912;

	//0x00AB1618 private: static class zCClassDef oCMobMsg::classDef
	const int oCMobMsg__classDef_G2 = 11212312;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCMobMsg__classDef_G1, oCMobMsg__classDef_G2));
};

func int Hlp_Is_zCEventMusicControler (var int ptr) {
	//0x008DE520 private: static class zCClassDef zCEventMusicControler::classDef
	const int zCEventMusicControler__classDef_G1 = 9299232;

	//0x009A4A38 private: static class zCClassDef zCEventMusicControler::classDef
	const int zCEventMusicControler__classDef_G2 = 10111544;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEventMusicControler__classDef_G1, zCEventMusicControler__classDef_G2));
};

func int Hlp_Is_zCEventScreenFX (var int ptr) {
	//0x008D7A28 private: static class zCClassDef zCEventScreenFX::classDef
	const int zCEventScreenFX__classDef_G1 = 9271848;

	//0x009A3C20 private: static class zCClassDef zCEventScreenFX::classDef
	const int zCEventScreenFX__classDef_G2 = 10107936;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEventScreenFX__classDef_G1, zCEventScreenFX__classDef_G2));
};

func int Hlp_Is_zCEventMover (var int ptr) {
	//0x008D7690 private: static class zCClassDef zCEventMover::classDef
	const int zCEventMover__classDef_G1 = 9270928;

	//0x009A3890 private: static class zCClassDef zCEventMover::classDef
	const int zCEventMover__classDef_G2 = 10107024;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEventMover__classDef_G1, zCEventMover__classDef_G2));
};

func int Hlp_Is_zCEventCommon (var int ptr) {
	//0x008D7DA8 private: static class zCClassDef zCEventCommon::classDef
	const int zCEventCommon__classDef_G1 = 9272744;

	//0x009A3FA0 private: static class zCClassDef zCEventCommon::classDef
	const int zCEventCommon__classDef_G2 = 10108832;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEventCommon__classDef_G1, zCEventCommon__classDef_G2));
};

func int Hlp_Is_zCCSCamera_EventMsg (var int ptr) {
	//0x0086C5F8 private: static class zCClassDef zCCSCamera_EventMsg::classDef
	const int zCCSCamera_EventMsg__classDef_G1 = 8832504;

	//0x008D0F38 private: static class zCClassDef zCCSCamera_EventMsg::classDef
	const int zCCSCamera_EventMsg__classDef_G2 = 9244472;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCCSCamera_EventMsg__classDef_G1, zCCSCamera_EventMsg__classDef_G2));
};

func int Hlp_Is_zCCSCamera_EventMsgActivate (var int ptr) {
	//0x0086C748 private: static class zCClassDef zCCSCamera_EventMsgActivate::classDef
	const int zCCSCamera_EventMsgActivate__classDef_G1 = 8832840;

	//0x008D1098 private: static class zCClassDef zCCSCamera_EventMsgActivate::classDef
	const int zCCSCamera_EventMsgActivate__classDef_G2 = 9244824;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCCSCamera_EventMsgActivate__classDef_G1, zCCSCamera_EventMsgActivate__classDef_G2));
};

func int Hlp_Is_zCEventMessage (var int ptr) {
	//0x008D7498 private: static class zCClassDef zCEventMessage::classDef
	const int zCEventMessage__classDef_G1 = 9270424;

	//0x009A3698 private: static class zCClassDef zCEventMessage::classDef
	const int zCEventMessage__classDef_G2 = 10106520;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCEventMessage__classDef_G1, zCEventMessage__classDef_G2));
};

/*
 *
 */
func int Hlp_Is_oCAniCtrl_Human (var int ptr) {
	//0x008D8BE0 private: static class zCClassDef oCAniCtrl_Human::classDef
	const int oCAniCtrl_Human__classDef_G1 = 9276384;

	//0x00AADB38 private: static class zCClassDef oCAniCtrl_Human::classDef
	const int oCAniCtrl_Human__classDef_G2 = 11197240;

	if (!ptr) { return 0; };
	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCAniCtrl_Human__classDef_G1, oCAniCtrl_Human__classDef_G2));
};

/*
 *
 */

func int Hlp_Is_zCDecal (var int ptr) {
	//0x00873758 private: static class zCClassDef zCDecal::classDef
	const int zCDecal__classDef_G1 = 8861528;

	//0x008D84B0 private: static class zCClassDef zCDecal::classDef
	const int zCDecal__classDef_G2 = 9274544;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCDecal__classDef_G1, zCDecal__classDef_G2));
};

func int Hlp_Is_zCModel (var int ptr) {
	//0x00873B10 private: static class zCClassDef zCModel::classDef
	const int zCModel__classDef_G1 = 8862480;

	//0x008D8920 private: static class zCClassDef zCModel::classDef
	const int zCModel__classDef_G2 = 9275680;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCModel__classDef_G1, zCModel__classDef_G2));
};

func int Hlp_Is_zCProgMeshProto (var int ptr) {
	//0x008C5B48 private: static class zCClassDef zCProgMeshProto::classDef
	const int zCProgMeshProto__classDef_G1 = 9198408;

	//0x00982B48 private: static class zCClassDef zCProgMeshProto::classDef
	const int zCProgMeshProto__classDef_G2 = 9972552;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCProgMeshProto__classDef_G1, zCProgMeshProto__classDef_G2));
};

func int Hlp_Is_zCVobLensFlare (var int ptr) {
	//0x008D79B8 private: static class zCClassDef zCVobLensFlare::classDef
	const int zCVobLensFlare__classDef_G1 = 9271736;

	//0x009A3BB0 private: static class zCClassDef zCVobLensFlare::classDef
	const int zCVobLensFlare__classDef_G2 = 10107824;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCVobLensFlare__classDef_G1, zCVobLensFlare__classDef_G2));
};

//G1
//0x008CE9E0 private: static class zCClassDef zCSkyControler::classDef
//0x008CEAD0 private: static class zCClassDef zCSkyControler_Mid::classDef
//0x008CEBB8 protected: static class zCSkyControler * zCSkyControler::s_activeSkyControler

//G2
//0x0099AB40 private: static class zCClassDef zCSkyControler::classDef
//0x0099ABB0 private: static class zCClassDef zCSkyControler_Mid::classDef
//0x0099AC8C protected: static class zCSkyControler * zCSkyControler::s_activeSkyControler

func int Hlp_Is_zCSkyControler_Outdoor (var int ptr) {
	//0x008CEA60 private: static class zCClassDef zCSkyControler_Outdoor::classDef
	const int zCSkyControler_Outdoor__classDef_G1 = 9235040;

	//0x0099ACD8 private: static class zCClassDef zCSkyControler_Outdoor::classDef
	const int zCSkyControler_Outdoor__classDef_G2 = 10071256;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCSkyControler_Outdoor__classDef_G1, zCSkyControler_Outdoor__classDef_G2));
};

func int Hlp_Is_zCSkyControler_Indoor (var int ptr) {
	//0x008CEB48 private: static class zCClassDef zCSkyControler_Indoor::classDef
	const int zCSkyControler_Indoor__classDef_G1 = 9235272;

	//0x0099AC20 private: static class zCClassDef zCSkyControler_Indoor::classDef
	const int zCSkyControler_Indoor__classDef_G2 = 10071072;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCSkyControler_Indoor__classDef_G1, zCSkyControler_Indoor__classDef_G2));
};

func int _zCVob_GetVisual (var int vobPtr) {
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

func int Hlp_Is_zCParticleFX (var int ptr) {
	if (!ptr) { return FALSE; };
	var int visualPtr; visualPtr = _zCVob_GetVisual (ptr);

	//0x008742F0 private: static class zCClassDef zCParticleFX::classDef
	const int zCParticleFX__classDef_G1 = 8864496;

	//0x008D91A8 private: static class zCClassDef zCParticleFX::classDef
	const int zCParticleFX__classDef_G2 = 9277864;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCParticleFX__classDef_G1, zCParticleFX__classDef_G2));

	//if (!visualPtr) { return FALSE; };
	//var zCVisual visual; visual = _^ (visualPtr);

	//visual zCParticleFX

	//0x007D4214 const zCParticleFX::`vftable'
	//const int zCParticleFX_vtbl_G1 = 8208916;

	//0x008325C4 const zCParticleFX::`vftable'
	//const int zCParticleFX_vtbl_G2 = 8594884;

	//if (visual._vtbl == MEMINT_SwitchG1G2 (zCParticleFX_vtbl_G1, zCParticleFX_vtbl_G2)) {
	//	return TRUE;
	//};

	//return FALSE;
};

func int Hlp_Is_zCMorphMesh (var int ptr) {
	if (!ptr) { return FALSE; };
	var int visualPtr; visualPtr = _zCVob_GetVisual (ptr);

	//0x00873D98 private: static class zCClassDef zCMorphMesh::classDef
	const int zCMorphMesh__classDef_G1 = 8863128;

	//0x008D8C00 private: static class zCClassDef zCMorphMesh::classDef
	const int zCMorphMesh__classDef_G2 = 9276416;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCMorphMesh__classDef_G1, zCMorphMesh__classDef_G2));

	//if (!visualPtr) { return FALSE; };
	//var zCVisual visual; visual = _^ (visualPtr);

	//visual zCMorphMesh

	//0x007D4144 const zCMorphMesh::`vftable'
	//const int zCMorphMesh_vtbl_G1 = 8208708;

	//0x008324D4 const zCMorphMesh::`vftable'
	//const int zCMorphMesh_vtbl_G2 = 8594644;

	//if (visual._vtbl == MEMINT_SwitchG1G2 (zCMorphMesh_vtbl_G1, zCMorphMesh_vtbl_G2)) {
	//	return TRUE;
	//};

	//return FALSE;
};

func int Hlp_VobVisual_Is_zCDecal (var int ptr) {
	if (!ptr) { return FALSE; };
	var int visualPtr; visualPtr = _zCVob_GetVisual (ptr);

	return + Hlp_Is_zCDecal (visualPtr);

	//if (!visualPtr) { return FALSE; };
	//var zCVisual visual; visual = _^ (visualPtr);

	//visual zCDecal

	//Ikarus constant for G1 has incorrect value ... G2A is not defined
	//0x007D3E04 const zCDecal::`vftable'
	//const int zCDecal_vtbl_G1 = 8207876;

	//0x00832084 const zCDecal::`vftable'
	//const int zCDecal_vtbl_G2 = 8593540;

	//if (visual._vtbl == MEMINT_SwitchG1G2 (zCDecal_vtbl_G1, zCDecal_vtbl_G2)) {
	//	return TRUE;
	//};

	//return FALSE;
};

func int Hlp_VobVisual_Is_zCModel (var int vobPtr) {
	if (!vobPtr) { return FALSE; };
	var int visualPtr; visualPtr = _zCVob_GetVisual (vobPtr);

	return + Hlp_Is_zCModel (visualPtr);
/*
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
*/
};

func int Hlp_VobVisual_Is_zCProgMeshProto (var int vobPtr) {
	if (!vobPtr) { return FALSE; };
	var int visualPtr; visualPtr = _zCVob_GetVisual (vobPtr);

	return + Hlp_Is_zCProgMeshProto (visualPtr);
/*
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
*/
};

func int Hlp_Is_zCVob (var int ptr) {
	//0x008D72D8 private: static class zCClassDef zCVob::classDef
	const int zCVob_classDef_G1 = 9269976;

	//0x009A34D8 private: static class zCClassDef zCVob::classDef
	const int zCVob_classDef_G2 = 10106072;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCVob_classDef_G1, zCVob_classDef_G2));
};

func int Hlp_Is_zCVobSpot (var int ptr) {
	//0x008DE3A0 private: static class zCClassDef zCVobSpot::classDef
	const int zCVobSpot__classDef_G1 = 9298848;

	//0x00AB6648 private: static class zCClassDef zCVobSpot::classDef
	const int zCVobSpot__classDef_G2 = 11232840;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCVobSpot__classDef_G1, zCVobSpot__classDef_G2));
};

func int Hlp_Is_zCWaypoint (var int ptr) {
	//0x008DE330 private: static class zCClassDef zCWaypoint::classDef
	const int zCWaypoint__classDef_G1 = 9298736;

	//0x00AB65D8 private: static class zCClassDef zCWaypoint::classDef
	const int zCWaypoint__classDef_G2 = 11232728;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCWaypoint__classDef_G1, zCWaypoint__classDef_G2));
};

func int Hlp_Is_zCVobWaypoint (var int ptr) {
	//0x007DEA6C const zCVobWaypoint::`vftable'
	//const int zCVobWaypoint_vtbl_G1 = 8252012;

	//0x0083E364 const zCVobWaypoint::`vftable'
	//const int zCVobWaypoint_vtbl_G2 = 8643428;

	//0x008DE250 private: static class zCClassDef zCVobWaypoint::classDef
	const int zCVobWaypoint__classDef_G1 = 9298512;

	//0x00AB64F8 private: static class zCClassDef zCVobWaypoint::classDef
	const int zCVobWaypoint__classDef_G2 = 11232504;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCVobWaypoint__classDef_G1, zCVobWaypoint__classDef_G2));
};

func int Hlp_Is_zCVobAnimate (var int ptr) {
	//0x008D7C58 private: static class zCClassDef zCVobAnimate::classDef
	const int zCVobAnimate__classDef_G1 = 9272408;

	//0x009A3E50 private: static class zCClassDef zCVobAnimate::classDef
	const int zCVobAnimate__classDef_G2 = 10108496;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (zCVobAnimate__classDef_G1, zCVobAnimate__classDef_G2));
};

func int Hlp_Is_oCAIVobMove (var int ptr) {
	//0x008D8900 private: static class zCClassDef oCAIVobMove::classDef
	const int oCAIVobMove__classDef_G1 = 9275648;

	//0x00AAD720 private: static class zCClassDef oCAIVobMove::classDef
	const int oCAIVobMove__classDef_G2 = 11196192;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCAIVobMove__classDef_G1, oCAIVobMove__classDef_G2));
};

/*
0x008D8970 private: static class zCClassDef oCAIArrowBase::classDef
0x008D89F8 private: static class zCClassDef oCAIDrop::classDef
0x008D8A68 private: static class zCClassDef oCAIArrow::classDef
0x008D8AD8 private: static class zCClassDef oCAISound::classDef

0x00AAD790 private: static class zCClassDef oCAIArrowBase::classDef
0x00AAD840 private: static class zCClassDef oCAIDrop::classDef
0x00AAD8C0 private: static class zCClassDef oCAIArrow::classDef
0x00AAD940 private: static class zCClassDef oCAISound::classDef
*/
func int Hlp_Is_oCAIVobMoveTorch (var int ptr) {
	//0x008D8B48 private: static class zCClassDef oCAIVobMoveTorch::classDef
	const int oCAIVobMoveTorch__classDef_G1 = 9276232;

	//0x00AAD9D8 private: static class zCClassDef oCAIVobMoveTorch::classDef
	const int oCAIVobMoveTorch__classDef_G2 = 11196888;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCAIVobMoveTorch__classDef_G1, oCAIVobMoveTorch__classDef_G2));
};

/*
 *	We don't have class definitions for these hmmmm ...
 */
func int Hlp_Is_oCItemContainer (var int ptr) {
	//0x007DCDFC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G1 = 8244732;

	//0x0083C4AC const oCItemContainer::`vftable'
	const int oCItemContainer_vtbl_G2 = 8635564;

	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == MEMINT_SwitchG1G2 (oCItemContainer_vtbl_G1, oCItemContainer_vtbl_G2));
};

func int Hlp_Is_oCStealContainer (var int ptr) {
	//0x007DCEA4 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G1 = 8244900;

	//0x0083C574 const oCStealContainer::`vftable'
	const int oCStealContainer_vtbl_G2 = 8635764;

	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == MEMINT_SwitchG1G2 (oCStealContainer_vtbl_G1, oCStealContainer_vtbl_G2));
};

func int Hlp_Is_oCNpcContainer (var int ptr) {
	//0x007DCF54 const oCNpcContainer::`vftable'
	const int oCNPCContainer_vtbl_G1 = 8245076;

	//0x0083C644 const oCNpcContainer::`vftable'
	const int oCNPCContainer_vtbl_G2 = 8635972;

	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == MEMINT_SwitchG1G2 (oCNPCContainer_vtbl_G1, oCNPCContainer_vtbl_G2));
};

func int Hlp_Is_oCNpcInventory (var int ptr) {
	//0x007DD004 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G1 = 8245252;

	//0x0083C714 const oCNpcInventory::`vftable'
	const int oCNpcInventory_vtbl_G2 = 8636180;

	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == MEMINT_SwitchG1G2 (oCNpcInventory_vtbl_G1, oCNpcInventory_vtbl_G2));
};

/*
 *	Seems like when sound is enabled, then zSound address points to zCSndSys_MSS object, when it is disabled it points to zCSoundSystemDummy
 *	If we try to play any sound using zCSndSys_MSS functions and sound is disabled then game crashes
 *	Therefore we have to add check to every function and check if Hlp_Is_zCSndSys_MSS (zSound) is true
 */
func int Hlp_Is_zCSndSys_MSS (var int snd) {
	//0x007D306C const zCSndSys_MSS::`vftable'
	const int zCSndSys_MSS_vtbl_G1 = 8204396;

	//0x0083120C const zCSndSys_MSS::`vftable'
	const int zCSndSys_MSS_vtbl_G2 = 8589836;

	if (!snd) { return FALSE; };

	return (MEM_ReadInt (snd) == (MEMINT_SwitchG1G2 (zCSndSys_MSS_vtbl_G1, zCSndSys_MSS_vtbl_G2)));
};

func int Hlp_Is_zCSoundSystemDummy (var int snd) {
	//0x007DC134 const zCSoundSystemDummy::`vftable'
	const int zCSoundSystemDummy_vtbl_G1 = 8241460;

	//0x0083A6A4 const zCSoundSystemDummy::`vftable'
	const int zCSoundSystemDummy_vtbl_G2 = 8627876;

	if (!snd) { return FALSE; };
	return (MEM_ReadInt (snd) == (MEMINT_SwitchG1G2 (zCSoundSystemDummy_vtbl_G1, zCSoundSystemDummy_vtbl_G2)));
};

func int Hlp_Is_oCVisualFX (var int ptr) {
	//0x00869E00 private: static class zCClassDef oCVisualFX::classDef
	const int oCVisualFX__classDef_G1 = 8822272;

	//0x008CE658 private: static class zCClassDef oCVisualFX::classDef
	const int oCVisualFX__classDef_G2 = 9234008;

	return MEM_CheckInheritance (ptr, MEMINT_SwitchG1G2 (oCVisualFX__classDef_G1, oCVisualFX__classDef_G2));
};
