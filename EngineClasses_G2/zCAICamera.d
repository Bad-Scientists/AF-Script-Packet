// sizeof 294h
class zCAICamera {
	//public zCObject : public zCAIBase
	var int _vtbl; //0

	var int refCtr; //4 int
	var int hashIndex; //8 unsigned short
	var int hashNext; //12 zCObject*
	var string objectName; //16 zSTRING

	var int d_showDots; //int // sizeof 04h offset 24h
	var int pathDetectCollision; //int // sizeof 04h offset 28h
	var int bestRange; //float // sizeof 04h offset 2Ch
	var int minRange; //float // sizeof 04h offset 30h
	var int maxRange; //float // sizeof 04h offset 34h
	var int bestRotX; //float // sizeof 04h offset 38h
	var int minRotX; //float // sizeof 04h offset 3Ch
	var int maxRotX; //float // sizeof 04h offset 40h
	var int bestRotY; //float // sizeof 04h offset 44h
	var int minRotY; //float // sizeof 04h offset 48h
	var int maxRotY; //float // sizeof 04h offset 4Ch
	var int bestRotZ; //float // sizeof 04h offset 50h
	var int minRotZ; //float // sizeof 04h offset 54h
	var int maxRotZ; //float // sizeof 04h offset 58h
	var int rotOffsetX; //float // sizeof 04h offset 5Ch
	var int rotOffsetY; //float // sizeof 04h offset 60h
	var int rotOffsetZ; //float // sizeof 04h offset 64h
	var int focusOffsetX; //float // sizeof 04h offset 68h
	var int focusOffsetY; //float // sizeof 04h offset 6Ch
	var int focusOffsetZ; //float // sizeof 04h offset 70h
	var int veloTrans; //float // sizeof 04h offset 74h
	var int veloRot; //float // sizeof 04h offset 78h
	var int translate; //int // sizeof 04h offset 7Ch
	var int rotate; //int // sizeof 04h offset 80h
	var int collision; //int // sizeof 04h offset 84h

	var int endOfDScript; //unsigned char endOfDScript; //136 sizeof 01h offset 88h

	//zCArray<zCVob*> targetVobList; //140 sizeof 0Ch offset 8Ch
	var int targetVobList_array; //zCVob*
	var int targetVobList_numAlloc;
	var int targetVobList_numInArray;

	var int camVob; //zCVob* // sizeof 04h offset 98h
	var int target; //zCVob* // sizeof 04h offset 9Ch

	//G2 NoTR specific
	var int targetAlpha; //float // sizeof 04h offset A0h

	var int numTargets; //int // sizeof 04h offset A4h
	var string oldCamSys; //zSTRING // sizeof 14h offset A8h
	var int sysChanged; //int // sizeof 04h offset BCh
	var int playerIsMovable; //int // sizeof 04h offset C0h
	var int followIdealPos; //int // sizeof 04h offset C4h
	var int dialogCamDuration; //float // sizeof 04h offset C8h
	var int numOUsSpoken; //int // sizeof 04h offset CCh
	var int numDialogCamTakes; //int // sizeof 04h offset D0h
	var int lastNumDialogCamTakes; //int // sizeof 04h offset D4h
	var int lastDialogCamSide; //int // sizeof 04h offset D8h
	var int firstSpeakerWasPC; //int // sizeof 04h offset DCh
	var int dialogCam; //zCCSCamera* // sizeof 04h offset E0h
	var string lastPresetName; //zSTRING // sizeof 14h offset E4h
	var int raysCasted; //int // sizeof 04h offset F8h
	var int underWater; //int // sizeof 04h offset FCh
	var int inCutsceneMode; //int // sizeof 04h offset 100h
	var string debugS; //zSTRING // sizeof 14h offset 104h
	var int showPath; //int // sizeof 04h offset 118h
	var int focusVob; //zCVob* // sizeof 04h offset 11Ch

	var int ctrlDot[MAX_CTRL_VOBS]; //zCVob* // sizeof 140h offset 120h
	var int pathSearch; //zCPathSearch* // sizeof 04h offset 260h
	var int moveTracker; //zCMovementTracker* // sizeof 04h offset 264h
	var int evasionSearchReport; //zSPathSearchResult* // sizeof 04h offset 268h
	var string curcammode; //zSTRING // sizeof 14h offset 26Ch
	var int npcVolumeRangeOffset; //float // sizeof 04h offset 280h
	var int camDistOffset; //float // sizeof 04h offset 284h
	var int camSysFirstPos[3]; //zVEC3 // sizeof 0Ch offset 288h
	var int firstPerson; //int // sizeof 04h offset 294h
	var int targetInPortalRoom; //int // sizeof 04h offset 298h
};
