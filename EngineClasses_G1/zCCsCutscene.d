//zCCsCustcene

//const int sizeof_zCEvMsgCutscene = ?;

class zCEvMsgCutscene {
	//class zCEventMessage {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16	8193786

	/*
	enum zTTimeBehavior {
		TBZero,
		TBFix,
		TBUnknown,
		TBAssembled
	};
	*/

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene; 
	//};

	/*
	enum TCutsceneSubType {
		EV_CS_STARTPLAY,
		EV_CS_STOP,
		EV_CS_INTERRUPT,
		EV_CS_RESUME,
		EV_CS_MAX
	};
	*/

	var string csName;		//	zSTRING csName;
	var int isOutputUnit;		//	int isOutputUnit;
	var int isGlobalCutscene;	//	int isGlobalCutscene;
	var int isMainRole;		//	int isMainRole;
	var int deleted;		//	int deleted;
};