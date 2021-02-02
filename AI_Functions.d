func void AI_TurnToPos (var int slfInstance, var int posPtr) {
	if (!posPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	slf.soundPosition[0] = MEM_ReadIntArray(posPtr, 0);
	slf.soundPosition[1] = MEM_ReadIntArray(posPtr, 1);
	slf.soundPosition[2] = MEM_ReadIntArray(posPtr, 2);

	AI_TurnToSound (slf);
};


func void AI_TurnToWP (var int slfInstance, var string waypoint) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int wpPtr; wpPtr = SearchWaypointByName (waypoint);
	if (!wpPtr) { return; };
	
	var zCWaypoint wp; wp = _^ (wpPtr);
	AI_TurnToPos (slf, _@ (wp.pos));
};

/*
	AI_TurnAwayWP

							[waypoint]
						/
					/
				[self]			([dir vector] = [waypoint] - [self])
			/
		/
	[pos]						(pos = [self] - [dir vector])
*/
func void AI_TurnAwayWP (var int slfInstance, var string waypoint) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int wpPtr; wpPtr = SearchWaypointByName (waypoint);
	
	if (!wpPtr) { return; };
	
	var zCWaypoint wp; wp = _^ (wpPtr);

	var int pos[3];		//position - vob
	copyVector (_@ (wp.pos), _@ (pos));

	var int posSelf[3];	//position - slf
	var int dir[3];		//direction - slf - wp

	//get position of slf
	TrfToPos (_@ (slf._zCVob_trafoObjToWorld), _@ (posSelf));

	//subtract posSelf from pos - to get 'direction vector'
	subVectors (_@ (dir), _@(pos), _@ (posSelf));

	//subtract direction vector from posSelf - should be basically pos rotated by 180 around self pos
	subVectors (_@ (pos), _@ (posSelf), _@ (dir));

	AI_TurnToPos (slf, _@ (pos));
};

func void AI_TurnToVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCVob vob; vob = _^(vobPtr);
	
	var int pos[3];
	TrfToPos (_@(vob.trafoObjToWorld), _@ (pos));
	
	AI_TurnToPos (slf, _@ (pos));
};

func void AI_TurnAwayVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCVob vob; vob = _^(vobPtr);
	
	var int pos[3];		//position - vob
	TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));

	var int posSelf[3];	//position - slf
	var int dir[3];		//direction - slf - vob

	//get position of slf
	TrfToPos (_@ (slf._zCVob_trafoObjToWorld), _@ (posSelf));

	//subtract pos slf from pos - to get 'direction vector'
	subVectors (_@ (dir), _@(pos), _@ (posSelf));

	//subtract direction vector from self - should be basically pos rotated by 180 around self pos
	subVectors (_@ (pos), _@ (posSelf), _@ (dir));
	
	AI_TurnToPos (slf, _@ (pos));
};

func void AI_GotoPos (var int slfInstance, var int posPtr) {
	if (!posPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	slf.soundPosition[0] = MEM_ReadIntArray(posPtr, 0);
	slf.soundPosition[1] = MEM_ReadIntArray(posPtr, 1);
	slf.soundPosition[2] = MEM_ReadIntArray(posPtr, 2);
	
	AI_GotoSound (slf);
};

func void AI_GotoVobPtr (var int slfInstance, var int vobPtr) {
	if (!vobPtr) { return; };

	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var zCVob vob; vob = _^(vobPtr);
	
	var int pos[3];
	TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));
	
	AI_GotoPos (slf, _@ (pos));
};

func void _AI_TeleportKeepQueue (var string vobName) {
	self = _^ (ECX);

	var int pos[3];

	var zCVob Vob;
	var int vobPtr;

	//Search for Vob Name
	vobPtr = MEM_SearchVobByName (vobName);

	//if Vob does not exist - search for waypoint
	if (!vobPtr) {
		var int wpPtr; wpPtr = SearchWaypointByName (vobName);

		//if waypoint does not exist - exit
		if (!wpPtr) { return; };

		var zCWaypoint wp;
		wp = _^ (wpPtr);
		copyVector (_@ (wp.pos), _@ (pos));
	} else {
		Vob = _^ (vobPtr);
		TrfToPos (_@ (vob.trafoObjToWorld), _@ (pos));
	};

	Vob = Hlp_GetNPC (self);

	//Update hero's position
	//TODO: teleport to Vob needs to be updated
	Vob.trafoObjToWorld[3] = pos[0];
	Vob.trafoObjToWorld[7] = pos[1];
	Vob.trafoObjToWorld[11] = pos[2];
};

func void AI_TeleportKeepQueue (var int slfInstance, var string vobName) {
	var C_NPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };
	AI_PlayAni (slf, "T_STAND_2_TELEPORT");
	AI_Function_S (slf, _AI_TeleportKeepQueue, vobName);
	AI_PlayAni (slf, "T_TELEPORT_2_STAND");
};
