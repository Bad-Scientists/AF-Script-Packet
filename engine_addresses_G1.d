/*
 *	Weapon stacking
 */

//0x0062A050 public: int __thiscall oCAniCtrl_Human::RemoveWeapon2(void) 
const int oCAniCtrl_Human__RemoveWeapon2	= 6463568;

//0x00668F60 public: virtual void __thiscall oCItemContainer::Activate(void) 
const int oCItemContainer__Activate		= 6721376;

//0x006BB0A0 public: void __thiscall oCNpc::OpenInventory(void) 
//Already defined in LeGo
//const int oCNPC__OpenInventory		= 7057568;

//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *) 
//Already defined in LeGo
//const int oCNPC__Equip			= 6908144;

//0x0068FBC0 public: void __thiscall oCNpc::UnequipItem(class oCItem *) 
//Already defined in LeGo
//const int oCNPC__UnequipItem			= 6880192;

//0x006A0D10 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *) 
const int oCNPC__DoTakeVob			= 6950160;

/*
 *	Inventory sorting
 */
 
//0x0066B3D0 public: __thiscall oCNpcInventory::oCNpcInventory(void) 
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

//0x006307C0 public: int __thiscall oCBarrier::Render(struct zTRenderContext &,int,int) 
const int oCBarrier__Render			= 6490048;

/*
 *	Enhanced InfoManager
 */

//0x00758A60 public: virtual int __thiscall zCViewDialogChoice::HandleEvent(int) 
const int zCViewDialogChoice__HandleEvent	= 7703136;

//0x0072BE90 public: void __fastcall oCInformationManager::Update(void) 
const int oCInformationManager__Update		= 7519888;

//0x0072CFC0 protected: int __fastcall oCInformationManager::CollectChoices(class oCInfo *) 
const int oCInformationManager__CollectChoices	= 7524288;

//0x0072CD90 protected: void __fastcall oCInformationManager::CollectInfos(void) 
const int oCInformationManager__CollectInfos	= 7523728;

/*
 *	Enhanced Trading
 */

//0x0072A2B0 protected: int __fastcall oCViewDialogTrade::OnTransferLeft(int) 
const int oCViewDialogTrade__OnTransferLeft	= 7512752;

//0x0072A530 protected: int __fastcall oCViewDialogTrade::OnTransferRight(int) 
const int oCViewDialogTrade__OnTransferRight	= 7513392;

//0x0072A870 protected: void __fastcall oCViewDialogTrade::OnAccept(void) 
const int oCViewDialogTrade__OnAccept		= 7514224;

//0x0072AAB0 protected: void __fastcall oCViewDialogTrade::OnExit(void) 
const int oCViewDialogTrade__OnExit		= 7514800;

//0x007299A0 public: virtual int __thiscall oCViewDialogTrade::HandleEvent(int) 
const int oCViewDialogTrade__HandleEvent	= 7510432;

/*
 *	Enhanced oCTriggerScript
 */

//0x007DBF2C const zCTrigger::`vftable' 
const int zCTrigger_vtbl = 8240940;

//0x007D134C const oCTriggerScript::`vftable' 
//Already defined in Ikarus
//const int oCTriggerScript_vtbl = 8196940;

//0x005E3770 public: virtual void __thiscall zCTrigger::OnTrigger(class zCVob *,class zCVob *) 
const int zCTrigger__OnTrigger = 6174576;

//0x007D4214 const zCParticleFX::`vftable' 
const int zCParticleFX_vtbl = 8208916;

//0x005E37D0 public: virtual void __thiscall zCTrigger::OnTouch(class zCVob *) 
const int zCTrigger__OnTouch = 6174672;

//0x005E37F0 public: virtual void __thiscall zCTrigger::OnUntouch(class zCVob *) 
const int zCTrigger__OnUntouch = 6174704;

func int Hlp_Is_zCTrigger (var int ptr) {
    if (!ptr) { return 0; };
    return (MEM_ReadInt (ptr) == zCTrigger_vtbl);
};

func int Hlp_Is_oCTriggerScript (var int ptr) {
    if (!ptr) { return 0; };
    return (MEM_ReadInt (ptr) == oCTriggerScript_vtbl);
};

func int Hlp_Is_zCParticleFX (var int ptr) {
    if (!ptr) { return 0; };
    return (MEM_ReadInt (ptr) == zCParticleFX_vtbl);
};

/*
 *	Enable Player States
 */

//0x006C5C60 public: int __thiscall oCNpc_States::DoAIState(void) 
const int oCNPC_States__DoAIState = 7101536;

/*
 *	PickLockHelper
 */

//0x00682990 protected: virtual int __thiscall oCMobLockable::PickLock(class oCNpc *,char) 
const int oCMobLockable__PickLock = 6826384;

//0x0067FCA0 protected: virtual void __thiscall oCMobInter::StartInteraction(class oCNpc *) 
const int oCMobInter__StartInteraction = 6814880;

//0x0067FFD0 public: virtual void __thiscall oCMobInter::EndInteraction(class oCNpc *,int) 
const int oCMobInter__EndInteraction = 6815696;

//0x00680250 public: virtual void __thiscall oCMobInter::StopInteraction(class oCNpc *) 
const int oCMobInter__StopInteraction = 6816336;

/*
 *	Prevent Looting
 */

//0x006BB890 public: void __thiscall oCNpc::OpenDeadNpc(void) 
const int oCNPC__OpenDeadNPC = 7059600;

/*
 *	ReOpen Last Map
 */
 
//0x0069A340 public: void __thiscall oCNpc::OpenScreen_Map(void) 
const int oCNPC__OpenScreen_Map = 6923072;

//0x007246D0 public: int __fastcall oCDocumentManager::CreateMap(void) 
const int oCDocumentManager__CreateMap = 7489232;

/*
 *	Interface
 */

//0x00613A60 protected: int __thiscall oCAIHuman::PC_ActionMove(int) 
const int oCAIHuman__PC_ActionMove = 6371936;

//0x006A69E0 public: virtual void __thiscall oCNpc::OnMessage(class zCEventMessage *,class zCVob *) 
const int oCNpc__OnMessage = 6973920;

/*
 *	Enhnaced PickLocking
 */

//0x006827C0 public: int __thiscall oCMobLockable::CanOpen(class oCNpc *) 
const int oCMobLockable__CanOpen = 6825920;


/*
 *	Enhanced PickPocketing
 */
//Already defined in LeGo (Lego 7058164) 
//0x006BB2F0 public: void __thiscall oCNpc::CloseInventory(void) 
//const int oCNPC__CloseInventory = 7058160;

//0x00669780 protected: virtual int __thiscall oCItemContainer::TransferItem(int,int) 
const int oCItemContainer__TransferItem = 6723456;

//0x007DCF54 const oCNpcContainer::`vftable' 
const int oCNPCContainer_vtbl = 8245076;

func int Hlp_Is_oCNpcContainer (var int ptr) {
    if (!ptr) { return 0; };
    return (MEM_ReadInt (ptr) == oCNPCContainer_vtbl);
};

/*
 *	game_Events_G12.d
 */

//0x006A8500 public: int __thiscall oCNpc::EV_DrawWeapon(class oCMsgWeapon *) 
const int oCNPC__EV_DrawWeapon		= 6980864;
//0x006A8B80 public: int __thiscall oCNpc::EV_DrawWeapon1(class oCMsgWeapon *) 
const int oCNPC__EV_DrawWeapon1		= 6982528;
//0x006A8E20 public: int __thiscall oCNpc::EV_DrawWeapon2(class oCMsgWeapon *)
const int oCNPC__EV_DrawWeapon2		= 6983200;

//0x00477830 public: void __thiscall oCStatusScreen::Show(void) 
const int oCStatusScreen__Show = 4683824;

//0x00477EC0 public: void __thiscall oCLogScreen::Show(void) 
const int oCLogScreen__Show = 4685504;

//0x00478490 public: void __thiscall oCMapScreen::Show(void)
const int oCMapScreen__Show = 4686992;

//0x006BB0A0 public: void __thiscall oCNpc::OpenInventory(void)
//Already defined in LeGo
//const int oCNPC__OpenInventory = 7057568;

//0x006A10F0 public: virtual int __thiscall oCNpc::DoDropVob(class zCVob *)
const int oCNpc__DoDropVob = 6951152;

/*
 *	game_Events_G1.d
 */

//0x00669DD0 protected: virtual int __thiscall oCItemContainer::HandleEvent(int) 
const int oCItemContainer__HandleEvent = 6725072;
//G2A HookLen 6

//0x0066A730 public: virtual int __thiscall oCStealContainer::HandleEvent(int) 
const int oCStealContainer__HandleEvent = 6727472;
//0x0066ACD0 public: virtual int __thiscall oCNpcContainer::HandleEvent(int) 

const int oCNpcContainer__HandleEvent = 6728912;
//G2A HookLen 7

//0x0066E390 public: virtual int __thiscall oCNpcInventory::HandleEvent(int) 
const int oCNpcInventory__HandleEvent = 6742928;
