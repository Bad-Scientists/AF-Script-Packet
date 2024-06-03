/*
 *	zVEC3_NormalizeSafe
 */
func void zVEC3_NormalizeSafe (var int vecPtr) {
	//0x004AC6C0 public: class zVEC3 & __thiscall zVEC3::NormalizeSafe(void)
	const int zVEC3__NormalizeSafe_G1 = 4900544;

	//0x00498A20 public: class zVEC3 & __thiscall zVEC3::NormalizeSafe(void)
	const int zVEC3__NormalizeSafe_G2 = 4819488;

	if (!vecPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall (_@ (vecPtr), MEMINT_SwitchG1G2 (zVEC3__NormalizeSafe_G1, zVEC3__NormalizeSafe_G2));
		call = CALL_End();
	};

	MEM_CopyBytes (CALL_RetValAsPtr(), vecPtr, 12);
};

/*
 *	zVEC3_LengthApprox // float
 */
func int zVEC3_LengthApprox (var int vecPtr) {
	//0x00488FD0 public: float __thiscall zVEC3::LengthApprox(void)const
	const int zVEC3__LengthApprox_G1 = 4755408;

	//0x00490E10 public: float __thiscall zVEC3::LengthApprox(void)const
	const int zVEC3__LengthApprox_G2 = 4787728;

	if (!vecPtr) { return FLOATNULL; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_RetValIsFloat ();
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (vecPtr), MEMINT_SwitchG1G2 (zVEC3__LengthApprox_G1, zVEC3__LengthApprox_G2));
		call = CALL_End();
	};

	return +retVal;
};

/*
 *	zMAT4_Mul_zVEC3
 */
func void zMAT4_Mul_zVEC3 (var int ptrzMAT4, var int ptrzVEC3, var int targetPtr) {
	//0x00472D40 class zVEC3 __cdecl operator*(class zMAT4 const &,class zVEC3 const &)
	const int zMAT4_Mul_zVEC3_G1 = 4664640;

	//0x00474370 class zVEC3 __cdecl operator*(class zMAT4 const &,class zVEC3 const &)
	const int zMAT4_Mul_zVEC3_G2 = 4670320;

	if ((!ptrzMAT4) || (!ptrzVEC3) || (!targetPtr)) { return; };

	//CALL_RetValIsStruct only supported in disposable calls
	CALL_RetValIsStruct (12);

	CALL_PtrParam (ptrzVEC3);
	CALL_PtrParam (ptrzMAT4);
	CALL__cdecl (MEMINT_SwitchG1G2 (zMAT4_Mul_zVEC3_G1, zMAT4_Mul_zVEC3_G2));

	var int posPtr; posPtr = CALL_RetValAsPtr ();
	MEM_CopyBytes (posPtr, targetPtr, 12);
	MEM_Free (posPtr);
};

/*
 *	zVEC3_Sub_zVEC3
 */
func void zVEC3_Sub_zVEC3 (var int ptrzVEC3_1, var int ptrzVEC3_2, var int targetPtr) {
	//0x00481010 class zVEC3 __cdecl operator-(class zVEC3 const &,class zVEC3 const &)
	const int zVEC3_Sub_zVEC3_G1 = 4722704;

	//0x004889F0 class zVEC3 __cdecl operator-(class zVEC3 const &,class zVEC3 const &)
	const int zVEC3_Sub_zVEC3_G2 = 4753904;

	if ((!ptrzVEC3_1) || (!ptrzVEC3_2) || (!targetPtr)) { return; };

	//CALL_RetValIsStruct only supported in disposable calls
	CALL_RetValIsStruct (12);

	CALL_PtrParam (ptrzVEC3_2);
	CALL_PtrParam (ptrzVEC3_1);
	CALL__cdecl (MEMINT_SwitchG1G2 (zVEC3_Sub_zVEC3_G1, zVEC3_Sub_zVEC3_G2));

	var int posPtr; posPtr = CALL_RetValAsPtr ();
	MEM_CopyBytes (posPtr, targetPtr, 12);
	MEM_Free (posPtr);
};

/*
 *	Pos_GetDistToPos // float
 */
func int Pos_GetDistToPos (var int posPtr1, var int posPtr2) {
	var int dir[3];
	zVEC3_Sub_zVEC3 (posPtr1, posPtr2, _@ (dir));
	return + zVEC3_LengthApprox (_@ (dir));
};
