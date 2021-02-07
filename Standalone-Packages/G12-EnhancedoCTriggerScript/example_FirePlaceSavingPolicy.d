/*
 *	This example demonstrates how you can use _OnTouch and _OnUnTouch events with oCTriggerScript object.
 *
 *	It does not contain anything that would prevent user from saving game.
 *	You can find code that will allow you to enable/disable saving here:
 *	Author: Sektenspinner
 *	https://forum.worldofplayers.de/forum/threads/790720-Scriptpaket-Zugriff-auf-ZenGine-Objekte/page2?p=12449815&viewfull=1#post12449815
 */
 
/*
 *	Example for _OnTouch event function
 *		this one will be called whenever object touches oCTriggerScript
 */
func void FirePlace_Saving_OnTouch (var int triggerPtr, var int vobPtr) {
	if (Hlp_Is_oCNpc (vobPtr)) {
		var oCNPC slf; slf = _^ (vobPtr);
		if (NPC_IsPlayer (slf)) {
			//Enable saving here
		};
	};
};

/*
 *	Example for OnUnTouch event function
 *		this one will be called whenever object leaves oCTriggerScript
 */
func void FirePlace_Saving_OnUnTouch (var int triggerPtr, var int vobPtr) {
	if (Hlp_Is_oCNpc (vobPtr)) {
		var oCNPC slf; slf = _^ (vobPtr);
		if (NPC_IsPlayer (slf)) {
			//Disable saving here
		};
	};
};

/*
 *	Dummy function, that will be called be engine 
 *		we don't need it for this exmple
 */
func void FirePlace_Saving () {
};

/*
 *	This function will add oCTriggerScript objects to every fireplace in your world, call it from Startup_ function:
 *
 *		func void startup_world () {
 *			FirePlace_AddSavingPolicy ();
 *		};
 *
 */
func void FirePlace_AddSavingPolicy () {
	var int vobPtr;
	
	var oCMobFire mob;
	var string mobVisualName;

	//Create array
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	//Fill array with oCMobFire objects
	if (MEMINT_SwitchG1G2 (1, 0)) {
		if (!SearchVobsByClass ("oCMobFire", vobListPtr)) {
			MEM_Info ("No oCMobFire objects found.");
			return;
		};
	} else {
		//Search by zCVisual or zCParticleFX does not work
		if (!SearchVobsByClass ("zCVob", vobListPtr)) {
			MEM_Info ("No zCVisual objects found.");
			return;
		};
	};

	var int counter; counter = 0;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var string triggerName;
	var int ptr;
	var oCTriggerScript ts;

	//Loop through all oCMobFire objects
	var int i; i = 0;
	var int count; count = vobList.numInArray;
	
	var int flagFound;

	//we have to use separate variable here for count
	while(i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);
		mobVisualName = Vob_GetVisualName (vobPtr);

		flagFound = FALSE;

		if (MEMINT_SwitchG1G2 (1, 0)) {
			//G1 example
			if (Hlp_StrCmp (mobVisualName, "FIREPLACE_GROUND.ASC"))		//oCMobFire
			|| (Hlp_StrCmp (mobVisualName, "FIREPLACE_GROUND2.ASC"))	//oCMobFire
			//|| (Hlp_StrCmp (mobVisualName, "BARBQ_SCAV.MDS"))		//oCMobInter!
			{
				flagFound = TRUE;
			};
		} else {
			//G2A example
			if (Hlp_StrCmp (mobVisualName, "NW_MISC_FIREPLACE_01.3DS"))	//zCVob
			{
				flagFound = TRUE;
			};
		};

		if (flagFound) {
			counter += 1;
			
			mob = _^ (vobPtr);

			triggerName = ConcatStrings ("FIREPLACE_SAVING", IntToString (counter));
			ptr = InsertTriggerScript (triggerName, _@ (mob._zCVob_trafoObjToWorld));

			ts = _^ (ptr);

			ts._zCTrigger_numCanBeActivated = -1;
			ts._zCTrigger_countCanBeActivated = -1;

			//Coby BBox from oCMobFire
			MEM_CopyBytes(vobPtr + 124, ptr + 124, 12);	//_zCVob_bbox3D_mins
			MEM_CopyBytes(vobPtr + 136, ptr + 136, 12);	//_zCVob_bbox3D_maxs

			//Enlarge BBox
			var int dir[3];
			var int posFirePlace[3];

			//Get position of oCMobFire
			TrfToPos (_@ (mob._zCVob_trafoObjToWorld), _@ (posFirePlace));

			//subtract BBox pos from oCMobFire pos - to get 'direction vector' from middle of oCMobFire to _zCVob_bbox3D_mins
			subVectors (_@ (dir), _@(posFirePlace), _@ (ts._zCVob_bbox3D_mins));

			//multiply by 2 (will result in a BBox 3 times bigger than oCMobFire BBox)
			mulVector (_@ (dir), mkf (2));

			//subtract direction vector from oCMobFire _zCVob_bbox3D_mins pos --> this will enlarge BBox
			subVectors (_@ (ts._zCVob_bbox3D_mins), _@ (ts._zCVob_bbox3D_mins), _@ (dir));

			//---

			//subtract BBox pos from oCMobFire pos - to get 'direction vector' from middle of oCMobFire to _zCVob_bbox3D_maxs
			subVectors (_@ (dir), _@(posFirePlace), _@ (ts._zCVob_bbox3D_maxs));
			
			//multiply by 2 (will result in a BBox 3 times bigger than oCMobFire BBox)
			mulVector (_@ (dir), mkf (2));

			//subtract direction vector from oCMobFire _zCVob_bbox3D_maxs pos --> this will enlarge BBox
			subVectors (_@ (ts._zCVob_bbox3D_maxs), _@ (ts._zCVob_bbox3D_maxs), _@ (dir));

			//Enable BBox - only for visual demonstration :)
			ts._zCVob_bitfield[0] = ts._zCVob_bitfield[0] | zCVob_bitfield0_drawBBox3D;
			
			ts._zCTrigger_bitfield = ts._zCTrigger_bitfield | zCTrigger_bitfield_reactToOnTouch | zCTrigger_bitfield_callEventFuncs;
			
			ts._zCTrigger_fireDelaySec = divf(mkf(1), mkf(100));
			ts._zCTrigger_retriggerWaitSec = divf(mkf(1), mkf(100));

			ts.scriptFunc = "FirePlace_Saving";
		};

		i += 1;
	end;

	//Free array
	MEM_ArrayFree (vobListPtr);
};
