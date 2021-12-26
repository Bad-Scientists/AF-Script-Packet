//class oCAIVobMoveTorch : public oCAIVobMove : public oCAISound : public zCAIBase : public zCObject {

/*
func void _oCAIVobMoveTorch_CreateIntoPtr (var int ai) {
	//0x006180A0 public: __thiscall oCAIVobMoveTorch::oCAIVobMoveTorch(void)
	const int oCAIVobMoveTorch__oCAIVobMoveTorch_G1 = 6389920;

	//0x0069FC60 public: __thiscall oCAIVobMoveTorch::oCAIVobMoveTorch(void)
	const int oCAIVobMoveTorch__oCAIVobMoveTorch_G2 = 6945888;

	CALL__thiscall (ai, MEMINT_SwitchG1G2 (oCAIVobMoveTorch__oCAIVobMoveTorch_G1, oCAIVobMoveTorch__oCAIVobMoveTorch_G2));
};
*/

func int oCAIVobMoveTorch_Create () {
	var int ai; ai = CreateNewInstanceByString ("oCAIVobMoveTorch");

	//Seems like CreateNewInstanceByString takes care of everything, we don't need to call constructor here :thinking:
	//_oCAIVobMoveTorch_CreateIntoPtr (ai);

	return +ai;
};

func void oCAIVobMoveTorch_Init (var int ai, var int vobPtr, var int ownerVobPtr, var int startPosPtr, var int angleF, var int velocityF, var int trafoPtr) {
	//0x00618280 public: virtual void __thiscall oCAIVobMoveTorch::Init(class zCVob *,class zCVob *,class zVEC3 &,float,float,class zMAT4 *)
	const int oCAIVobMoveTorch__Init_G1 = 6390400;

	//0x0069FE40 public: virtual void __thiscall oCAIVobMoveTorch::Init(class zCVob *,class zCVob *,class zVEC3 &,float,float,class zMAT4 *)
	const int oCAIVobMoveTorch__Init_G2 = 6946368;

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

		CALL__thiscall (_@ (ai), MEMINT_SwitchG1G2 (oCAIVobMoveTorch__Init_G1, oCAIVobMoveTorch__Init_G2));
		call = CALL_End ();
	};
};
