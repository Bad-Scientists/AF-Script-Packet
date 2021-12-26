//Same as zCObject
//class zCAIBase : public zCObject {

class zCAIBase {
	//public zCObject
	var int _vtbl;			//0

	var int refCtr;			//4	int
	var int hashIndex;		//8	unsigned short
	var int hashNext;		//12	zCObject*
	var string objectName;		//16	zSTRING
};

class oCAISound {
	//public zCObject : public zCAIBase
	var int _vtbl;			//0

	var int refCtr;			//4	int
	var int hashIndex;		//8	unsigned short
	var int hashNext;		//12	zCObject*
	var string objectName;		//16	zSTRING

	//oCAISound
	var int slideSoundHandle;	//36	int
	var int slideSoundOn;		//40	char
};

class oCAIArrowBase {
	//public zCObject : public zCAIBase : public oCAISound
	var int _vtbl;			//0

	var int refCtr;			//4	int
	var int hashIndex;		//8	unsigned short
	var int hashNext;		//12	zCObject*
	var string objectName;		//16	zSTRING

	//oCAISound
	var int slideSoundHandle;	//36	int
	var int slideSoundOn;		//40	char

	//oCAIArrowBase
	//zCList<zCVob> ignoreVobList;
	var int ignoreVobList_data;	//44
	var int ignoreVobList_next;	//48

	var int collisionOccured;	//52	int
	var int timeLeft;		//56	float
	var int vob;			//60	zCVob*
	var int startDustFX;		//64	int
	var int trailVob;		//68	zCVob*
	var int trailStrip;		//72	zCPolyStrip*
	var int trailActive;		//76	int
	var int trailTime;		//80	float
};

class oCAIArrow {
	//public zCObject : public zCAIBase : public oCAISound : public oCAIArrowBase
	var int _vtbl;			//0

	var int refCtr;			//4	int
	var int hashIndex;		//8	unsigned short
	var int hashNext;		//12	zCObject*
	var string objectName;		//16	zSTRING

	//oCAISound
	var int slideSoundHandle;	//36	int
	var int slideSoundOn;		//40	char

	//oCAIArrowBase
	//zCList<zCVob> ignoreVobList;
	var int ignoreVobList_data;	//44
	var int ignoreVobList_next;	//48

	var int collisionOccured;	//52	int
	var int timeLeft;		//56	float
	var int vob;			//60	zCVob*
	var int startDustFX;		//64	int
	var int trailVob;		//68	zCVob*
	var int trailStrip;		//72	zCPolyStrip*
	var int trailActive;		//76	int
	var int trailTime;		//80	float

	//oCAIArrow
	var int arrow;			//84	oCItem*
	var int owner;			//88	oCNpc*
	var int removeVob;		//92	int
	var int targetNPC;		//96	zCVob*
};

class oCAIDrop {
	//public zCObject : public zCAIBase : public oCAISound
	var int _vtbl;			//0

	var int refCtr;			//4	int
	var int hashIndex;		//8	unsigned short
	var int hashNext;		//12	zCObject*
	var string objectName;		//16	zSTRING

	//oCAISound
	var int slideSoundHandle;	//36	int
	var int slideSoundOn;		//40	char

	//oCAIDrop
	//zCList<zCVob> ignoreVobList;
	var int ignoreVobList_data;	//44
	var int ignoreVobList_next;	//48

	var int vob;			//52	zCVob*
	var int owner;			//56	zCVob*
	var int collisionOccured;	//60	int
	var int timer;			//64	float
	var int count;			//68	float
};

class oCAIVobMove {
	//public zCObject : public zCAIBase : public oCAISound
	var int _vtbl;			//0

	var int refCtr;			//4	int
	var int hashIndex;		//8	unsigned short
	var int hashNext;		//12	zCObject*
	var string objectName;		//16	zSTRING

	//oCAISound
	var int slideSoundHandle;	//36	int
	var int slideSoundOn;		//40	char

	//oCAIVobMove
	var int vob;			//44	zCVob*
	var int owner;			//48	zCVob*

	//zCList<zCVob> ignoreVobList;
	var int ignoreVobList_data;	//52
	var int ignoreVobList_next;	//56
};

class oCAIVobMoveTorch {
	//public zCObject : public zCAIBase : public oCAISound : public oCAIVobMove
	var int _vtbl;			//0

	var int refCtr;			//4	int
	var int hashIndex;		//8	unsigned short
	var int hashNext;		//12	zCObject*
	var string objectName;		//16	zSTRING

	//oCAISound
	var int slideSoundHandle;	//36	int
	var int slideSoundOn;		//40	char

	//oCAIVobMove
	var int vob;			//44	zCVob*
	var int owner;			//48	zCVob*

	//zCList<zCVob> ignoreVobList;
	var int ignoreVobList_data;	//52
	var int ignoreVobList_next;	//56

	//oCAIVobMoveTorch
	var int timer;			//60	float
};
