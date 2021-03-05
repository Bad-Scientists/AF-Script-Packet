/*
 *	This example demonstrates usage of new oCTriggerScript feature: _OnContact event 
 *
 *	Script uses 2 effects: VOB_BURN_LEFTFOOT & VOB_BURN_RIGHTFOOT which you have to add to your mod manually.
 *	You can find them in folder:
 *		Resources\Scripts\system\VISUALFX\visualFX_VOB_BURN_LEFTFOOT.d
 *		Resources\Scripts\system\VISUALFX\visualFX_VOB_BURN_RIGHTFOOT.d
 *
 *	+ You need to add to your PFX this effect:
 *		Resources\Scripts\system\PFX\pfx_MFX_FIRESPELL_HUMANBURN_TINY.d
 */

/*
 *	Example for _OnTouch event function
 *		this one will not be called, because in this example I am using flag zCTrigger_bitfield_reactToOnContact (replaces both _OnTouch and _OnTrigger event functions)
 */
func void FirePlace_FireDamage_ApplyDamage_OnTouch (var int triggerPtr, var int vobPtr) {
};

/*
 *	Example for _OnTrigger event function
 *		this one will not be called, because in this example I am using flag zCTrigger_bitfield_reactToOnContact (replaces both _OnTouch and _OnTrigger event functions)
 */
func void FirePlace_FireDamage_ApplyDamage_OnTrigger (var int triggerPtr) {
};

/*
 *	Example for _OnContact event function
 *		this function will be called in a loop with delay of oCTriggerScript._zCTrigger_fireDelaySec every time an object touches trigger
 */
func void FirePlace_FireDamage_ApplyDamage_OnContact (var int triggerPtr) {
	if (!triggerPtr) {
		return;
	};

	//Get Trigger Position
	var int tPos[3];
	var zCTrigger t; t = _^ (triggerPtr);

	TrfToPos (_@ (t._zCVob_trafoObjToWorld), _@ (tPos));

	//Loop through all vobs in touchVobList
	var int count; count = t._zCVob_touchVobList_numInArray;

	if (count > 0) {
		var int bitsBackup;

		var int vobPtr;
		var int i; i = 0;

		var int pos[3]; var int dir[3];
		var int dist;

		//we have to use separate variable here for count
		while(i < count);
			//Read vob pointer from touchVobList array
			vobPtr = MEM_ReadIntArray(t._zCVob_touchVobList_array, i);

			//Is it item?
			if (Hlp_Is_oCItem (vobPtr)) {
				var int amount; amount = 0;
				var oCItem itm; itm = _^ (vobPtr);

				if (Hlp_IsValidItem (itm)) {
					amount = itm.amount;

					//Get item position and direction (rotation)
					trfPosToVector (_@ (itm._zCVob_trafoObjToWorld), _@ (pos));
					trfDirToVector (_@ (itm._zCVob_trafoObjToWorld), _@ (dir));
					
					//Get distance
					dist = getVectorDistXZ (_@ (pos), _@ (tPos));

					//If close enough --> then replace with cooked meat
					if (lef (dist, mkf (90))) {
						if (Hlp_GetinstanceID (itm) == ItFoMuttonRaw) {
							//Ignore moving items
							if (!(itm._zCVob_bitfield[1] & zCVob_bitfield1_isInMovementMode)) {
								//remove bitfields - this will temporarily disable trigger
								//we have to disable it otherwise Wld_RemoveItem will cause infinite loop when removing item from world
								bitsBackup = t.bitfield;
								t.bitfield = 0;

								//Remove item from world
								Wld_RemoveItem (itm);

								//Insert new item to same position
								InsertItemPos ("ItFoMutton", amount, _@ (pos), _@ (dir));

								//restore bitfields
								t.bitfield = bitsBackup;
							};
						};
					};
				};
			};

			//Is it NPC ?
			if (Hlp_Is_oCNPC (vobPtr)) {
				var oCNpc slf; slf = _^ (vobPtr);

				//Safety check
				if (Hlp_IsValidNPC (slf)) {

					//Get NPC position
					TrfToPos (_@ (slf._zCVob_trafoObjToWorld), _@ (pos));

					//Get distance
					dist = getVectorDistXZ (_@ (pos), _@ (tPos));

					//If close enough --> then burn victim
					if (lef (dist, mkf (90))) {
						//If NPC is not dead
						if (!NPC_IsDead (slf)) {
							//NPC - dodge fire place
							if (!NPC_IsPlayer (slf)) {
								AI_TurnToVobPtr (slf, triggerPtr);
								AI_Dodge (slf);
							};

							//Play T_STUMBLE ani
							NPC_PlayAni (slf, "T_STUMBLE");

							//Add effect for burning legs :)
							Wld_PlayEffect ("VOB_BURN_LEFTFOOT", slf, slf, 0, 0, 0, FALSE);
							Wld_PlayEffect ("VOB_BURN_RIGHTFOOT", slf, slf, 0, 0, 0, FALSE);

							//Hurt NPC
							slf.attribute [ATR_HITPOINTS] -= 3;
						};
					};
				};
			};

			i += 1;
		end;
	};
};

/*
 *	Example for _OnUntouch event function
 *		this one will be called, but we don't need it for this example
 */
func void FirePlace_FireDamage_ApplyDamage_OnUntouch (var int triggerPtr, var int vobPtr) {
};

/*
 *	Dummy function, that will be called be engine 
 *		we don't need it for this exmple
 */
func void FirePlace_FireDamage_ApplyDamage () {
};

/*
 *	This function will add oCTriggerScript objects to every fireplace in your world, call it from Startup_ function:
 *
 *		func void startup_world () {
 *			FirePlace_AddFireDamageTriggers ();
 *		};
 *
 */
func void FirePlace_AddFireDamageTriggers () {
	var int vobPtr;
	
	var oCMob mob;
	var string mobVisualName;

	//Create array
	var int vobListPtr; vobListPtr = MEM_ArrayCreate ();

	//Fill array with oCMob objects
//	if (MEMINT_SwitchG1G2 (1, 0)) {
//		if (!SearchVobsByClass ("oCMOB", vobListPtr)) {	//CASE sensitive!
//			MEM_Info ("No oCMOB objects found.");
//			return;
//		};
//	} else {
		//Search by zCVisual or zCParticleFX does not work
		if (!SearchVobsByClass ("zCVob", vobListPtr)) {
			MEM_Info ("No zCVisual objects found.");
			return;
		};
//	};
	
	var int counter; counter = 0;
	var zCArray vobList; vobList = _^ (vobListPtr);

	var string triggerName;
	var int ptr;
	var oCTriggerScript ts;

	//Loop through all objects
	var int i; i = 0;
	var int count; count = vobList.numInArray;

	var int flagFound;
	
	//we have to use separate variable here for count
	while(i < count);
		//Read vobPtr from vobList array
		vobPtr = MEM_ArrayRead (vobListPtr, i);

		//Get visual name
		mobVisualName = Vob_GetVisualName (vobPtr);

		flagFound = FALSE;
		if (MEMINT_SwitchG1G2 (1, 0)) {
			//G1 example
			//FIREPLACE_GROUND.ASC
			if (Hlp_StrCmp (mobVisualName, "FIREPLACE_GROUND.ASC"))		//oCMobFire
			|| (Hlp_StrCmp (mobVisualName, "FIREPLACE_GROUND2.ASC"))	//oCMobFire
			|| (Hlp_StrCmp (mobVisualName, "BARBQ_SCAV.MDS"))		//oCMobInter!
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
			
			triggerName = ConcatStrings ("FIREPLACE_TRIGGERFIREDAMAGE", IntToString (counter));
			ptr = InsertTriggerScript (triggerName, _@ (mob._zCVob_trafoObjToWorld));

			ts = _^ (ptr);

			ts._zCTrigger_numCanBeActivated = -1;
			ts._zCTrigger_countCanBeActivated = -1;

			//Coby BBox from oCMobFire
			MEM_CopyBytes(vobPtr + 124, ptr + 124, 12);	//_zCVob_bbox3D_mins
			MEM_CopyBytes(vobPtr + 136, ptr + 136, 12);	//_zCVob_bbox3D_maxs

			//Enable BBox - only for visual demonstration :)
			ts._zCVob_bitfield[0] = ts._zCVob_bitfield[0] | zCVob_bitfield0_drawBBox3D;
			
			ts._zCTrigger_bitfield = ts._zCTrigger_bitfield | zCTrigger_bitfield_reactToOnContact | zCTrigger_bitfield_callEventFuncs;
			
			ts._zCTrigger_fireDelaySec = divf(mkf(8), mkf(10));
			ts._zCTrigger_retriggerWaitSec = divf(mkf(8), mkf(10));

			ts.scriptFunc = "FirePlace_FireDamage_ApplyDamage";
		};

		i += 1;
	end;

	//Free array
	MEM_ArrayFree (vobListPtr);
};
