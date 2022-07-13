/*
class zCObject {
    var int    _vtbl;          // 0x0000
    var int    refCtr;         // 0x0004 int
    var int    hashIndex;      // 0x0008 zWORD
    var int    hashNext;       // 0x000C zCObject*
    var string objectName;     // 0x0010 zSTRING
};
*/

const int EV_ROBUSTTRACE = 0;
const int EV_GOTOPOS = 1;
const int EV_GOTOVOB = 2;
const int EV_GOROUTE = 3;
const int EV_TURN = 4;
const int EV_TURNTOPOS = 5;
const int EV_TURNTOVOB = 6;
const int EV_TURNAWAY = 7;
const int EV_JUMP = 8;
const int EV_SETWALKMODE = 9;
const int EV_WHIRLAROUND = 10;
const int EV_STANDUP = 11;
const int EV_CANSEENPC = 12;
const int EV_STRAFE = 13;
const int EV_GOTOFP = 14;
const int EV_DODGE = 15;
const int EV_BEAMTO = 16;
const int EV_ALIGNTOFP = 17;
const int EV_MOVE_MAX = 18;

const int EV_TAKEVOB = 0;
const int EV_DROPVOB = 1;
const int EV_THROWVOB = 2;
const int EV_EXCHANGE = 3;
const int EV_USEMOB = 4;
const int EV_USEITEM = 5;
const int EV_INSERTINTERACTITEM = 6;
const int EV_REMOVEINTERACTITEM = 7;
const int EV_CREATEINTERACTITEM = 8;
const int EV_DESTROYINTERACTITEM = 9;
const int EV_PLACEINTERACTITEM = 10;
const int EV_EXCHANGEINTERACTITEM = 11;
const int EV_USEMOBWITHITEM = 12;
const int EV_CALLSCRIPT = 13;
const int EV_EQUIPITEM = 14;
const int EV_USEITEMTOSTATE = 15;
const int EV_TAKEMOB = 16;
const int EV_DROPMOB = 17;
const int EV_MANIP_MAX = 18;

const int EV_ATTACKFORWARD = 0;
const int EV_ATTACKLEFT = 1;
const int EV_ATTACKRIGHT = 2;
const int EV_ATTACKRUN = 3;
const int EV_ATTACKFINISH = 4;
const int EV_PARADE = 5;
const int EV_AIMAT = 6;
const int EV_SHOOTAT = 7;
const int EV_STOPAIM = 8;
const int EV_DEFEND = 9;
const int EV_ATTACKBOW = 10;
const int EV_ATTACKMAGIC = 11;
const int EV_ATTACK_MAX = 12;

const int EV_PLAYANISOUND = 0;
const int EV_PLAYANI = 1;
const int EV_PLAYSOUND = 2;
const int EV_LOOKAT = 3;
const int EV_OUTPUT = 4;
const int EV_OUTPUTSVM = 5;
const int EV_CUTSCENE = 6;
const int EV_WAITTILLEND = 7;
const int EV_ASK = 8;
const int EV_WAITFORQUESTION = 9;
const int EV_STOPLOOKAT = 10;
const int EV_STOPPOINTAT = 11;
const int EV_POINTAT = 12;
const int EV_QUICKLOOK = 13;
const int EV_PLAYANI_NOOVERLAY = 14;
const int EV_PLAYANI_FACE = 15;
const int EV_PROCESSINFOS = 16;
const int EV_STOPPROCESSINFOS = 17;
const int EV_OUTPUTSVM_OVERLAY = 18;
const int EV_SNDPLAY = 19;
const int EV_SNDPLAY3D = 20;
const int EV_PRINTSCREEN = 21;
const int EV_STARTFX = 22;
const int EV_STOPFX = 23;
const int EV_CONV_MAX = 24;

const int EV_DRAWWEAPON = 0;
const int EV_DRAWWEAPON1 = 1;
const int EV_DRAWWEAPON2 = 2;
const int EV_REMOVEWEAPON = 3;
const int EV_REMOVEWEAPON1 = 4;
const int EV_REMOVEWEAPON2 = 5;
const int EV_CHOOSEWEAPON = 6;
const int EV_FORCEREMOVEWEAPON = 7;
const int EV_ATTACK = 8;
const int EV_EQUIPBESTWEAPON = 9;
const int EV_EQUIPBESTARMOR = 10;
const int EV_UNEQUIPWEAPONS = 11;
const int EV_UNEQUIPARMOR = 12;
const int EV_EQUIPARMOR = 13;
const int EV_WEAPON_MAX = 14;

class zCEventManager {
	var int _vtbl;			//0	8251772		zCEventManager_vtbl
	var int refctr;			//4	1
	var int hashindex;		//8	65535
	var int hashNext;		//12	0

	var string objectName;		//16	8193786		zSTRING numMessages in string sometimes???

	var int cleared;		//36	int cleared;
	var int active;			//40	int active;
	var int cutscene;		//44	zCCutscene* cutscene;

	//zCArray<zCEventMessage*> messageList;
	var int messageList_array;	//48
	var int messageList_numAlloc;	//52
	var int messageList_numInArray;	//56

	var int hostVob;		//60	zCVob* hostVob;
};

const int sizeof_zCEventMessage		= 44;

class zCEventMessage {
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
};

const int sizeof_zCEventCore		= 76;

class zCEventCore {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

/*
	enum zTEventCoreSubType {
		zEVENT_TRIGGER,
		zEVENT_UNTRIGGER,
		zEVENT_TOUCH,
		zEVENT_UNTOUCH,
		zEVENT_TOUCHLEVEL,
		zEVENT_DAMAGE,
		zEVENT_CORE_NUM_SUBTYPES
	};
*/

	var int otherVob;		//44	zCVob* otherVob;
	var int vobInstigator;		//48	zCVob* vobInstigator;
	var int damage;			//52	float damage;
	var int damageType;		//56	int damageType;
	var int inflictorVob;		//60	zCVob* inflictorVob;
	var int hitLocation[3];		//64	zVEC3 hitLocation;
};

const int sizeof_oCNpcMessage		= 68;

class oCNpcMessage {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64
};

//const int sizeof_oCMsgDamage		= ?;

class oCMsgDamage {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

	/*
	enum TDamageSubType {
		EV_DAMAGE_ONCE,
		EV_DAMAGE_PER_FRAME,
		EV_DAMAGE_MAX
	};
	*/

	//TODO ma tu byt rozpad na oSDamageDescriptor ? alebo pointer ?
	//oCNpc::oSDamageDescriptor descDamage;
};

const int sizeof_oCMsgWeapon		= 80;

class oCMsgWeapon {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

	/*
	enum TWeaponSubType {
		EV_DRAWWEAPON,
		EV_DRAWWEAPON1,
		EV_DRAWWEAPON2,
		EV_REMOVEWEAPON,
		EV_REMOVEWEAPON1,
		EV_REMOVEWEAPON2,
		EV_CHOOSEWEAPON,
		EV_FORCEREMOVEWEAPON,
		EV_ATTACK,
		EV_EQUIPBESTWEAPON,
		EV_EQUIPBESTARMOR,
		EV_UNEQUIPWEAPONS,
		EV_UNEQUIPARMOR,
		EV_EQUIPARMOR,
		EV_WEAPON_MAX
	};
	*/

	var int targetMode;		//68	int targetMode;
	//int duringRun       : 1;	1
	//int initDone        : 1;	2
	//int firstTime       : 1;	4
	//int useFist         : 1;	8
	//int showMagicCircle : 1;	16

	var int bitfield_oCMsgWeapon;	//72
	var int ani;			//76	int ani
};

const int sizeof_oCMsgMovement		= 124;

class oCMsgMovement {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

	/*
	enum TMovementSubType {
		EV_ROBUSTTRACE,
		EV_GOTOPOS,
		EV_GOTOVOB,
		EV_GOROUTE,
		EV_TURN,
		EV_TURNTOPOS,
		EV_TURNTOVOB,
		EV_TURNAWAY,
		EV_JUMP,
		EV_SETWALKMODE,
		EV_WHIRLAROUND,
		EV_STANDUP,
		EV_CANSEENPC,
		EV_STRAFE,
		EV_GOTOFP,
		EV_DODGE,
		EV_BEAMTO,
		EV_ALIGNTOFP,
		EV_MOVE_MAX
	};
	*/

	var string targetName;		//68	zSTRING targetName;
	var int route;			//88	zCRoute* route;
	var int targetVob;		//92	zCVob* targetVob;
	var int targetPos[3];		//96	zVEC3 targetPos;
	var int angle;			//108	float angle;
	var int timer;			//112	float timer;
	var int targetMode;		//116	int targetMode;
	var int ani;			//120	int ani;

};

const int sizeof_oCMsgAttack		= 88;

class oCMsgAttack {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

//class zCEventMessage

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

//class oCNpcMessage
	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

//class oCMsgAttack
/*
	enum TAttackSubType {
		EV_ATTACKFORWARD,
		EV_ATTACKLEFT,
		EV_ATTACKRIGHT,
		EV_ATTACKRUN,
		EV_ATTACKFINISH,
		EV_PARADE,
		EV_AIMAT,
		EV_SHOOTAT,
		EV_STOPAIM,
		EV_DEFEND,
		EV_ATTACKBOW,
		EV_ATTACKMAGIC,
		EV_ATTACK_MAX
	};
*/
	var int combo;			//68	int combo;
	var int target;			//72	zCVob* target;
	var int hitAni;			//76	int hitAni;
	var int startFrame;		//80	float startFrame;

	//int enableNextHit : 1;
	//int reachedTarget : 1;
	var int bitfield_oCMsgAttack;	//84
};

const int sizeof_oCMsgUseItem		= 80;

class oCMsgUseItem {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

/*
	enum TUseItemSubType {
		EV_DRINK,
		EV_EQUIPITEM,
		EV_UNEQUIPITEM,
		EV_USEITEM_MAX
	};
*/

	var int vob;			//68	zCVob* vob;
	var int ani;			//72	int ani;
	var int state;			//76	int state;
};

const int sizeof_oCMsgState		= 116;

class oCMsgState {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

/*
	enum TStateSubType {
		EV_STARTSTATE,
		EV_WAIT,
		EV_SETNPCSTOSTATE,
		EV_SETTIME,
		EV_APPLYTIMEDOVERLAY,
		EV_STATE_MAX
	};
*/

	var int function;		//68	int function;
	var int minutes;		//72	int minutes;
	var int instance;		//76	int instance;
	var string wp;			//80	zSTRING wp;
	var int timer;			//100	float timer;
	var int other;			//104	oCNpc* other;
	var int victim;			//108	oCNpc* victim;

	//int endOldState : 1;
	//int inRoutine   : 1;
	var int bitfield_oCMsgState;	//112
};

const int sizeof_oCMsgManipulate	= 132;

class oCMsgManipulate {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;		//	1
	//int deleted      : 1;		//	2
	//int inUse        : 1; 	//	4
	var int bitfield_oCNpcMessage;	//64

/*
	enum TManipulateSubType {
		EV_TAKEVOB,
		EV_DROPVOB,
		EV_THROWVOB,
		EV_EXCHANGE,
		EV_USEMOB,
		EV_USEITEM,
		EV_INSERTINTERACTITEM,
		EV_REMOVEINTERACTITEM,
		EV_CREATEINTERACTITEM,
		EV_DESTROYINTERACTITEM,
		EV_PLACEINTERACTITEM,
		EV_EXCHANGEINTERACTITEM,
		EV_USEMOBWITHITEM,
		EV_CALLSCRIPT,
		EV_EQUIPITEM,
		EV_USEITEMTOSTATE,
		EV_TAKEMOB,
		EV_DROPMOB,
		EV_MANIP_MAX
	};
*/

	var string name;		//68	zSTRING name;
	var string slot;		//88	zSTRING slot;

	var int targetVob;		//108	zCVob* targetVob;
	var int flag;			//112	int flag;
	var int aniCombY;		//116	float aniCombY;

//    union {
	var int npcSlot;		//120	int npcSlot;
	var int targetState;		//124	int targetState;
	var int aniID;			//128	int aniID
//    };

};

const int sizeof_oCMsgConversation = 152;

class oCMsgConversation {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

/*
	enum TConversationSubType {
		EV_PLAYANISOUND,
		EV_PLAYANI,
		EV_PLAYSOUND,
		EV_LOOKAT,
		EV_OUTPUT,
		EV_OUTPUTSVM,
		EV_CUTSCENE,
		EV_WAITTILLEND,
		EV_ASK,
		EV_WAITFORQUESTION,
		EV_STOPLOOKAT,
		EV_STOPPOINTAT,
		EV_POINTAT,
		EV_QUICKLOOK,
		EV_PLAYANI_NOOVERLAY,
		EV_PLAYANI_FACE,
		EV_PROCESSINFOS,
		EV_STOPPROCESSINFOS,
		EV_OUTPUTSVM_OVERLAY,
		EV_SNDPLAY,
		EV_SNDPLAY3D,
		EV_PRINTSCREEN,
		EV_STARTFX,
		EV_STOPFX,
		EV_CONV_MAX
	};
*/

	var string text;		//68	zSTRING text;
	var string name;		//88	zSTRING name;
	var int target;			//108	zCVob* target;
	var int targetPos[3];		//112	zVEC3 targetPos;
	var int ani;			//124	int ani;

	var int u4;			//128
	//union {
	//var int cAni;			//128	zCModelAni* cAni;
	//var int watchMsg;		//132	zCEventMessage* watchMsg;
	//};

	var int handle;			//132	int handle;
	var int timer;			//136	float timer;
	var int number;			//140	int number;
	var int f_no;			//144	int f_no;
	var int f_yes;			//148	int f_yes;
};

const int sizeof_oCMsgMagic = 108;

class oCMsgMagic {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;

	var string targetVobName;	//44	zSTRING targetVobName;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1;
	var int bitfield_oCNpcMessage;	//64

/*
	enum TConversationSubType {
		EV_OPEN,
		EV_CLOSE,
		EV_MOVE,
		EV_INVEST,
		EV_CAST,
		EV_SETLEVEL,
		EV_SHOWSYMBOL,
		EV_SETFRONTSPELL,
		EV_CASTSPELL,
		EV_READY,
		EV_UNREADY,
		EV_MAGIC_MAX
	};
*/
	var int what;			//68	int what;
	var int level;			//72	int level;
	var int removeSymbol;		//76	int removeSymbol;
	var int manaInvested;		//80	int manaInvested;
	var int energyLeft;		//84	int energyLeft;
	var int target;			//88	zCVob* target;
	var int targetPos[3];		//92	zVEC3 targetPos;
	var int activeSpell;		//104	int activeSpell;
};

const int sizeof_oCMobMsg = 56;

class oCMobMsg {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16	8193786

	var int subType;		//36	unsigned short int subType;
	var int inCutscene;		//40	int inCutscene;
/*
	enum TMobMsgSubType {
		EV_STARTINTERACTION,
		EV_STARTSTATECHANGE,
		EV_ENDINTERACTION,
		EV_UNLOCK,
		EV_LOCK,
		EV_CALLSCRIPT
	};
*/
	var int npc;			//44	oCNpc* npc;
	var int from;			//48	int from;
	//int to      : 31;
	//int playAni : 1;
	var int bitfield_oCMobMsg;	//52
};

class zCCSCamera_EventMsg {
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
	enum zTCSCam_EvSubType {
		EV_NOTHING,
		EV_PLAY,
		EV_PAUSE,
		EV_RESUME,
		EV_STOP,
		EV_GOTO_KEY,
		EV_SET_DURATION,
		EV_SET_TO_TIME
	};
	*/

	var int key;			//	int key;
	var int time;			//	float time;
	var int isDeleted;		//	int isDeleted;

	/*
	enum zTCamTrj_KFType {
		KF_UNDEF,
		KF_TARGET,
		KF_CAM
	};
	*/
	var int kfType;			//	zTCamTrj_KFType kfType;
};

class zCCSCamera_EventMsgActivate {
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
	enum zTCSCam_ActivateSubType {
		EV_DEACTIVATE,
		EV_SETCAMREFERENCE,
		EV_SETTARGETREFERENCE
	};
	*/

	var string referenceName;	//zSTRING referenceName;
	var int isDeleted;		//int isDeleted;
	var int referenceVob;		//zCVob* referenceVob;
};

class zCEventMusicControler {
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
	enum zTEventMusicControlerSubType {
		zEVENT_START_SPECIAL_SGT,
		zEVENT_STOP_SPECIAL_SGT,
		zEVENT_MUSICCONTROLER_COUNT
	};
	*/

	var string sgt;			//	zSTRING sgt;
};

//Same as zCEventMessage ?
class zCEventCommon {
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
	enum zTEventCommonSubType {
		zEVENT_ENABLE,
		zEVENT_DISABLE,
		zEVENT_TOGGLE_ENABLED,
		zEVENT_RESET,
		zEVENT_MISC_NUM_SUBTYPES
	};
	*/
};

class zCEventMover {
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
	enum zTEventMoverSubType {
		zEVENT_GOTO_KEY_FIXED_DIRECTLY,
		zEVENT_GOTO_KEY_FIXED_ORDER,
		zEVENT_GOTO_KEY_NEXT,
		zEVENT_GOTO_KEY_PREV,
		zEVENT_MISC_NUM_SUBTYPES
	};
	*/

	var int gotoFixedKeyframe;	//	int gotoFixedKeyframe;
};

class zCEventScreenFX {
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
	enum zTEventScreenFXSubType {
		zEVENT_BLEND_FADEIN,
		zEVENT_BLEND_FADEOUT,
		zEVENT_CINEMA_FADEIN,
		zEVENT_CINEMA_FADEOUT,
		zEVENT_FOV_MORPH,
		zEVENT_SCREENFX_COUNT
	};
	*/

	var int duration;		//	float duration;
	var int color;			//	zCOLOR color;
	var int fovDeg;			//	float fovDeg;
};
