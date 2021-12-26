//0x0061A040 public: virtual void __thiscall oCAIDrop::ReportCollisionToAI(class zCCollisionReport const &)

//class oCAIDrop : public oCAISound : public zCAIBase : public zCObject {

func int oCAIDrop_Create () {
	var int ai; ai = CreateNewInstanceByString ("oCAIDrop");
	return +ai;
};

func void oCAIDrop_Init (var int ai, var int vobPtr, var int ownerVobPtr, var int startPosPtr, var int angleF, var int velocityF) {
	//0x00619D90 public: void __thiscall oCAIDrop::SetupAIVob(class zCVob *,class zCVob *)
	const int oCAIDrop__SetupAIVob_G1 = 6397328;

	//0x006A21C0 public: void __thiscall oCAIDrop::SetupAIVob(class zCVob *,class zCVob *)
	const int oCAIDrop__SetupAIVob_G2 = 6955456;

	if (!ai) { return; };
	if (!vobPtr) { return; };
	if (!ownerVobPtr) { return; };
	if (!startPosPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (ownerVobPtr));
		CALL_PtrParam (_@ (vobPtr));

		CALL__thiscall (_@ (ai), MEMINT_SwitchG1G2 (oCAIDrop__SetupAIVob_G1, oCAIDrop__SetupAIVob_G2));
		call = CALL_End ();
	};

	//0x0061A130 public: void __thiscall oCAIDrop::SetStartPosition(class zVEC3 &)
	const int oCAIDrop__SetStartPosition_G1 = 6398256;

	//0x006A2590 public: void __thiscall oCAIDrop::SetStartPosition(class zVEC3 &)
	const int oCAIDrop__SetStartPosition_G2 = 6956432;

	const int call2 = 0;
	if (CALL_Begin (call2)) {
		CALL_PtrParam (_@ (startPosPtr));

		CALL__thiscall (_@ (ai), MEMINT_SwitchG1G2 (oCAIDrop__SetStartPosition_G1, oCAIDrop__SetStartPosition_G2));
		call2 = CALL_End ();
	};

	//0x0061A080 public: void __thiscall oCAIDrop::SetVelocity(float,float)
	const int oCAIDrop__SetVelocity_G1 = 6398080;

	//0x006A24E0 public: void __thiscall oCAIDrop::SetVelocity(float,float)
	const int oCAIDrop__SetVelocity_G2 = 6398080;

	const int call3 = 0;
	if (CALL_Begin (call3)) {
		CALL_FloatParam (_@ (angleF));	//Angle
		CALL_FloatParam (_@ (velocityF));	//Velocity

		CALL__thiscall (_@ (ai), MEMINT_SwitchG1G2 (oCAIDrop__SetVelocity_G1, oCAIDrop__SetVelocity_G2));
		call3 = CALL_End ();
	};
};
