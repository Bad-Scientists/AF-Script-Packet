instance zCMaterial@ (zCMaterial);

func void _zCMaterial_CreateIntoPtr (var int ptr) {
	//0x0054CFC0 public: __thiscall zCMaterial::zCMaterial(void)
	const int zCMaterial__zCMaterial_G1 = 5558208;

	//0x00563E00 public: __thiscall zCMaterial::zCMaterial(void)
	const int zCMaterial__zCMaterial_G2 = 5651968;

	CALL__thiscall (ptr, MEMINT_SwitchG1G2 (zCMaterial__zCMaterial_G1, zCMaterial__zCMaterial_G2));
};

//0x0054D0A0 public: __thiscall zCMaterial::zCMaterial(class zSTRING const &)

//0x0054DC30 public: void __thiscall zCMaterial::SetTexture(class zCTexture *)
//0x0054DD60 public: void __thiscall zCMaterial::SetDetailTexture(class zSTRING &)
//0x0054DE40 public: void __thiscall zCMaterial::SetDetailTexture(class zCTexture *)
//0x0054DE80 private: void __thiscall zCMaterial::AutoAssignDetailTexture(void)
//0x0054DF80 public: class zVEC2 __thiscall zCMaterial::GetTexScale(void)
//0x0054DFE0 public: void __thiscall zCMaterial::SetTexScale(class zVEC2)
//0x0054E000 public: void __thiscall zCMaterial::RemoveTexture(void)
//0x0054E030 public: class zSTRING const & __thiscall zCMaterial::GetTextureName(void)
//0x0054E050 public: static class zCMaterial * __cdecl zCMaterial::SearchName(class zSTRING &)
//0x0054E100 public: static class zSTRING const & __cdecl zCMaterial::GetMatGroupString(enum zTMat_Group)
//0x0054E150 public: class zSTRING const & __thiscall zCMaterial::GetMatGroupString(void)const
//0x0054E1A0 public: void __thiscall zCMaterial::SetMatGroupByString(class zSTRING const &)
//0x0054E360 public: void __thiscall zCMaterial::RefreshAvgColorFromTexture(void)

func int zCMaterial_Create () {
	var int ptr; ptr = create (zCMaterial@);

	_zCMaterial_CreateIntoPtr (ptr);

	return ptr;
};

func void zCMaterial_SetTexture (var int ptr, var string textureName) {
	//0x0054DAC0 public: void __thiscall zCMaterial::SetTexture(class zSTRING &)
	const int zCMaterial__SetTexture_G1 = 5561024;

	//0x005649E0 public: void __thiscall zCMaterial::SetTexture(class zSTRING &)
	const int zCMaterial__SetTexture_G2 = 5655008;

	if (!ptr) { return; };

	//textureName = STR_Upper (textureName);

	CALL_zStringPtrParam (textureName);
	CALL__thiscall (ptr, MEMINT_SwitchG1G2 (zCMaterial__SetTexture_G1, zCMaterial__SetTexture_G2));
};
