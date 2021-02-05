/*
class zCObject {
    var int    _vtbl;          // 0x0000
    var int    refCtr;         // 0x0004 int
    var int    hashIndex;      // 0x0008 zWORD
    var int    hashNext;       // 0x000C zCObject*
    var string objectName;     // 0x0010 zSTRING
};
*/

class zCEventManager {
	var int _vtbl;			//0	8251772		zCEventManager_vtbl
	var int refctr;			//4	1
	var int hashindex;		//8	65535
	var int hashNext;		//12	0

	var string objectName;		//16	8193786		zSTRING numMessages in string sometimes???

	var int cleared;		//36	0
	var int active;			//40	1
	var int cutscene;		//44	8194596		MEM_ReadInt (cutsceneContent) zCCSCutsceneContext_vtbl

	var int messageList_array;	//48	??
	var int messageList_numAlloc;	//52	16
	var int events_numInArray;	//56	4

	var int hostVob;		//60	zCVob*
};

const int sizeof_zCEventMessage = 44;

class zCEventMessage {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16	8193786

	var int subType;		//36
	var int inCutscene;		//40
};

const int sizeof_zCEventCore = 72; //?

class zCEventCore {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

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

	var int otherVob;		//44 zCVob* 
	var int vobInstigator;		//48 zCVob* 
	var int damage;			//52 float
	var int damageType;		//56
	var int inflictorVob;		//60 zCVob*
	var int hitLocation;		//64 zVEC3
};

class oCNpcMessage {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;
};

class oCMsgDamage  {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

/*
    enum TDamageSubType {
      EV_DAMAGE_ONCE,
      EV_DAMAGE_PER_FRAME,
      EV_DAMAGE_MAX
    };
*/
	var int damageDescriptor;	//76	oSDamageDescriptor
};

class oCMsgWeapon {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

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

	var int targetMode;
	//int duringRun       : 1;
	//int initDone        : 1;
	//int firstTime       : 1;
	//int useFist         : 1;
	//int showMagicCircle : 1;
	var int bitfield_oCMsgWeapon;
	var int ani;
};

class oCMsgMovement {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

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
*/

	var string targetName;		//zSTRING
	var int route;			//zCRoute*
	var int targetVob;		//zCVob*
	var int targetPos;		//zVEC3
	var int angle;			//float
	var int timer;			//float
	var int targetMode;
	var int ani;
  
};

class oCMsgAttack {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

//class zCEventMessage

	var int subType;		//36
	var int inCutscene;		//40

//class oCNpcMessage
	var string targetVobName;	//44	zString_vtbl 8193768;

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

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

	var int combo;			//76			aniID ?
	var int target;			//80	zCVob*		0
	var int hitAni;			//84			0
	var int startFrame;		//88	float		#

	//int enableNextHit : 1;
	//int reachedTarget : 1;
	var int bitfield_oCMsgAttack;
};

class oCMsgUseItem {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

/*

    enum TUseItemSubType {
      EV_DRINK,
      EV_EQUIPITEM,
      EV_UNEQUIPITEM,
      EV_USEITEM_MAX
    };
*/

	var int vob;			//zCVob*
	var int ani;
	var int state;
};

class oCMsgState {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

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

	var int function;
	var int minutes;
	var int instance;
	var string wp;			//zSTRING
	var int timer;			//float
	var int other;			//oCNpc*
	var int victim;			//oCNpc*

	//int endOldState : 1;
	//int inRoutine   : 1; 
	var int bitfield_oCMsgState;
};

class oCMsgManipulate {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

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

	var string name;		//zSTRING
	var string slot;		//zSTRING

	var int targetVob;		//zCVob*
	var int flag;
	var int aniCombY;		//float
/*
    union {
      int npcSlot;
      int targetState;
      int aniID;
    };
*/

};

const int sizeof_oCMsgConversation = 136;

class oCMsgConversation {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

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
      EV_CONV_MAX
    };
*/

	var string text;		//76	zSTRING
	var string name;		//96	zSTRING
	var int target;			//116	zCVob*
	var int targetPos[3];		//120	zVEC3
	var int ani;			//132
/*
    union {
      zCModelAni* cAni;
      zCEventMessage* watchMsg;
    };
*/

/*
    int handle;
    float timer;
    int number;
    int f_no;
    int f_yes;
*/
};

class oCMsgMagic {
	var int _vtbl;			//0
	var int refctr;			//4
	var int hashindex;		//8
	var int hashNext;		//12

	var string objectName;		//16

	var int subType;		//36
	var int inCutscene;		//40

	var string targetVobName;	//44	zSTRING

	//int highPriority : 1;
	//int deleted      : 1;
	//int inUse        : 1; 
	var int bitfield_oCNpcMessage;

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

	var int what;
	var int level;
	var int removeSymbol;
	var int manaInvested;
	var int energyLeft;
	var int target;			//zCVob*
	var int targetPos;		//zVEC3
	var int activeSpell;
};
