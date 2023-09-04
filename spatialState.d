//float
func int zCAIPlayer_GetWaterLevel (var int aiPlayerPtr) {
	if (!aiPlayerPtr) { return FLOATNULL; };
	var zCAIPlayer aiPlayer; aiPlayer = _^ (aiPlayerPtr);
	return aiPlayer.waterLevel;
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

//float
func int Npc_GetFeetY (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);

	if (!Hlp_IsValidNpc (slf)) { return FLOATNULL; };
	if (!slf.aniCtrl) { return FLOATNULL; };

	return + zCAIPlayer_GetFeetY (slf.aniCtrl);
};

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
	var int feetY; feetY = Npc_GetFeetY (slfInstance);
	var int waterY; waterY = Npc_GetWaterY (slfInstance);

	if (gf (waterY, feetY)) {
		return + subF (waterY, feetY);
	};

	return FLOATNULL;
};
