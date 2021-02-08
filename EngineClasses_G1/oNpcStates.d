/*
  enum {
    AITIME_NO,
    AITIME_ONCE,
    AITIME_TIMED
  };

  enum {
    NPC_AISTATE_ANSWER      = -2,
    NPC_AISTATE_DEAD        = -3,
    NPC_AISTATE_UNCONSCIOUS = -4,
    NPC_AISTATE_FADEAWAY    = -5,
    NPC_AISTATE_FOLLOW      = -6
  };
*/

/*
  struct TNpcAIState {
  public:
    int index;
    int loop;
    int end;
    int timeBehaviour;
    float restTime;
    int phase;
    int valid;
    zSTRING name;
    float stateTime;
    int prgIndex;
    int isRtnState;
*/

class oCNpc_States {
	var int _vtbl;
	
	var string name;			//zSTRING name;
	var int npc;				//oCNpc* npc;

	//TNpcAIState curState;
	var int curState_index;			//int index;
	var int curState_loop;			//int loop;
	var int curState_end;			//int end;
	var int curState_timeBehaviour;		//int timeBehaviour;
	var int curState_restTime;		//float restTime;
	var int curState_phase;			//int phase;
	var int curState_valid;			//int valid;
	var string curState_name;		//zSTRING name;
	var int curState_stateTime;		//float stateTime;
	var int curState_prgIndex;		//int prgIndex;
	var int curState_isRtnState;		//int isRtnState;
	//TNpcAIState nextState;
	var int nextState_index;		//int index;
	var int nextState_loop;			//int loop;
	var int nextState_end;			//int end;
	var int nextState_timeBehaviour;	//int timeBehaviour;
	var int nextState_restTime;		//float restTime;
	var int nextState_phase;		//int phase;
	var int nextState_valid;		//int valid;
	var string nextState_name;		//zSTRING name;
	var int nextState_stateTime;		//float stateTime;
	var int nextState_prgIndex;		//int prgIndex;
	var int nextState_isRtnState;		//int isRtnState;

	var int lastAIState;			//int lastAIState;
	var int hasRoutine;			//int hasRoutine;
	var int rtnChanged;			//int rtnChanged;
	var int rtnBefore;			//oCRtnEntry* rtnBefore;
	var int rtnNow;				//oCRtnEntry* rtnNow;
	var int rtnRoute;			//zCRoute* rtnRoute;
	var int rtnOverlay;			//int rtnOverlay;
	var int rtnOverlayCount;		//int rtnOverlayCount;
	var int walkmode_routine;		//int walkmode_routine;
	var int weaponmode_routine;		//int weaponmode_routine;
	var int startNewRoutine;		//int startNewRoutine;
	var int aiStateDriven;			//int aiStateDriven;
	var int aiStatePosition[3];		//zVEC3 aiStatePosition; float
	var int parOther;			//oCNpc* parOther;
	var int parVictim;			//oCNpc* parVictim;
	var int parItem;			//oCItem* parItem;
	var int rntChangeCount;			//int rntChangeCount;
};
