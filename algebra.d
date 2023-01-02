/*
 *	zVEC3_NormalizeSafe
 */
func int zVEC3_NormalizeSafe (var int vecPtr) {
	//0x004AC6C0 public: class zVEC3 & __thiscall zVEC3::NormalizeSafe(void)
	const int zVEC3__NormalizeSafe_G1 = 4900544;

	//0x00498A20 public: class zVEC3 & __thiscall zVEC3::NormalizeSafe(void)
	const int zVEC3__NormalizeSafe_G2 = 4819488;

	if (!vecPtr) { return FLOATNULL; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@ (retVal));
		CALL__thiscall (_@ (vecPtr), MEMINT_SwitchG1G2 (zVEC3__NormalizeSafe_G1, zVEC3__NormalizeSafe_G2));
		call = CALL_End();
	};

	return +retVal;
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

