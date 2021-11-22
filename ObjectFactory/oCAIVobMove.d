//0x006176C0 public: __thiscall oCAIVobMove::oCAIVobMove(void)

func int oCAIVobMove_Create () {
	var int ai; ai = CreateNewInstanceByString ("oCAIVobMove");
	return +ai;
};

func void oCAIVobMove_Init (var int ai, var int vobPtr, var int ownerVobPtr, var int startPosPtr, var int angleF, var int velocityF, var int trafoPtr) {
	//0x006179E0 public: virtual void __thiscall oCAIVobMove::Init(class zCVob *,class zCVob *,class zVEC3 &,float,float,class zMAT4 *)
	const int oCAIVobMove__Init_G1 = 6388192;

	//0x0069F540 public: virtual void __thiscall oCAIVobMove::Init(class zCVob *,class zCVob *,class zVEC3 &,float,float,class zMAT4 *)
	const int oCAIVobMove__Init_G2 = 6944064;

	if (!ai) { return; };
	if (!vobPtr) { return; };
	if (!ownerVobPtr) { return; };
	if (!startPosPtr) { return; };
	if (!trafoPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (trafoPtr));	//Direction

		CALL_FloatParam (_@ (velocityF));	//Velocity
		CALL_FloatParam (_@ (angleF));		//Angle

		CALL_PtrParam (_@ (startPosPtr));

		CALL_PtrParam (_@ (ownerVobPtr));
		CALL_PtrParam (_@ (vobPtr));

		CALL__thiscall (_@ (ai), MEMINT_SwitchG1G2 (oCAIVobMove__Init_G1, oCAIVobMove__Init_G2));
		call = CALL_End ();
	};
};
