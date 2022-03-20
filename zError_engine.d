func void zERROR_SetFilterLevel (var int zErrorLevel) {
	//0x008699D8 class zERROR zerr
	const int zERROR__zerr_G1 = 8821208;
	//0x008CDCD0 class zERROR zerr
	const int zERROR__zerr_G2 = 9231568;

	//0x00449680 public: void __thiscall zERROR::SetFilterLevel(int)
	const int zERROR__SetFilterLevel_G1 = 4494976;
	//0x0044DDA0 public: void __thiscall zERROR::SetFilterLevel(int)
	const int zERROR__SetFilterLevel_G2 = 4513184;

	CALL_IntParam (zErrorLevel);
	CALL__thiscall (MEMINT_SwitchG1G2 (zERROR__zerr_G1, zERROR__zerr_G2), MEMINT_SwitchG1G2 (zERROR__SetFilterLevel_G1, zERROR__SetFilterLevel_G2));
};

//0x008699D8 class zERROR zerr

//0x007D1834 const zERROR::`vftable'
//0x004476B0 public: __thiscall zERROR::zERROR(void)
//0x00447900 public: virtual void * __thiscall zERROR::`vector deleting destructor'(unsigned int)
//0x00447920 public: void __thiscall zERROR::Init(class zSTRING)
//0x00447FD0 public: virtual __thiscall zERROR::~zERROR(void)
//0x004481D0 public: void __thiscall zERROR::SendToSpy(class zSTRING &)
//0x00448240 public: int __thiscall zERROR::Report(enum zERROR_LEVEL,int,class zSTRING const &,signed char,unsigned int,int,char *,char *)
//0x00448250 public: int __thiscall zERROR::Report(enum zERROR_TYPE,int,class zSTRING const &,signed char,unsigned int,int,char *,char *)
//0x00448990 private: void __thiscall zERROR::BlockBegin(char *,int)
//0x00448BE0 public: static void __cdecl zSTRING::operator delete(void *,char const *,char const *,int)
//0x00448BF0 private: void __thiscall zERROR::BlockEnd(char *,int)
//0x00448F90 public: void __thiscall zERROR::Separator(class zSTRING)
//0x004491A0 public: void __thiscall zERROR::ShowSpy(int)
//0x004492F0 public: int __thiscall zERROR::Message(class zSTRING const &)
//0x00449330 public: int __thiscall zERROR::Warning(class zSTRING const &)
//0x00449360 public: int __thiscall zERROR::Fatal(class zSTRING const &)
//0x00449390 public: int __thiscall zERROR::Fault(class zSTRING const &)
//0x004493C0 public: void __thiscall zERROR::SetFilterFlags(unsigned long)
//0x004494E0 public: void __thiscall zERROR::SetFilterAuthors(class zSTRING)
//0x00449680 public: void __thiscall zERROR::SetFilterLevel(int)
//0x004497B0 public: void __thiscall zERROR::SetTarget(int)
//0x00449A40 public: class zSTRING __thiscall zERROR::GetTargetDescription(void)
//0x00449C60 public: class zSTRING __thiscall zERROR::GetFilterFlagDescription(void)
//0x00449E60 public: class zSTRING __thiscall zERROR::GetFilterAuthors(void)
//0x00449EB0 public: bool __thiscall zERROR::SearchForSpy(void)

func int zERROR_GetFilterLevel () {
	//0x008699D8 class zERROR zerr
	const int zerr_G1 = 8821208;
	//0x008CDCD0 class zERROR zerr
	const int zerr_G2 = 9231568;

	//0x0057E350 public: int __thiscall zERROR::GetFilterLevel(void)
	const int zERROR__GetFilterLevel_G1 = 5759824;

	//0x0059D130 public: int __thiscall zERROR::GetFilterLevel(void)
	const int zERROR__GetFilterLevel_G2 = 5886256;

	CALL__thiscall (MEMINT_SwitchG1G2(zerr_G1, zerr_G2), MEMINT_SwitchG1G2 (zERROR__GetFilterLevel_G1, zERROR__GetFilterLevel_G2));

	return CALL_RetValAsInt ();
};

func void zSpy_Info (var string s) {
	var int errorLevel; errorLevel = zERROR_GetFilterLevel ();
	zERROR_SetFilterLevel (1);
	MEM_Info (s);
	//PrintS (s);
	zERROR_SetFilterLevel (errorLevel);
};
