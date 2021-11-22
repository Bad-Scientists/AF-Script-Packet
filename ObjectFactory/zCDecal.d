/*
 *
 */
func void zCDecal_SetTexture (var int ptr, var string textureName) {
	//0x00542240 public: void __thiscall zCDecal::SetTexture(class zSTRING &)
	const int zCDecal__SetTexture_G1 = 5513792;

	//0x00556950 public: void __thiscall zCDecal::SetTexture(class zSTRING &)
	const int zCDecal__SetTexture_G2 = 5597520;

	CALL_zStringPtrParam (textureName);
	CALL__thiscall (ptr, MEMINT_SwitchG1G2 (zCDecal__SetTexture_G1, zCDecal__SetTexture_G2));
};

func void zCDecal_SetTextureByPtr (var int ptr, var int texturePtr) {
	//0x00542250 public: void __thiscall zCDecal::SetTexture(class zCTexture *)
	const int zCDecal__SetTexture_G1 = 5513808;

	//0x00556960 public: void __thiscall zCDecal::SetTexture(class zCTexture *)
	const int zCDecal__SetTexture_G2 = 5597536;

	CALL_PtrParam (texturePtr);
	CALL__thiscall (ptr, MEMINT_SwitchG1G2 (zCDecal__SetTexture_G1, zCDecal__SetTexture_G2));
};

func void zCDecal_SetDecalDim (var int ptr, var int dimX, var int dimY) {
	//0x00542260 public: void __thiscall zCDecal::SetDecalDim(float,float)
	const int zCDecal__SetDecalDim_G1 = 5513824;

	//0x00556970 public: void __thiscall zCDecal::SetDecalDim(float,float)
	const int zCDecal__SetDecalDim_G2 = 5597552;

	CALL_FloatParam (dimY);
	CALL_FloatParam (dimX);
	CALL__thiscall (ptr, MEMINT_SwitchG1G2 (zCDecal__SetDecalDim_G1, zCDecal__SetDecalDim_G2));
};

func void _zCDecalPtr_CreateIntoPtr (var int ptr) {
	//0x00541E20 public: __thiscall zCDecal::zCDecal(void)
	const int zCDecal__zCDecal_G1 = 5512736;

	//0x00556570 public: __thiscall zCDecal::zCDecal(void)
	const int zCDecal__zCDecal_G2 = 5596528;

	CALL__thiscall (ptr, MEMINT_SwitchG1G2 (zCDecal__zCDecal_G1, zCDecal__zCDecal_G2));
};

instance zCDecal@ (zCDecal);

func int zCDecal_Create (var string textureName, var int dimX, var int dimY) {
	var int ptr; ptr = create (zCDecal@);

	_zCDecalPtr_CreateIntoPtr (ptr);

	zCDecal_SetTexture (ptr, textureName);
	zCDecal_SetDecalDim (ptr, dimX, dimY);

	return ptr;
};
