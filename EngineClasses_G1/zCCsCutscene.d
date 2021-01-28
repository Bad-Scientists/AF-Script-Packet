//zCCsCustcene

class zCEvMsgCutscene {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//20
	var int inCutscene;		//24

/*
    enum TCutsceneSubType {
      EV_CS_STARTPLAY,
      EV_CS_STOP,
      EV_CS_INTERRUPT,
      EV_CS_RESUME,
      EV_CS_MAX
    };
*/

	var string csName;
	var int isOutputUnit;
	var int isGlobalCutscene;
	var int isMainRole;
	var int deleted;
};

