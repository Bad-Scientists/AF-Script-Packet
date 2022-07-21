/*
 *	Mouse input
 *	 - Ikarus G1 constants are incorrect, we have to use our own
 */
const int MOUSE_WHEEL_UP = 522;
const int MOUSE_WHEEL_DOWN = 523;

const int MOUSE_BUTTON_LEFT = 524;
const int MOUSE_BUTTON_RIGHT = 525;
const int MOUSE_BUTTON_MIDDLE = 526;

//522	2057 - Wheel up
//523	2058 - Wheel down

//524	2050 - Left Mouse button
//525	2052 - Right Mouse button
//526        - Middle Mouse button

//Special buttons
//527        - Forward button
//528        - Backward button

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

/*
 *	Sprint mode
 */

//0x006AD500 public: void __thiscall oCAniCtrl_Human::ToggleWalkMode(int)
//const int oCAniCtrl_Human__ToggleWalkMode = 7001344;

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

//0x0082EA4C const zCCSCutsceneContext::`vftable'
const int zCCSCutsceneContext_vtbl	= 8579660;

//0x0083DA8C const oCNpcMessage::`vftable'
const int oCNpcMessage_vtbl		= 8641164;

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

//0x0083DE7C const oCMsgMagic::`vftable'
const int oCMsgMagic_vtbl		= 8642172;

//0x0083AF34 const zCEventMusicControler::`vftable'
const int zCEventMusicControler_vtbl	= 8630068;

//0x0082E7BC const zCEventCore::`vftable'
const int zCEventCore_vtbl		= 8579004;

//0x0082ED14 const zCEvMsgCutscene::`vftable'
const int zCEvMsgCutscene_vtbl		= 8580372;

//0x0083096C const zCCSCamera_EventMsg::`vftable'
//0x0082E6FC const zCCSCamera_EventMsgActivate::`vftable'


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
//Already defined in LeGo
//const int oCGame__ChangeLevel = 7107216;

/*
 *	No Ammo print
 */
//0x0073C6E0 public: int __thiscall oCNpc::IsMunitionAvailable(class oCItem *)
const int oCNpc__IsMunitionAvailable = 7587552;

/*
 *	Log Dialogues
 */
//0x00786380 public: virtual void __thiscall zCEventManager::OnMessage(class zCEventMessage *,class zCVob *)
const int zCEventManager__OnMessage = 7889792;

/*
 *	Rain Control
 */
//0x005EA850 public: virtual void __thiscall zCSkyControler_Outdoor::RenderSkyPre(void)
const int zCSkyControler_Outdoor__RenderSkyPre = 6203472;




//0x00832084 const zCDecal::`vftable'
const int zCDecal_vtbl = 8593540;

//0x0083E434 const zCVobSpot::`vftable'
const int zCVobSpot_vtbl = 8643636;

//0x0083C4AC const oCItemContainer::`vftable'
const int oCItemContainer_vtbl = 8635564;

//0x0083C574 const oCStealContainer::`vftable'
const int oCStealContainer_vtbl = 8635764;

//0x0083C644 const oCNpcContainer::`vftable'
const int oCNPCContainer_vtbl = 8635972;

//0x0083C714 const oCNpcInventory::`vftable'
const int oCNpcInventory_vtbl = 8636180;

//========================================
// Interface scaling
// Author: szapp (Mud-freak)
//========================================

//Not yet published,
func int _getInterfaceScaling () {
    //Super cheap, but effective and versatile: Just take (actual width) / (default width) of the health bar
    //MEM_InitGlobalInst();
    var oCViewStatusBar hpBar; hpBar = _^ (MEM_Game.hpBar);
    return fracf(hpBar.zCView_vsizex, Print_ToVirtual(180, PS_X));
};

/*
 *	Changes screen color - taken from LeGo FocusNames
 */
func void SetFontColor (var int col) {
	//0x006FFD80 public: void __thiscall zCView::SetFontColor(struct zCOLOR const &)
	const int zCView__SetFontColor_G1 = 7339392;

	//0x007A9910 public: void __thiscall zCView::SetFontColor(struct zCOLOR const &)
	const int zCView__SetFontColor_G2 = 8034576;

	var int ptr; ptr = MEM_Alloc (4);
	MEM_WriteInt (ptr, col);

	var int screenPtr; screenPtr = MEM_ReadInt (screen_offset);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (ptr));
		CALL__thiscall (_@ (screenPtr), MEMINT_SwitchG1G2 (zCView__SetFontColor_G1, zCView__SetFontColor_G2));
		call = CALL_End();
	};

	MEM_Free (ptr);
};

func string GetSymbolName (var int symbolIndex) {
	var int symbPtr; symbPtr = MEM_GetSymbolByIndex (symbolIndex);

	if (symbPtr) {
		var zCPar_symbol symb; symb = _^ (symbPtr);
		return symb.name;
	};

	return "";
};

func int NPC_BodyStateContains (var int slfInstance, var int bodyState) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	if ((NPC_GetBodyState (slf) & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS)) == (bodystate & (BS_MAX | BS_FLAG_INTERRUPTABLE | BS_FLAG_FREEHANDS))) {
		return TRUE;
	};

	return FALSE;
};

//Gothic Sourcer compatibility - we cannot access MEM_World.voblist_npcs directly, because it seems like GS does not respect arrays > [255] ... which we do have in class oWorld ...
//therefore we have to access voblist_npcs by accessing pointer @ offset

//G1	offset 25192
//G2A	offset 25216
func int MEM_World_Get_voblist () {
	return + (MEM_ReadInt (_@ (MEM_World) + MEMINT_SwitchG1G2 (25192, 25216)));
};

//G1	offset 25196
//G2A	offset 25220
func int MEM_World_Get_voblist_npcs () {
	return + (MEM_ReadInt (_@ (MEM_World) + MEMINT_SwitchG1G2 (25196, 25220)));
};

func MEMINT_HelperClass Hlp_GetAliveNPC (var int slfInstanceID) {
	var int listPtr;

	listPtr = MEM_World_Get_voblist_npcs ();

	var int ptr; ptr = 0;

	var zCListSort list;

	while (listPtr);
		list = _^ (listPtr);
		if (list.data) {
			if (Hlp_Is_oCNpc (list.data)) {
				var oCNpc slf; slf = _^ (list.data);
				if (Hlp_IsValidNPC (slf)) {
					if (!Npc_IsDead (slf)) {
						if (Hlp_GetInstanceID (slf) == slfInstanceID) {
							ptr = list.data;
							break;
						};
					};
				};
			};
		};

		listPtr = list.next;
	end;

	MEM_AssignInstSuppressNullWarning = TRUE;
	MEM_PtrToInst (ptr);
	MEM_AssignInstSuppressNullWarning = FALSE;
};
