/*
enum {
	SPL_STATUS_DONTINVEST,
	SPL_STATUS_CANINVEST,
	SPL_STATUS_CAST,
	SPL_STATUS_STOP,
	SPL_STATUS_NEXTLEVEL
};

enum {
	SPL_CAT_GOOD,
	SPL_CAT_NEUTRAL,
	SPL_CAT_BAD
};

enum {
	TARGET_COLLECT_NONE,
	TARGET_COLLECT_CASTER,
	TARGET_COLLECT_FOCUS,
	TARGET_COLLECT_ALL,
	TARGET_COLLECT_FOCUS_FALLBACK_NONE,
	TARGET_COLLECT_FOCUS_FALLBACK_CASTER,
	TARGET_COLLECT_ALL_FALLBACK_NONE,
	TARGET_COLLECT_ALL_FALLBACK_CASTER
};

enum {
	TARGET_FLAG_NONE,
	TARGET_FLAG_ALL,
	TARGET_FLAG_ITEMS,
	TARGET_FLAG_NPCS   = 4,
	TARGET_FLAG_ORCS   = 8,
	TARGET_FLAG_HUMANS = 16,
	TARGET_FLAG_UNDEAD = 32,
	TARGET_FLAG_LIVING = 64
};
*/

class oCSpell{
	var int _vtbl;				//0

//class zCObject {
	var int refCtr;				//4	int refCtr;
	var int hashIndex;			//8	unsigned short hashIndex;
	var int hashNext;			//12	zCObject* hashNext;
	var string objectName;			//16	zSTRING objectName

//};

	var int keyNo;				//36	int keyNo;
	var int effect;				//40	oCVisualFX* effect;
	var int controlWarnFX;			//44	oCVisualFX* controlWarnFX;
	var int spellCaster;			//48	zCVob* spellCaster;
	var int spellCasterNpc;			//52	oCNpc* spellCasterNpc;
	var int spellTarget;			//56	zCVob* spellTarget;
	var int spellTargetNpc;			//60	oCNpc* spellTargetNpc;
	var int saveNpc;			//64	oCNpc* saveNpc;
	var int manaTimer;			//68	float manaTimer;
	var int manaInvested;			//72	int manaInvested;
	var int spellLevel;			//76	int spellLevel;				
	var int spellStatus;			//80	int spellStatus;
	var int spellID;			//84	int spellID;
	var int spellInfo;			//88	int spellInfo;
	var int spellEnabled;			//92	int spellEnabled;
	var int spellInitDone;			//96	int spellInitDone;
	var int timerEffect;			//100	int timerEffect;
	var int canBeDeleted;			//104	int canBeDeleted;
	var int up;				//108	float up;
	var int hoverY;				//112	float hoverY;
	var int hoverOld;			//116	float hoverOld;
	var int hoverDir;			//120	float hoverDir;
	var int spellEnergy;			//124	int spellEnergy;
	//group {
	var int manaInvestTime;			//128	float manaInvestTime;
	var int damagePerLevel;			//132	int damagePerLevel;
	var int damageType;			//136	int damageType;
	var int spellType;			//140	int spellType;
	var int canTurnDuringInvest;		//144	int canTurnDuringInvest;
	var int canChangeTargetDuringInvest;	//148	int canChangeTargetDuringInvest;
	var int isMultiEffect;			//152	int isMultiEffect;
	var int targetCollectAlgo;		//156	int targetCollectAlgo;
	var int targetCollectType;		//160	int targetCollectType;
	var int targetCollectRange;		//164	int targetCollectRange;
	var int targetCollectAzi;		//168	int targetCollectAzi;
	var int targetCollectElev;		//172	int targetCollectElev;
	//};
};
