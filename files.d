/*
 *	File functions
 */

var int Files_LookAtVDFS;

/*
 *	zCOption_ChangeDir
 */
func void zCOption_ChangeDir(var int optionPath) {
	//0x00869694 class zCOption * zoptions
	const int zoptions_addr_G1 = 8820372;

	//0x008CD988 class zCOption * zoptions
	const int zoptions_addr_G2 = 9230728;

	//0x0045FB00 public: void __thiscall zCOption::ChangeDir(enum zTOptionPaths)
	const int zCOption__ChangeDir_G1 = 4586240;

	//0x00465160 public: void __thiscall zCOption::ChangeDir(enum zTOptionPaths)
	const int zCOption__ChangeDir_G2 = 4608352;

	const int call = 0;
	if (CALL_Begin(call)) {
		var int zoptionsPtr; zoptionsPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zoptions_addr_G1, zoptions_addr_G2));

		//zoptions->ChangeDir(DIR_PRESETS);
		CALL_IntParam(_@(optionPath));
		CALL__thiscall(_@(zoptionsPtr), MEMINT_SwitchG1G2(zCOption__ChangeDir_G1, zCOption__ChangeDir_G2));

		call = CALL_End();
	};
};

/*
 *	zCOption_GetDirString
 */
func string zCOption_GetDirString(var int optionPath) {
	//0x00869694 class zCOption * zoptions
	const int zoptions_addr_G1 = 8820372;

	//0x008CD988 class zCOption * zoptions
	const int zoptions_addr_G2 = 9230728;

	//0x0045FC00 public: class zSTRING & __thiscall zCOption::GetDirString(enum zTOptionPaths)
	const int zCOption__GetDirString_G1 = 4586496;

	//0x00465260 public: class zSTRING & __thiscall zCOption::GetDirString(enum zTOptionPaths)
	const int zCOption__GetDirString_G2 = 4608608;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		var int zoptionsPtr; zoptionsPtr = MEM_ReadInt(MEMINT_SwitchG1G2(zoptions_addr_G1, zoptions_addr_G2));

		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(optionPath));
		CALL__thiscall(_@(zoptionsPtr), MEMINT_SwitchG1G2(zCOption__GetDirString_G1, zCOption__GetDirString_G2));
		call = CALL_End();
	};

	if (retVal) {
		return MEM_ReadString(retVal);
	};

	return STR_EMPTY;
};

//-- ZFILE_FILE functions

/*
 *	zFILE_FILE_GetByFilePath
 */
func int zFILE_FILE_GetByFilePath(var string filePath) {
	//0x0043F540 public: __thiscall zFILE_FILE::zFILE_FILE(class zSTRING const &)
	const int zFILE_FILE__zFILE_FILE_G1 = 4453696;

	//0x00443450 public: __thiscall zFILE_FILE::zFILE_FILE(class zSTRING const &)
	const int zFILE_FILE__zFILE_FILE_G2 = 4469840;

	//This does not work - we have to allocate memory by ourselves
	//var int ptr; ptr = CreateNewInstanceByString("zFILE_FILE");

	//Same for G1 & G2A
	const int sizeof_zFILE_FILE = 448;
	var int ptr; ptr = MEM_Alloc(sizeof_zFILE_FILE);

	CALL_zStringPtrParam(filePath);
	CALL__thiscall(ptr, MEMINT_SwitchG1G2(zFILE_FILE__zFILE_FILE_G1, zFILE_FILE__zFILE_FILE_G2));

	return + ptr;
};

/*
 *	zFILE_FILE_Exists
 */
func int zFILE_FILE_Exists(var int filePtr) {
	//0x0043F7A0 public: virtual bool __thiscall zFILE_FILE::Exists(void)
	const int zFILE_FILE__Exists_G1 = 4454304;

	//0x004436B0 public: virtual bool __thiscall zFILE_FILE::Exists(void)
	const int zFILE_FILE__Exists_G2 = 4470448;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_FILE__Exists_G1, zFILE_FILE__Exists_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_FILE_FileDelete
 */
func int zFILE_FILE_FileDelete(var int filePtr) {
	//0x00443880 public: virtual bool __thiscall zFILE_FILE::FileDelete(void)
	const int zFILE_FILE__FileDelete_G1 = 4470912;

	//0x004477E0 public: virtual bool __thiscall zFILE_FILE::FileDelete(void)
	const int zFILE_FILE__FileDelete_G2 = 4487136;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_FILE__FileDelete_G1, zFILE_FILE__FileDelete_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_FILE_Create
 */
func int zFILE_FILE_Create(var int filePtr) {
	//0x0043FAE0 public: virtual int __thiscall zFILE_FILE::Create(void)
	const int zFILE_FILE__Create_G1 = 4455136;

	//0x004439F0 public: virtual int __thiscall zFILE_FILE::Create(void)
	const int zFILE_FILE__Create_G2 = 4471280;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_FILE__Create_G1, zFILE_FILE__Create_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_FILE_Open
 */
func int zFILE_FILE_Open(var int filePtr, var int writeMode) {
	//0x0043FD80 public: virtual int __thiscall zFILE_FILE::Open(bool)
	const int zFILE_FILE__Open_G1 = 4455808;

	//0x00443C90 public: virtual int __thiscall zFILE_FILE::Open(bool)
	const int zFILE_FILE__Open_G2 = 4471952;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(writeMode));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_FILE__Open_G1, zFILE_FILE__Open_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_FILE_Append
 */
func void zFILE_FILE_Append(var int filePtr) {
	//0x00440350 public: virtual void __thiscall zFILE_FILE::Append(void)
	const int zFILE_FILE__Append_G1 = 4457296;

	//0x00444270 public: virtual void __thiscall zFILE_FILE::Append(void)
	const int zFILE_FILE__Append_G2 = 4473456;

	if (!filePtr) { return; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_FILE__Append_G1, zFILE_FILE__Append_G2));
		call = CALL_End();
	};

	return;
};

/*
 *	zFILE_FILE_Close
 */
func int zFILE_FILE_Close(var int filePtr) {
	//0x00440100 public: virtual int __thiscall zFILE_FILE::Close(void)
	const int zFILE_FILE__Close_G1 = 4456704;

	//0x00444010 public: virtual int __thiscall zFILE_FILE::Close(void)
	const int zFILE_FILE__Close_G2 = 4472848;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_FILE__Close_G1, zFILE_FILE__Close_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_FILE_Release
 */
func void zFILE_FILE_Release(var int filePtr) {
	//0x0043F670 public: virtual __thiscall zFILE_FILE::~zFILE_FILE(void)
	const int zFILE_FILE___zFILE_FILE_G1 = 4454000;

	//0x00443580 public: virtual __thiscall zFILE_FILE::~zFILE_FILE(void)
	const int zFILE_FILE___zFILE_FILE_G2 = 4470144;

	if (!filePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_FILE___zFILE_FILE_G1, zFILE_FILE___zFILE_FILE_G2));
		call = CALL_End();
	};

	MEM_Free(filePtr);
};

//-- zFILE_VDFS functions

/*
 *	zFILE_VDFS_GetByFilePath
 */
func int zFILE_VDFS_GetByFilePath(var string filePath) {
	//0x00444D90 public: __thiscall zFILE_VDFS::zFILE_VDFS(class zSTRING const &)
	const int zFILE_VDFS__zFILE_VDFS_G1 = 4476304;

	//0x00448E20 public: __thiscall zFILE_VDFS::zFILE_VDFS(class zSTRING const &)
	const int zFILE_VDFS__zFILE_VDFS_G2 = 4492832;

	//This does not work - we have to allocate memory by ourselves
	//var int ptr; ptr = CreateNewInstanceByString("zFILE_VDFS");

	//Same for G1 & G2A
	const int sizeof_zFILE_VDFS = 10808;
	var int ptr; ptr = MEM_Alloc(sizeof_zFILE_VDFS);

	CALL_zStringPtrParam(filePath);
	CALL__thiscall(ptr, MEMINT_SwitchG1G2(zFILE_VDFS__zFILE_VDFS_G1, zFILE_VDFS__zFILE_VDFS_G2));

	return + ptr;
};

/*
 *	zFILE_VDFS_Exists
 */
func int zFILE_VDFS_Exists(var int filePtr) {
	//0x00444F90 public: virtual bool __thiscall zFILE_VDFS::Exists(void)
	const int zFILE_VDFS__Exists_G1 = 4476816;

	//0x00449020 public: virtual bool __thiscall zFILE_VDFS::Exists(void)
	const int zFILE_VDFS__Exists_G2 = 4493344;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_VDFS__Exists_G1, zFILE_VDFS__Exists_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_VDFS_Open
 */
func int zFILE_VDFS_Open(var int filePtr, var int writeMode) {
	//0x00445090 public: virtual int __thiscall zFILE_VDFS::Open(bool)
	const int zFILE_VDFS__Open_G1 = 4477072;

	//0x00449120 public: virtual int __thiscall zFILE_VDFS::Open(bool)
	const int zFILE_VDFS__Open_G2 = 4493600;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(writeMode));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_VDFS__Open_G1, zFILE_VDFS__Open_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_VDFS_Close
 */
func int zFILE_VDFS_Close(var int filePtr) {
	//0x00445310 public: virtual int __thiscall zFILE_VDFS::Close(void)
	const int zFILE_VDFS__Close_G1 = 4477712;

	//0x004493A0 public: virtual int __thiscall zFILE_VDFS::Close(void)
	const int zFILE_VDFS__Close_G2 = 4494240;

	if (!filePtr) { return FALSE; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_VDFS__Close_G1, zFILE_VDFS__Close_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zFILE_VDFS_Release
 */
func void zFILE_VDFS_Release(var int filePtr) {
	//0x00444E40 public: virtual __thiscall zFILE_VDFS::~zFILE_VDFS(void)
	const int zFILE_VDFS___zFILE_VDFS_G1 = 4476480;

	//0x00448ED0 public: virtual __thiscall zFILE_VDFS::~zFILE_VDFS(void)
	const int zFILE_VDFS___zFILE_VDFS_G2 = 4493008;

	if (!filePtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(filePtr), MEMINT_SwitchG1G2(zFILE_VDFS___zFILE_VDFS_G1, zFILE_VDFS___zFILE_VDFS_G2));
		call = CALL_End();
	};

	MEM_Free(filePtr);
};

/*
 *	FileExists
 *	 - wrapper function checking if file exists
 */
func int FileExists(var string filePath) {
	var int retVal;
	var int filePtr; filePtr = zFILE_FILE_GetByFilePath(filePath);
	retVal = zFILE_FILE_Exists(filePtr);
	zFILE_FILE_Release(filePtr);
	return + retVal;
};
