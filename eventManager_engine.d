/*
 *	Event Manager (AI queue) functions [WIP]
 */

//007D3ECC  .rdata    Debug data           ??_7zCMaterial@@6B@

//007D0894  .rdata    Debug data           ??_7zCObject@@6B@
const int zCObject_vtbl			= 8194196;
 
//007DE97C  .rdata    Debug data           ??_7zCEventManager@@6B@
const int zCEventManager_vtbl		= 8251772;

//007D0A24  .rdata    Debug data           ??_7zCCSCutsceneContext@@6B@
const int zCCSCutsceneContext_vtbl	= 8194596;

//007D0D44  .rdata    Debug data           ??_7zCCSBlockPosition@@6B@
const int zCCSBlockPosition_vtbl	= 8195396;

//007D0FAC  .rdata    Debug data           ??_7zCCSProps@@6B@
const int zCCSProps_vtbl		= 8196012;

//007D08F4  .rdata    Debug data           ??_7oCCSPlayer@@6BzCObject@@@
const int zCObject__oCCSPlayer__vtbl	= 8194292;

//--->

//007DE28C  .rdata    Debug data           ??_7oCNpcMessage@@6B@
const int oCNpcMessage_vtbl		= 8249996;
//007DE2F4  .rdata    Debug data           ??_7oCMsgDamage@@6B@
const int oCMsgDamage_vtbl		= 8250100;
//007DE35C  .rdata    Debug data           ??_7oCMsgWeapon@@6B@
const int oCMsgWeapon_vtbl		= 8250204;
//007DE3C4  .rdata    Debug data           ??_7oCMsgMovement@@6B@
const int oCMsgMovement_vtbl		= 8250308;
//007DE42C  .rdata    Debug data           ??_7oCMsgAttack@@6B@
const int oCMsgAttack_vtbl		= 8250412;
//007DE494  .rdata    Debug data           ??_7oCMsgUseItem@@6B@
const int oCMsgUseItem_vtbl		= 8250516;
//007DE4FC  .rdata    Debug data           ??_7oCMsgState@@6B@
const int oCMsgState_vtbl		= 8250620;
//007DE564  .rdata    Debug data           ??_7oCMsgManipulate@@6B@
const int oCMsgManipulate_vtbl		= 8250724;
//007DE5CC  .rdata    Debug data           ??_7oCMsgConversation@@6B@
const int oCMsgConversation_vtbl	= 8250828;
//007DE634  .rdata    Debug data           ??_7oCMsgMagic@@6B@
const int oCMsgMagic_vtbl		= 8250932;

//007DEDDC  .rdata    Debug data           ??_7zCEventMusicControler@@6B@
const int zCEventMusicControler_vtbl	= 8252892;

//007D0754  .rdata    Debug data           ??_7zCEventMessage@@6B@
const int zCEventMessage_vtbl		= 8193876;

//007D07B4  .rdata    Debug data           ??_7zCEventCore@@6B@
const int zCEventCore_vtbl		= 8193972;

//007D284C  .rdata    Debug data           ??_7zCCSCamera_EventMsg@@6B@
//007D06F4  .rdata    Debug data           ??_7zCCSCamera_EventMsgActivate@@6B@
//007D07B4  .rdata    Debug data           ??_7zCEventCore@@6B@
//007D0CE4  .rdata    Debug data           ??_7zCEvMsgCutscene@@6B@

//007DBE0C  .rdata    Debug data           ??_7zCEventCommon@@6B@
//007DBE6C  .rdata    Debug data           ??_7zCEventMover@@6B@
//007DBECC  .rdata    Debug data           ??_7zCEventScreenFX@@6B@

//007DDC9C  .rdata    Debug data           ??_7oCMobMsg@@6B@
const int oCMobMsg_vtbl			= 8248476;

func int Hlp_Is_zCEventManager (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == zCEventManager_vtbl);
};

func int Hlp_Is_oCMsgConversation (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == oCMsgConversation_vtbl);
};

func int Hlp_Is_zCCSCutsceneContext (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == zCCSCutsceneContext_vtbl);
};

func int Hlp_Is_oCNpcMessage (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == oCNpcMessage_vtbl);
};

func int zCEventMessage_MD_GetNumOfSubTypes (var int eventMessage) {
	//00401E90  .text     Debug data           ?MD_GetNumOfSubTypes@zCEventMessage@@UAEHXZ
	const int zCEventMessage__MD_GetNumOfSubTypes_G1 = 4202128;

	//0x00401FE0 public: virtual int __thiscall zCEventMessage::MD_GetNumOfSubTypes(void)
	const int zCEventMessage__MD_GetNumOfSubTypes_G2 = 4202464;
	
	if (!eventMessage) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__MD_GetNumOfSubTypes_G1, zCEventMessage__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMessage_GetSubType (var int eventMessage) {
	//0073F4C0  .text     Debug data           ?GetSubType@zCEventMessage@@QBEGXZ
	const int zCEventMessage__GetSubType_G1 = 7599296;

	//0x00674290 public: unsigned short __thiscall zCEventMessage::GetSubType(void)const 
	const int zCEventMessage__GetSubType_G2 = 6767248;

	if (!eventMessage) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__GetSubType_G1, zCEventMessage__GetSubType_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

//---

func int zCEventCore_MD_GetNumOfSubTypes (var int eventMessage) {
	//00401FF0  .text     Debug data           ?MD_GetNumOfSubTypes@zCEventCore@@UAEHXZ
	const int zCEventCore__MD_GetNumOfSubTypes_G1 = 4202480;

	//0x00402140 public: virtual int __thiscall zCEventCore::MD_GetNumOfSubTypes(void)
	const int zCEventCore__MD_GetNumOfSubTypes_G2 = 4202816;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventCore__MD_GetNumOfSubTypes_G1, zCEventCore__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEvMsgCutscene_MD_GetNumOfSubTypes (var int eventMessage) {
	//0040C2B0  .text     Debug data           ?MD_GetNumOfSubTypes@zCEvMsgCutscene@@UAEHXZ
	const int zCEvMsgCutscene__MD_GetNumOfSubTypes_G1 = 4244144;

	//0x0040C6A0 public: virtual int __thiscall zCEvMsgCutscene::MD_GetNumOfSubTypes(void)
	const int zCEvMsgCutscene__MD_GetNumOfSubTypes_G2 = 4245152;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEvMsgCutscene__MD_GetNumOfSubTypes_G1, zCEvMsgCutscene__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCCSCamera_EventMsg_MD_GetNumOfSubTypes (var int eventMessage) {
	//004BDBA0  .text     Debug data           ?MD_GetNumOfSubTypes@zCCSCamera_EventMsg@@UAEHXZ
	const int zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G1 = 4971424;

	//0x004C7000 public: virtual int __thiscall zCCSCamera_EventMsg::MD_GetNumOfSubTypes(void)
	const int zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G2 = 5009408;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G1, zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCCSCamera_EventMsgActivate_MD_GetNumOfSubTypes (var int eventMessage) {
	//004BDFA0  .text     Debug data           ?MD_GetNumOfSubTypes@zCCSCamera_EventMsgActivate@@UAEHXZ
	const int zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G1 = 4972448;

	//0x004C7400 public: virtual int __thiscall zCCSCamera_EventMsgActivate::MD_GetNumOfSubTypes(void)
	const int zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G2 = 5010432;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G1, zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventCommon_MD_GetNumOfSubTypes (var int eventMessage) {
	//005E2200  .text     Debug data           ?MD_GetNumOfSubTypes@zCEventCommon@@UAEHXZ
	const int zCEventCommon__MD_GetNumOfSubTypes_G1 = 6169088;

	//0x0060F0D0 public: virtual int __thiscall zCEventCommon::MD_GetNumOfSubTypes(void)
	const int zCEventCommon__MD_GetNumOfSubTypes_G2 = 6353104;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventCommon__MD_GetNumOfSubTypes_G1, zCEventCommon__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMover_MD_GetNumOfSubTypes (var int eventMessage) {
	//005E25E0  .text     Debug data           ?MD_GetNumOfSubTypes@zCEventMover@@UAEHXZ
	const int zCEventMover__MD_GetNumOfSubTypes_G1 = 6170080;

	//0x0060F470 public: virtual int __thiscall zCEventMover::MD_GetNumOfSubTypes(void)
	const int zCEventMover__MD_GetNumOfSubTypes_G2 = 6354032;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMover__MD_GetNumOfSubTypes_G1, zCEventMover__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventScreenFX_MD_GetNumOfSubTypes (var int eventMessage) {
	//005E2920  .text     Debug data           ?MD_GetNumOfSubTypes@zCEventScreenFX@@UAEHXZ
	const int zCEventScreenFX__MD_GetNumOfSubTypes_G1 = 6170912;

	//0x0060F790 public: virtual int __thiscall zCEventScreenFX::MD_GetNumOfSubTypes(void)
	const int zCEventScreenFX__MD_GetNumOfSubTypes_G2 = 6354832;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventScreenFX__MD_GetNumOfSubTypes_G1, zCEventScreenFX__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMobMsg_MD_GetNumOfSubTypes (var int eventMessage) {
	//0067A560  .text     Debug data           ?MD_GetNumOfSubTypes@oCMobMsg@@UAEHXZ
	const int oCMobMsg__MD_GetNumOfSubTypes_G1 = 6792544;

	//0x0071B740 public: virtual int __thiscall oCMobMsg::MD_GetNumOfSubTypes(void)
	const int oCMobMsg__MD_GetNumOfSubTypes_G2 = 7452480;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMobMsg__MD_GetNumOfSubTypes_G1, oCMobMsg__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgDamage_MD_GetNumOfSubTypes (var int eventMessage) {
	//006BE210  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgDamage@@UAEHXZ
	const int oCMsgDamage__MD_GetNumOfSubTypes_G1 = 7070224;

	//0x007653B0 public: virtual int __thiscall oCMsgDamage::MD_GetNumOfSubTypes(void)
	const int oCMsgDamage__MD_GetNumOfSubTypes_G2 = 7754672;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgDamage__MD_GetNumOfSubTypes_G1, oCMsgDamage__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgMovement_MD_GetNumOfSubTypes (var int eventMessage) {
	//006BEEF0  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgMovement@@UAEHXZ
	const int oCMsgMovement__MD_GetNumOfSubTypes_G1 = 7073520;

	//0x00766090 public: virtual int __thiscall oCMsgMovement::MD_GetNumOfSubTypes(void)
	const int oCMsgMovement__MD_GetNumOfSubTypes_G2 = 7757968;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgMovement__MD_GetNumOfSubTypes_G1, oCMsgMovement__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgWeapon_MD_GetNumOfSubTypes (var int eventMessage) {
	//006BF920  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgWeapon@@UAEHXZ
	const int oCMsgWeapon__MD_GetNumOfSubTypes_G1 = 7076128;

	//0x00766AC0 public: virtual int __thiscall oCMsgWeapon::MD_GetNumOfSubTypes(void)
	const int oCMsgWeapon__MD_GetNumOfSubTypes_G2 = 7760576;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgWeapon__MD_GetNumOfSubTypes_G1, oCMsgWeapon__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgAttack_MD_GetNumOfSubTypes (var int eventMessage) {
	//006C0500  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgAttack@@UAEHXZ
	const int oCMsgAttack__MD_GetNumOfSubTypes_G1 = 7079168;

	//0x007676A0 public: virtual int __thiscall oCMsgAttack::MD_GetNumOfSubTypes(void)
	const int oCMsgAttack__MD_GetNumOfSubTypes_G2 = 7763616;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgAttack__MD_GetNumOfSubTypes_G1, oCMsgAttack__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgState_MD_GetNumOfSubTypes (var int eventMessage) {
	//006C1340  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgState@@UAEHXZ
	const int oCMsgState__MD_GetNumOfSubTypes_G1 = 7082816;

	//0x007684E0 public: virtual int __thiscall oCMsgState::MD_GetNumOfSubTypes(void)
	const int oCMsgState__MD_GetNumOfSubTypes_G2 = 7767264;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgState__MD_GetNumOfSubTypes_G1, oCMsgState__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgManipulate_MD_GetNumOfSubTypes (var int eventMessage) {
	//006C23A0  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgManipulate@@UAEHXZ
	const int oCMsgManipulate__MD_GetNumOfSubTypes_G1 = 7087008;

	//0x00769540 public: virtual int __thiscall oCMsgManipulate::MD_GetNumOfSubTypes(void)
	const int oCMsgManipulate__MD_GetNumOfSubTypes_G2 = 7771456;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgManipulate__MD_GetNumOfSubTypes_G1, oCMsgManipulate__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgConversation_MD_GetNumOfSubTypes (var int eventMessage) {
	//006C3760  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgConversation@@UAEHXZ
	const int oCMsgConversation__MD_GetNumOfSubTypes_G1 = 7092064;

	//0x0076A900 public: virtual int __thiscall oCMsgConversation::MD_GetNumOfSubTypes(void)
	const int oCMsgConversation__MD_GetNumOfSubTypes_G2 = 7776512;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgConversation__MD_GetNumOfSubTypes_G1, oCMsgConversation__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int oCMsgMagic_MD_GetNumOfSubTypes (var int eventMessage) {
	//006C4240  .text     Debug data           ?MD_GetNumOfSubTypes@oCMsgMagic@@UAEHXZ
	const int oCMsgMagic__MD_GetNumOfSubTypes_G1 = 7094848;

	//0x0076B420 public: virtual int __thiscall oCMsgMagic::MD_GetNumOfSubTypes(void)
	const int oCMsgMagic__MD_GetNumOfSubTypes_G2 = 7779360;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (oCMsgMagic__MD_GetNumOfSubTypes_G1, oCMsgMagic__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMusicControler_MD_GetNumOfSubTypes (var int eventMessage) {
	//0070D2E0  .text     Debug data           ?MD_GetNumOfSubTypes@zCEventMusicControler@@UAEHXZ
	const int zCEventMusicControler__MD_GetNumOfSubTypes_G1 = 7394016;

	//0x00642B30 public: virtual int __thiscall zCEventMusicControler::MD_GetNumOfSubTypes(void)
	const int zCEventMusicControler__MD_GetNumOfSubTypes_G2 = 6564656;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMusicControler__MD_GetNumOfSubTypes_G1, zCEventMusicControler__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};


//MD_GetSubTypeString functions


func string zCEvMsgCutscene_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//0040C2C0  .text     Debug data           ?MD_GetSubTypeString@zCEvMsgCutscene@@UAE?AVzSTRING@@H@Z
	const int zCEvMsgCutscene__MD_GetSubTypeString_G1 = 4244160;

	//0x0040C6B0 public: virtual class zSTRING __thiscall zCEvMsgCutscene::MD_GetSubTypeString(int)
	const int zCEvMsgCutscene__MD_GetSubTypeString_G2 = 4245168;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEvMsgCutscene__MD_GetSubTypeString_G1, zCEvMsgCutscene__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCCSCamera_EventMsg_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//004BDBB0  .text     Debug data           ?MD_GetSubTypeString@zCCSCamera_EventMsg@@UAE?AVzSTRING@@H@Z
	const int zCCSCamera_EventMsg__MD_GetSubTypeString_G1 = 4971440;

	//0x004C7010 public: virtual class zSTRING __thiscall zCCSCamera_EventMsg::MD_GetSubTypeString(int)
	const int zCCSCamera_EventMsg__MD_GetSubTypeString_G2 = 5009424;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCCSCamera_EventMsg__MD_GetSubTypeString_G1, zCCSCamera_EventMsg__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCCSCamera_EventMsgActivate_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//004BDFB0  .text     Debug data           ?MD_GetSubTypeString@zCCSCamera_EventMsgActivate@@UAE?AVzSTRING@@H@Z
	const int zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G1 = 4972464;

	//0x004C7410 public: virtual class zSTRING __thiscall zCCSCamera_EventMsgActivate::MD_GetSubTypeString(int)
	const int zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G2 = 5010448;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G1, zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventCore_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//005D9A00  .text     Debug data           ?MD_GetSubTypeString@zCEventCore@@UAE?AVzSTRING@@H@Z
	const int zCEventCore__MD_GetSubTypeString_G1 = 6134272;

	//0x006062F0 public: virtual class zSTRING __thiscall zCEventCore::MD_GetSubTypeString(int)
	const int zCEventCore__MD_GetSubTypeString_G2 = 6316784;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventCore__MD_GetSubTypeString_G1, zCEventCore__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventCommon_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//005E2970  .text     Debug data           ?MD_GetSubTypeString@zCEventCommon@@UAE?AVzSTRING@@H@Z
	const int zCEventCommon__MD_GetSubTypeString_G1 = 6170992;

	//0x0060F7E0 public: virtual class zSTRING __thiscall zCEventCommon::MD_GetSubTypeString(int)
	const int zCEventCommon__MD_GetSubTypeString_G2 = 6354912;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventCommon__MD_GetSubTypeString_G1, zCEventCommon__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventMover_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//005E2AD0  .text     Debug data           ?MD_GetSubTypeString@zCEventMover@@UAE?AVzSTRING@@H@Z
	const int zCEventMover__MD_GetSubTypeString_G1 = 6171344;

	//0x0060F940 public: virtual class zSTRING __thiscall zCEventMover::MD_GetSubTypeString(int)
	const int zCEventMover__MD_GetSubTypeString_G2 = 6355264;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventMover__MD_GetSubTypeString_G1, zCEventMover__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventScreenFX_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//005EA670  .text     Debug data           ?MD_GetSubTypeString@zCEventScreenFX@@UAE?AVzSTRING@@H@Z
	const int zCEventScreenFX__MD_GetSubTypeString_G1 = 6202992;

	//0x00617720 public: virtual class zSTRING __thiscall zCEventScreenFX::MD_GetSubTypeString(int)
	const int zCEventScreenFX__MD_GetSubTypeString_G2 = 6387488;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventScreenFX__MD_GetSubTypeString_G1, zCEventScreenFX__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMobMsg_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//0067A570  .text     Debug data           ?MD_GetSubTypeString@oCMobMsg@@UAE?AVzSTRING@@H@Z
	const int oCMobMsg__MD_GetSubTypeString_G1 = 6792560;

	//0x0071B750 public: virtual class zSTRING __thiscall oCMobMsg::MD_GetSubTypeString(int)
	const int oCMobMsg__MD_GetSubTypeString_G2 = 7452496;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMobMsg__MD_GetSubTypeString_G1, oCMobMsg__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgDamage_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//006BE220  .text     Debug data           ?MD_GetSubTypeString@oCMsgDamage@@UAE?AVzSTRING@@H@Z
	const int oCMsgDamage__MD_GetSubTypeString_G1 = 7070240;

	//0x007653C0 public: virtual class zSTRING __thiscall oCMsgDamage::MD_GetSubTypeString(int)
	const int oCMsgDamage__MD_GetSubTypeString_G2 = 7754688;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMsgDamage__MD_GetSubTypeString_G1, oCMsgDamage__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgWeapon_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//006BF930  .text     Debug data           ?MD_GetSubTypeString@oCMsgWeapon@@UAE?AVzSTRING@@H@Z
	const int oCMsgWeapon__MD_GetSubTypeString_G1 = 7076144;

	//0x00766AD0 public: virtual class zSTRING __thiscall oCMsgWeapon::MD_GetSubTypeString(int)
	const int oCMsgWeapon__MD_GetSubTypeString_G2 = 7760592;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMsgWeapon__MD_GetSubTypeString_G1, oCMsgWeapon__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgMovement_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//006BEF00  .text     Debug data           ?MD_GetSubTypeString@oCMsgMovement@@UAE?AVzSTRING@@H@Z
	const int oCMsgMovement__MD_GetSubTypeString_G1 = 7073536;

	//0x007660A0 public: virtual class zSTRING __thiscall oCMsgMovement::MD_GetSubTypeString(int)
	const int oCMsgMovement__MD_GetSubTypeString_G2 = 7757984;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMsgMovement__MD_GetSubTypeString_G1, oCMsgMovement__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgAttack_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//006C0510  .text     Debug data           ?MD_GetSubTypeString@oCMsgAttack@@UAE?AVzSTRING@@H@Z
	const int oCMsgAttack__MD_GetSubTypeString_G1 = 7079184;

	//0x007676B0 public: virtual class zSTRING __thiscall oCMsgAttack::MD_GetSubTypeString(int)
	const int oCMsgAttack__MD_GetSubTypeString_G2 = 7763632;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMsgAttack__MD_GetSubTypeString_G1, oCMsgAttack__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgState_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//006C1350  .text     Debug data           ?MD_GetSubTypeString@oCMsgState@@UAE?AVzSTRING@@H@Z
	const int oCMsgState__MD_GetSubTypeString_G1 = 7082832;

	//0x007684F0 public: virtual class zSTRING __thiscall oCMsgState::MD_GetSubTypeString(int)
	const int oCMsgState__MD_GetSubTypeString_G2 = 7767280;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMsgState__MD_GetSubTypeString_G1, oCMsgState__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgManipulate_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//006C23B0  .text     Debug data           ?MD_GetSubTypeString@oCMsgManipulate@@UAE?AVzSTRING@@H@Z
	const int oCMsgManipulate__MD_GetSubTypeString_G1 = 7087024;

	//0x00769550 public: virtual class zSTRING __thiscall oCMsgManipulate::MD_GetSubTypeString(int)
	const int oCMsgManipulate__MD_GetSubTypeString_G2 = 7771472;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMsgManipulate__MD_GetSubTypeString_G1, oCMsgManipulate__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgMagic_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//006C4250  .text     Debug data           ?MD_GetSubTypeString@oCMsgMagic@@UAE?AVzSTRING@@H@Z
	const int oCMsgMagic__MD_GetSubTypeString_G1 = 7094864;

	//0x0076B430 public: virtual class zSTRING __thiscall oCMsgMagic::MD_GetSubTypeString(int)
	const int oCMsgMagic__MD_GetSubTypeString_G2 = 7779376;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (oCMsgMagic__MD_GetSubTypeString_G1, oCMsgMagic__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventMusicControler_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//0070D370  .text     Debug data           ?MD_GetSubTypeString@zCEventMusicControler@@UAE?AVzSTRING@@H@Z
	const int zCEventMusicControler__MD_GetSubTypeString_G1 = 7394160;

	//0x00642BC0 public: virtual class zSTRING __thiscall zCEventMusicControler::MD_GetSubTypeString(int)
	const int zCEventMusicControler__MD_GetSubTypeString_G2 = 6564800;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventMusicControler__MD_GetSubTypeString_G1, zCEventMusicControler__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

/*

0x00417DD0 public: class zCEventMessage * __thiscall zCCutscene::GetNextMessage(struct zTCSBlockPosition &)
0x00417E20 public: class zCCSBlockBase * __thiscall zCCutscene::GetNextBlock(struct zTCSBlockPosition &)

00401DF0  .text     Debug data           ?_GetClassDef@zCEventMessage@@EBEPAVzCClassDef@@XZ
00401E00  .text     Debug data           ?IsOverlay@zCEventMessage@@UAEHXZ
00401E10  .text     Debug data           ?IsNetRelevant@zCEventMessage@@UAEHXZ
00401E20  .text     Debug data           ?IsHighPriority@zCEventMessage@@UAEHXZ
00401E30  .text     Debug data           ?IsJob@zCEventMessage@@UAEHXZ
00401E40  .text     Debug data           ?Delete@zCEventMessage@@UAEXXZ
00401E50  .text     Debug data           ?IsDeleteable@zCEventMessage@@UAEHXZ
00401E60  .text     Debug data           ?IsDeleted@zCEventMessage@@UAEHXZ
00401E70  .text     Debug data           ?SetCutsceneMode@zCEventMessage@@UAEXH@Z
00401E80  .text     Debug data           ?GetCutsceneMode@zCEventMessage@@UAEHXZ
00401E90  .text     Debug data           ?MD_GetNumOfSubTypes@zCEventMessage@@UAEHXZ
00401EA0  .text     Debug data           ?MD_GetSubTypeString@zCEventMessage@@UAE?AVzSTRING@@H@Z
00401EE0  .text     Debug data           ?MD_GetVobRefName@zCEventMessage@@UAE?AVzSTRING@@XZ
00401F20  .text     Debug data           ?MD_SetVobRefName@zCEventMessage@@UAEXABVzSTRING@@@Z
00401F30  .text     Debug data           ?MD_SetVobParam@zCEventMessage@@UAEXPAVzCVob@@@Z
00401F40  .text     Debug data           ?MD_GetTimeBehavior@zCEventMessage@@UAE?AW4zTTimeBehavior@1@XZ
00401F50  .text     Debug data           ?MD_GetMinTime@zCEventMessage@@UAEMXZ

00452600  .text     Debug data           ?GetNumMessages@zCEventManager@@UAEHXZ
005D49B0  .text     Debug data           ?GetEM@zCVob@@QAIPAVzCEventManager@@H@Z
005D8E80  .text     Debug data           ?GetMessageID@zCEventMessage@@IBEKXZ
005D8EA0  .text     Debug data           ?AnalyzeMessageID@zCEventMessage@@CAXKAAG0@Z
005D8EC0  .text     Debug data           ?CreateFromID@zCEventMessage@@KAPAV1@K@Z
005D8EE0  .text     Debug data           ?PackToBuffer@zCEventMessage@@QAEXAAVzCBuffer@@PAVzCEventManager@@@Z
005D8F30  .text     Debug data           ?CreateFromBuffer@zCEventMessage@@SAPAV1@AAVzCBuffer@@PAVzCEventManager@@@Z
006DD030  .text     Debug data           ?KillMessages@zCEventManager@@QAEXXZ
006DD090  .text     Debug data           ?OnMessage@zCEventManager@@UAEXPAVzCEventMessage@@PAVzCVob@@@Z
006DD970  .text     Debug data           ?SendMessageToHost@zCEventManager@@MAEXPAVzCEventMessage@@PAVzCVob@@1@Z
006DDB10  .text     Debug data           ?SetShowMessageCommunication@zCEventManager@@SAXH@Z
006DDB20  .text     Debug data           ?GetShowMessageCommunication@zCEventManager@@SAHXZ
006DDB30  .text     Debug data           ?ShowMessageCommunication@zCEventManager@@IAEXPAVzCVob@@0@Z
006DDD10  .text     Debug data           ?ProcessMessageList@zCEventManager@@MAEXXZ
006DDE20  .text     Debug data           ?SetActive@zCEventManager@@UAEXH@Z
006DDFA0  .text     Debug data           ?Delete@zCEventManager@@MAEXPAVzCEventMessage@@@Z
006DDFE0  .text     Debug data           ?RemoveFromList@zCEventManager@@MAEXPAVzCEventMessage@@@Z
006DE030  .text     Debug data           ?InsertInList@zCEventManager@@MAEXPAVzCEventMessage@@@Z
006DE260  .text     Debug data           ?SetCutscene@zCEventManager@@UAEXPAVzCCutscene@@@Z
006DE2D0  .text     Debug data           ?GetCutscene@zCEventManager@@UAEPAVzCCutscene@@XZ
006DE2E0  .text     Debug data           ?GetCutsceneMode@zCEventManager@@UAEHXZ
006DE2F0  .text     Debug data           ?Clear@zCEventManager@@UAEXXZ
006DE4F0  .text     Debug data           ?IsEmpty@zCEventManager@@UAEHH@Z
006DE550  .text     Debug data           ?IsRunning@zCEventManager@@UAEHPAVzCEventMessage@@@Z
006DE580  .text     Debug data           ?GetActiveMessage@zCEventManager@@UAEPAVzCEventMessage@@XZ
006DE5C0  .text     Debug data           ?Print_db@zCEventManager@@IAEXABVzSTRING@@PAVzCVob@@@Z
006DE5D0  .text     Debug data           ?OnTouch@zCEventManager@@UAEXPAVzCVob@@@Z
006DE690  .text     Debug data           ?OnUntouch@zCEventManager@@UAEXPAVzCVob@@@Z
006DE750  .text     Debug data           ?OnTouchLevel@zCEventManager@@UAEXXZ
006DE760  .text     Debug data           ?OnTrigger@zCEventManager@@UAEXPAVzCVob@@0@Z
006DE820  .text     Debug data           ?OnUntrigger@zCEventManager@@UAEXPAVzCVob@@0@Z
006DE8E0  .text     Debug data           ?OnDamage@zCEventManager@@UAEXPAVzCVob@@0MHABVzVEC3@@@Z
006DE9B0  .text     Debug data           ?GetEventMessage@zCEventManager@@UAEPAVzCEventMessage@@H@Z
006DE9C0  .text     Debug data           ?ShowList@zCEventManager@@UAEXHH@Z
006DEC70  .text     Debug data           ?Archive@zCEventManager@@MAEXAAVzCArchiver@@@Z
006DECB0  .text     Debug data           ?Unarchive@zCEventManager@@MAEXAAVzCArchiver@@@Z
006DED20  .text     Debug data           ?Remove@?$zCArray@PAVzCEventManager@@@@QAEXABQAVzCEventManager@@@Z
*/

func int oCNPC_GetTalkingWithMessage (var int slfinstance, var int npcinstance) {
	//00633620  .text     Debug data           ?GetTalkingWithMessage@oCNpc@@QAEPAVzCEventMessage@@PAV1@@Z
	const int oCNPC__GetTalkingWithMessage_G1 = 6501920;

	//0x006BCFB0 public: class zCEventMessage * __thiscall oCNpc::GetTalkingWithMessage(class oCNpc *)
	const int oCNPC__GetTalkingWithMessage_G2 = 7065520;

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var oCNPC npc; npc = Hlp_GetNPC (npcinstance);
	if (!Hlp_IsValidNPC (npc)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);
	var int npcPtr; npcPtr = _@ (npc);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (npcPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNPC__GetTalkingWithMessage_G1, oCNPC__GetTalkingWithMessage_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsPtr ();
};

func int zCEventMessage_GetClassDef (var int eventMessage) {
	//00401DF0  .text     Debug data           ?_GetClassDef@zCEventMessage@@EBEPAVzCClassDef@@XZ
	const int zCEventManage__GetClassDef_G1 = 4201968;

	//0x00401F30 private: virtual class zCClassDef * __thiscall zCEventMessage::_GetClassDef(void)const 
	const int zCEventManage__GetClassDef_G2 = 4202288;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__GetClassDef_G1, zCEventManage__GetClassDef_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsPtr ();
};

func int zCEventMessage_IsOverlay (var int eventMessage) {
	//00401E00  .text     Debug data           ?IsOverlay@zCEventMessage@@UAEHXZ
	const int zCEventManage__IsOverlay_G1 = 4201984;

	//0x00401F40 public: virtual int __thiscall zCEventMessage::IsOverlay(void)
	const int zCEventManage__IsOverlay_G2 = 4202304;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__IsOverlay_G1, zCEventManage__IsOverlay_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsNetRelevant (var int eventMessage) {
	//00401E10  .text     Debug data           ?IsNetRelevant@zCEventMessage@@UAEHXZ
	const int zCEventManage__IsNetRelevant_G1 = 4202000;

	//0x00401F50 public: virtual int __thiscall zCEventMessage::IsNetRelevant(void)
	const int zCEventManage__IsNetRelevant_G2 = 4202304;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__IsNetRelevant_G1, zCEventManage__IsNetRelevant_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsHighPriority (var int eventMessage) {
	//00401E20  .text     Debug data           ?IsHighPriority@zCEventMessage@@UAEHXZ
	const int zCEventManage__IsHighPriority_G1 = 4202016;

	//0x00401F60 public: virtual int __thiscall zCEventMessage::IsHighPriority(void)
	const int zCEventManage__IsHighPriority_G2 = 4202336;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__IsHighPriority_G1, zCEventManage__IsHighPriority_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsJob (var int eventMessage) {
	//00401E30  .text     Debug data           ?IsJob@zCEventMessage@@UAEHXZ
	const int zCEventManage__IsJob_G1 = 4202032;

	//0x00401F70 public: virtual int __thiscall zCEventMessage::IsJob(void)
	const int zCEventManage__IsJob_G2 = 4202352;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__IsJob_G1, zCEventManage__IsJob_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsDeleteable (var int eventMessage) {
	//00401E50  .text     Debug data           ?IsDeleteable@zCEventMessage@@UAEHXZ
	const int zCEventManage__IsDeleteable_G1 = 4202064;

	//0x00401FA0 public: virtual int __thiscall zCEventMessage::IsDeleteable(void)
	const int zCEventManage__IsDeleteable_G2 = 4202400;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__IsDeleteable_G1, zCEventManage__IsDeleteable_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsDeleted (var int eventMessage) {
	//00401E60  .text     Debug data           ?IsDeleted@zCEventMessage@@UAEHXZ
	const int zCEventManage__IsDeleted_G1 = 4202080;

	//0x00401FB0 public: virtual int __thiscall zCEventMessage::IsDeleted(void)
	const int zCEventManage__IsDeleted_G2 = 4202416;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__IsDeleted_G1, zCEventManage__IsDeleted_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventMessage_GetCutsceneMode (var int eventMessage) {
	//00401E80  .text     Debug data           ?GetCutsceneMode@zCEventMessage@@UAEHXZ
	const int zCEventManage__GetCutsceneMode_G1 = 4202032;

	//0x00401FD0 public: virtual int __thiscall zCEventMessage::GetCutsceneMode(void)
	const int zCEventManage__GetCutsceneMode_G2 = 4202448;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventManage__GetCutsceneMode_G1, zCEventManage__GetCutsceneMode_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func string zCEventMessage_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//00401EA0  .text     Debug data           ?MD_GetSubTypeString@zCEventMessage@@UAE?AVzSTRING@@H@Z
	const int zCEventMessage__MD_GetSubTypeString_G1 = 4202144;

	//0x00401FF0 public: virtual class zSTRING __thiscall zCEventMessage::MD_GetSubTypeString(int)
	const int zCEventMessage__MD_GetSubTypeString_G2 = 4202480;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventMessage__MD_GetSubTypeString_G1, zCEventMessage__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

/*
 *
 *
 *
 */

func int zCEventManager_GetNumMessages (var int eventManager) {
	//00452600  .text     Debug data           ?GetNumMessages@zCEventManager@@UAEHXZ
	const int zCEventManager__GetNumMessages_G1 = 4531712;

	//0x00457430 public: virtual int __thiscall zCEventManager::GetNumMessages(void)
	const int zCEventManager__GetNumMessages_G2 = 4551728;

	if (!eventManager) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventManager), MEMINT_SwitchG1G2 (zCEventManager__GetNumMessages_G1, zCEventManager__GetNumMessages_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func int zCEventManager_GetActiveMessage (var int eventManager) {
	//006DE580  .text     Debug data           ?GetActiveMessage@zCEventManager@@UAEPAVzCEventMessage@@XZ
	const int zCEventManager__GetActiveMessage_G1 = 7202176;

	//0x00787810 public: virtual class zCEventMessage * __thiscall zCEventManager::GetActiveMessage(void)
	const int zCEventManager__GetActiveMessage_G2 = 7895056;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventManager), MEMINT_SwitchG1G2 (zCEventManager__GetActiveMessage_G1, zCEventManager__GetActiveMessage_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsPtr ();
};

func int zCEventManager_GetEventMessage (var int eventManager, var int index) {
	//006DE9B0  .text     Debug data           ?GetEventMessage@zCEventManager@@UAEPAVzCEventMessage@@H@Z
	const int zCEventManager__GetEventMessage_G1 = 7203248;

	//0x00787C40 public: virtual class zCEventMessage * __thiscall zCEventManager::GetEventMessage(int)
	const int zCEventManager__GetEventMessage_G2 = 7896128;

	if (!eventManager) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (index));
		CALL__thiscall (_@ (eventManager), MEMINT_SwitchG1G2 (zCEventManager__GetEventMessage_G1, zCEventManager__GetEventMessage_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsPtr ();
};

//-->

func int oCMsgConversation_IsOverlay (var int msgConversation) {
	//006C3960  .text     Debug data           ?IsOverlay@oCMsgConversation@@UAEHXZ
	const int oCMsgConversation__IsOverlay_G1 = 7092576;

	//0x0076AB00 public: virtual int __thiscall oCMsgConversation::IsOverlay(void)
	const int oCMsgConversation__IsOverlay_G2 = 7777024;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (msgConversation), MEMINT_SwitchG1G2 (oCMsgConversation__IsOverlay_G1, oCMsgConversation__IsOverlay_G2));
		call = CALL_End();
	};
	
	return CALL_RetValAsInt ();
};

func string oCMsgConversation_MD_GetSubTypeString (var int msgConversation, var int subType) {
	//006C39A0  .text     Debug data           ?MD_GetSubTypeString@oCMsgConversation@@UAE?AVzSTRING@@H@Z
	const int oCMsgConversation__MD_GetSubTypeString_G1 = 7092640;

	//0x0076AB60 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetSubTypeString(int)
	const int oCMsgConversation__MD_GetSubTypeString_G2 = 7777120;

	if (!msgConversation) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (msgConversation, MEMINT_SwitchG1G2 (oCMsgConversation__MD_GetSubTypeString_G1, oCMsgConversation__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgConversation_MD_GetVobRefName (var int msgConversation) {
	//006C3B80  .text     Debug data           ?MD_GetVobRefName@oCMsgConversation@@UAE?AVzSTRING@@XZ
	const int oCMsgConversation__MD_GetVobRefName_G1 = 7093120;

	//0x0076AD60 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetVobRefName(void)
	const int oCMsgConversation__MD_GetVobRefName_G2 = 7777632;

	CALL_RetValIszString();
	CALL__thiscall (msgConversation, MEMINT_SwitchG1G2 (oCMsgConversation__MD_GetVobRefName_G1, oCMsgConversation__MD_GetVobRefName_G2));
	return CALL_RetValAszstring ();
};

func int zCVob_GetEM (var int vobPtr) {
	//005D49B0  .text     Debug data           ?GetEM@zCVob@@QAIPAVzCEventManager@@H@Z
	const int zCVob__GetEM_G1 = 6113712;
	
	//0x005FFE10 public: class zCEventManager * __fastcall zCVob::GetEM(int)
	const int zCVob__GetEM_G2 = 6290960;

	if (!vobPtr) { return 0; };

	var int f; f = false;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(vobPtr), _@(f), MEMINT_SwitchG1G2 (zCVob__GetEM_G1, zCVob__GetEM_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

/*
 *
 */

func void zCEventManager_OnTouch (var int eMgr, var int vobPtr) {
	//006DE5D0  .text     Debug data           ?OnTouch@zCEventManager@@UAEXPAVzCVob@@@Z
	const int zCEventManager__OnTouch_G1 = 7202256;
	
	//0x00787860 public: virtual void __thiscall zCEventManager::OnTouch(class zCVob *)
	const int zCEventManager__OnTouch_G2 = 7895136;

	if (!eMgr) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(vobPtr));
		CALL_PutRetValTo(0);
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__OnTouch_G1, zCEventManager__OnTouch_G2));

		call = CALL_End();
	};
};

func void zCEventManager_OnUntouch (var int eMgr, var int vobPtr) {
	//006DE690  .text     Debug data           ?OnUntouch@zCEventManager@@UAEXPAVzCVob@@@Z
	const int zCEventManager__OnUntouch_G1 = 7202448;
	
	//0x00787920 public: virtual void __thiscall zCEventManager::OnUntouch(class zCVob *)
	const int zCEventManager__OnUntouch_G2 = 7895328;

	if (!eMgr) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(vobPtr));
		CALL_PutRetValTo(0);
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__OnUntouch_G1, zCEventManager__OnUntouch_G2));

		call = CALL_End();
	};
};

func void zCEventManager_OnTrigger (var int eMgr, var int vobPtr) {
	//006DE760  .text     Debug data           ?OnTrigger@zCEventManager@@UAEXPAVzCVob@@0@Z
	const int zCEventManager__OnTrigger_G1 = 7202256;
	
	//0x007879F0 public: virtual void __thiscall zCEventManager::OnTrigger(class zCVob *,class zCVob *)
	const int zCEventManager__OnTrigger_G2 = 7895136;

	if (!eMgr) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(vobPtr));
		CALL_PtrParam(_@(vobPtr));
		CALL_PutRetValTo(0);
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__OnTrigger_G1, zCEventManager__OnTrigger_G2));

		call = CALL_End();
	};
};

func void zCEventManager_OnUnTrigger (var int eMgr, var int vobPtr) {
	//006DE820  .text     Debug data           ?OnUntrigger@zCEventManager@@UAEXPAVzCVob@@0@Z
	const int zCEventManager__OnUnTrigger_G1 = 7202848;
	
	//0x00787AB0 public: virtual void __thiscall zCEventManager::OnUntrigger(class zCVob *,class zCVob *)
	const int zCEventManager__OnUnTrigger_G2 = 7895728;

	if (!eMgr) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(vobPtr));
		CALL_PtrParam(_@(vobPtr));
		CALL_PutRetValTo(0);
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__OnUnTrigger_G1, zCEventManager__OnUnTrigger_G2));

		call = CALL_End();
	};
};

func void zCEventManager_DoFrameActivity (var int eMgr) {
	//006DCC80  .text     Debug data           ?DoFrameActivity@zCEventManager@@SAXXZ
	const int zCEventManager__DoFrameActivity_G1 = 7195776;
	
	//0x00785F70 public: static void __cdecl zCEventManager::DoFrameActivity(void)
	const int zCEventManager__DoFrameActivity_G2 = 7888752;

	if (!eMgr) { return; };

	CALL__cdecl (MEMINT_SwitchG1G2 (zCEventManager__DoFrameActivity_G1, zCEventManager__DoFrameActivity_G2));
};

func void zCEventManager_OnMessage (var int eMgr, var int eMsg, var int vobPtr) {
	//006DD090  .text     Debug data           ?OnMessage@zCEventManager@@UAEXPAVzCEventMessage@@PAVzCVob@@@Z
	const int zCEventManager__OnMessage_G1 = 7196816;
	
	//0x00786380 public: virtual void __thiscall zCEventManager::OnMessage(class zCEventMessage *,class zCVob *)
	const int zCEventManager__OnMessage_G2 = 7889792;

	if (!eMgr) { return; };
	if (!eMsg) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(vobPtr));
		CALL_PtrParam(_@(eMsg));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__OnMessage_G1, zCEventManager__OnMessage_G2));

		call = CALL_End();
	};
};

func void zCEventManager_RemoveFromList (var int eMgr, var int eMsg) {
	//006DDFE0  .text     Debug data           ?RemoveFromList@zCEventManager@@MAEXPAVzCEventMessage@@@Z
	const int zCEventManager__RemoveFromList_G1 = 7200736;
	
	//0x007872B0 protected: virtual void __thiscall zCEventManager::RemoveFromList(class zCEventMessage *)
	const int zCEventManager__RemoveFromList_G2 = 7893680;

	if (!eMgr) { return; };
	if (!eMsg) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(eMsg));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__RemoveFromList_G1, zCEventManager__RemoveFromList_G2));

		call = CALL_End();
	};
};

func void zCEventManager_InsertInList (var int eMgr, var int eMsg) {
	//006DE030  .text     Debug data           ?InsertInList@zCEventManager@@MAEXPAVzCEventMessage@@@Z
	const int zCEventManager__InsertInList_G1 = 7200816;
	
	//0x00787300 protected: virtual void __thiscall zCEventManager::InsertInList(class zCEventMessage *)
	const int zCEventManager__InsertInList_G2 = 7893760;

	if (!eMgr) { return; };
	if (!eMsg) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(eMsg));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__InsertInList_G1, zCEventManager__InsertInList_G2));

		call = CALL_End();
	};
};

func void zCEventManager_ProcessMessageList (var int eMgr) {
	//006DDD10  .text     Debug data           ?ProcessMessageList@zCEventManager@@MAEXXZ
	const int zCEventManager__ProcessMessageList_G1 = 7200016;

	//0x00787000 protected: virtual void __thiscall zCEventManager::ProcessMessageList(void)
	const int zCEventManager__ProcessMessageList_G2 = 7892992;

	if (!eMgr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__ProcessMessageList_G1, zCEventManager__ProcessMessageList_G2));
		call = CALL_End();
	};
};

func void zCEventManager_SetActive (var int eMgr, var int index) {
	//006DDE20  .text     Debug data           ?SetActive@zCEventManager@@UAEXH@Z
	const int zCEventManager__SetActive_G1 = 7200288;

	//0x00787110 public: virtual void __thiscall zCEventManager::SetActive(int)
	const int zCEventManager__SetActive_G2 = 7893264;

	if (!eMgr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(index));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__SetActive_G1, zCEventManager__SetActive_G2));

		call = CALL_End();
	};
};
