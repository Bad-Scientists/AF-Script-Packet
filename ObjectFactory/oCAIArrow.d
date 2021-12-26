//0x00618D50 public: virtual void __thiscall oCAIArrowBase::ReportCollisionToAI(class zCCollisionReport const &)

//0x006195E0 public: virtual void __thiscall oCAIArrow::ReportCollisionToAI(class zCCollisionReport const &)

//class oCAIArrow : public oCAIArrowBase : oCAIArrowBase : public oCAISound : public zCAIBase : public zCObject {

func int oCAIArrow_Create () {
	var int ai; ai = CreateNewInstanceByString ("oCAIArrow");
	return +ai;
};

func void oCAIArrow_Init (var int ai, var int arrowVobPtr, var int ownerVobPtr, var int targetVobPtr) {
	//0x006190E0 public: void __thiscall oCAIArrow::SetTarget(class zCVob *)
	//const int oCAIArrow__SetTarget_G1 = 6394080;

	//0x006A0FF0 public: void __thiscall oCAIArrow::SetTarget(class zCVob *)
	//const int oCAIArrow__SetTarget_G2 = 6950896;

	//0x006191D0 public: void __thiscall oCAIArrow::SetupAIVob(class zCVob *,class zCVob *,class zCVob *)
	const int oCAIArrow__SetupAIVob_G1 = 6394320;

	//0x006A10E0 public: void __thiscall oCAIArrow::SetupAIVob(class zCVob *,class zCVob *,class zCVob *)
	const int oCAIArrow__SetupAIVob_G2 = 6951136;

	if (!ai) { return; };
	if (!arrowVobPtr) { return; };
	if (!ownerVobPtr) { return; };
	if (!targetVobPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (targetVobPtr));
		CALL_PtrParam (_@ (ownerVobPtr));
		CALL_PtrParam (_@ (arrowVobPtr));

		CALL__thiscall (_@ (ai), MEMINT_SwitchG1G2 (oCAIArrow__SetupAIVob_G1, oCAIArrow__SetupAIVob_G2));
		call = CALL_End ();
	};
};
