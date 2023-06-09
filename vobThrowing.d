/*
 *	Vob throwing functions
 */

/*
 *	Vob_ThrowAngle
 */
func void Vob_ThrowAngle (var int vobPtr, var int posPtr, var int dirPtr, var int angle, var int velocity) {
	if (!vobPtr) { return; };

	var int dir[3];
	if (dirPtr) {
		MEM_CopyBytes (dirPtr, _@ (dir), 12);
	} else {
		//If direction was not provided - default values
		dir[0] = FLOATNULL;
		dir[1] = FLOATNULL;
		dir[2] = FLOATNULL;
	};

	//X axis rotation, in order to turn vector up we have to use negative value for angle
	var int trafoRot[16]; NewTrafo (_@(trafoRot));
	VectorDirToTrf (_@ (dir), _@ (trafoRot));
	zMAT4_PostRotateX (_@ (trafoRot), negf (mkf (angle)));
	TrfDirToVector (_@ (trafoRot), _@ (dir));

	NormalizeVector (_@ (dir));
	MulVector (_@ (dir), mkf (velocity));

	//Set physics enabled
	zCVob_SetPhysicsEnabled (vobPtr, 1);
	zCVob_SetSleeping (vobPtr, 0);

	//Apply 'velocity'
	var int rigidBodyPtr; rigidBodyPtr = zCVob_GetRigidBody (vobPtr);
	zCRigidBody_SetVelocity (rigidBodyPtr, _@ (dir));
};

/*
 *	Vob_ThrowFromPosToPos
 *	 - function throws item from fromPosPtr to targetPosPtr. It calculates angle and velocity required to manage this (#peknyObluk :) )
 */
func void Vob_ThrowFromPosToPos (var int vobPtr, var int fromPosPtr, var int targetPosPtr, var int angle) {

	var int trafo[16]; NewTrafo (_@(trafo));

	//dir - vector smeru
	var int dir[3]; SubVectors (_@ (dir), targetPosPtr, fromPosPtr);

	NormalizeVector (_@ (dir));
	VectorDirToTrf (_@ (dir), _@ (trafo));

	//X axis rotation, in order to turn vektor up we have to use negative value for angle
	zMAT4_PostRotateX (_@ (trafo), negf (mkf (angle)));

	//Velocity calculation

	/*
	Thank you helpo1 :)
	SQRT(
		(1/2 * ABS(tiažové zrýchlenie))
	      * (dolet^2 / COS(elevačný uhol)^2)
	      * (1 / (výškový rozdiel + TG(elevačný uhol) * dolet))
	    )
	*/

	//9,823
	var int g; g = mkf (450); //900 seems to be Gothics gravity acceleration
	var int d; d = GetVectorDist (fromPosPtr, targetPosPtr);
	var int b; b = divf (sqrf (d), sqrf (cos (TRF_Deg2Rad (angle))));
	var int h; h = GetVectorDistY (fromPosPtr, targetPosPtr);
	var int c; c = divf (mkf(1), addf (h, mulf (tan (TRF_Deg2Rad (angle)), d)));
	var int velocity; velocity = mulf (mulf (g, b),c);

	//
	if lf (velocity, floatnull) {
		velocity = floatone;
	} else {
		velocity = sqrtf (velocity);
	};

	//
	TrfDirToVector (_@ (trafo), _@ (dir));

	NormalizeVector (_@ (dir));
	MulVector (_@ (dir), velocity);

	//Set physics enabled
	zCVob_SetPhysicsEnabled (vobPtr, 1);
	zCVob_SetSleeping (vobPtr, 0);

	//Apply 'velocity'
	var int rigidBodyPtr; rigidBodyPtr = zCVob_GetRigidBody (vobPtr);
	zCRigidBody_SetVelocity (rigidBodyPtr, _@ (dir));
};

func void Npc_DropInventory (var int slfInstance, var string invSlot, var int dontDropFlags, var int dontDropMainFlag) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	var int noOfCategories;

	if (GOTHIC_BASE_VERSION == 1) {
		noOfCategories = INV_CAT_MAX;
	} else {
		noOfCategories = 1;
	};

	var int armorItemID; armorItemID = -1;
	if (Npc_HasEquippedArmor(slf)) {
		var C_ITEM armorItem; armorItem = Npc_GetEquippedArmor(slf);
		armorItemID = Hlp_GetInstanceID(armorItem);
	};

	var int npcInventoryPtr; npcInventoryPtr = _@ (slf.inventory2_vtbl);

	//Create inventory slot (force creation if it does not exist already)
	NPC_CreateInvSlot (slf, invSlot);

	var int posFrom[3];
	var int nodePosPtr;

	nodePosPtr = NPC_GetNodePositionWorld (slf, invSlot);
	if (nodePosPtr) {
		CopyVector (nodePosPtr, _@ (posFrom));
	};
	MEM_Free (nodePosPtr);

	repeat (invCat, noOfCategories); var int invCat;
		var int itmSlot; itmSlot = 0;
		var int amount; amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);

		var int itemInstanceID;

		while (amount > 0);
			itemInstanceID = Hlp_GetInstanceID (item);

			//Do we want to remove this item?
			//(do not remove equipped armor)
			if ((item.Flags & dontDropFlags) || (item.MainFlag & dontDropMainFlag) || ((armorItemID == itemInstanceID) && (item.Flags & ITEM_ACTIVE_LEGO)))
			{
				itmSlot += 1;
				amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
				continue;
			};

			var int vobPtr; vobPtr = _@ (item);

			//oCNPC_UnequipItemPtr (slf, vobPtr);

			//-->
			//Remove from inventory
			vobPtr = oCNpcInventory_RemoveByPtr (npcInventoryPtr, vobPtr, amount);

			//Put into slot
			oCNpc_PutInSlot_Fixed (slf, invSlot, vobPtr, 0);

			//Drop from slot (this will insert it into the world)
			vobPtr = oCNpc_DropFromSlot (slf, invSlot);

			//Add item dropped flag
			const int ITEM_DROPPED = 1 << 10; // (intern) Dropped
			oCItem_AddFlags (vobPtr, ITEM_DROPPED);

			//Throw item using Vob_ThrowAngle
			var int dir[3];
			dir[0] = mkf (Hlp_Random (1000) * (Hlp_Random (2) * -1));
			dir[1] = mkf (1000); //up
			dir[2] = mkf (Hlp_Random (1000) * (Hlp_Random (2) * -1));

			var int angle; angle = Hlp_Random (360);
			var int velocity; velocity = 200 + Hlp_Random (100);
			Vob_ThrowAngle (vobPtr, _@ (posFrom), _@ (dir), angle, velocity);
			//<--

			amount = NPC_GetInvItemBySlot (slf, invCat, itmSlot);
		end;
	end;
};
