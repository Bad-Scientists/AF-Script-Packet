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
