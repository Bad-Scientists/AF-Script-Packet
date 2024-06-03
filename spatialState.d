func void zCAIPlayer_CalcStateVars (var int aiPlayerPtr) {
	//0x004FE8D0 private: void __thiscall zCAIPlayer::CalcStateVars(void)
	const int zCAIPlayer__CalcStateVars_G1 = 5236944;

	//0x0050E440 private: void __thiscall zCAIPlayer::CalcStateVars(void)
	const int zCAIPlayer__CalcStateVars_G2 = 5301312;

	if (!aiPlayerPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (aiPlayerPtr), MEMINT_SwitchG1G2 (zCAIPlayer__CalcStateVars_G1, zCAIPlayer__CalcStateVars_G2));
		call = CALL_End();
	};
};

/*
 *	zCVob_GetCollisionObject
 */
func int zCVob_GetCollisionObject (var int vobPtr) {
	//0x005F10C0 public: class zCCollisionObject * __thiscall zCVob::GetCollisionObject(void)const
	const int zCVob__GetCollisionObject_G1 = 6230208;

	//0x0061E650 public: class zCCollisionObject * __thiscall zCVob::GetCollisionObject(void)const
	const int zCVob__GetCollisionObject_G2 = 6415952;

	if (!vobPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (vobPtr), MEMINT_SwitchG1G2 (zCVob__GetCollisionObject_G1, zCVob__GetCollisionObject_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	Vob_GetSpatialState
 */
func int Vob_GetSpatialState (var int vobPtr) {
	//Same offset size for G1 & G2 NoTR
	//zTSpatialState m_oSpatialState; // sizeof 20h offset C0h
	//zTSpatialState m_oSpatialState; // sizeof 20h offset C0h
	const int m_oSpatialState_offset = 192;

	if (!vobPtr) { return 0; };

	var int collObjectPtr; collObjectPtr = zCVob_GetCollisionObject (vobPtr);

	if (!collObjectPtr) { return 0; };

	return + (collObjectPtr + m_oSpatialState_offset);
};

/*
 *	Vob_GetConfig
 */
func int Vob_GetConfig (var int vobPtr) {
	//Same offset size for G1 & G2 NoTR
	//zTConfig m_oConfig; // sizeof 10h offset FCh
	//zTConfig m_oConfig; // sizeof 10h offset FCh
	const int m_oConfig_offset = 252;

	if (!vobPtr) { return 0; };

	var int collObjectPtr; collObjectPtr = zCVob_GetCollisionObject (vobPtr);

	if (!collObjectPtr) { return 0; };

	return + (collObjectPtr + m_oConfig_offset);
};

//int
func int zCAIPlayer_GetWaterLevel (var int aiPlayerPtr) {
	if (!aiPlayerPtr) { return 0; };
	var zCAIPlayer aiPlayer; aiPlayer = _^ (aiPlayerPtr);
	return aiPlayer.waterLevel;
};

//int
func int oCAniCtrl_Human_GetWaterLevel (var int aniCtrlPtr) {
	//0x0062F1D0 public: int __thiscall oCAniCtrl_Human::GetWaterLevel(void)
	const int oCAniCtrl_Human__GetWaterLevel_G1 = 6484432;

	//0x006B89D0 public: int __thiscall oCAniCtrl_Human::GetWaterLevel(void)
	const int oCAniCtrl_Human__GetWaterLevel_G2 = 7047632;

	if (!aniCtrlPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo (_@ (retVal));
		CALL__thiscall (_@ (aniCtrlPtr), MEMINT_SwitchG1G2 (oCAniCtrl_Human__GetWaterLevel_G1, oCAniCtrl_Human__GetWaterLevel_G2));
		call = CALL_End();
	};

	return + retVal;
};

//float
func int zCAIPlayer_GetFeetY (var int aiPlayerPtr) {
	if (!aiPlayerPtr) { return FLOATNULL; };
	var zCAIPlayer aiPlayer; aiPlayer = _^ (aiPlayerPtr);
	return aiPlayer.feetY;
};

//float
func int zCAIPlayer_GetHeadY (var int aiPlayerPtr) {
	if (!aiPlayerPtr) { return FLOATNULL; };
	var zCAIPlayer aiPlayer; aiPlayer = _^ (aiPlayerPtr);
	return aiPlayer.headY;
};

//float
func int zCAIPlayer_GetAboveFloor (var int aiPlayerPtr) {
	if (!aiPlayerPtr) { return FLOATNULL; };
	var zCAIPlayer aiPlayer; aiPlayer = _^ (aiPlayerPtr);
	return aiPlayer.aboveFloor;
};

//float
func int zCAIPlayer_GetFallDownDistanceY (var int aiPlayerPtr) {
	if (!aiPlayerPtr) { return FLOATNULL; };
	var zCAIPlayer aiPlayer; aiPlayer = _^ (aiPlayerPtr);
	return aiPlayer.fallDownDistanceY;
};

//float
func int Vob_GetFloorY (var int vobPtr) {
	var int spatialStatePtr; spatialStatePtr = Vob_GetSpatialState (vobPtr);
	if (!spatialStatePtr) { return FLOATNULL; };
	var zTSpatialState spatialState; spatialState = _^ (spatialStatePtr);
	return spatialState.m_fFloorY;
};

//float
func int Vob_GetLastFloorY (var int vobPtr) {
	var int spatialStatePtr; spatialStatePtr = Vob_GetSpatialState (vobPtr);
	if (!spatialStatePtr) { return FLOATNULL; };
	var zTSpatialState spatialState; spatialState = _^ (spatialStatePtr);
	return spatialState.m_fLastFloorY;
};

//float
func int Vob_GetWaterY (var int vobPtr) {
	var int spatialStatePtr; spatialStatePtr = Vob_GetSpatialState (vobPtr);
	if (!spatialStatePtr) { return FLOATNULL; };
	var zTSpatialState spatialState; spatialState = _^ (spatialStatePtr);
	return spatialState.m_fWaterY;
};

//float
func int Vob_GetCeilingY (var int vobPtr) {
	var int spatialStatePtr; spatialStatePtr = Vob_GetSpatialState (vobPtr);
	if (!spatialStatePtr) { return FLOATNULL; };
	var zTSpatialState spatialState; spatialState = _^ (spatialStatePtr);
	return spatialState.m_fCeilingY;
};

//zCPolygon*
func int Vob_GetFloorPoly (var int vobPtr) {
	var int spatialStatePtr; spatialStatePtr = Vob_GetSpatialState (vobPtr);
	if (!spatialStatePtr) { return FLOATNULL; };
	var zTSpatialState spatialState; spatialState = _^ (spatialStatePtr);
	return spatialState.m_poFloorPoly;
};

//zCPolygon*
func int Vob_GetWaterPoly (var int vobPtr) {
	var int spatialStatePtr; spatialStatePtr = Vob_GetSpatialState (vobPtr);
	if (!spatialStatePtr) { return FLOATNULL; };
	var zTSpatialState spatialState; spatialState = _^ (spatialStatePtr);
	return spatialState.m_poWaterPoly;
};

//-- Wrapper functions for Npcs
//zTConfig*
func int Npc_GetConfig (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };
	return + Vob_GetConfig (_@ (slf));
};

//int
/*
 *	Npc_GetWaterLevel
 *	0 - not in water
 *	1 - knees in water
 *	2 - swimming
 */
func int Npc_GetWaterLevel (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return 0; };
	if (!slf.aniCtrl) { return 0; };

	return + oCAniCtrl_Human_GetWaterLevel (slf.aniCtrl);
};

//float
func int Npc_GetFeetY (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return FLOATNULL; };
	if (!slf.aniCtrl) { return FLOATNULL; };
	return + zCAIPlayer_GetFeetY (slf.aniCtrl);
};

//float
func int Npc_GetAboveFloor (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return FLOATNULL; };
	if (!slf.aniCtrl) { return FLOATNULL; };
	return + zCAIPlayer_GetAboveFloor (slf.aniCtrl);
};

//float
func int Npc_GetWaterY (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return FLOATNULL; };
	return + Vob_GetWaterY (_@ (slf));
};

//floor
func int Npc_GetFloorY (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return FLOATNULL; };
	return + Vob_GetFloorY (_@ (slf));
};

//float
func int Npc_GetHeadY (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return FLOATNULL; };
	return + zCAIPlayer_GetHeadY (slf.aniCtrl);
};

//float
func int Npc_GetWaterDepthKnee (var int slfInstance) {
	//Check if Npc is flying - if yes - return 0 water depth
	var int configPtr; configPtr = Npc_GetConfig (slfInstance);
	if (configPtr) {
		var zTConfig config; config = _^ (configPtr);

		if (config.bitfield[1] & bitfield1_m_eState == zCONFIG_STATE_FLY)
		|| (config.bitfield[1] & bitfield1_m_eState == zCONFIG_STATE_SLIDE)
		{
			return FLOATNULL;
		};
	};

	//Return water - knees difference
	var int feetY; feetY = Npc_GetFeetY (slfInstance);
	var int waterY; waterY = Npc_GetWaterY (slfInstance);

	//If water is underneath feet - return 0
	if (lf (waterY, feetY)) {
		return FLOATNULL;
	};

	//Get water depth knee
	var int waterDepthKnee; waterDepthKnee = subF (waterY, feetY);
	return + waterDepthKnee;
};
