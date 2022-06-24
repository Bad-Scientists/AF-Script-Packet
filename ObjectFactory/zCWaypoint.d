func int zCWaypoint_Create () {
	var int ptr; ptr = CreateNewInstanceByString ("zCWaypoint");
	return +ptr;
};

func void zCWaypoint_Init (var int wpPtr, var string waypointName, var int vobWaypointPtr, var int x, var int y, var int z) {
	if (!wpPtr) { return; };

	if (vobWaypointPtr) {
		//0x00705D70 public: void __thiscall zCWaypoint::Init(class zCVobWaypoint *)
		const int zCWaypoint__Init_VobWp_G1 = 7363952;

		//0x007AF970 public: void __thiscall zCWaypoint::Init(class zCVobWaypoint *)
		const int zCWaypoint__Init_VobWp_G2 = 8059248;

		CALL_PtrParam (vobWaypointPtr);
		CALL__thiscall (wpPtr, MEMINT_SwitchG1G2 (zCWaypoint__Init_VobWp_G1, zCWaypoint__Init_VobWp_G2));
	} else {
		//0x00705D00 public: void __thiscall zCWaypoint::Init(float,float,float)
		const int zCWaypoint__Init_G1 = 7363840;

		//0x007AF900 public: void __thiscall zCWaypoint::Init(float,float,float)
		const int zCWaypoint__Init_G2 = 8059136;

		CALL_FloatParam (z);
		CALL_FloatParam (y);
		CALL_FloatParam (x);

		CALL__thiscall (wpPtr, MEMINT_SwitchG1G2 (zCWaypoint__Init_G1, zCWaypoint__Init_G2));
	};

	//0x00705FB0 public: void __thiscall zCWaypoint::SetName(class zSTRING &)
	const int zCWaypoint__SetName_G1 = 7364528;

	//0x007AFBB0 public: void __thiscall zCWaypoint::SetName(class zSTRING &)
	const int zCWaypoint__SetName_G2 = 8059824;

	CALL_zStringPtrParam (waypointName);
	CALL__thiscall (wpPtr, MEMINT_SwitchG1G2 (zCWaypoint__SetName_G1, zCWaypoint__SetName_G2));
};