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

