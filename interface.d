//Author: szapp (Mud-freak)
//========================================
// Interface scaling
//========================================

//Not yet published, 
func int _getInterfaceScaling () {
    //Super cheap, but effective and versatile: Just take (actual width) / (default width) of the health bar
    //MEM_InitGlobalInst();
    var oCViewStatusBar hpBar; hpBar = _^(MEM_Game.hpBar);
    return fracf(hpBar.zCView_vsizex, Print_ToVirtual(180, PS_X));
};

/*
 *	Detection for Ctrl key
 */
var int PC_ActionButtonPressed;

func void _hook_oCAIHuman_PC_ActionMove () {
	PC_ActionButtonPressed = MEM_ReadInt (ESP + 4);
};

func void G12_GetActionButton_Init () {
	const int once = 0;
	if (!once) {
		//G1 hook len 13, G2A hook len = 9
		HookEngine (oCAIHuman__PC_ActionMove, MEMINT_SwitchG1G2 (13, 9), "_hook_oCAIHuman_PC_ActionMove");
	};
};
