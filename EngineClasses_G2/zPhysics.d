class zCRigidBody {
	var int mass; //float
	var int massInv; //float
	var int iBody[9]; //zMAT3
	var int iBodyInv[9]; //zMAT3
	var int xPos[3]; //zVEC3
	var int RDir[9]; //zMAT3
	var int PLinMom[3]; //zVEC3
	var int LAngMom[3]; //zVEC3
	var int iInv[9]; //zMAT3
	var int v[3]; //zVEC3
	var int omega[3]; //zVEC3
	var int force[3]; //zVEC3
	var int torque[3]; //zVEC3
	var int gravityScale; //float
	var int slideDir[3]; //zVEC3
	var int slideAngle; //float
	var int bitfield;
	/*
	unsigned char gravityOn      : 1;
	unsigned char collisionHad   : 1;
	unsigned char mode           : 1;
	unsigned char justSetSliding : 4;
	*/
};