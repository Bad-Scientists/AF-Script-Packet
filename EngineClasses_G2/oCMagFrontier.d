const int bitfield_oCMagFrontier_isWarning = 1;
const int bitfield_oCMagFrontier_isShooting = 2;

// sizeof 10h
class oCMagFrontier {
	var int warningFX; //oCVisualFX*         // sizeof 04h    offset 00h
	var int shootFX; //oCVisualFX*           // sizeof 04h    offset 04h
	var int npc; //oCNpc*                    // sizeof 04h    offset 08h
	//unsigned char isWarning  : 1; // sizeof 01h    offset bit
	//unsigned char isShooting : 1; // sizeof 01h    offset bit
	var int bitfield;
};
