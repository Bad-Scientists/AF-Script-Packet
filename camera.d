func int zCCamera_Get_activeCam () {
	//0x00873240 public: static class zCCamera * zCCamera::activeCam
	const int activeCam_addr_G1 = 8860224;

	//0x008D7F94 public: static class zCCamera * zCCamera::activeCam
	const int activeCam_addr_G2 = 9273236;

	return + MEMINT_SwitchG1G2 (activeCam_addr_G1, activeCam_addr_G2);
};

func void zCCamera_Activate (var int camera) {
	//0x005364C0 public: void __thiscall zCCamera::Activate(void)
	const int zCCamera__Activate_G1 = 5465280;

	//0x0054A700 public: void __thiscall zCCamera::Activate(void)
	const int zCCamera__Activate_G2 = 5547776;

	if (!camera) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (camera, MEMINT_SwitchG1G2 (zCCamera__Activate_G1, zCCamera__Activate_G2));
		call = CALL_End();
	};
};

//--

func void zCCamera_ProjectF (var int camera, var int posPtr, var int xscrPtrF, var int yscrPtrF) {
	//0x0051D7F0 public: void __thiscall zCCamera::Project(class zVEC3 const * const,float &,float &)const
	const int zCCamera__Project_G1 = 5363696;

	//0x00530030 public: void __thiscall zCCamera::Project(class zVEC3 const * const,float &,float &)const
	const int zCCamera__Project_G2 = 5439536;

	if (!camera) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam ( _@ (yscrPtrF));
		CALL_PtrParam ( _@ (xscrPtrF));
		CALL_PtrParam ( _@ (posPtr));
		CALL__thiscall (camera, MEMINT_SwitchG1G2 (zCCamera__Project_G1, zCCamera__Project_G2));
		call = CALL_End();
	};
};

func void zCCamera_Project (var int camera, var int posPtr, var int xscrPtr, var int yscrPtr) {
	//0x005606D0 public: void __thiscall zCCamera::Project(class zVEC3 const * const,int &,int &)
	const int zCCamera__Project_G1 = 5637840;

	//0x0057A440 public: void __thiscall zCCamera::Project(class zVEC3 const * const,int &,int &)
	const int zCCamera__Project_G2 = 5743680;

	if (!camera) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PtrParam ( _@ (yscrPtr));
		CALL_PtrParam ( _@ (xscrPtr));
		CALL_PtrParam ( _@ (posPtr));
		CALL__thiscall (camera, MEMINT_SwitchG1G2 (zCCamera__Project_G1, zCCamera__Project_G2));
		call = CALL_End();
	};
};

