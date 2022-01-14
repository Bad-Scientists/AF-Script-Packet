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
 *	Returns 1st Guild owner of portal room
 *	 - takes into consideration also guild of NPC if there is an NPC owner (lower prio than guild owner)
 */
func int Wld_PortalGetGuild (var string portalName) {
	if (!MEM_Game.portalMan) { return -1; };

	var oCPortalRoomManager portalMan; portalMan = _^ (MEM_Game.portalMan);
	var oCPortalRoom portalRoom;

	var int npcPtr;
	var int portalPtr;

	var oCNPC npc;
	var int guild; guild = -1;
	var int guildNPC; guildNPC = -1;

	var int i; i = 0;
	var int flagFound; flagFound = FALSE;

	while (i < portalMan.portals_numInArray);
		portalPtr = MEM_ReadIntArray (portalMan.portals_array, i);

		if (portalPtr) {
			portalRoom = _^ (portalPtr);

			if (Hlp_StrCmp (portalRoom.portalName, portalName)) {
				flagFound = TRUE;

				if (portalRoom.ownerGuild != -1) {
					if (guild == -1) { guild = portalRoom.ownerGuild; };
				} else {
					if (guildNPC == -1) {
						if (STR_Len (portalRoom.ownerNpc)) {
							npcPtr = MEM_SearchVobByName (portalRoom.ownerNpc);

							if (Hlp_Is_oCNpc (npcPtr)) {
								npc = _^ (npcPtr);
								if (Hlp_IsValidNPC (npc)) {
									guildNPC = npc.guild;
								};
							};
						};
					};
				};
			} else {
				//List of portal rooms is sorted alphabetically - so if we found it previously and now portal name is different - we can exit
				if (flagFound) { break; };
			};
		};

		i += 1;
	end;

	//If there is no guild assigned, return NPC guild
	if (guild == -1) { return guildNPC; };

	return guild;
};

/*
 *	Returns 1st NPC instance owner of portal room
 *	 - takes into consideration also guild of NPC if there is an NPC owner (lower prio than guild owner)
 */
func int Wld_PortalGetOwnerInstanceID (var string portalName) {
	if (!MEM_Game.portalMan) { return -1; };

	var oCPortalRoomManager portalMan; portalMan = _^ (MEM_Game.portalMan);
	var oCPortalRoom portalRoom;

	var int npcPtr;
	var int portalPtr;

	var oCNPC npc;

	var int i; i = 0;
	var int flagFound; flagFound = FALSE;

	while (i < portalMan.portals_numInArray);
		portalPtr = MEM_ReadIntArray (portalMan.portals_array, i);

		if (portalPtr) {
			portalRoom = _^ (portalPtr);

			if (Hlp_StrCmp (portalRoom.portalName, portalName)) {
				flagFound = TRUE;

				if (STR_Len (portalRoom.ownerNpc)) {
					npcPtr = MEM_SearchVobByName (portalRoom.ownerNpc);

					if (Hlp_Is_oCNpc (npcPtr)) {
						npc = _^ (npcPtr);
						if (Hlp_IsValidNPC (npc)) {
							return (Hlp_GetInstanceID (npc));
						};
					};
				};
			} else {
				//List of portal rooms is sorted alphabetically - so if we found it previously and now portal name is different - we can exit
				if (flagFound) { break; };
			};
		};

		i += 1;
	end;

	return -1;
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

/*
 *	Returns Vob portal guild's number
 *	 - either assigned via Wld_AssignRoomToGuild or Wld_AssignRoomToNpc (if only NPC was assigned)
 */
func int Vob_GetPortalGuild (var int vobPtr) {
	var int portalNamePtr; portalNamePtr = Vob_GetPortalNamePtr (vobPtr);

	if (portalNamePtr) {
		var string portalName; portalName = MEM_ReadString (portalNamePtr);
		return Wld_PortalGetGuild (portalName);
	};

	return -1;
};

/*
 *	Checks whether portal is owned by specific NPC
 */
func int Wld_PortalIsOwnedByNPC (var string portalName, var int slfInstance) {
	if (!MEM_Game.portalMan) { return 0; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return 0; };

	var oCPortalRoomManager portalMan; portalMan = _^ (MEM_Game.portalMan);
	var oCPortalRoom portalRoom;

	var int npcPtr;
	var int portalPtr;

	var oCNPC npc;

	var int i; i = 0;

	while (i < portalMan.portals_numInArray);
		portalPtr = MEM_ReadIntArray (portalMan.portals_array, i);

		if (portalPtr) {
			portalRoom = _^ (portalPtr);

			if (Hlp_StrCmp (portalRoom.portalName, portalName)) {
				if (STR_Len (portalRoom.ownerNpc)) {
					npcPtr = MEM_SearchVobByName (portalRoom.ownerNpc);

					if (Hlp_Is_oCNpc (npcPtr)) {
						npc = _^ (npcPtr);
						if (Hlp_GetInstanceID (npc) == Hlp_GetInstanceID (slf)) {
							return TRUE;
						};
					};
				};
			};

			i += 1;
		};
	end;

	return 0;
};

/*
 *	Checks whether portal is owned by specific guild
 */
func int Wld_PortalIsOwnedByGuild (var string portalName, var int guild) {
	if (!MEM_Game.portalMan) { return 0; };

	var oCPortalRoomManager portalMan; portalMan = _^ (MEM_Game.portalMan);
	var oCPortalRoom portalRoom;

	var int npcPtr;
	var int portalPtr;

	var oCNPC npc;

	var int i; i = 0;

	while (i < portalMan.portals_numInArray);
		portalPtr = MEM_ReadIntArray (portalMan.portals_array, i);

		if (portalPtr) {
			portalRoom = _^ (portalPtr);

			if (Hlp_StrCmp (portalRoom.portalName, portalName)) {
				//Is there an owner ?
				if (STR_Len (portalRoom.ownerNpc)) {
					npcPtr = MEM_SearchVobByName (portalRoom.ownerNpc);

					if (Hlp_Is_oCNpc (npcPtr)) {
						npc = _^ (npcPtr);
						if (npc.guild == guild) {
							return TRUE;
						};
					};
				};

				//check owner guild
				if (portalRoom.ownerGuild == guild) {
					return TRUE;
				};
			};

			i += 1;
		};
	end;

	return 0;
};

/*
 *	Code taken from szapps function Wld_PortalMergeDuplicates
 *	Original post: https://forum.worldofplayers.de/forum/threads/1495001-Scriptsammlung-ScriptBin/page7?p=26646175&viewfull=1#post26646175
 */
func void Wld_RoomRemoveNPC (var string portalName, var int slfInstance) {
	if (!MEM_Game.portalman) { return; };

	//Why zCMenu ?
	//0x004D1470 public: void __thiscall zCArraySort<class zCMenu *>::RemoveOrderIndex(int)
	const int zCArraySort_RemoveOrderIndex_G1 = 5051504; //0x4D1470
	const int zCArraySort_RemoveOrderIndex_G2 = 5104352; //0x4DE2E0

	//Destructor ?
	//0x006CA8D0 public: __thiscall oCPortalRoom::~oCPortalRoom(void)
	const int oCPortalRoom___oCPortalRoom_G1  = 7121104; //0x6CA8D0
	const int oCPortalRoom___oCPortalRoom_G2  = 7807568; //0x772250

	if (!MEM_Game.portalMan) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var oCPortalRoomManager portalMan; portalMan = _^ (MEM_Game.portalMan);
	var oCPortalRoom portalRoom;

	var int portalsArrPtr; portalsArrPtr = _@ (portalMan.portals_array);

	var int npcPtr;
	var int portalPtr;

	var oCNPC npc;

	var int i; i = 0;

	while (i < portalMan.portals_numInArray);
		portalPtr = MEM_ReadIntArray (portalMan.portals_array, i);

		if (portalPtr) {
			portalRoom = _^ (portalPtr);

			if (Hlp_StrCmp (portalRoom.portalName, portalName)) {
				if (STR_Len (portalRoom.ownerNpc)) {
					npcPtr = MEM_SearchVobByName (portalRoom.ownerNpc);

					if (Hlp_Is_oCNpc (npcPtr)) {
						npc = _^ (npcPtr);
						if (Hlp_GetInstanceID (npc) == Hlp_GetInstanceID (slf)) {
							const int call = 0;
							if (CALL_Begin(call)) {
								CALL_IntParam (_@(i));
								CALL__thiscall (_@(portalsArrPtr), MEMINT_SwitchG1G2 (zCArraySort_RemoveOrderIndex_G1, zCArraySort_RemoveOrderIndex_G2));
								CALL__thiscall (_@(portalPtr), MEMINT_SwitchG1G2 (oCPortalRoom___oCPortalRoom_G1, oCPortalRoom___oCPortalRoom_G2));
								call = CALL_End();
							};
						};
					};
				};
			};

			i += 1;
		};
	end;
};
