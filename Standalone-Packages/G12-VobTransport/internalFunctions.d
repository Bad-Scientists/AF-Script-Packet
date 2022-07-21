/*
 *	Custom function recognizing Vobs that can be moved around
 */
func int Hlp_Is_zCVob__vobTransport (var int vobPtr) {
	if (!vobPtr) { return FALSE; };

	//0x007DB44C const zCVob::`vftable'
	//const int zCVob_vtbl_G1 = 8238156;

	//0x0083997C const zCVob::`vftable'
	//const int zCVob_vtbl_G2 = 8624508;

	//
	//if (MEM_ReadInt (vobPtr) == MEMINT_SwitchG1G2 (zCVob_vtbl_G1, zCVob_vtbl_G2)) {

	if (Hlp_Is_zCVob (vobPtr)) {
		//Not yet supported
		if (Hlp_Is_zCParticleFX (vobPtr)) { return FALSE; };

		//All other zCVob objects should be supported
		//MEM_Info (IntToString (MEM_ReadInt (vobPtr)));
		//return TRUE;

		var zCVob vob; vob = _^ (vobPtr);
		if (vob.type == 0) {
			/*
			enum zTVobType {
			zVOB_TYPE_NORMAL,		//0
			zVOB_TYPE_LIGHT,		//1
			zVOB_TYPE_SOUND,		//2
			zVOB_TYPE_LEVEL_COMPONENT,	//3
			zVOB_TYPE_SPOT,			//4
			zVOB_TYPE_CAMERA,		//5
			zVOB_TYPE_STARTPOINT,		//6
			zVOB_TYPE_WAYPOINT,		//7
			zVOB_TYPE_MARKER,		//8
			zVOB_TYPE_SEPARATOR = 127,
			zVOB_TYPE_MOB,			//128
			zVOB_TYPE_ITEM,			//129
			zVOB_TYPE_NSC			//130
			*/

			//Ignore all vobs without visual (I noticed weird behaviour - game crashed sometimes - not sure what kind of vobs these are :-/)
			//Camera vob ...
			var string visualName; visualName = Vob_GetVisualName (vobPtr);
			if (STR_Len (visualName)) {
				return TRUE;
			};
		};
	};

	return FALSE;
};
