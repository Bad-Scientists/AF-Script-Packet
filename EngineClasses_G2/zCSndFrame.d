// sizeof 6Ch
// Same for G1 & G2A
class zCSndFrame {
	var string fileName;		//zSTRING // sizeof 14h offset 00h
	var int pitchOffset;		//float // sizeof 04h offset 14h
	var int pitchVariance;		//float // sizeof 04h offset 18h
	var int defVolume;		//int // sizeof 04h offset 1Ch
	var int looping;		//int // sizeof 04h offset 20h
	var int loopStartOffset;	//int // sizeof 04h offset 24h
	var int loopEndOffset;		//int // sizeof 04h offset 28h
	var int reverbLevel;		//float // sizeof 04h offset 2Ch
	var string pfxName;		//zSTRING // sizeof 14h offset 30h
	var int dScriptEnd;		//unsigned char // sizeof 01h offset 44h
	var string instance;		//zSTRING // sizeof 14h offset 48h
	var int actVolume;		//int // sizeof 04h offset 5Ch
	var int actRate;		//int // sizeof 04h offset 60h
	var int actPan;			//int // sizeof 04h offset 64h
	var int wav;			//zCWaveData* // sizeof 04h offset 68h
};
