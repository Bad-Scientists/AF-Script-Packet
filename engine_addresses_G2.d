/*
 *	Enhanced InfoManager
 */

//0x0068EBA0 public: virtual int __thiscall zCViewDialogChoice::HandleEvent(int)
const int zCViewDialogChoice__HandleEvent	= 6876064;

//0x00660BB0 public: void __fastcall oCInformationManager::Update(void)
const int oCInformationManager__Update		= 6687664;

//0x00661CD0 protected: int __fastcall oCInformationManager::CollectChoices(class oCInfo *)
const int oCInformationManager__CollectChoices	= 6692048;

//0x00661AA0 protected: void __fastcall oCInformationManager::CollectInfos(void)
const int oCInformationManager__CollectInfos	= 6691488;

/*
 *	Enhanced oCTriggerScript
 */

//0x0083A3FC const zCTrigger::`vftable'
const int zCTrigger_vtbl = 8627196;

//0x0082F404 const oCTriggerScript::`vftable'
//Not defined in Ikarus for G2A!
const int oCTriggerScript_vtbl = 8582148;

//0x0082458C const zCParticleFX::`vftable' 
const int zCParticleFX_vtbl = 8537484;




//0x006105E0 public: virtual void __thiscall zCTrigger::OnTrigger(class zCVob *,class zCVob *)
const int zCTrigger__OnTrigger = 6358496;

//0x00610640 public: virtual void __thiscall zCTrigger::OnTouch(class zCVob *)
const int zCTrigger__OnTouch = 6358592;

//0x00610660 public: virtual void __thiscall zCTrigger::OnUntouch(class zCVob *)
const int zCTrigger__OnUntouch = 6358624;

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

//0x0076D1A0 public: int __thiscall oCNPC_States::DoAIState(void)
const int oCNPC_States__DoAIState = 7786912;

/*
 *	PickLockHelper
 */

//0x00724800 protected: virtual int __thiscall oCMobLockable::PickLock(class oCNpc *,char)
const int oCMobLockable__PickLock = 7489536;

//0x00721580 protected: virtual void __thiscall oCMobInter::StartInteraction(class oCNpc *)
const int oCMobInter__StartInteraction = 7476608;

//0x00721950 public: virtual void __thiscall oCMobInter::EndInteraction(class oCNpc *,int)
const int oCMobInter__EndInteraction = 7477584;

//0x00721C20 public: virtual void __thiscall oCMobInter::StopInteraction(class oCNpc *)
const int oCMobInter__StopInteraction = 7478304;

/*
 *	Prevent Looting
 */

//0x00762970 public: void __thiscall oCNpc::OpenDeadNpc(void)
const int oCNPC__OpenDeadNPC = 7743856;

/*
 *	Interface
 */

//0x00699F60 protected: int __thiscall oCAIHuman::PC_ActionMove(int)
const int oCAIHuman__PC_ActionMove = 6922080;

//0x0074B020 public: virtual void __thiscall oCNpc::OnMessage(class zCEventMessage *,class zCVob *)
const int oCNpc__OnMessage = 7647264;


/*
 *	game_Events_G12.d
 */

//Already defined in LeGo
//0x00762410 public: void __thiscall oCNpc::CloseInventory(void)
//const int oCNPC__CloseInventory = 7742480;

//0x0074CC10 public: int __thiscall oCNpc::EV_DrawWeapon(class oCMsgWeapon *)
//Already defined in LeGo 2.7.1
//const int oCNPC__EV_DrawWeapon		= 7654416;
//0x0074D2E0 public: int __thiscall oCNpc::EV_DrawWeapon1(class oCMsgWeapon *)
//Already defined in LeGo 2.7.1
//const int oCNPC__EV_DrawWeapon1		= 7656160;
//0x0074D580 public: int __thiscall oCNpc::EV_DrawWeapon2(class oCMsgWeapon *)
const int oCNPC__EV_DrawWeapon2		= 7656832;

//0x0047ED60 public: void __thiscall oCStatusScreen::Show(void)
const int oCStatusScreen__Show = 4713824;

//0x0047F3E0 public: void __thiscall oCLogScreen::Show(void)
const int oCLogScreen__Show = 4715488;

//0x0047F9C0 public: void __thiscall oCMapScreen::Show(int)
const int oCMapScreen__Show = 4716992;

//0x00709F40 protected: virtual int __thiscall oCItemContainer::TransferItem(int,int)
const int oCItemContainer__TransferItem = 7380800;

//0x00739C90 public: void __thiscall oCNpc::Equip(class oCItem *)
//Already defined in LeGo
//const int oCNPC__Equip			= 7576720;

//0x007326C0 public: void __thiscall oCNpc::UnequipItem(class oCItem *)
//Already defined in LeGo
//const int oCNPC__UnequipItem			= 7546560;

//0x007449C0 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
const int oCNPC__DoTakeVob			= 7621056;

//0x00762250 public: void __thiscall oCNPC::OpenInventory(int)
//Already defined in LeGo
//const int oCNPC__OpenInventory = 7742032;

//0x00744DD0 public: virtual int __thiscall oCNpc::DoDropVob(class zCVob *)
const int oCNpc__DoDropVob = 7622096;

//0x0083C644 const oCNpcContainer::`vftable' 
const int oCNPCContainer_vtbl = 8635972;

func int Hlp_Is_oCNpcContainer (var int ptr) {
    if (!ptr) { return 0; };
    return (MEM_ReadInt (ptr) == oCNPCContainer_vtbl);
};

/*
 *	Sprint mode
 */

//0x006AD500 public: void __thiscall oCAniCtrl_Human::ToggleWalkMode(int)
const int oCAniCtrl_Human__ToggleWalkMode = 7001344;

/*
 *	Event Manager
 */

//0x00832214 const zCMaterial::`vftable' 

//0x0082E89C const zCObject::`vftable' 
//const int zCObject_vtbl		= 8579228;
 
//0x0082ED78 const zCCSBlockPosition::`vftable' 
//const int zCCSBlockPosition_vtbl	= 8580472;

//0x0082F00C const zCCSProps::`vftable' 
//const int zCCSProps_vtbl		= 8581132;

//0x0082E904 const oCCSPlayer::`vftable'{for `zCObject'} 
//const int zCObject__oCCSPlayer_vtbl	= 8579332;

//0x0082E75C const zCEventMessage::`vftable' 
const int zCEventMessage_vtbl		= 8578908;

//0x0083E23C const zCEventManager::`vftable' 
const int zCEventManager_vtbl		= 8643132;

func int Hlp_Is_zCEventManager (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == zCEventManager_vtbl);
};

//0x0082EA4C const zCCSCutsceneContext::`vftable' 
const int zCCSCutsceneContext_vtbl	= 8579660;

func int Hlp_Is_zCCSCutsceneContext (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == zCCSCutsceneContext_vtbl);
};

//0x0083DA8C const oCNpcMessage::`vftable' 
const int oCNpcMessage_vtbl		= 8641164;

func int Hlp_Is_oCNpcMessage (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == oCNpcMessage_vtbl);
};

//0x0083DAFC const oCMsgDamage::`vftable' 
const int oCMsgDamage_vtbl		= 8641276;

//0x0083DB6C const oCMsgWeapon::`vftable' 
const int oCMsgWeapon_vtbl		= 8641388;

//0x0083DBDC const oCMsgMovement::`vftable' 
const int oCMsgMovement_vtbl		= 8641500;

//0x0083DC4C const oCMsgAttack::`vftable' 
const int oCMsgAttack_vtbl		= 8641612;

//0x0083DCBC const oCMsgUseItem::`vftable' 
const int oCMsgUseItem_vtbl		= 8641724;

//0x0083DD2C const oCMsgState::`vftable' 
const int oCMsgState_vtbl		= 8641836;

//0x0083DD9C const oCMsgManipulate::`vftable' 
const int oCMsgManipulate_vtbl		= 8641948;

//0x0083DE0C const oCMsgConversation::`vftable' 
const int oCMsgConversation_vtbl	= 8642060;

func int Hlp_Is_oCMsgConversation (var int ptr) {
	if (!ptr) { return 0; };
	return (MEM_ReadInt (ptr) == oCMsgConversation_vtbl);
};

//0x0083DE7C const oCMsgMagic::`vftable' 
const int oCMsgMagic_vtbl		= 8642172;

//0x0083AF34 const zCEventMusicControler::`vftable' 
const int zCEventMusicControler_vtbl	= 8630068;

//0x0082E7BC const zCEventCore::`vftable' 
const int zCEventCore_vtbl		= 8579004;

//0x0083096C const zCCSCamera_EventMsg::`vftable' 
//0x0082E6FC const zCCSCamera_EventMsgActivate::`vftable' 
//0x0082E7BC const zCEventCore::`vftable' 
//0x0082ED14 const zCEvMsgCutscene::`vftable' 

//0x0083A2DC const zCEventCommon::`vftable' 
//0x0083A33C const zCEventMover::`vftable' 
//0x0083A39C const zCEventScreenFX::`vftable' 

//0x0083D474 const oCMobMsg::`vftable' 
const int oCMobMsg_vtbl			= 8639604;


/*
 *	TriggerChangeLevel event
 */

//0x006C7AF0 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
const int oCGame__TriggerChangeLevel = 7109360;


/*
 *	Gamestate extended events
 */

//0x00748880 public: void __thiscall oCNpc::PreSaveGameProcessing(void) 
const int oCNpc__PreSaveGameProcessing = 7637120;

//0x00748B90 public: void __thiscall oCNpc::PostSaveGameProcessing(void) 
const int oCNpc__PostSaveGameProcessing = 7637904;

//0x006C7290 private: virtual void __thiscall oCGame::ChangeLevel(class zSTRING const &,class zSTRING const &) 
const int oCGame__ChangeLevel = 7107216;
