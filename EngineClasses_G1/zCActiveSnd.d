const int bitfield_zCActiveSnd_active = 1;
const int bitfield_zCActiveSnd_looping = 2;
const int bitfield_zCActiveSnd_isAmbient = 4;
const int bitfield_zCActiveSnd_is3D = 8;
const int bitfield_zCActiveSnd_allocated = 16;
const int bitfield_zCActiveSnd_vobSlot = 32;

// sizeof 54h
class zCActiveSnd {
	var int handle;			//int // sizeof 04h offset 00h
	var int sample;			//void* // sizeof 04h offset 04h
	var int sample3D;		//void* // sizeof 04h offset 08h
	var int age;			//unsigned long // sizeof 04h offset 0Ch
	var int loopType;		//zCSoundSystem::zTLoopType // sizeof 04h offset 10h
	var int radius;			//float // sizeof 04h offset 14h
	var int reverbLevel;		//float // sizeof 04h offset 18h
	var int pitchOffset;		//float // sizeof 04h offset 1Ch
	var int volWeight;		//float // sizeof 04h offset 20h
	var int obstruction;		//float // sizeof 04h offset 24h

	var int bitfield_zCActiveSnd;
	/*
	group {
		unsigned char active : 1; // sizeof 01h offset bit	1
		unsigned char looping : 1; // sizeof 01h offset bit	2
		unsigned char isAmbient : 1; // sizeof 01h offset bit	4
		unsigned char is3D : 1; // sizeof 01h offset bit	8
		unsigned char allocated : 1; // sizeof 01h offset bit	16
		unsigned char vobSlot : 3; // sizeof 03h offset bit	32
	};
	*/
	//Is this correct conversion ??
	var int bitfield;
	//unsigned char pan;		// sizeof 01h offset 29h
	//unsigned char volume;		// sizeof 01h offset 2Ah
	//unsigned short rate;		// sizeof 02h offset 2Ch

	var int muteTime;		//int // sizeof 04h offset 30h
	var int frameCtr;		//int // sizeof 04h offset 34h
	var int lastPos[3];		//zVEC3 // sizeof 0Ch offset 38h
	var int lastTime;		//float // sizeof 04h offset 44h
	var int sourceVob;		//zCVob* // sizeof 04h offset 48h
	var int sourceFrm;		//zCSndFrame* // sizeof 04h offset 4Ch
	var int sourceSnd;		//zCSndFX_MSS* // sizeof 04h offset 50h
};
