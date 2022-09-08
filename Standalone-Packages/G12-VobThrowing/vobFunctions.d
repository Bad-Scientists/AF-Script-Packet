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
