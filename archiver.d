/*
 *	Archiver functions
 */
const int zARC_FLAG_WRITE_HEADER = 0;
const int zARC_FLAG_WRITE_BRIEF_HEADER = 1;
const int zARC_FLAG_NO_SPY_MESSAGES = 2;

const int zARC_MODE_BINARY = 0;
const int zARC_MODE_ASCII = 1;
const int zARC_MODE_ASCII_PROPS = 2;
const int zARC_MODE_BINARY_SAFE = 3;

/*
 *	zCArchiverFactory_CreateArchiverFromMode
 */
func int zCArchiverFactory_CreateArchiverFromMode(var int archiveMode)
{
	//0x0086F9AC class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G1 = 8845740;

	//0x008D472C class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G2 = 9258796;

	//0x0050ACC0 private: class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverFromMode(enum zTArchiveMode)
	const int zCArchiverFactory__CreateArchiverFromMode_G1 = 5287104;

	//0x0051ACD0 private: class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverFromMode(enum zTArchiveMode)
	const int zCArchiverFactory__CreateArchiverFromMode_G2 = 5352656;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(archiveMode));
		CALL__thiscall(MEMINT_SwitchG1G2(zarcFactory_addr_G1, zarcFactory_addr_G2), MEMINT_SwitchG1G2(zCArchiverFactory__CreateArchiverFromMode_G1, zCArchiverFactory__CreateArchiverFromMode_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCArchiverFactory_CreateArchiverWrite_FileName
 */
func int zCArchiverFactory_CreateArchiverWrite_FileName(var string fileName, var int archiveMode, var int saveGame, var int arcFlags)
{
	//0x0086F9AC class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G1 = 8845740;

	//0x008D472C class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G2 = 9258796;

	//0x0050AF80 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverWrite(class zSTRING const &,enum zTArchiveMode,int,int)
	const int zCArchiverFactory__CreateArchiverWrite_G1 = 5287808;

	//0x0051AF20 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverWrite(class zSTRING const &,enum zTArchiveMode,int,int)
	const int zCArchiverFactory__CreateArchiverWrite_G2 = 5353248;

	CALL_IntParam(arcFlags);
	CALL_IntParam(saveGame);
	CALL_IntParam(archiveMode);
	CALL_zStringPtrParam(fileName);
	CALL__thiscall(MEMINT_SwitchG1G2(zarcFactory_addr_G1, zarcFactory_addr_G2), MEMINT_SwitchG1G2(zCArchiverFactory__CreateArchiverWrite_G1, zCArchiverFactory__CreateArchiverWrite_G2));

	return + CALL_RetValAsPtr();
};

/*
 *	zCArchiverFactory_CreateArchiverWrite
 */
func int zCArchiverFactory_CreateArchiverWrite(var int filePtr, var int archiveMode, var int saveGame, var int arcFlags)
{
	//0x0086F9AC class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G1 = 8845740;

	//0x008D472C class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G2 = 9258796;

	//0x0050B000 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverWrite(class zFILE *,enum zTArchiveMode,int,int)
	const int zCArchiverFactory__CreateArchiverWrite_G1 = 5287936;

	//0x0051AFA0 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverWrite(class zFILE *,enum zTArchiveMode,int,int)
	const int zCArchiverFactory__CreateArchiverWrite_G2 = 5353376;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(arcFlags));
		CALL_IntParam(_@(saveGame));
		CALL_IntParam(_@(archiveMode));
		CALL_PtrParam(_@(filePtr));
		CALL__thiscall(MEMINT_SwitchG1G2(zarcFactory_addr_G1, zarcFactory_addr_G2), MEMINT_SwitchG1G2(zCArchiverFactory__CreateArchiverWrite_G1, zCArchiverFactory__CreateArchiverWrite_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCArchiverFactory_CreateArchiverRead_FileName
 */
func int zCArchiverFactory_CreateArchiverRead_FileName(var string fileName, var int arcFlags)
{
	//0x0086F9AC class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G1 = 8845740;

	//0x008D472C class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G2 = 9258796;

	//0x0050A2B0 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverRead(class zSTRING const &,int)
	const int zCArchiverFactory__CreateArchiverRead_G1 = 5284528;

	//0x0051A120 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverRead(class zSTRING const &,int)
	const int zCArchiverFactory__CreateArchiverRead_G2 = 5349664;

	CALL_IntParam(arcFlags);
	CALL_zStringPtrParam(fileName);
	CALL__thiscall(MEMINT_SwitchG1G2(zarcFactory_addr_G1, zarcFactory_addr_G2), MEMINT_SwitchG1G2(zCArchiverFactory__CreateArchiverRead_G1, zCArchiverFactory__CreateArchiverRead_G2));

	return + CALL_RetValAsPtr();
};

/*
 *	zCArchiverFactory_CreateArchiverRead
 */
func int zCArchiverFactory_CreateArchiverRead(var int filePtr, var int arcFlags)
{
	//0x0086F9AC class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G1 = 8845740;

	//0x008D472C class zCArchiverFactory zarcFactory
	const int zarcFactory_addr_G2 = 9258796;

	//0x0050A240 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverRead(class zFILE *,int)
	const int zCArchiverFactory__CreateArchiverRead_G1 = 5284416;

	//0x0051A0B0 public: virtual class zCArchiver * __thiscall zCArchiverFactory::CreateArchiverRead(class zFILE *,int)
	const int zCArchiverFactory__CreateArchiverRead_G2 = 5349552;

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL_IntParam(_@(arcFlags));
		CALL_PtrParam(_@(filePtr));
		CALL__thiscall(MEMINT_SwitchG1G2(zarcFactory_addr_G1, zarcFactory_addr_G2), MEMINT_SwitchG1G2(zCArchiverFactory__CreateArchiverRead_G1, zCArchiverFactory__CreateArchiverRead_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCArchiverGeneric_WriteObject
 */
func void zCArchiverGeneric_WriteObject(var int archiverPtr, var int objectPtr)
{
	//0x00514310 public: virtual void __fastcall zCArchiverGeneric::WriteObject(class zCObject *)
	const int zCArchiverGeneric__WriteObject_G1 = 5325584;

	//0x00524EC0 public: virtual void __fastcall zCArchiverGeneric::WriteObject(class zCObject *)
	const int zCArchiverGeneric__WriteObject_G2 = 5394112;

	if (!archiverPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__fastcall(_@(archiverPtr), _@(objectPtr), MEMINT_SwitchG1G2(zCArchiverGeneric__WriteObject_G1, zCArchiverGeneric__WriteObject_G2));
		call = CALL_End();
	};
};

/*
 *	zCArchiverGeneric_EndOfArchive
 */
func int zCArchiverGeneric_EndOfArchive(var int archiverPtr)
{
	//0x00512200 public: virtual int __fastcall zCArchiverGeneric::EndOfArchive(void)
	const int zCArchiverGeneric__EndOfArchive_G1 = 5317120;

	//0x00522650 public: virtual int __fastcall zCArchiverGeneric::EndOfArchive(void)
	const int zCArchiverGeneric__EndOfArchive_G2 = 5383760;

	if (!archiverPtr) { return 0; };

	var int retVal;
	
	const int null = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__fastcall(_@(archiverPtr), _@(null), MEMINT_SwitchG1G2(zCArchiverGeneric__EndOfArchive_G1, zCArchiverGeneric__EndOfArchive_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCArchiverGeneric_ReadObject
 */
func int zCArchiverGeneric_ReadObject(var int archiverPtr, var int objectPtr)
{
	//0x005161B0 public: virtual class zCObject * __fastcall zCArchiverGeneric::ReadObject(class zCObject *)
	const int zCArchiverGeneric__ReadObject_G1 = 5333424;

	//0x00526DF0 public: virtual class zCObject * __fastcall zCArchiverGeneric::ReadObject(class zCObject *)
	const int zCArchiverGeneric__ReadObject_G2 = 5402096;

	if (!archiverPtr) { return 0; };

	var int retVal;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(retVal));
		CALL__fastcall(_@(archiverPtr), _@(objectPtr), MEMINT_SwitchG1G2(zCArchiverGeneric__ReadObject_G1, zCArchiverGeneric__ReadObject_G2));
		call = CALL_End();
	};

	return + retVal;
};

/*
 *	zCArchiverGeneric_Close
 */
func void zCArchiverGeneric_Close(var int archiverPtr)
{
	//0x00512080 public: virtual void __thiscall zCArchiverGeneric::Close(void)
	const int zCArchiverGeneric__Close_G1 = 5316736;

	//0x00522470 public: virtual void __thiscall zCArchiverGeneric::Close(void)
	const int zCArchiverGeneric__Close_G2 = 5383280;

	if (!archiverPtr) { return; };

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL__thiscall(_@(archiverPtr), MEMINT_SwitchG1G2(zCArchiverGeneric__Close_G1, zCArchiverGeneric__Close_G2));
		call = CALL_End();
	};
};
