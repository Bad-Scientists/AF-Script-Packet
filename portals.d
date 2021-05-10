/*
 *	Taken from scripts created by: szapp (mud-freak)
 *	Original post: https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page7?p=26646175&viewfull=1#post26646175
 *
 *	Why these different functions:
 *	I don't necesarily think that assigning portal room to multiple NPCs or Guilds is an error ... it might be a nifty feature :)
 *
 *	Requires also:
 *		vobFunctions.d
 */

/*
 *	Returns pointer to portal room name string!
 */
func int Vob_GetPortalNamePtr (var int vobPtr) {
	//0x005D5690 public: class zSTRING const * __thiscall zCVob::GetSectorNameVobIsIn(void)const 
	const int zCVob__GetSectorNameVobIsIn_G1             = 6117008;

	//0x00600AE0 public: class zSTRING const * __thiscall zCVob::GetSectorNameVobIsIn(void)const 
	const int zCVob__GetSectorNameVobIsIn_G2             = 6294240;

	//In G1 item is no longer physically in the room, when called from B_AssessTheft ?! because of that function does not return portal room pointer
	//Sooo here I am using dirty solution, which szapp did not recommend as it might cause issues ... but so far I didn't recognize any
	//I am a simple man ... give me working a workaround and I wont get to proper solution :)

	if (!vobPtr) { return 0; };

	//--> Dirty workaround: Insert temporarily Vob at last position of vobPtr
	var zCVob vob; vob = _^ (vobPtr);
	var string visualName; visualName = Vob_GetVisualName (vobPtr);
	vobPtr = InsertObject ("zCVob", "", visualName, _@ (vob.trafoObjToWorld), 0);
	//<--

	var int sectorNamePtr; sectorNamePtr = 0;

	const int call = 0;
	if (CALL_Begin(call)) {
		CALL_PutRetValTo(_@(sectorNamePtr));
		CALL__thiscall(_@(vobPtr), MEMINT_SwitchG1G2 (zCVob__GetSectorNameVobIsIn_G1, zCVob__GetSectorNameVobIsIn_G2));
		call = CALL_End();
	};

	//--> remove our temporary vob
	RemoveoCVobSafe (vobPtr, 0);
	//<--
	return +sectorNamePtr;
};

/*
 *	Returns Vob portal name
 */
func string Vob_GetPortalName (var int vobPtr) {
	var int portalNamePtr; portalNamePtr = Vob_GetPortalNamePtr (vobPtr);

	if (portalNamePtr) {
		var string portalName; portalName = MEM_ReadString (portalNamePtr);
		return portalName;
	};

	return "";
};
