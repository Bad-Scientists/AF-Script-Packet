//Class defintion is same for G1 & G2 NoTR

// sizeof 20h
class zTSpatialState {
	var int m_fFloorY; //float // sizeof 04h offset 00h
	var int m_fWaterY; //float // sizeof 04h offset 04h
	var int m_fCeilingY; //float // sizeof 04h offset 08h
	var int m_fLastFloorY; //float // sizeof 04h offset 0Ch
	var int m_poFloorPoly; //zCPolygon* // sizeof 04h offset 10h
	var int m_poWaterPoly; //zCPolygon* // sizeof 04h offset 14h
	var int m_poCeilingPoly; //zCPolygon* // sizeof 04h offset 18h
	var int bitfield;
	//group {
	//	unsigned char m_bFloorIsStair : 1; // sizeof 01h offset bit
	//	unsigned char m_bFloorIsVob : 1; // sizeof 01h offset bit
	//	unsigned char m_bIsUninited : 1; // sizeof 01h offset bit
	//};
};
