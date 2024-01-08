//Class defintion is same for G1 & G2 NoTR

/*
enum zEConfigState {
	zCONFIG_STATE_STAND,
	zCONFIG_STATE_FLY,
	zCONFIG_STATE_SLIDE,
	zCONFIG_STATE_SWIM,
	zCONFIG_STATE_DIVE
};
*/

const int bitfield0_m_bTreatWaterAsSolid			= ((1 << 1) - 1) <<  0;
const int bitfield0_m_bDoWallSliding				= ((1 << 1) - 1) <<  1;
const int bitfield0_m_bUseSpacingRays				= ((1 << 1) - 1) <<  2;
const int bitfield0_m_m_bLiftSpacingRayStart		= ((1 << 1) - 1) <<  3;
const int bitfield0_m_bFloorTooLowIsHardCollision	= ((1 << 1) - 1) <<  4;
const int bitfield0_m_eDoHeightCorrection			= ((1 << 1) - 1) <<  5;
const int bitfield0_m_eDoHeightCorrectionSmooth		= ((1 << 1) - 1) <<  6;
const int bitfield1_m_eState						= ((1 << 4) - 1) <<  0;

// sizeof 10h
class zTConfig {
	var int m_fMaxGroundAngleWalk; //float  // sizeof 04h offset 00h
	var int m_fStepHeight; //float  // sizeof 04h offset 04h
	var int bitfield[2];
	//group {
	//	unsigned char m_bTreatWaterAsSolid : 1; // sizeof 01h offset bit
	//	unsigned char m_bDoWallSliding : 1; // sizeof 01h offset bit
	//	unsigned char m_bUseSpacingRays : 1; // sizeof 01h offset bit
	//	unsigned char m_bLiftSpacingRayStart : 1; // sizeof 01h offset bit
	//	unsigned char m_bFloorTooLowIsHardCollision : 1; // sizeof 01h offset bit
	//	unsigned char m_eDoHeightCorrection : 1; // sizeof 01h offset bit
	//	unsigned char m_eDoHeightCorrectionSmooth : 1; // sizeof 01h offset bit
	//	zEConfigState m_eState : 4; // sizeof 04h offset bit
	//};
};
