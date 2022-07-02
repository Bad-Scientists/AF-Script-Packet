/*
 *	Event Manager (AI queue) functions [WIP]
 */

func int zCEventMessage_MD_GetNumOfSubTypes (var int eventMessage) {
	//0x00401E90 public: virtual int __thiscall zCEventMessage::MD_GetNumOfSubTypes(void)
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
	//0x0073F4C0 public: unsigned short __thiscall zCEventMessage::GetSubType(void)const
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
	//0x00401FF0 public: virtual int __thiscall zCEventCore::MD_GetNumOfSubTypes(void)
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
	//0x0040C2B0 public: virtual int __thiscall zCEvMsgCutscene::MD_GetNumOfSubTypes(void)
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
	//0x004BDBA0 public: virtual int __thiscall zCCSCamera_EventMsg::MD_GetNumOfSubTypes(void)
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
	//0x004BDFA0 public: virtual int __thiscall zCCSCamera_EventMsgActivate::MD_GetNumOfSubTypes(void)
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
	//0x005E2200 public: virtual int __thiscall zCEventCommon::MD_GetNumOfSubTypes(void)
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
	//0x005E25E0 public: virtual int __thiscall zCEventMover::MD_GetNumOfSubTypes(void)
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
	//0x005E2920 public: virtual int __thiscall zCEventScreenFX::MD_GetNumOfSubTypes(void)
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
	//0x0067A560 public: virtual int __thiscall oCMobMsg::MD_GetNumOfSubTypes(void)
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
	//0x006BE210 public: virtual int __thiscall oCMsgDamage::MD_GetNumOfSubTypes(void)
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
	//0x006BEEF0 public: virtual int __thiscall oCMsgMovement::MD_GetNumOfSubTypes(void)
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
	//0x006BF920 public: virtual int __thiscall oCMsgWeapon::MD_GetNumOfSubTypes(void)
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
	//0x006C0500 public: virtual int __thiscall oCMsgAttack::MD_GetNumOfSubTypes(void)
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
	//0x006C1340 public: virtual int __thiscall oCMsgState::MD_GetNumOfSubTypes(void)
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
	//0x006C23A0 public: virtual int __thiscall oCMsgManipulate::MD_GetNumOfSubTypes(void)
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
	//0x006C3760 public: virtual int __thiscall oCMsgConversation::MD_GetNumOfSubTypes(void)
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
	//0x006C4240 public: virtual int __thiscall oCMsgMagic::MD_GetNumOfSubTypes(void)
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
	//0x0070D2E0 public: virtual int __thiscall zCEventMusicControler::MD_GetNumOfSubTypes(void)
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
	//0x0040C2C0 public: virtual class zSTRING __thiscall zCEvMsgCutscene::MD_GetSubTypeString(int)
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
	//0x004BDBB0 public: virtual class zSTRING __thiscall zCCSCamera_EventMsg::MD_GetSubTypeString(int)
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
	//0x004BDFB0 public: virtual class zSTRING __thiscall zCCSCamera_EventMsgActivate::MD_GetSubTypeString(int)
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
	//0x005D9A00 public: virtual class zSTRING __thiscall zCEventCore::MD_GetSubTypeString(int)
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
	//0x005E2970 public: virtual class zSTRING __thiscall zCEventCommon::MD_GetSubTypeString(int)
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
	//0x005E2AD0 public: virtual class zSTRING __thiscall zCEventMover::MD_GetSubTypeString(int)
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
	//0x005EA670 public: virtual class zSTRING __thiscall zCEventScreenFX::MD_GetSubTypeString(int)
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
	//0x0067A570 public: virtual class zSTRING __thiscall oCMobMsg::MD_GetSubTypeString(int)
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
	//0x006BE220 public: virtual class zSTRING __thiscall oCMsgDamage::MD_GetSubTypeString(int)
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
	//0x006BF930 public: virtual class zSTRING __thiscall oCMsgWeapon::MD_GetSubTypeString(int)
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
	//0x006BEF00 public: virtual class zSTRING __thiscall oCMsgMovement::MD_GetSubTypeString(int)
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
	//0x006C0510 public: virtual class zSTRING __thiscall oCMsgAttack::MD_GetSubTypeString(int)
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
	//0x006C1350 public: virtual class zSTRING __thiscall oCMsgState::MD_GetSubTypeString(int)
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
	//0x006C23B0 public: virtual class zSTRING __thiscall oCMsgManipulate::MD_GetSubTypeString(int)
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
	//0x006C4250 public: virtual class zSTRING __thiscall oCMsgMagic::MD_GetSubTypeString(int)
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
	//0x0070D370 public: virtual class zSTRING __thiscall zCEventMusicControler::MD_GetSubTypeString(int)
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
	//0x00633620 public: class zCEventMessage * __thiscall oCNpc::GetTalkingWithMessage(class oCNpc *)
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
	//0x00401DF0 private: virtual class zCClassDef * __thiscall zCEventMessage::_GetClassDef(void)const
	const int zCEventMessage___GetClassDef_G1 = 4201968;

	//0x00401F30 private: virtual class zCClassDef * __thiscall zCEventMessage::_GetClassDef(void)const
	const int zCEventMessage___GetClassDef_G2 = 4202288;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage___GetClassDef_G1, zCEventMessage___GetClassDef_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func int zCEventMessage_IsOverlay (var int eventMessage) {
	//0x00401E00 public: virtual int __thiscall zCEventMessage::IsOverlay(void)
	const int zCEventMessage__IsOverlay_G1 = 4201984;

	//0x00401F40 public: virtual int __thiscall zCEventMessage::IsOverlay(void)
	const int zCEventMessage__IsOverlay_G2 = 4202304;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__IsOverlay_G1, zCEventMessage__IsOverlay_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsNetRelevant (var int eventMessage) {
	//0x00401E10 public: virtual int __thiscall zCEventMessage::IsNetRelevant(void)
	const int zCEventMessage__IsNetRelevant_G1 = 4202000;

	//0x00401F50 public: virtual int __thiscall zCEventMessage::IsNetRelevant(void)
	const int zCEventMessage__IsNetRelevant_G2 = 4202320;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__IsNetRelevant_G1, zCEventMessage__IsNetRelevant_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsHighPriority (var int eventMessage) {
	//0x00401E20 public: virtual int __thiscall zCEventMessage::IsHighPriority(void)
	const int zCEventMessage__IsHighPriority_G1 = 4202016;

	//0x00401F60 public: virtual int __thiscall zCEventMessage::IsHighPriority(void)
	const int zCEventMessage__IsHighPriority_G2 = 4202336;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__IsHighPriority_G1, zCEventMessage__IsHighPriority_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsJob (var int eventMessage) {
	//0x00401E30 public: virtual int __thiscall zCEventMessage::IsJob(void)
	const int zCEventMessage__IsJob_G1 = 4202032;

	//0x00401F70 public: virtual int __thiscall zCEventMessage::IsJob(void)
	const int zCEventMessage__IsJob_G2 = 4202352;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__IsJob_G1, zCEventMessage__IsJob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsDeleteable (var int eventMessage) {
	//0x00401E50 public: virtual int __thiscall zCEventMessage::IsDeleteable(void)
	const int zCEventMessage__IsDeleteable_G1 = 4202064;

	//0x00401FA0 public: virtual int __thiscall zCEventMessage::IsDeleteable(void)
	const int zCEventMessage__IsDeleteable_G2 = 4202400;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__IsDeleteable_G1, zCEventMessage__IsDeleteable_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsDeleted (var int eventMessage) {
	//0x00401E60 public: virtual int __thiscall zCEventMessage::IsDeleted(void)
	const int zCEventMessage__IsDeleted_G1 = 4202080;

	//0x00401FB0 public: virtual int __thiscall zCEventMessage::IsDeleted(void)
	const int zCEventMessage__IsDeleted_G2 = 4202416;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__IsDeleted_G1, zCEventMessage__IsDeleted_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_GetCutsceneMode (var int eventMessage) {
	//0x00401E80 public: virtual int __thiscall zCEventMessage::GetCutsceneMode(void)
	const int zCEventMessage__GetCutsceneMode_G1 = 4202112;

	//0x00401FD0 public: virtual int __thiscall zCEventMessage::GetCutsceneMode(void)
	const int zCEventMessage__GetCutsceneMode_G2 = 4202448;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eventMessage), MEMINT_SwitchG1G2 (zCEventMessage__GetCutsceneMode_G1, zCEventMessage__GetCutsceneMode_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func string zCEventMessage_MD_GetSubTypeString (var int eventMessage, var int subType) {
	//0x00401EA0 public: virtual class zSTRING __thiscall zCEventMessage::MD_GetSubTypeString(int)
	const int zCEventMessage__MD_GetSubTypeString_G1 = 4202144;

	//0x00401FF0 public: virtual class zSTRING __thiscall zCEventMessage::MD_GetSubTypeString(int)
	const int zCEventMessage__MD_GetSubTypeString_G2 = 4202480;

	if (!eventMessage) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventMessage__MD_GetSubTypeString_G1, zCEventMessage__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func void zCEventMessage_Delete (var int eventMessage) {
	//0x00401E40 public: virtual void __thiscall zCEventMessage::Delete(void)
	const int zCEventMessage__Delete_G1 = 4202048;

	//0x00401F90 public: virtual void __thiscall zCEventMessage::Delete(void)
	const int zCEventMessage__Delete_G2 = 4202384;

	if (!eventMessage) { return; };

	CALL__thiscall (eventMessage, MEMINT_SwitchG1G2 (zCEventMessage__Delete_G1, zCEventMessage__Delete_G2));
};

/*
 *
 *
 *
 */

func int zCEventManager_GetNumMessages (var int eventManager) {
	//0x00452600 public: virtual int __thiscall zCEventManager::GetNumMessages(void)
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
	//0x006DE580 public: virtual class zCEventMessage * __thiscall zCEventManager::GetActiveMessage(void)
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
	//0x006DE9B0 public: virtual class zCEventMessage * __thiscall zCEventManager::GetEventMessage(int)
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
	//0x006C3960 public: virtual int __thiscall oCMsgConversation::IsOverlay(void)
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
	//0x006C39A0 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetSubTypeString(int)
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
	//0x006C3B80 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetVobRefName(void)
	const int oCMsgConversation__MD_GetVobRefName_G1 = 7093120;

	//0x0076AD60 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetVobRefName(void)
	const int oCMsgConversation__MD_GetVobRefName_G2 = 7777632;

	CALL_RetValIszString();
	CALL__thiscall (msgConversation, MEMINT_SwitchG1G2 (oCMsgConversation__MD_GetVobRefName_G1, oCMsgConversation__MD_GetVobRefName_G2));
	return CALL_RetValAszstring ();
};

func int zCVob_GetEM (var int vobPtr) {
	//0x005D49B0 public: class zCEventManager * __fastcall zCVob::GetEM(int)
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
	//0x006DE5D0 public: virtual void __thiscall zCEventManager::OnTouch(class zCVob *)
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
	//0x006DE690 public: virtual void __thiscall zCEventManager::OnUntouch(class zCVob *)
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
	//0x006DE760 public: virtual void __thiscall zCEventManager::OnTrigger(class zCVob *,class zCVob *)
	const int zCEventManager__OnTrigger_G1 = 7202656;

	//0x007879F0 public: virtual void __thiscall zCEventManager::OnTrigger(class zCVob *,class zCVob *)
	const int zCEventManager__OnTrigger_G2 = 7895536;

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
	//0x006DE820 public: virtual void __thiscall zCEventManager::OnUntrigger(class zCVob *,class zCVob *)
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
	//0x006DCC80 public: static void __cdecl zCEventManager::DoFrameActivity(void)
	const int zCEventManager__DoFrameActivity_G1 = 7195776;

	//0x00785F70 public: static void __cdecl zCEventManager::DoFrameActivity(void)
	const int zCEventManager__DoFrameActivity_G2 = 7888752;

	if (!eMgr) { return; };

	CALL__cdecl (MEMINT_SwitchG1G2 (zCEventManager__DoFrameActivity_G1, zCEventManager__DoFrameActivity_G2));
};

func void zCEventManager_OnMessage (var int eMgr, var int eMsg, var int vobPtr) {
	//0x006DD090 public: virtual void __thiscall zCEventManager::OnMessage(class zCEventMessage *,class zCVob *)
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
	//0x006DDFE0 protected: virtual void __thiscall zCEventManager::RemoveFromList(class zCEventMessage *)
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
	//0x006DE030 protected: virtual void __thiscall zCEventManager::InsertInList(class zCEventMessage *)
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
	//0x006DDD10 protected: virtual void __thiscall zCEventManager::ProcessMessageList(void)
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

func void zCEventManager_SetActive (var int eMgr, var int on) {
	//0x006DDE20 public: virtual void __thiscall zCEventManager::SetActive(int)
	const int zCEventManager__SetActive_G1 = 7200288;

	//0x00787110 public: virtual void __thiscall zCEventManager::SetActive(int)
	const int zCEventManager__SetActive_G2 = 7893264;

	if (!eMgr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(on));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__SetActive_G1, zCEventManager__SetActive_G2));

		call = CALL_End();
	};
};

/*
 *	Wrapper for *MD_GetSubType functions
 */
func int eMsg_MD_GetSubType (var int eMsg) {
	if (!eMsg) { return -1; };

	var int subType; subType = zCEventMessage_GetSubType (eMsg);

	/*
	0		0
	1		1 << 0
	2		1 << 1
	4		1 << 2
	8		1 << 3
	16		1 << 4
	32		1 << 5
	64		1 << 6
	128		1 << 7
	256		1 << 8
	512		1 << 9
	1024		1 << 10
	2048		1 << 11
	4096		1 << 12
	8192		1 << 13
	16384		1 << 14
	32768		1 << 15
	65536		1 << 16
	131072		1 << 17
	262144		1 << 18
	524288		1 << 19
	1048576		1 << 20
	2097152		1 << 21
	4194304		1 << 22
	8388608		1 << 23
	16777216	1 << 24
	33554432	1 << 25
	67108864	1 << 26
	134217728	1 << 27
	268435456	1 << 28
	536870912	1 << 29
	1073741824	1 << 30
	*/

	//564133898
	//564133895
	//1073741841

	//1073741824;
	//-2147483648;

	//var zCEventMessage eventMessage;
	//eventMessage = _^ (eMsg);
	//return eventMessage.subType;

	//eventMessage.subType sometimes has huge values - idk why.
	//Are these some 'bitwise flags' that we can remove?
	//If I deduct these constants then function seems to return correct values.

/*
	const int bit6 = 1 << 6;	//64
	const int bit7 = 1 << 7;	//128
	const int bit8 = 1 << 8;	//256
	const int bit9 = 1 << 9;	//512
	const int bit10 = 1 << 10;	//1024
	const int bit11 = 1 << 11;	//2048
	const int bit12 = 1 << 12;
	const int bit13 = 1 << 13;
	const int bit14 = 1 << 14;
	const int bit15 = 1 << 15;
	const int bit16 = 1 << 16;
	const int bit17 = 1 << 17;
	const int bit18 = 1 << 18;
	const int bit19 = 1 << 19;
	const int bit20 = 1 << 20;
	const int bit21 = 1 << 21;
	const int bit22 = 1 << 22;
	const int bit23 = 1 << 23;
	const int bit24 = 1 << 24;
	const int bit25 = 1 << 25;
	const int bit26 = 1 << 26;
	const int bit27 = 1 << 27;
	const int bit28 = 1 << 28;
	const int bit29 = 1 << 29;
	const int bit30 = 1 << 30;	//1073741824

	if (subType & bit30) { subType = (subType & ~ bit30); };
	if (subType & bit29) { subType = (subType & ~ bit29); };
	if (subType & bit28) { subType = (subType & ~ bit28); };
	if (subType & bit27) { subType = (subType & ~ bit27); };
	if (subType & bit26) { subType = (subType & ~ bit26); };
	if (subType & bit25) { subType = (subType & ~ bit25); };
	if (subType & bit24) { subType = (subType & ~ bit24); };
	if (subType & bit23) { subType = (subType & ~ bit23); };
	if (subType & bit22) { subType = (subType & ~ bit22); };
	if (subType & bit21) { subType = (subType & ~ bit21); };
	if (subType & bit20) { subType = (subType & ~ bit20); };
	if (subType & bit19) { subType = (subType & ~ bit19); };
	if (subType & bit18) { subType = (subType & ~ bit18); };
	if (subType & bit17) { subType = (subType & ~ bit17); };
	if (subType & bit16) { subType = (subType & ~ bit16); };
	if (subType & bit15) { subType = (subType & ~ bit15); };
	if (subType & bit14) { subType = (subType & ~ bit14); };
	if (subType & bit13) { subType = (subType & ~ bit13); };
	if (subType & bit12) { subType = (subType & ~ bit12); };
	if (subType & bit11) { subType = (subType & ~ bit11); };
	if (subType & bit10) { subType = (subType & ~ bit10); };
	if (subType & bit9) { subType = (subType & ~ bit9); };
	if (subType & bit8) { subType = (subType & ~ bit8); };
	if (subType & bit7) { subType = (subType & ~ bit7); };
	if (subType & bit6) { subType = (subType & ~ bit6); };
*/

	const int bitMask = (1 << 6) - 1;
	return (subType & bitMask);
};

func string eMsg_MD_GetMsgTypeString (var int eMsg) {
	if (!eMsg) { return ""; };

	var int vtbl; vtbl = MEM_ReadInt (eMsg);

	if (vtbl == oCMsgConversation_vtbl) { return "oCMsgConversation"; };
	if (vtbl == zCEventCore_vtbl) { return "zCEventCore"; };
	if (vtbl == oCNpcMessage_vtbl) { return "oCNpcMessage"; };
	if (vtbl == oCMsgDamage_vtbl) { return "oCMsgDamage"; };
	if (vtbl == oCMsgWeapon_vtbl) { return "oCMsgWeapon"; };
	if (vtbl == oCMsgMovement_vtbl) { return "oCMsgMovement"; };
	if (vtbl == oCMsgAttack_vtbl) { return "oCMsgAttack"; };
	if (vtbl == oCMsgUseItem_vtbl) { return "oCMsgUseItem"; };
	if (vtbl == oCMsgState_vtbl) { return "oCMsgState"; };
	if (vtbl == oCMsgManipulate_vtbl) { return "oCMsgManipulate"; };
	if (vtbl == oCMsgMagic_vtbl) { return "oCMsgMagic"; };
	if (vtbl == zCEvMsgCutscene_vtbl) { return "zCEvMsgCutscene"; };

	//Is this NPC related?
	if (vtbl == zCEventMusicControler_vtbl) { return "zCEventMusicControler"; };
	if (vtbl == oCMobMsg_vtbl) { return "oCMobMsg"; };

	//unknown vtbl
	MEM_Info (ConcatStrings ("eMsg_MD_GetMsgTypeString - Unknown vtbl: ", IntToString (vtbl)));
	return "";
};

/*
 *	Wrapper for *MD_GetSubTypeString functions
 */
func string eMsg_MD_GetSubTypeString (var int eMsg) {
	if (!eMsg) { return ""; };

	var int vtbl; vtbl = MEM_ReadInt (eMsg);

	var int subType; subType = eMsg_MD_GetSubType (eMsg);

	/*
		Seems like not all event-like classes have their MD_GetSubTypeString function ...
		Do we need to emulate them ?
	*/

	if (vtbl == oCMsgConversation_vtbl) {
		return oCMsgConversation_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == zCEventCore_vtbl) {
		return zCEventCore_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCNpcMessage_vtbl) {
		MEM_Info ("oCNpcMessage_vtbl");
		return "";
	};

	if (vtbl == oCMsgDamage_vtbl) {
		return oCMsgDamage_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgWeapon_vtbl) {
		return oCMsgWeapon_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgMovement_vtbl) {
		return oCMsgMovement_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgAttack_vtbl) {
		return oCMsgAttack_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgUseItem_vtbl) {
		MEM_Info ("oCMsgUseItem_vtbl");
		return "";
	};

	if (vtbl == oCMsgState_vtbl) {
		return oCMsgState_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgManipulate_vtbl) {
		return oCMsgManipulate_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMsgMagic_vtbl) {
		return oCMsgMagic_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == zCEvMsgCutscene_vtbl) {
		return zCEvMsgCutscene_MD_GetSubTypeString (eMsg, subType);
	};

	//Is this NPC related?
	if (vtbl == zCEventMusicControler_vtbl) {
		return zCEventMusicControler_MD_GetSubTypeString (eMsg, subType);
	};

	if (vtbl == oCMobMsg_vtbl) {
		return oCMobMsg_MD_GetSubTypeString (eMsg, subType);
	};

	//unknown vtbl
	MEM_Info (ConcatStrings ("eMsg_MD_GetSubTypeString - Unknown vtbl: ", IntToString (vtbl)));
	return "";
};

/*
 *	Function returns Event Name from Event Manager at index
 *		eMgr			Event Manager
 *		index			Event Message index (starts at 0)
 */
func string zcEventManager_GetEventName (var int eMgr, var int index){
	if (!Hlp_Is_zCEventManager (eMgr)) { return ""; };

	//Is there anything in event manager?
	if (zCEventManager_GetNumMessages (eMgr) <= index) { return ""; };

	//Get Event Message
	var int eMsg; eMsg = zCEventManager_GetEventMessage (eMgr, index);

	if (!eMsg) { return ""; };

	var string eventName;
	eventName = eMsg_MD_GetSubTypeString (eMsg);

	return eventName;
};

func int zcEventManager_GetEventCountByEventName (var int eMgr, var string eventName){
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	//Is there anything in event manager?
	var int eventCount; eventCount = 0;
	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);

	if (eventTotal == 0) { return 0; };

	var int eMsg;
	var string thisEventName;

	//Loop through Event Messages
	var int i; i = 0;

	while (i < eventTotal);
		thisEventName = zcEventManager_GetEventName (eMgr, i);

		if (Hlp_StrCmp (eventName, thisEventName)) {
			eventCount += 1;
		};

		i += 1;
	end;

	return eventCount;
};

func int zcEventManager_GetEventByEventName (var int eMgr, var string eventName){
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);

	if (eventTotal == 0) { return 0; };

	var int eMsg;
	var string thisEventName;

	//Loop through Event Messages
	var int i; i = 0;

	while (i < eventTotal);
		thisEventName = zcEventManager_GetEventName (eMgr, i);

		if (Hlp_StrCmp (eventName, thisEventName)) {
			return +zCEventManager_GetEventMessage (eMgr, i);
		};

		i += 1;
	end;

	return 0;
};

func int zcEventManager_GetIndexByEventName (var int eMgr, var string eventName){
	if (!Hlp_Is_zCEventManager (eMgr)) { return -1; };

	var int eventTotal; eventTotal = zCEventManager_GetNumMessages (eMgr);

	if (eventTotal == 0) { return -1; };

	var int eMsg;
	var string thisEventName;

	//Loop through Event Messages
	var int i; i = 0;

	while (i < eventTotal);
		thisEventName = zcEventManager_GetEventName (eMgr, i);

		if (Hlp_StrCmp (eventName, thisEventName)) {
			return i;
		};

		i += 1;
	end;

	return -1;
};

/*
 *	Function returns number of Event messages in NPC's Event Manager
 *		slfinstance		NPC instance
 */
func int NPC_EM_GetEventCount (var int slfinstance){
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	return +zCEventManager_GetNumMessages (eMgr);
};

/*
 *	Function returns Event Name from NPC's Event Manager at index
 *		slfinstance		NPC instance
 *		index			Event Message index (starts at 0)
 */
func string NPC_EM_GetEventName (var int slfinstance, var int index){
	if (index < 0) { return ""; };

	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return ""; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	return zcEventManager_GetEventName (eMgr, index);
};

/*
 *	Function returns number of Event Messages which are in NPC's Event Manager (by name)
 *		slfinstance		NPC instance
 *		eventName		Event Name
 */
func int NPC_EM_GetEventCountByEventName (var int slfinstance, var string eventName){
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	return +zcEventManager_GetEventCountByEventName (eMgr, eventName);
};

/*
 *	Function returns Event Name of Active Event Message from NPC's Event Manager
 *		slfinstance		NPC instance
 *
 *
 *	Hmmm this one does not return same thing as NPC_EM_GetEventName (eMgr, 0);
 */
func string NPC_EM_GetActiveEventName (var int slfinstance){
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return ""; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return ""; };

	//Get Event Message
	var int eMsg; eMsg = zCEventManager_GetActiveMessage (eMgr);

	if (!eMsg) { return ""; };

	var string eventName;
	eventName = eMsg_MD_GetSubTypeString (eMsg);

	return eventName;
};

func int NPC_EM_GetEventMessage (var int slfInstance, var int index) {
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	if (!zCEventManager_GetNumMessages (eMgr)) { return 0; };

	//Get Event Message
	return +zCEventManager_GetEventMessage (eMgr, index);
};

func int NPC_EM_GetEventMessageByEventName (var int slfInstance, var string eventName) {
	var oCNPC slf; slf = Hlp_GetNPC (slfinstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	if (!zCEventManager_GetNumMessages (eMgr)) { return 0; };

	//Get Event Message
	return +zcEventManager_GetEventByEventName (eMgr, eventName);
};
