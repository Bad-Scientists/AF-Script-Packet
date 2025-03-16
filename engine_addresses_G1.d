/*
 *	Mouse input
 *	 - Ikarus G1 constants are incorrect, we have to use our own
 */
const int MOUSE_WHEEL_UP = 2057;
const int MOUSE_WHEEL_DOWN = 2058;

const int MOUSE_BUTTON_LEFT = 2050;
const int MOUSE_BUTTON_RIGHT = 2052;
//const int MOUSE_BUTTON_MIDDLE = ; //We don't have this one in G1?

//522	2057 - Wheel up
//523	2058 - Wheel down

//524	2050 - Left Mouse button
//525	2052 - Right Mouse button
//526        - Middle Mouse button

//Special buttons
//527        - Forward button
//528        - Backward button

/*
 *	Trade sections
 */

const int TRADE_SECTION_LEFT_INVENTORY_G1 = 0;
const int TRADE_SECTION_LEFT_CONTAINER_G1 = 1;
const int TRADE_SECTION_RIGHT_CONTAINER_G1 = 2;
const int TRADE_SECTION_RIGHT_INVENTORY_G1 = 3;
const int TRADE_SECTION_CHOICE_G1 = 4;

/*
 *	Weapon stacking
 */

//0x0062A050 public: int __thiscall oCAniCtrl_Human::RemoveWeapon2(void)
const int oCAniCtrl_Human__RemoveWeapon2 = 6463568;

//0x00668F60 public: virtual void __thiscall oCItemContainer::Activate(void)
const int oCItemContainer__Activate = 6721376;

//0x006BB0A0 public: void __thiscall oCNpc::OpenInventory(void)
//Already defined in LeGo
//const int oCNPC__OpenInventory = 7057568;

//0x006968F0 public: void __thiscall oCNpc::Equip(class oCItem *)
//Already defined in LeGo
//const int oCNPC__Equip = 6908144;

//0x0068FBC0 public: void __thiscall oCNpc::UnequipItem(class oCItem *)
//Already defined in LeGo
//const int oCNPC__UnequipItem = 6880192;

//0x006A0D10 public: virtual int __thiscall oCNpc::DoTakeVob(class zCVob *)
const int oCNPC__DoTakeVob = 6950160;

/*
 *	Inventory sorting
 */

//0x0066B3D0 public: __thiscall oCNpcInventory::oCNpcInventory(void)
//inventory2_inventory1_Compare int(_cdecl*)(oCItem*, OCItem*)

const int inventory2_inventory0_Compare = 6732080;	//66B930	InventorySortDefault	??
const int inventory2_inventory1_Compare = 6731024;	//66B510	InventorySortCombat	INV_WEAPON
const int inventory2_inventory2_Compare = 6731488;	//66B6E0	InventorySortArmor	INV_ARMOR
const int inventory2_inventory3_Compare = 6732080;	//66B930	InventorySortDefault	INV_RUNE
const int inventory2_inventory4_Compare = 6732080;	//66B930	InventorySortDefault	INV_MAGIC
const int inventory2_inventory5_Compare = 6731568;	//66B730	InventorySortFood	INV_FOOD
const int inventory2_inventory6_Compare = 6732080;	//66B930	InventorySortDefault	INV_POTION
const int inventory2_inventory7_Compare = 6731216;	//66B5D0	InventorySortDoc	INV_DOC
const int inventory2_inventory8_Compare = 6731648;	//66B780	InventorySortOther	INV_MISC

/*
 *	Enhanced InfoManager
 */

//0x00758A60 public: virtual int __thiscall zCViewDialogChoice::HandleEvent(int)
const int zCViewDialogChoice__HandleEvent = 7703136;

//0x0072BE90 public: void __fastcall oCInformationManager::Update(void)
const int oCInformationManager__Update = 7519888;

//0x0072CFC0 protected: int __fastcall oCInformationManager::CollectChoices(class oCInfo *)
const int oCInformationManager__CollectChoices = 7524288;

//0x0072CD90 protected: void __fastcall oCInformationManager::CollectInfos(void)
const int oCInformationManager__CollectInfos = 7523728;

/*
 *	Enhanced Trading
 */

//0x0072A2B0 protected: int __fastcall oCViewDialogTrade::OnTransferLeft(int)
const int oCViewDialogTrade__OnTransferLeft = 7512752;

//0x0072A530 protected: int __fastcall oCViewDialogTrade::OnTransferRight(int)
const int oCViewDialogTrade__OnTransferRight = 7513392;

//0x0072A870 protected: void __fastcall oCViewDialogTrade::OnAccept(void)
const int oCViewDialogTrade__OnAccept = 7514224;

//0x0072AAB0 protected: void __fastcall oCViewDialogTrade::OnExit(void)
const int oCViewDialogTrade__OnExit = 7514800;

//0x007293F0 protected: void __fastcall oCViewDialogTrade::TransferReset(void)
const int oCViewDialogTrade__TransferReset = 7508976;

//0x007299A0 public: virtual int __thiscall oCViewDialogTrade::HandleEvent(int)
const int oCViewDialogTrade__HandleEvent = 7510432;

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

/*
 *	game_Events_G12.d
 */

//0x006A8500 public: int __thiscall oCNpc::EV_DrawWeapon(class oCMsgWeapon *)
const int oCNPC__EV_DrawWeapon = 6980864;
//0x006A8B80 public: int __thiscall oCNpc::EV_DrawWeapon1(class oCMsgWeapon *)
const int oCNPC__EV_DrawWeapon1 = 6982528;
//0x006A8E20 public: int __thiscall oCNpc::EV_DrawWeapon2(class oCMsgWeapon *)
const int oCNPC__EV_DrawWeapon2 = 6983200;

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

/*
 *	Sprint mode
 */

//0x00624E30 public: void __thiscall oCAniCtrl_Human::ToggleWalkMode(int)
//const int oCAniCtrl_Human__ToggleWalkMode = 6442544;

/*
 *	Event Manager
 */

//0x007D3ECC const zCMaterial::`vftable'

//0x007D0894 const zCObject::`vftable'
//const int zCObject_vtbl = 8194196;

//0x007D0D44 const zCCSBlockPosition::`vftable'
//const int zCCSBlockPosition_vtbl = 8195396;

//0x007D0FAC const zCCSProps::`vftable'
//const int zCCSProps_vtbl = 8196012;

//0x007D08F4 const oCCSPlayer::`vftable'{for `zCObject'}
//const int zCObject__oCCSPlayer_vtbl = 8194292;

//0x007D0754 const zCEventMessage::`vftable'
const int zCEventMessage_vtbl = 8193876;

//0x007DE97C const zCEventManager::`vftable'
const int zCEventManager_vtbl = 8251772;

//0x007D0A24 const zCCSCutsceneContext::`vftable'
const int zCCSCutsceneContext_vtbl = 8194596;

//0x007DE28C const oCNpcMessage::`vftable'
const int oCNpcMessage_vtbl = 8249996;

//0x007DE2F4 const oCMsgDamage::`vftable'
const int oCMsgDamage_vtbl = 8250100;

//0x007DE35C const oCMsgWeapon::`vftable'
const int oCMsgWeapon_vtbl = 8250204;

//0x007DE3C4 const oCMsgMovement::`vftable'
const int oCMsgMovement_vtbl = 8250308;

//0x007DE42C const oCMsgAttack::`vftable'
const int oCMsgAttack_vtbl = 8250412;

//0x007DE494 const oCMsgUseItem::`vftable'
const int oCMsgUseItem_vtbl = 8250516;

//0x007DE4FC const oCMsgState::`vftable'
const int oCMsgState_vtbl = 8250620;

//0x007DE564 const oCMsgManipulate::`vftable'
const int oCMsgManipulate_vtbl = 8250724;

//0x007DE5CC const oCMsgConversation::`vftable'
const int oCMsgConversation_vtbl = 8250828;

//0x007DE634 const oCMsgMagic::`vftable'
const int oCMsgMagic_vtbl = 8250932;

//0x007DEDDC const zCEventMusicControler::`vftable'
const int zCEventMusicControler_vtbl = 8252892;

//0x007D07B4 const zCEventCore::`vftable'
const int zCEventCore_vtbl = 8193972;

//0x007D0CE4 const zCEvMsgCutscene::`vftable'
const int zCEvMsgCutscene_vtbl = 8195300;

//0x007D284C const zCCSCamera_EventMsg::`vftable'
//0x007D06F4 const zCCSCamera_EventMsgActivate::`vftable'
//0x007D07B4 const zCEventCore::`vftable'
//0x007D0CE4 const zCEvMsgCutscene::`vftable'

//0x007DBE0C const zCEventCommon::`vftable'
//0x007DBE6C const zCEventMover::`vftable'
//0x007DBECC const zCEventScreenFX::`vftable'

//0x007DDC9C const oCMobMsg::`vftable'
const int oCMobMsg_vtbl = 8248476;

/*
 *	TriggerChangeLevel event
 */

//0x0063D480 public: virtual void __thiscall oCGame::TriggerChangeLevel(class zSTRING const &,class zSTRING const &)
const int oCGame__TriggerChangeLevel = 6542464;


/*
 *	Gamestate extended events
 */

//0x006A4500 public: void __thiscall oCNpc::PreSaveGameProcessing(void)
const int oCNpc__PreSaveGameProcessing = 6964480;

//0x006A4810 public: void __thiscall oCNpc::PostSaveGameProcessing(void)
const int oCNpc__PostSaveGameProcessing = 6965264;

//0x0063CD60 private: virtual void __thiscall oCGame::ChangeLevel(class zSTRING const &,class zSTRING const &)
//Already defined in LeGo
//const int oCGame__ChangeLevel = 6540640;

/*
 *	No Ammo print
 */
//0x00699290 public: int __thiscall oCNpc::IsMunitionAvailable(class oCItem *)
const int oCNpc__IsMunitionAvailable = 6918800;

/*
 *	Log Dialogues
 */
//0x006DD090 public: virtual void __thiscall zCEventManager::OnMessage(class zCEventMessage *,class zCVob *)
const int zCEventManager__OnMessage = 7196816;

/*
 *	Rain Control
 */
//0x005C0900 public: virtual void __thiscall zCSkyControler_Outdoor::RenderSkyPre(void)
const int zCSkyControler_Outdoor__RenderSkyPre = 6031616;




//0x007D3E04 const zCDecal::`vftable'
//Already defined in Ikarus - but has incorrect value !! const int zCDecal_vtbl= 8241804;
//const int zCDecal_vtbl = 8207876;

//0x007DCDFC const oCItemContainer::`vftable'
const int oCItemContainer_vtbl = 8244732;

//0x007DCEA4 const oCStealContainer::`vftable'
const int oCStealContainer_vtbl = 8244900;

//0x007DCF54 const oCNpcContainer::`vftable'
const int oCNpcContainer_vtbl = 8245076;

//0x007DD004 const oCNpcInventory::`vftable'
const int oCNpcInventory_vtbl = 8245252;

//0x007DEB3C const zCVobSpot::`vftable'
const int zCVobSpot_vtbl = 8252220;

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

	const int colorPtr = 0;

	if (!colorPtr) {
		colorPtr = MEM_Alloc (4);
	};

	MEM_WriteInt (colorPtr, col);

	var int screenPtr; screenPtr = MEM_ReadInt (screen_offset);

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam (_@ (colorPtr));
		CALL__thiscall (_@ (screenPtr), MEMINT_SwitchG1G2 (zCView__SetFontColor_G1, zCView__SetFontColor_G2));
		call = CALL_End();
	};
};

func string GetSymbolName (var int symbolIndex) {
	if (symbolIndex < 0) { return STR_EMPTY; };

	var int symbPtr; symbPtr = MEM_GetSymbolByIndex (symbolIndex);

	if (symbPtr) {
		var zCPar_symbol symb; symb = _^ (symbPtr);
		return symb.name;
	};

	return STR_EMPTY;
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

func void MEM_WriteNOP (var int addr, var int len) {
	MemoryProtectionOverride (addr, len);
	repeat (i, len); var int i;
		MEM_WriteByte (addr + i, ASMINT_OP_nop);
	end;
};
