/*
 *	Sound.d
 *	 - allows you to play .WAV files directly - no requirement to create sound instances in SFX.D
 *	 - more importantly - functions playing sound return sound handles
 */

const int zSND_LOOPING_DEFAULT = 0;
const int zSND_LOOPING_ENABLED = 1;
const int zSND_LOOPING_DISABLED = 2;

//Global variables
var int zSound;
var int activeSndList;

func void MEM_InitSound () {
	//0x008CEE4C class zCSoundSystem * zsound
	const int zCSoundSystem__Address_G1 = 9236044;

	//0x0099B03C class zCSoundSystem * zsound
	const int zCSoundSystem__Address_G2 = 10072124;

	zSound = MEM_ReadInt (MEMINT_SwitchG1G2 (zCSoundSystem__Address_G1, zCSoundSystem__Address_G2));

	//0x008CEEBC class zCSoundManager * zsndMan
	//const int zCSoundManager__Address_G1 = 9236156;

	//0x0086D47C class zCMusicSystem * zmusic
	//const int zCMusicSystem__Address_G1 = 8836220;

	//0x0086D480 protected: static int zCMusicSystem::s_musicSystemDisabled
	//const int zCMusicSystem__s_musicSystemDisabled_G1 = 8836224;

	//0x0086DCEC private: static class zCActiveSnd * zCActiveSnd::nextFreeSnd
	//const int zCActiveSnd__nextFreeSnd_G1 = 8838380;

	//MEM_Info (IntToString (MEM_ReadInt (zCMusicSystem__s_musicSystemDisabled_G1)));
	//MEM_Info (IntToString (MEM_ReadInt (zCSoundManager__Address_G1)));
	//MEM_Info (IntToString (MEM_ReadInt (zCMusicSystem__Address_G1)));
	//MEM_Info (IntToString (MEM_ReadInt (zCActiveSnd__nextFreeSnd_G1)));

	//0x0086DCB8 private: static class zCArray<class zCActiveSnd *> zCActiveSnd::preAllocedSndList
	//const int zCActiveSnd__preAllocedSndList_G1 = 8838328;

	//0x008D2A20 private: static class zCArray<class zCActiveSnd *> zCActiveSnd::preAllocedSndList
	//const int zCActiveSnd__preAllocedSndList_G2 = 9251360;

	//var zCArray zCActiveSnd_preAllocedSndList;
	//zCActiveSnd_preAllocedSndList = _^ (MEMINT_SwitchG1G2 (zCActiveSnd__preAllocedSndList_G1, zCActiveSnd__preAllocedSndList_G2));


	//0x0086D700 public: static class zCArraySort<class zCActiveSnd *> zCActiveSnd::activeSndList
	const int zCActiveSnd__activeSndList_G1 = 8836864;

	//0x008D2198 public: static class zCArraySort<class zCActiveSnd *> zCActiveSnd::activeSndList
	const int zCActiveSnd__activeSndList_G2 = 9249176;

	activeSndList = MEMINT_SwitchG1G2 (zCActiveSnd__activeSndList_G1, zCActiveSnd__activeSndList_G2);
};

/*
 *	Stops all sound handles for an NPC
 */
func void oCNpc_StopAllVoices (var int slfInstance) {
	//0x0069AD30 public: void __thiscall oCNpc::StopAllVoices(void)
	const int oCNpc__StopAllVoices_G1 = 6925616;

	//0x0073E360 public: void __thiscall oCNpc::StopAllVoices(void)
	const int oCNpc__StopAllVoices_G2 = 7594848;

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int slfPtr; slfPtr = _@ (slf);

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (slfPtr), MEMINT_SwitchG1G2 (oCNpc__StopAllVoices_G1, oCNpc__StopAllVoices_G2));
		call = CALL_End();
	};
};

/*
 *	Function stops all sounds
 */
func void zCSndSys_MSS_StopAllSounds () {
	//0x004E46D0 public: virtual void __thiscall zCSndSys_MSS::StopAllSounds(void)
	const int zCSndSys_MSS__StopAllSounds_G1 = 5129936;

	//0x004F23C0 public: virtual void __thiscall zCSndSys_MSS::StopAllSounds(void)
	const int zCSndSys_MSS__StopAllSounds_G2 = 5186496;

	MEM_InitSound ();
	if (!Hlp_Is_zCSndSys_MSS (zSound)) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL__thiscall (_@ (zSound), MEMINT_SwitchG1G2 (zCSndSys_MSS__StopAllSounds_G1, zCSndSys_MSS__StopAllSounds_G2));
		call = CALL_End();
	};
};

/*
 *	Function loads .WAV file
 *	Returns pointer zCSoundFX*
 */
func int zCSndSys_MSS_LoadSoundFX (var string fileName) {
	//0x004E0370 public: virtual class zCSoundFX * __thiscall zCSndSys_MSS::LoadSoundFX(class zSTRING const &)
	const int zCSndSys_MSS__LoadSoundFX_G1 = 5112688;

	//0x004ED960 public: virtual class zCSoundFX * __thiscall zCSndSys_MSS::LoadSoundFX(class zSTRING const &)
	const int zCSndSys_MSS__LoadSoundFX_G2 = 5167456;

	MEM_InitSound ();
	if (!Hlp_Is_zCSndSys_MSS (zSound)) { return 0; };

	CALL_zStringPtrParam (fileName);
	CALL__thiscall (zSound, MEMINT_SwitchG1G2 (zCSndSys_MSS__LoadSoundFX_G1, zCSndSys_MSS__LoadSoundFX_G2));
	return CALL_RetValAsPtr ();
};

/*
 *	Function plays zCSoundFX*
 *	Returns sound handle
 */
func int zCSndSys_MSS_PlaySound (var int soundPtr, var int slot) {
	//0x004E2140 public: virtual int __thiscall zCSndSys_MSS::PlaySound(class zCSoundFX *,int)
	const int zCSndSys_MSS__PlaySound_G1 = 5120320;

	//0x004EF7B0 public: virtual int __thiscall zCSndSys_MSS::PlaySound(class zCSoundFX *,int)
	const int zCSndSys_MSS__PlaySound_G2 = 5175216;

	MEM_InitSound ();
	if (!Hlp_Is_zCSndSys_MSS (zSound)) { return 0; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (slot));
		CALL_PtrParam (_@ (soundPtr));
		CALL__thiscall (_@ (zSound), MEMINT_SwitchG1G2 (zCSndSys_MSS__PlaySound_G1, zCSndSys_MSS__PlaySound_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

/*
 *	Function plays 3D zCSoundFX* on specified vob - with additional parameters
 *	Returns sound handle
 */
func int zCSndSys_MSS_PlaySound3D_Ext (var int soundPtr, var int vobPtr, var int slot, var int sound3DParams) {
	//0x004E37D0 public: virtual int __thiscall zCSndSys_MSS::PlaySound3D(class zCSoundFX *,class zCVob *,int,struct zCSoundSystem::zTSound3DParams *)
	const int zCSndSys_MSS__PlaySound3D_G1 = 5126096;

	//0x004F10F0 public: virtual int __thiscall zCSndSys_MSS::PlaySound3D(class zCSoundFX *,class zCVob *,int,struct zCSoundSystem::zTSound3DParams *)
	const int zCSndSys_MSS__PlaySound3D_G2 = 5181680;

	MEM_InitSound ();
	if (!Hlp_Is_zCSndSys_MSS (zSound)) { return 0; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (sound3DParams));
		CALL_IntParam (_@ (slot));
		CALL_PtrParam (_@ (vobPtr));
		CALL_PtrParam (_@ (soundPtr));
		CALL__thiscall (_@ (zSound), MEMINT_SwitchG1G2 (zCSndSys_MSS__PlaySound3D_G1, zCSndSys_MSS__PlaySound3D_G2));
		call = CALL_End();
	};

	return CALL_RetValAsInt ();
};

/*
 *	zCActiveSnd_GetHandleSound
 *	 - function returns pointer to zCActiveSnd* for specified sound handle
 */
func int zCActiveSnd_GetHandleSound (var int soundHandle) {
	//0x004E8D90 public: static class zCActiveSnd * __cdecl zCActiveSnd::GetHandleSound(int)
	const int zCActiveSnd__GetHandleSound_G1 = 5148048;

	//0x004F6F40 public: static class zCActiveSnd * __cdecl zCActiveSnd::GetHandleSound(int)
	const int zCActiveSnd__GetHandleSound_G2 = 5205824;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_IntParam (_@ (soundHandle));
		CALL__cdecl (MEMINT_SwitchG1G2(zCActiveSnd__GetHandleSound_G1, zCActiveSnd__GetHandleSound_G2));
		call = CALL_End();
	};

	return CALL_RetValAsPtr ();
};

/*
 *	zCActiveSnd_RemoveSound
 *	 - function removes sound by sound pointer zCActiveSnd*
 */
func void zCActiveSnd_RemoveSound (var int activeSndPtr) {
	//0x004E9010 public: static void __cdecl zCActiveSnd::RemoveSound(class zCActiveSnd *)
	const int zCActiveSnd__RemoveSound_G1 = 5148688;

	//0x004F71A0 public: static void __cdecl zCActiveSnd::RemoveSound(class zCActiveSnd *)
	const int zCActiveSnd__RemoveSound_G2 = 5206432;

	if (!activeSndPtr) { return; };

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (activeSndPtr));
		CALL__cdecl (MEMINT_SwitchG1G2(zCActiveSnd__RemoveSound_G1, zCActiveSnd__RemoveSound_G2));
		call = CALL_End();
	};
};

/*
 *	Function will stop sound handle
 */
func void zCSndSys_MSS_StopSound (var int soundHandle) {
	//--> Not sure if I am using this one incorrectly - but it crashed everytime

	//0x004E4610 public: virtual void __thiscall zCSndSys_MSS::StopSound(int const &)
	//const int zCSndSys_MSS__StopSound_G1 = 5129744;

	//0x004F2300 public: virtual void __thiscall zCSndSys_MSS::StopSound(int const &)
	//const int zCSndSys_MSS__StopSound_G2 = 5186304;

	//MEM_InitSound ();
	//if (!Hlp_Is_zCSndSys_MSS (zSound)) { return; };

	//const int call = 0;
	//if (CALL_Begin (call)) {
	//	CALL_IntParam (_@ (soundHandle));
	//	CALL__thiscall (_@ (zSound), MEMINT_SwitchG1G2 (zCSndSys_MSS__StopSound_G1, zCSndSys_MSS__StopSound_G2));
	//	call = CALL_End();
	//};

	//<--

	var int activeSndPtr; activeSndPtr = zCActiveSnd_GetHandleSound (soundHandle);
	if (!activeSndPtr) { return; };
	zCActiveSnd_RemoveSound (activeSndPtr);
};

/*
 *	zCActiveSnd_UpdateSoundsByFrame
 *	 - function updates sound by pointer to zCSndFrame *
 */
func void zCActiveSnd_UpdateSoundsByFrame (var int sndFramePtr) {
	//0x004E93C0 public: static void __cdecl zCActiveSnd::UpdateSoundsByFrame(class zCSndFrame *)
	const int zCActiveSnd__UpdateSoundsByFrame_G1 = 5149632;

	//0x004F7540 public: static void __cdecl zCActiveSnd::UpdateSoundsByFrame(class zCSndFrame *)
	const int zCActiveSnd__UpdateSoundsByFrame_G2 = 5207360;

	const int call = 0;
	if (CALL_Begin (call)) {
		CALL_PtrParam (_@ (sndFramePtr));
		CALL__cdecl (MEMINT_SwitchG1G2(zCActiveSnd__UpdateSoundsByFrame_G1, zCActiveSnd__UpdateSoundsByFrame_G2));
		call = CALL_End();
	};
};

/*
 *	Function sets default values for zTSound3DParams object
 */
func void zTSound3DParams_SetDefaults (var int ptrParams) {
	//Default params
	var zTSound3DParams params;
	if (!ptrParams) { return; };
	params = _^ (ptrParams);

	const int zSND_RADIUS_DEFAULT	= -1;
	const int zSND_PITCH_DEFAULT	= -999999;

	//SetDefaults
	params.obstruction		= 0;
	params.volume			= 1;
	params.radius			= mkf (zSND_RADIUS_DEFAULT);
	params.loopType			= zSND_LOOPING_DEFAULT;
	params.coneAngleDeg		= 0;
	params.reverbLevel		= 1;
	params.isAmbient3D		= FALSE;
	params.pitchOffset		= mkf(zSND_PITCH_DEFAULT);
};

/*
 *	Function plays 3D zCSoundFX* on specified vob
 *	Returns sound handle
 */
func int zCSndSys_MSS_PlaySound3D (var int soundPtr, var int vobPtr) {
	var zTSound3DParams params;

	//This does not work
	//zTSound3DParams_SetDefaults (_@ (params));

	const int zSND_RADIUS_DEFAULT	= -1;
	const int zSND_PITCH_DEFAULT	= -999999;

	//SetDefaults
	params.obstruction		= 0;
	params.volume			= 1;
	params.radius			= mkf (zSND_RADIUS_DEFAULT);
	params.loopType			= zSND_LOOPING_DEFAULT;
	params.coneAngleDeg		= 0;
	params.reverbLevel		= 1;
	params.isAmbient3D		= FALSE;
	params.pitchOffset		= mkf(zSND_PITCH_DEFAULT);

	return +zCSndSys_MSS_PlaySound3D_Ext (soundPtr, vobPtr, 0, _@ (params));
};

/*
 *	Wrapper function for playing .WAV file
 *	Returns sound handle
 */
func int WAV_PlaySound (var string fileName, var int slot) {
	var int soundPtr; soundPtr = zCSndSys_MSS_LoadSoundFX (fileName);
	return +zCSndSys_MSS_PlaySound (soundPtr, slot);
};

/*
 *	Wrapper function for playing .WAV file in 3D
 *	Returns sound handle
 */
func int WAV_PlaySound3D (var string fileName, var int vobPtr) {
	var int soundPtr; soundPtr = zCSndSys_MSS_LoadSoundFX (fileName);
	return +zCSndSys_MSS_PlaySound3D (soundPtr, vobPtr);
};

/*
 *	Function loops thorugh list of active sounds and finds out, whether specified fileName or instance name is playing
 */
func int WAV_IsPlaying (var string fileOrInstName) {
	MEM_InitSound ();

	if (!activeSndList) { return FALSE; };

	var zCArray activeSndArray; activeSndArray = _^ (activeSndList);

	fileOrInstName = STR_Upper (fileOrInstName);

	var int i; i = 0;
	while (i < activeSndArray.numInArray);
		var int activeSndPtr; activeSndPtr = MEM_ArrayRead (activeSndList, i);
		if (activeSndPtr) {
			var zCActiveSnd activeSnd; activeSnd = _^ (activeSndPtr);
			//Active
			if (activeSnd.bitfield_zCActiveSnd & bitfield_zCActiveSnd_active) {
				if (activeSnd.sourceFrm) {
					var zCSndFrame sndFrame; sndFrame = _^ (activeSnd.sourceFrm);
					if ((Hlp_StrCmp (sndFrame.fileName, fileOrInstName)) || (Hlp_StrCmp (sndFrame.instance, fileOrInstName))) {
						return TRUE;
					};
				};
			};
		};

		i += 1;
	end;

	return FALSE;
};

/*
 *	Function loops through list of active sounds and returns a handle for fileName or instance name (if playing)
 */
func int WAV_GetSoundHandle (var string fileOrInstName) {
	MEM_InitSound ();

	if (!activeSndList) { return -1; };

	var zCArray activeSndArray; activeSndArray = _^ (activeSndList);

	fileOrInstName = STR_Upper (fileOrInstName);

	var int i; i = 0;
	while (i < activeSndArray.numInArray);
		var int activeSndPtr; activeSndPtr = MEM_ArrayRead (activeSndList, i);
		if (activeSndPtr) {
			var zCActiveSnd activeSnd; activeSnd = _^ (activeSndPtr);
			if (activeSnd.sourceFrm) {
				var zCSndFrame sndFrame; sndFrame = _^ (activeSnd.sourceFrm);
				if ((Hlp_StrCmp (sndFrame.fileName, fileOrInstName)) || (Hlp_StrCmp (sndFrame.instance, fileOrInstName))) {
					return activeSnd.handle;
				};
			};
		};

		i += 1;
	end;

	return -1;
};

/*
 *	Wrapper function for playing .WAV file on NPC
 *	Sound handle is inserted into NPCs listOfVoiceHandles_array
 */
func void NPC_WAV_PlaySound (var int slfInstance, var string fileName) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int soundHandle;

	soundHandle = WAV_PlaySound (fileName, 0);
	MEM_ArrayInsert (_@ (slf.listOfVoiceHandles_array), soundHandle);
};

/*
 *	Wrapper function for playing .WAV file on NPC in 3D
 *	Sound handle is inserted into NPCs listOfVoiceHandles_array
 */
func void NPC_WAV_PlaySound3D (var int slfInstance, var string fileName) {
	var oCNpc slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int soundHandle;

	soundHandle = WAV_PlaySound3D (fileName, _@ (slf));
	MEM_ArrayInsert (_@ (slf.listOfVoiceHandles_array), soundHandle);
};
