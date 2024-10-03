/*
 *	Default player turn speed in Gothic is 0.1
 *	 - this simple 'patch' allows us to define our own values
 */

/*
Usage - call from Init_Global after Ikarus initialization

func void Init_Global () {
	//Ikarus initialization
	MEM_InitAll();

	//Default turn speed is 0.1
	G12_SetPlayerTurnSpeed(castToIntF (0.18));
};
*/

var int PLAYER_TURNSPEED;

func void _G12_SetPlayerTurnSpeed (var int addr) {
	//Override with pointer to our new variable
	MemoryProtectionOverride (addr, 4);
	MEM_WriteInt (addr, _@ (PLAYER_TURNSPEED));
};

func void G12_SetPlayerTurnSpeed (var int newTurnSpeedF) {
	//0x0074B3D0 public: float __thiscall oCNpc::GetTurnSpeed(void)
	//0x007D1110 __real@3dcccccd

	//0x00680970 public: float __thiscall oCNpc::GetTurnSpeed(void)
	//0x0082F330 __real@3dcccccd

	PLAYER_TURNSPEED = newTurnSpeedF;

	//0074b3df
	const int oCNpc__GetTurnSpeed_addr_G1 = 7648223;

	//0068097f
	const int oCNpc__GetTurnSpeed_addr_G2 = 6818175;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__GetTurnSpeed_addr_G1, oCNpc__GetTurnSpeed_addr_G2) + 2);

	//0074da9a
	//??? is this oCNpc::Turn ???
	const int oCNpc__FUN_0074da70_addr_G1 = 7658138;

	//0068302a
	const int oCNpc__FUN_00683000_addr_G2 = 6828074;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__FUN_0074da70_addr_G1, oCNpc__FUN_00683000_addr_G2) + 2);

	//0074dbba
	const int oCNpc__Turning_addr_G1 = 7658426;

	//0068314a
	const int oCNpc__Turning_addr_G2 = 6828362;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__Turning_addr_G1, oCNpc__Turning_addr_G2) + 2);

	//0074fea2
	const int oCNpc__EV_Turn_addr_G1 = 7667362;

	//00685df2
	const int oCNpc__EV_Turn_addr_G2 = 6839794;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__EV_Turn_addr_G1, oCNpc__EV_Turn_addr_G2) + 2);

	//0075014d
	const int oCNpc__EV_TurnToPos_addr_G1 = 7668045;

	//0068609d
	const int oCNpc__EV_TurnToPos_addr_G2 = 6840477;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__EV_TurnToPos_addr_G1, oCNpc__EV_TurnToPos_addr_G2) + 2);

	//007503b9
	const int oCNpc__EV_TurnToVob_addr_G1 = 7668665;

	//00686309
	const int oCNpc__EV_TurnToVob_addr_G2 = 6841097;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__EV_TurnToVob_addr_G1, oCNpc__EV_TurnToVob_addr_G2) + 2);

	//00751759
	const int oCNpc__RbtAvoidObstacles_TurnSpeed_addr3_G1 = 7673689;

	//00687729
	const int oCNpc__RbtAvoidObstacles_TurnSpeed_addr3_G2 = 6846249;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__RbtAvoidObstacles_TurnSpeed_addr3_G1, oCNpc__RbtAvoidObstacles_TurnSpeed_addr3_G2) + 2);

	//0075193f
	const int oCNpc__RbtAvoidObstacles_TurnSpeed_addr2_G1 = 7674175;

	//006878ec
	const int oCNpc__RbtAvoidObstacles_TurnSpeed_addr2_G2 = 6846700;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__RbtAvoidObstacles_TurnSpeed_addr2_G1, oCNpc__RbtAvoidObstacles_TurnSpeed_addr2_G2) + 2);

	//00751b3a
	const int oCNpc__RbtAvoidObstacles_TurnSpeed_addr1_G1 = 7674682;

	//00687ad9
	const int oCNpc__RbtAvoidObstacles_TurnSpeed_addr1_G2 = 6847193;

	_G12_SetPlayerTurnSpeed (MEMINT_SwitchG1G2 (oCNpc__RbtAvoidObstacles_TurnSpeed_addr1_G1, oCNpc__RbtAvoidObstacles_TurnSpeed_addr1_G2) + 2);
};
