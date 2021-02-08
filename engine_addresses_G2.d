/*
 *	Enhanced InfoManager
 */

//0x0068EBA0 public: virtual int __thiscall zCViewDialogChoice::HandleEvent(int)
const int zCViewDialogChoice__HandleEvent	= 6876064;

//0x00660BB0 public: void __fastcall oCInformationManager::Update(void)
const int oCInformationManager__Update		= 6687664;


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
