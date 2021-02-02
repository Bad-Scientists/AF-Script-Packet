/*
 *	Weapon stacking
 */

//0062A050  .text     Debug data           ?RemoveWeapon2@oCAniCtrl_Human@@QAEHXZ
const int oCAniCtrl_Human__RemoveWeapon2	= 6463568;

//00668F60  .text     Debug data           ?Activate@oCItemContainer@@UAEXXZ
const int oCItemContainer__Activate		= 6721376;

//006BB0A0  .text     Debug data           ?OpenInventory@oCNPC@@QAEXXZ
//Already defined in LeGo
//const int oCNPC__OpenInventory		= 7057568;

//006968F0  .text     Debug data           ?Equip@oCNPC@@QAEXPAVoCItem@@@Z
//Already defined in LeGo
//const int oCNPC__Equip			= 6908144;

//0068FBC0  .text     Debug data           ?UnequipItem@oCNPC@@QAEXPAVoCItem@@@Z
//Already defined in LeGo
//const int oCNPC__UnequipItem			= 6880192;

//006A0D10  .text     Debug data           ?DoTakeVob@oCNPC@@UAEHPAVzCVob@@@Z
const int oCNPC__DoTakeVob			= 6950160;

/*
 *	Inventory sorting
 */
 
//0066B3D0  .text     Debug data           ??0oCNpcInventory@@QAE@XZ
//inventory2_inventory1_Compare int(_cdecl*)(oCItem*, OCItem*)
const int inventory2_inventory0_Compare		= 6732080;	//66B930	??
const int inventory2_inventory1_Compare		= 6731024;	//66B510	INV_WEAPON
const int inventory2_inventory2_Compare		= 6731488;	//66B6E0	INV_ARMOR
const int inventory2_inventory3_Compare		= 6732080;	//66B930	INV_RUNE
const int inventory2_inventory4_Compare		= 6732080;	//66B930	INV_MAGIC
const int inventory2_inventory5_Compare		= 6731568;	//66B730	INV_FOOD
const int inventory2_inventory6_Compare		= 6732080;	//66B930	INV_POTION
const int inventory2_inventory7_Compare		= 6731216;	//66B5D0	INV_DOC
const int inventory2_inventory8_Compare		= 6731648;	//66B780	INV_MISC

/*
 *	Barrier - ever looming threat
 */

//006307C0  .text     Debug data           ?Render@oCBarrier@@QAEHAAUzTRenderContext@@HH@Z
const int oCBarrier__Render			= 6490048;

/*
 *	Enhanced InfoManager
 */

//00758A60  .text     Debug data           ?HandleEvent@zCViewDialogChoice@@UAEHH@Z
const int zCViewDialogChoice__HandleEvent	= 7703136;

//0072BE90  .text     Debug data           ?Update@oCInformationManager@@QAIXXZ
const int oCInformationManager__Update		= 7519888;

/*
 *	Enhanced Trading
 */

//0072A2B0  .text     Debug data           ?OnTransferLeft@oCViewDialogTrade@@IAIHH@Z
const int oCViewDialogTrade__OnTransferLeft	= 7512752;

//0072A530  .text     Debug data           ?OnTransferRight@oCViewDialogTrade@@IAIHH@Z
const int oCViewDialogTrade__OnTransferRight	= 7513392;

//0072A870  .text     Debug data           ?OnAccept@oCViewDialogTrade@@IAIXXZ
const int oCViewDialogTrade__OnAccept		= 7514224;

//0072AAB0  .text     Debug data           ?OnExit@oCViewDialogTrade@@IAIXXZ
const int oCViewDialogTrade__OnExit		= 7514800;

//007299A0  .text     Debug data           ?HandleEvent@oCViewDialogTrade@@UAEHH@Z
const int oCViewDialogTrade__HandleEvent	= 7510432;

/*
 *	Enhanced oCTriggerScript
 */
//007DBF2C  .rdata    Debug data           ??_7zCTrigger@@6B@
const int zCTrigger_vtbl = 8240940;

//007D134C  .rdata    Debug data           ??_7oCTriggerScript@@6B@
//Already defined in Ikarus
//const int oCTriggerScript_vtbl = 8196940;

//005E3770  .text     Debug data           ?OnTrigger@zCTrigger@@UAEXPAVzCVob@@0@Z
const int zCTrigger__OnTrigger = 6174576;


//005E37D0  .text     Debug data           ?OnTouch@zCTrigger@@UAEXPAVzCVob@@@Z
const int zCTrigger__OnTouch = 6174672;


//005E37F0  .text     Debug data           ?OnUntouch@zCTrigger@@UAEXPAVzCVob@@@Z
const int zCTrigger__OnUntouch = 6174704;

func int Hlp_Is_zCTrigger (var int ptr) {
    if (!ptr) { return 0; };
    return (MEM_ReadInt (ptr) == zCTrigger_vtbl);
};

func int Hlp_Is_oCTriggerScript (var int ptr) {
    if (!ptr) { return 0; };
    return (MEM_ReadInt (ptr) == oCTriggerScript_vtbl);
};
