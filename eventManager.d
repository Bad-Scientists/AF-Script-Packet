/*
 *	Event Manager (AI queue) functions [WIP]
 */

func int zCEventMessage_MD_GetNumOfSubTypes (var int eMsg) {
	//0x00401E90 public: virtual int __thiscall zCEventMessage::MD_GetNumOfSubTypes(void)
	const int zCEventMessage__MD_GetNumOfSubTypes_G1 = 4202128;

	//0x00401FE0 public: virtual int __thiscall zCEventMessage::MD_GetNumOfSubTypes(void)
	const int zCEventMessage__MD_GetNumOfSubTypes_G2 = 4202464;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__MD_GetNumOfSubTypes_G1, zCEventMessage__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_GetSubType (var int eMsg) {
	//0x0073F4C0 public: unsigned short __thiscall zCEventMessage::GetSubType(void)const
	const int zCEventMessage__GetSubType_G1 = 7599296;

	//0x00674290 public: unsigned short __thiscall zCEventMessage::GetSubType(void)const
	const int zCEventMessage__GetSubType_G2 = 6767248;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__GetSubType_G1, zCEventMessage__GetSubType_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

//---

func int zCEventCore_MD_GetNumOfSubTypes (var int eMsg) {
	//0x00401FF0 public: virtual int __thiscall zCEventCore::MD_GetNumOfSubTypes(void)
	const int zCEventCore__MD_GetNumOfSubTypes_G1 = 4202480;

	//0x00402140 public: virtual int __thiscall zCEventCore::MD_GetNumOfSubTypes(void)
	const int zCEventCore__MD_GetNumOfSubTypes_G2 = 4202816;

	if (!Hlp_Is_zCEventCore (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventCore__MD_GetNumOfSubTypes_G1, zCEventCore__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEvMsgCutscene_MD_GetNumOfSubTypes (var int eMsg) {
	//0x0040C2B0 public: virtual int __thiscall zCEvMsgCutscene::MD_GetNumOfSubTypes(void)
	const int zCEvMsgCutscene__MD_GetNumOfSubTypes_G1 = 4244144;

	//0x0040C6A0 public: virtual int __thiscall zCEvMsgCutscene::MD_GetNumOfSubTypes(void)
	const int zCEvMsgCutscene__MD_GetNumOfSubTypes_G2 = 4245152;

	if (!Hlp_Is_zCEvMsgCutscene (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEvMsgCutscene__MD_GetNumOfSubTypes_G1, zCEvMsgCutscene__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCCSCamera_EventMsg_MD_GetNumOfSubTypes (var int eMsg) {
	//0x004BDBA0 public: virtual int __thiscall zCCSCamera_EventMsg::MD_GetNumOfSubTypes(void)
	const int zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G1 = 4971424;

	//0x004C7000 public: virtual int __thiscall zCCSCamera_EventMsg::MD_GetNumOfSubTypes(void)
	const int zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G2 = 5009408;

	if (!Hlp_Is_zCCSCamera_EventMsg (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G1, zCCSCamera_EventMsg__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCCSCamera_EventMsgActivate_MD_GetNumOfSubTypes (var int eMsg) {
	//0x004BDFA0 public: virtual int __thiscall zCCSCamera_EventMsgActivate::MD_GetNumOfSubTypes(void)
	const int zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G1 = 4972448;

	//0x004C7400 public: virtual int __thiscall zCCSCamera_EventMsgActivate::MD_GetNumOfSubTypes(void)
	const int zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G2 = 5010432;

	if (!Hlp_Is_zCCSCamera_EventMsgActivate (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G1, zCCSCamera_EventMsgActivate__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventCommon_MD_GetNumOfSubTypes (var int eMsg) {
	//0x005E2200 public: virtual int __thiscall zCEventCommon::MD_GetNumOfSubTypes(void)
	const int zCEventCommon__MD_GetNumOfSubTypes_G1 = 6169088;

	//0x0060F0D0 public: virtual int __thiscall zCEventCommon::MD_GetNumOfSubTypes(void)
	const int zCEventCommon__MD_GetNumOfSubTypes_G2 = 6353104;

	if (!Hlp_Is_zCEventCommon (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventCommon__MD_GetNumOfSubTypes_G1, zCEventCommon__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMover_MD_GetNumOfSubTypes (var int eMsg) {
	//0x005E25E0 public: virtual int __thiscall zCEventMover::MD_GetNumOfSubTypes(void)
	const int zCEventMover__MD_GetNumOfSubTypes_G1 = 6170080;

	//0x0060F470 public: virtual int __thiscall zCEventMover::MD_GetNumOfSubTypes(void)
	const int zCEventMover__MD_GetNumOfSubTypes_G2 = 6354032;

	if (!Hlp_Is_zCEventMover (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMover__MD_GetNumOfSubTypes_G1, zCEventMover__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventScreenFX_MD_GetNumOfSubTypes (var int eMsg) {
	//0x005E2920 public: virtual int __thiscall zCEventScreenFX::MD_GetNumOfSubTypes(void)
	const int zCEventScreenFX__MD_GetNumOfSubTypes_G1 = 6170912;

	//0x0060F790 public: virtual int __thiscall zCEventScreenFX::MD_GetNumOfSubTypes(void)
	const int zCEventScreenFX__MD_GetNumOfSubTypes_G2 = 6354832;

	if (!Hlp_Is_zCEventScreenFX (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventScreenFX__MD_GetNumOfSubTypes_G1, zCEventScreenFX__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMobMsg_MD_GetNumOfSubTypes (var int eMsg) {
	//0x0067A560 public: virtual int __thiscall oCMobMsg::MD_GetNumOfSubTypes(void)
	const int oCMobMsg__MD_GetNumOfSubTypes_G1 = 6792544;

	//0x0071B740 public: virtual int __thiscall oCMobMsg::MD_GetNumOfSubTypes(void)
	const int oCMobMsg__MD_GetNumOfSubTypes_G2 = 7452480;

	if (!Hlp_Is_oCMobMsg (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMobMsg__MD_GetNumOfSubTypes_G1, oCMobMsg__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgDamage_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006BE210 public: virtual int __thiscall oCMsgDamage::MD_GetNumOfSubTypes(void)
	const int oCMsgDamage__MD_GetNumOfSubTypes_G1 = 7070224;

	//0x007653B0 public: virtual int __thiscall oCMsgDamage::MD_GetNumOfSubTypes(void)
	const int oCMsgDamage__MD_GetNumOfSubTypes_G2 = 7754672;

	if (!Hlp_Is_oCMsgDamage (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgDamage__MD_GetNumOfSubTypes_G1, oCMsgDamage__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgMovement_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006BEEF0 public: virtual int __thiscall oCMsgMovement::MD_GetNumOfSubTypes(void)
	const int oCMsgMovement__MD_GetNumOfSubTypes_G1 = 7073520;

	//0x00766090 public: virtual int __thiscall oCMsgMovement::MD_GetNumOfSubTypes(void)
	const int oCMsgMovement__MD_GetNumOfSubTypes_G2 = 7757968;

	if (!Hlp_Is_oCMsgMovement (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgMovement__MD_GetNumOfSubTypes_G1, oCMsgMovement__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgWeapon_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006BF920 public: virtual int __thiscall oCMsgWeapon::MD_GetNumOfSubTypes(void)
	const int oCMsgWeapon__MD_GetNumOfSubTypes_G1 = 7076128;

	//0x00766AC0 public: virtual int __thiscall oCMsgWeapon::MD_GetNumOfSubTypes(void)
	const int oCMsgWeapon__MD_GetNumOfSubTypes_G2 = 7760576;

	if (!Hlp_Is_oCMsgWeapon (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgWeapon__MD_GetNumOfSubTypes_G1, oCMsgWeapon__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgAttack_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006C0500 public: virtual int __thiscall oCMsgAttack::MD_GetNumOfSubTypes(void)
	const int oCMsgAttack__MD_GetNumOfSubTypes_G1 = 7079168;

	//0x007676A0 public: virtual int __thiscall oCMsgAttack::MD_GetNumOfSubTypes(void)
	const int oCMsgAttack__MD_GetNumOfSubTypes_G2 = 7763616;

	if (!Hlp_Is_oCMsgAttack (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgAttack__MD_GetNumOfSubTypes_G1, oCMsgAttack__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgState_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006C1340 public: virtual int __thiscall oCMsgState::MD_GetNumOfSubTypes(void)
	const int oCMsgState__MD_GetNumOfSubTypes_G1 = 7082816;

	//0x007684E0 public: virtual int __thiscall oCMsgState::MD_GetNumOfSubTypes(void)
	const int oCMsgState__MD_GetNumOfSubTypes_G2 = 7767264;

	if (!Hlp_Is_oCMsgState (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgState__MD_GetNumOfSubTypes_G1, oCMsgState__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgManipulate_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006C23A0 public: virtual int __thiscall oCMsgManipulate::MD_GetNumOfSubTypes(void)
	const int oCMsgManipulate__MD_GetNumOfSubTypes_G1 = 7087008;

	//0x00769540 public: virtual int __thiscall oCMsgManipulate::MD_GetNumOfSubTypes(void)
	const int oCMsgManipulate__MD_GetNumOfSubTypes_G2 = 7771456;

	if (!Hlp_Is_oCMsgManipulate (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgManipulate__MD_GetNumOfSubTypes_G1, oCMsgManipulate__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgConversation_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006C3760 public: virtual int __thiscall oCMsgConversation::MD_GetNumOfSubTypes(void)
	const int oCMsgConversation__MD_GetNumOfSubTypes_G1 = 7092064;

	//0x0076A900 public: virtual int __thiscall oCMsgConversation::MD_GetNumOfSubTypes(void)
	const int oCMsgConversation__MD_GetNumOfSubTypes_G2 = 7776512;

	if (!Hlp_Is_oCMsgConversation (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgConversation__MD_GetNumOfSubTypes_G1, oCMsgConversation__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int oCMsgMagic_MD_GetNumOfSubTypes (var int eMsg) {
	//0x006C4240 public: virtual int __thiscall oCMsgMagic::MD_GetNumOfSubTypes(void)
	const int oCMsgMagic__MD_GetNumOfSubTypes_G1 = 7094848;

	//0x0076B420 public: virtual int __thiscall oCMsgMagic::MD_GetNumOfSubTypes(void)
	const int oCMsgMagic__MD_GetNumOfSubTypes_G2 = 7779360;

	if (!Hlp_Is_oCMsgMagic (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgMagic__MD_GetNumOfSubTypes_G1, oCMsgMagic__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMusicControler_MD_GetNumOfSubTypes (var int eMsg) {
	//0x0070D2E0 public: virtual int __thiscall zCEventMusicControler::MD_GetNumOfSubTypes(void)
	const int zCEventMusicControler__MD_GetNumOfSubTypes_G1 = 7394016;

	//0x00642B30 public: virtual int __thiscall zCEventMusicControler::MD_GetNumOfSubTypes(void)
	const int zCEventMusicControler__MD_GetNumOfSubTypes_G2 = 6564656;

	if (!Hlp_Is_zCEventMusicControler (eMsg)) { return -1; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMusicControler__MD_GetNumOfSubTypes_G1, zCEventMusicControler__MD_GetNumOfSubTypes_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};


//MD_GetSubTypeString functions


func string zCEvMsgCutscene_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x0040C2C0 public: virtual class zSTRING __thiscall zCEvMsgCutscene::MD_GetSubTypeString(int)
	const int zCEvMsgCutscene__MD_GetSubTypeString_G1 = 4244160;

	//0x0040C6B0 public: virtual class zSTRING __thiscall zCEvMsgCutscene::MD_GetSubTypeString(int)
	const int zCEvMsgCutscene__MD_GetSubTypeString_G2 = 4245168;

	if (!Hlp_Is_zCEvMsgCutscene (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCEvMsgCutscene__MD_GetSubTypeString_G1, zCEvMsgCutscene__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCCSCamera_EventMsg_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x004BDBB0 public: virtual class zSTRING __thiscall zCCSCamera_EventMsg::MD_GetSubTypeString(int)
	const int zCCSCamera_EventMsg__MD_GetSubTypeString_G1 = 4971440;

	//0x004C7010 public: virtual class zSTRING __thiscall zCCSCamera_EventMsg::MD_GetSubTypeString(int)
	const int zCCSCamera_EventMsg__MD_GetSubTypeString_G2 = 5009424;

	if (!Hlp_Is_zCCSCamera_EventMsg (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCCSCamera_EventMsg__MD_GetSubTypeString_G1, zCCSCamera_EventMsg__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCCSCamera_EventMsgActivate_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x004BDFB0 public: virtual class zSTRING __thiscall zCCSCamera_EventMsgActivate::MD_GetSubTypeString(int)
	const int zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G1 = 4972464;

	//0x004C7410 public: virtual class zSTRING __thiscall zCCSCamera_EventMsgActivate::MD_GetSubTypeString(int)
	const int zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G2 = 5010448;

	if (!Hlp_Is_zCCSCamera_EventMsgActivate (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G1, zCCSCamera_EventMsgActivate__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventCore_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x005D9A00 public: virtual class zSTRING __thiscall zCEventCore::MD_GetSubTypeString(int)
	const int zCEventCore__MD_GetSubTypeString_G1 = 6134272;

	//0x006062F0 public: virtual class zSTRING __thiscall zCEventCore::MD_GetSubTypeString(int)
	const int zCEventCore__MD_GetSubTypeString_G2 = 6316784;

	if (!Hlp_Is_zCEventCore (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCEventCore__MD_GetSubTypeString_G1, zCEventCore__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventCommon_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x005E2970 public: virtual class zSTRING __thiscall zCEventCommon::MD_GetSubTypeString(int)
	const int zCEventCommon__MD_GetSubTypeString_G1 = 6170992;

	//0x0060F7E0 public: virtual class zSTRING __thiscall zCEventCommon::MD_GetSubTypeString(int)
	const int zCEventCommon__MD_GetSubTypeString_G2 = 6354912;

	if (!Hlp_Is_zCEventCommon (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCEventCommon__MD_GetSubTypeString_G1, zCEventCommon__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventMover_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x005E2AD0 public: virtual class zSTRING __thiscall zCEventMover::MD_GetSubTypeString(int)
	const int zCEventMover__MD_GetSubTypeString_G1 = 6171344;

	//0x0060F940 public: virtual class zSTRING __thiscall zCEventMover::MD_GetSubTypeString(int)
	const int zCEventMover__MD_GetSubTypeString_G2 = 6355264;

	if (!Hlp_Is_zCEventMover (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCEventMover__MD_GetSubTypeString_G1, zCEventMover__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventScreenFX_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x005EA670 public: virtual class zSTRING __thiscall zCEventScreenFX::MD_GetSubTypeString(int)
	const int zCEventScreenFX__MD_GetSubTypeString_G1 = 6202992;

	//0x00617720 public: virtual class zSTRING __thiscall zCEventScreenFX::MD_GetSubTypeString(int)
	const int zCEventScreenFX__MD_GetSubTypeString_G2 = 6387488;

	if (!Hlp_Is_zCEventScreenFX (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCEventScreenFX__MD_GetSubTypeString_G1, zCEventScreenFX__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMobMsg_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x0067A570 public: virtual class zSTRING __thiscall oCMobMsg::MD_GetSubTypeString(int)
	const int oCMobMsg__MD_GetSubTypeString_G1 = 6792560;

	//0x0071B750 public: virtual class zSTRING __thiscall oCMobMsg::MD_GetSubTypeString(int)
	const int oCMobMsg__MD_GetSubTypeString_G2 = 7452496;

	if (!Hlp_Is_oCMobMsg (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMobMsg__MD_GetSubTypeString_G1, oCMobMsg__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgDamage_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006BE220 public: virtual class zSTRING __thiscall oCMsgDamage::MD_GetSubTypeString(int)
	const int oCMsgDamage__MD_GetSubTypeString_G1 = 7070240;

	//0x007653C0 public: virtual class zSTRING __thiscall oCMsgDamage::MD_GetSubTypeString(int)
	const int oCMsgDamage__MD_GetSubTypeString_G2 = 7754688;

	if (!Hlp_Is_oCMsgDamage (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgDamage__MD_GetSubTypeString_G1, oCMsgDamage__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgWeapon_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006BF930 public: virtual class zSTRING __thiscall oCMsgWeapon::MD_GetSubTypeString(int)
	const int oCMsgWeapon__MD_GetSubTypeString_G1 = 7076144;

	//0x00766AD0 public: virtual class zSTRING __thiscall oCMsgWeapon::MD_GetSubTypeString(int)
	const int oCMsgWeapon__MD_GetSubTypeString_G2 = 7760592;

	if (!Hlp_Is_oCMsgWeapon (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgWeapon__MD_GetSubTypeString_G1, oCMsgWeapon__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgMovement_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006BEF00 public: virtual class zSTRING __thiscall oCMsgMovement::MD_GetSubTypeString(int)
	const int oCMsgMovement__MD_GetSubTypeString_G1 = 7073536;

	//0x007660A0 public: virtual class zSTRING __thiscall oCMsgMovement::MD_GetSubTypeString(int)
	const int oCMsgMovement__MD_GetSubTypeString_G2 = 7757984;

	if (!Hlp_Is_oCMsgMovement (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgMovement__MD_GetSubTypeString_G1, oCMsgMovement__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgAttack_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006C0510 public: virtual class zSTRING __thiscall oCMsgAttack::MD_GetSubTypeString(int)
	const int oCMsgAttack__MD_GetSubTypeString_G1 = 7079184;

	//0x007676B0 public: virtual class zSTRING __thiscall oCMsgAttack::MD_GetSubTypeString(int)
	const int oCMsgAttack__MD_GetSubTypeString_G2 = 7763632;

	if (!Hlp_Is_oCMsgAttack (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgAttack__MD_GetSubTypeString_G1, oCMsgAttack__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgState_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006C1350 public: virtual class zSTRING __thiscall oCMsgState::MD_GetSubTypeString(int)
	const int oCMsgState__MD_GetSubTypeString_G1 = 7082832;

	//0x007684F0 public: virtual class zSTRING __thiscall oCMsgState::MD_GetSubTypeString(int)
	const int oCMsgState__MD_GetSubTypeString_G2 = 7767280;

	if (!Hlp_Is_oCMsgState (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgState__MD_GetSubTypeString_G1, oCMsgState__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgManipulate_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006C23B0 public: virtual class zSTRING __thiscall oCMsgManipulate::MD_GetSubTypeString(int)
	const int oCMsgManipulate__MD_GetSubTypeString_G1 = 7087024;

	//0x00769550 public: virtual class zSTRING __thiscall oCMsgManipulate::MD_GetSubTypeString(int)
	const int oCMsgManipulate__MD_GetSubTypeString_G2 = 7771472;

	if (!Hlp_Is_oCMsgManipulate (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgManipulate__MD_GetSubTypeString_G1, oCMsgManipulate__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgMagic_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006C4250 public: virtual class zSTRING __thiscall oCMsgMagic::MD_GetSubTypeString(int)
	const int oCMsgMagic__MD_GetSubTypeString_G1 = 7094864;

	//0x0076B430 public: virtual class zSTRING __thiscall oCMsgMagic::MD_GetSubTypeString(int)
	const int oCMsgMagic__MD_GetSubTypeString_G2 = 7779376;

	if (!Hlp_Is_oCMsgMagic (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgMagic__MD_GetSubTypeString_G1, oCMsgMagic__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string zCEventMusicControler_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x0070D370 public: virtual class zSTRING __thiscall zCEventMusicControler::MD_GetSubTypeString(int)
	const int zCEventMusicControler__MD_GetSubTypeString_G1 = 7394160;

	//0x00642BC0 public: virtual class zSTRING __thiscall zCEventMusicControler::MD_GetSubTypeString(int)
	const int zCEventMusicControler__MD_GetSubTypeString_G2 = 6564800;

	if (!Hlp_Is_zCEventMusicControler (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCEventMusicControler__MD_GetSubTypeString_G1, zCEventMusicControler__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func int oCNpc_GetTalkingWithMessage (var int slfInstance, var int npcInstance) {
	//0x00633620 public: class zCEventMessage * __thiscall oCNpc::GetTalkingWithMessage(class oCNpc *)
	const int oCNpc__GetTalkingWithMessage_G1 = 6501920;

	//0x006BCFB0 public: class zCEventMessage * __thiscall oCNpc::GetTalkingWithMessage(class oCNpc *)
	const int oCNpc__GetTalkingWithMessage_G2 = 7065520;

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var oCNpc npc; npc = Hlp_GetNPC (npcInstance);
	if (!Hlp_IsValidNPC (npc)) { return 0; };

	var int slfPtr; slfPtr = _@ (slf);
	var int npcPtr; npcPtr = _@ (npc);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (npcPtr));
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__GetTalkingWithMessage_G1, oCNpc__GetTalkingWithMessage_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func int zCEventMessage_GetClassDef (var int eMsg) {
	//0x00401DF0 private: virtual class zCClassDef * __thiscall zCEventMessage::_GetClassDef(void)const
	const int zCEventMessage___GetClassDef_G1 = 4201968;

	//0x00401F30 private: virtual class zCClassDef * __thiscall zCEventMessage::_GetClassDef(void)const
	const int zCEventMessage___GetClassDef_G2 = 4202288;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage___GetClassDef_G1, zCEventMessage___GetClassDef_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func int zCEventMessage_IsOverlay (var int eMsg) {
	//0x00401E00 public: virtual int __thiscall zCEventMessage::IsOverlay(void)
	const int zCEventMessage__IsOverlay_G1 = 4201984;

	//0x00401F40 public: virtual int __thiscall zCEventMessage::IsOverlay(void)
	const int zCEventMessage__IsOverlay_G2 = 4202304;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__IsOverlay_G1, zCEventMessage__IsOverlay_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsNetRelevant (var int eMsg) {
	//0x00401E10 public: virtual int __thiscall zCEventMessage::IsNetRelevant(void)
	const int zCEventMessage__IsNetRelevant_G1 = 4202000;

	//0x00401F50 public: virtual int __thiscall zCEventMessage::IsNetRelevant(void)
	const int zCEventMessage__IsNetRelevant_G2 = 4202320;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__IsNetRelevant_G1, zCEventMessage__IsNetRelevant_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsHighPriority (var int eMsg) {
	//0x00401E20 public: virtual int __thiscall zCEventMessage::IsHighPriority(void)
	const int zCEventMessage__IsHighPriority_G1 = 4202016;

	//0x00401F60 public: virtual int __thiscall zCEventMessage::IsHighPriority(void)
	const int zCEventMessage__IsHighPriority_G2 = 4202336;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__IsHighPriority_G1, zCEventMessage__IsHighPriority_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsJob (var int eMsg) {
	//0x00401E30 public: virtual int __thiscall zCEventMessage::IsJob(void)
	const int zCEventMessage__IsJob_G1 = 4202032;

	//0x00401F70 public: virtual int __thiscall zCEventMessage::IsJob(void)
	const int zCEventMessage__IsJob_G2 = 4202352;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__IsJob_G1, zCEventMessage__IsJob_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsDeleteable (var int eMsg) {
	//0x00401E50 public: virtual int __thiscall zCEventMessage::IsDeleteable(void)
	const int zCEventMessage__IsDeleteable_G1 = 4202064;

	//0x00401FA0 public: virtual int __thiscall zCEventMessage::IsDeleteable(void)
	const int zCEventMessage__IsDeleteable_G2 = 4202400;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__IsDeleteable_G1, zCEventMessage__IsDeleteable_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_IsDeleted (var int eMsg) {
	//0x00401E60 public: virtual int __thiscall zCEventMessage::IsDeleted(void)
	const int zCEventMessage__IsDeleted_G1 = 4202080;

	//0x00401FB0 public: virtual int __thiscall zCEventMessage::IsDeleted(void)
	const int zCEventMessage__IsDeleted_G2 = 4202416;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__IsDeleted_G1, zCEventMessage__IsDeleted_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventMessage_GetCutsceneMode (var int eMsg) {
	//0x00401E80 public: virtual int __thiscall zCEventMessage::GetCutsceneMode(void)
	const int zCEventMessage__GetCutsceneMode_G1 = 4202112;

	//0x00401FD0 public: virtual int __thiscall zCEventMessage::GetCutsceneMode(void)
	const int zCEventMessage__GetCutsceneMode_G2 = 4202448;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__GetCutsceneMode_G1, zCEventMessage__GetCutsceneMode_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func string zCEventMessage_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x00401EA0 public: virtual class zSTRING __thiscall zCEventMessage::MD_GetSubTypeString(int)
	const int zCEventMessage__MD_GetSubTypeString_G1 = 4202144;

	//0x00401FF0 public: virtual class zSTRING __thiscall zCEventMessage::MD_GetSubTypeString(int)
	const int zCEventMessage__MD_GetSubTypeString_G2 = 4202480;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (zCEventMessage__MD_GetSubTypeString_G1, zCEventMessage__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func void zCEventMessage_Delete (var int eMsg) {
	//0x00401E40 public: virtual void __thiscall zCEventMessage::Delete(void)
	const int zCEventMessage__Delete_G1 = 4202048;

	//0x00401F90 public: virtual void __thiscall zCEventMessage::Delete(void)
	const int zCEventMessage__Delete_G2 = 4202384;

	if (!Hlp_Is_zCEventMessage (eMsg)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (zCEventMessage__Delete_G1, zCEventMessage__Delete_G2));
		call = CALL_End();
	};
};

/*
 *
 *
 *
 */

func int zCEventManager_IsRunning (var int eMgr, var int eMsg) {
	//0x006DE550 public: virtual int __thiscall zCEventManager::IsRunning(class zCEventMessage *)
	const int zCEventManager__IsRunning_G1 = 7202128;

	//0x007877E0 public: virtual int __thiscall zCEventManager::IsRunning(class zCEventMessage *)
	const int zCEventManager__IsRunning_G2 = 7895008;

	//This function loops through EM event list and checks if specified message is in the list
	//It can be used t check if message is 'safe' (if it is in EM then it's kinda safe :) )
	//Function Hlp_Is_zCEventMessage is reading pointer - if pointer is invalid we might crash (which happened to me as I used some EM manipulation functions incorrectly ...)
	//Anyway it's counter-productive to check eMsg here --> thus only checking if eMsg is NULL
	//if (!Hlp_Is_zCEventMessage (eMsg)) { return 0; };
	if (!eMsg) { return 0; };
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (eMsg));
		CALL__thiscall (_@ (eMgr), MEMINT_SwitchG1G2 (zCEventManager__IsRunning_G1, zCEventManager__IsRunning_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventManager_GetCutsceneMode (var int eMgr) {
	//0x006DE2E0 public: virtual int __thiscall zCEventManager::GetCutsceneMode(void)
	const int zCEventManager__GetCutsceneMode_G1 = 7201504;

	//0x00787570 public: virtual int __thiscall zCEventManager::GetCutsceneMode(void)
	const int zCEventManager__GetCutsceneMode_G2 = 7894384;

	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMgr), MEMINT_SwitchG1G2 (zCEventManager__GetCutsceneMode_G1, zCEventManager__GetCutsceneMode_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventManager_GetNumMessages (var int eMgr) {
	//0x00452600 public: virtual int __thiscall zCEventManager::GetNumMessages(void)
	const int zCEventManager__GetNumMessages_G1 = 4531712;

	//0x00457430 public: virtual int __thiscall zCEventManager::GetNumMessages(void)
	const int zCEventManager__GetNumMessages_G2 = 4551728;

	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMgr), MEMINT_SwitchG1G2 (zCEventManager__GetNumMessages_G1, zCEventManager__GetNumMessages_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func int zCEventManager_GetActiveMessage (var int eMgr) {
	//0x006DE580 public: virtual class zCEventMessage * __thiscall zCEventManager::GetActiveMessage(void)
	const int zCEventManager__GetActiveMessage_G1 = 7202176;

	//0x00787810 public: virtual class zCEventMessage * __thiscall zCEventManager::GetActiveMessage(void)
	const int zCEventManager__GetActiveMessage_G2 = 7895056;

	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMgr), MEMINT_SwitchG1G2 (zCEventManager__GetActiveMessage_G1, zCEventManager__GetActiveMessage_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

func int zCEventManager_GetEventMessage (var int eMgr, var int index) {
	//0x006DE9B0 public: virtual class zCEventMessage * __thiscall zCEventManager::GetEventMessage(int)
	const int zCEventManager__GetEventMessage_G1 = 7203248;

	//0x00787C40 public: virtual class zCEventMessage * __thiscall zCEventManager::GetEventMessage(int)
	const int zCEventManager__GetEventMessage_G2 = 7896128;

	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_IntParam (_@ (index));
		CALL__thiscall (_@ (eMgr), MEMINT_SwitchG1G2 (zCEventManager__GetEventMessage_G1, zCEventManager__GetEventMessage_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

//-->

func int oCMsgConversation_IsOverlay (var int eMsg) {
	//0x006C3960 public: virtual int __thiscall oCMsgConversation::IsOverlay(void)
	const int oCMsgConversation__IsOverlay_G1 = 7092576;

	//0x0076AB00 public: virtual int __thiscall oCMsgConversation::IsOverlay(void)
	const int oCMsgConversation__IsOverlay_G2 = 7777024;

	if (!Hlp_Is_oCMsgConversation (eMsg)) { return 0; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (eMsg), MEMINT_SwitchG1G2 (oCMsgConversation__IsOverlay_G1, oCMsgConversation__IsOverlay_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

func string oCMsgConversation_MD_GetSubTypeString (var int eMsg, var int subType) {
	//0x006C39A0 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetSubTypeString(int)
	const int oCMsgConversation__MD_GetSubTypeString_G1 = 7092640;

	//0x0076AB60 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetSubTypeString(int)
	const int oCMsgConversation__MD_GetSubTypeString_G2 = 7777120;

	if (!Hlp_Is_oCMsgConversation (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL_IntParam (subType);
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgConversation__MD_GetSubTypeString_G1, oCMsgConversation__MD_GetSubTypeString_G2));
	return CALL_RetValAszstring ();
};

func string oCMsgConversation_MD_GetVobRefName (var int eMsg) {
	//0x006C3B80 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetVobRefName(void)
	const int oCMsgConversation__MD_GetVobRefName_G1 = 7093120;

	//0x0076AD60 public: virtual class zSTRING __thiscall oCMsgConversation::MD_GetVobRefName(void)
	const int oCMsgConversation__MD_GetVobRefName_G2 = 7777632;

	if (!Hlp_Is_oCMsgConversation (eMsg)) { return ""; };

	CALL_RetValIszString();
	CALL__thiscall (eMsg, MEMINT_SwitchG1G2 (oCMsgConversation__MD_GetVobRefName_G1, oCMsgConversation__MD_GetVobRefName_G2));
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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
	if (!Hlp_Is_zCEventMessage (eMsg)) { return; };
	if (!vobPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(vobPtr));
		CALL_PtrParam(_@(eMsg));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__OnMessage_G1, zCEventManager__OnMessage_G2));

		call = CALL_End();
	};
};

func void zCEventManager_Delete (var int eMgr, var int eMsg) {
	//0x006DDFA0 protected: virtual void __thiscall zCEventManager::Delete(class zCEventMessage *)
	const int zCEventManager__Delete_G1 = 7200672;

	//0x00787270 protected: virtual void __thiscall zCEventManager::Delete(class zCEventMessage *)
	const int zCEventManager__Delete_G2 = 7893616;

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
	if (!Hlp_Is_zCEventMessage (eMsg)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(eMsg));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__Delete_G1, zCEventManager__Delete_G2));

		call = CALL_End();
	};
};

func void zCEventManager_RemoveFromList (var int eMgr, var int eMsg) {
	//0x006DDFE0 protected: virtual void __thiscall zCEventManager::RemoveFromList(class zCEventMessage *)
	const int zCEventManager__RemoveFromList_G1 = 7200736;

	//0x007872B0 protected: virtual void __thiscall zCEventManager::RemoveFromList(class zCEventMessage *)
	const int zCEventManager__RemoveFromList_G2 = 7893680;

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
	if (!Hlp_Is_zCEventMessage (eMsg)) { return; };

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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };
	if (!Hlp_Is_zCEventMessage (eMsg)) { return; };

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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };

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

	if (!Hlp_Is_zCEventManager (eMgr)) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam(_@(on));
		CALL__thiscall(_@(eMgr), MEMINT_SwitchG1G2 (zCEventManager__SetActive_G1, zCEventManager__SetActive_G2));

		call = CALL_End();
	};
};

/*
So this is class tree for all zCEventMessage sub-classes - I think that all functions that are figuring out event message type have to take this hierarchy into consideration.
Thus rewriting all functions to check event message type from the bottom of the list to the top.

class tree G1
 - zCEventMessage .... <zObject.cpp,#244>
	 - oCMobMsg .... <zObject.cpp,#244>
	 - oCNpcMessage .... <zObject.cpp,#244>
		 - oCMsgAttack .... <zObject.cpp,#244>
		 - oCMsgConversation [objs 13185] [ctor 13221] .... <zObject.cpp,#244>
		 - oCMsgDamage .... <zObject.cpp,#244>
		 - oCMsgMagic .... <zObject.cpp,#244>
		 - oCMsgManipulate [ctor 1] .... <zObject.cpp,#244>
		 - oCMsgMovement [objs 2] [ctor 17] .... <zObject.cpp,#244>
		 - oCMsgState [objs 1] [ctor 3] .... <zObject.cpp,#244>
		 - oCMsgUseItem .... <zObject.cpp,#244>
		 - oCMsgWeapon .... <zObject.cpp,#244>
	 - zCCSCamera_EventMsg [ctor 6] .... <zObject.cpp,#244>
	 - zCCSCamera_EventMsgActivate [ctor 81] .... <zObject.cpp,#244>
	 - zCEvMsgCutscene [ctor 12] .... <zObject.cpp,#244>
	 - zCEventCommon .... <zObject.cpp,#244>
	 - zCEventCore [ctor 1] .... <zObject.cpp,#244>
	 - zCEventMover .... <zObject.cpp,#244>
	 - zCEventMusicControler .... <zObject.cpp,#244>
	 - zCEventScreenFX [ctor 1] .... <zObject.cpp,#244>

class tree G2A
 - zCEventMessage .... <zObject.cpp,#242>
	 - oCMobMsg [ctor 2] .... <zObject.cpp,#242>
	 - oCNpcMessage .... <zObject.cpp,#242>
		 - oCMsgAttack .... <zObject.cpp,#242>
		 - oCMsgConversation [objs 20829] [ctor 20833] .... <zObject.cpp,#242>
		 - oCMsgDamage .... <zObject.cpp,#242>
		 - oCMsgMagic .... <zObject.cpp,#242>
		 - oCMsgManipulate [objs 1] [ctor 3] .... <zObject.cpp,#242>
		 - oCMsgMovement [objs 1] [ctor 14] .... <zObject.cpp,#242>
		 - oCMsgState [ctor 6] .... <zObject.cpp,#242>
		 - oCMsgUseItem .... <zObject.cpp,#242>
		 - oCMsgWeapon [ctor 1] .... <zObject.cpp,#242>
	 - zCCSCamera_EventMsg [ctor 1] .... <zObject.cpp,#242>
	 - zCCSCamera_EventMsgActivate [ctor 1] .... <zObject.cpp,#242>
	 - zCEvMsgCutscene .... <zObject.cpp,#242>
	 - zCEventCommon .... <zObject.cpp,#242>
	 - zCEventCore [ctor 1] .... <zObject.cpp,#242>
	 - zCEventMover .... <zObject.cpp,#242>
	 - zCEventMusicControler .... <zObject.cpp,#242>
	 - zCEventScreenFX [ctor 1] .... <zObject.cpp,#242>
*/

/*
 *	Wrapper for *MD_GetSubType functions
 */
func int eMsg_MD_GetSubType (var int eMsg) {
	if (!eMsg) { return -1; };

	var int subType; subType = zCEventMessage_GetSubType (eMsg);
	if (subType == -1) { return -1; };

	//Convert to Unsigned short
	subType = subType << 16;
	subType = subType >> 16;

	return subType;
};

func string eMsg_MD_GetMsgTypeString (var int eMsg) {
	if (!eMsg) { return ""; };

	if (Hlp_Is_zCEventScreenFX (eMsg)) { return "zCEventScreenFX"; };
	if (Hlp_Is_zCEventMusicControler (eMsg)) { return "zCEventMusicControler"; };
	if (Hlp_Is_zCEventMover (eMsg)) { return "zCEventMover"; };
	if (Hlp_Is_zCEventCore (eMsg)) { return "zCEventCore"; };
	if (Hlp_Is_zCEventCommon (eMsg)) { return "zCEventCommon"; };
	if (Hlp_Is_zCEvMsgCutscene (eMsg)) { return "zCEvMsgCutscene"; };
	if (Hlp_Is_zCCSCamera_EventMsgActivate (eMsg)) { return "zCCSCamera_EventMsgActivate"; };
	if (Hlp_Is_zCCSCamera_EventMsg (eMsg)) { return "zCCSCamera_EventMsg"; };
	if (Hlp_Is_oCMsgWeapon (eMsg)) { return "oCMsgWeapon"; };
	if (Hlp_Is_oCMsgUseItem (eMsg)) { return "oCMsgUseItem"; };
	if (Hlp_Is_oCMsgState (eMsg)) { return "oCMsgState"; };
	if (Hlp_Is_oCMsgMovement (eMsg)) { return "oCMsgMovement"; };
	if (Hlp_Is_oCMsgManipulate (eMsg)) { return "oCMsgManipulate"; };
	if (Hlp_Is_oCMsgMagic (eMsg)) { return "oCMsgMagic"; };
	if (Hlp_Is_oCMsgDamage (eMsg)) { return "oCMsgDamage"; };
	if (Hlp_Is_oCMsgConversation (eMsg)) { return "oCMsgConversation"; };
	if (Hlp_Is_oCMsgAttack (eMsg)) { return "oCMsgAttack"; };
	if (Hlp_Is_oCNpcMessage (eMsg)) { return "oCNpcMessage"; };
	if (Hlp_Is_oCMobMsg (eMsg)) { return "oCMobMsg"; };
	if (Hlp_Is_zCEventMessage (eMsg)) { return "zCEventMessage"; };

	//unknown vtbl
	var int vtbl; vtbl = MEM_ReadInt (eMsg);
	MEM_Info (ConcatStrings ("eMsg_MD_GetMsgTypeString - unknown vtbl: ", IntToString (vtbl)));
	return "";
};

/*
 *	Wrapper for *MD_GetSubTypeString functions
 */
func string eMsg_MD_GetSubTypeString (var int eMsg) {
	var int subType; subType = eMsg_MD_GetSubType (eMsg);
	if (subType == -1) { return ""; };

	/*
		Seems like not all event-like classes have their MD_GetSubTypeString function ...
		Do we need to emulate them ?
	*/

	if (Hlp_Is_zCEventScreenFX (eMsg)) {
		return zCEventScreenFX_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCEventMusicControler (eMsg)) {
		return zCEventMusicControler_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCEventMover (eMsg)) {
		return zCEventMover_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCEventCore (eMsg)) {
		return zCEventCore_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCEventCommon (eMsg)) {
		return zCEventCommon_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCEvMsgCutscene (eMsg)) {
		return zCEvMsgCutscene_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCCSCamera_EventMsgActivate (eMsg)) {
		return zCCSCamera_EventMsgActivate_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCCSCamera_EventMsg (eMsg)) {
		return zCCSCamera_EventMsg_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgWeapon (eMsg)) {
		return oCMsgWeapon_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgUseItem (eMsg)) {
		MEM_Info ("eMsg_MD_GetSubTypeString: oCMsgUseItem does not have MD_GetSubTypeString function.");
		return "";
	};

	if (Hlp_Is_oCMsgState (eMsg)) {
		return oCMsgState_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgMovement (eMsg)) {
		return oCMsgMovement_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgManipulate (eMsg)) {
		return oCMsgManipulate_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgMagic (eMsg)) {
		return oCMsgMagic_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgDamage (eMsg)) {
		return oCMsgDamage_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgConversation (eMsg)) {
		return oCMsgConversation_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCMsgAttack (eMsg)) {
		return oCMsgAttack_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_oCNpcMessage (eMsg)) {
		MEM_Info ("eMsg_MD_GetSubTypeString: oCNpcMessage does not have MD_GetSubTypeString function.");
		return "";
	};

	if (Hlp_Is_oCMobMsg (eMsg)) {
		return oCMobMsg_MD_GetSubTypeString (eMsg, subType);
	};

	if (Hlp_Is_zCEventMessage (eMsg)) {
		return zCEventMessage_MD_GetSubTypeString (eMsg, subType);
		return "";
	};

	//---

	//unknown vtbl
	var int vtbl; vtbl = MEM_ReadInt (eMsg);
	MEM_Info (ConcatStrings ("eMsg_MD_GetSubTypeString - unknown vtbl: ", IntToString (vtbl)));
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
 *		slfInstance		NPC instance
 */
func int NPC_EM_GetEventCount (var int slfInstance){
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));

	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	return +zCEventManager_GetNumMessages (eMgr);
};

/*
 *	Function returns Event Name from NPC's Event Manager at index
 *		slfInstance		NPC instance
 *		index			Event Message index (starts at 0)
 */
func string NPC_EM_GetEventName (var int slfInstance, var int index){
	if (index < 0) { return ""; };

	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return ""; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	return zcEventManager_GetEventName (eMgr, index);
};

/*
 *	Function returns number of Event Messages which are in NPC's Event Manager (by name)
 *		slfInstance		NPC instance
 *		eventName		Event Name
 */
func int NPC_EM_GetEventCountByEventName (var int slfInstance, var string eventName){
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);

	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	return +zcEventManager_GetEventCountByEventName (eMgr, eventName);
};

/*
 *	Function returns Event Name of Active Event Message from NPC's Event Manager
 *		slfInstance		NPC instance
 *
 *
 *	Hmmm this one does not return same thing as NPC_EM_GetEventName (eMgr, 0);
 */
func string NPC_EM_GetActiveEventName (var int slfInstance){
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
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
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	if (!zCEventManager_GetNumMessages (eMgr)) { return 0; };

	//Get Event Message
	return +zCEventManager_GetEventMessage (eMgr, index);
};

func int NPC_EM_GetEventMessageByEventName (var int slfInstance, var string eventName) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	//Get Event Manager
	var int eMgr; eMgr = zCVob_GetEM (_@ (slf));
	if (!Hlp_Is_zCEventManager (eMgr)) { return 0; };

	if (!zCEventManager_GetNumMessages (eMgr)) { return 0; };

	//Get Event Message
	return +zcEventManager_GetEventByEventName (eMgr, eventName);
};
