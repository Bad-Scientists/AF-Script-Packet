/*
 *	NPC_AddBlood
 *	 - adds blood texture underneath Npc
 */
func void zCAIPlayer_AddBlood (var int aiPtr, var int v1, var int v2, var int sizef, var int scaleUp, var string texture) {
	//0x004FFE20 public: void __thiscall zCAIPlayer::AddBlood(class zVEC3 const &,class zVEC3 const &,float,int,class zSTRING *)
	const int zCAIPlayer__AddBlood_G1 = 5242400;

	//0x0050F8C0 public: void __thiscall zCAIPlayer::AddBlood(class zVEC3 const &,class zVEC3 const &,float,int,class zSTRING *)
	const int zCAIPlayer__AddBlood_G2 = 5306560;

	if (!aiPtr) { return; };

	CALL_zStringPtrParam (texture);
	CALL_IntParam (scaleUp);
	CALL_FloatParam (sizef);
	CALL_PtrParam (v2);
	CALL_PtrParam (v1);
	CALL__thiscall (aiPtr, MEMINT_SwitchG1G2 (zCAIPlayer__AddBlood_G1, zCAIPlayer__AddBlood_G2));
};

/*
 *	Npc_AddBloodTexture
 *	 - wrapper function that adds blood texture underneath Npc
 */
func void Npc_AddBloodTexture (var int slfInstance, var int scaleUp, var string texture) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	var int pos[3]; MEM_CopyBytes (zCVob_GetPositionWorld (_@ (slf)), _@(pos), 12);

	var int dir[3];
	dir[0] = FLOATNULL;
	dir[1] = negf (mkf (1000));
	dir[2] = FLOATNULL;

	if (!slf.aniCtrl) { return; };

	var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (slf.aniCtrl);

	//TODO: adding it 2x - not sure why - seems like if there is not bloodVob - then adding 'one blood spot' does not work
	if (aniCtrl._zCAIPlayer_bloodVobList_numInArray == 0) {
		zCAIPlayer_AddBlood (slf.aniCtrl, _@ (pos), _@ (dir), mkf (100), scaleUp, texture);
	};

	zCAIPlayer_AddBlood (slf.aniCtrl, _@ (pos), _@ (dir), mkf (100), scaleUp, texture);
};

/*
 *
 */
func void Npc_AddBlood (var int slfInstance, var int scaleUp) {
	var oCNPC slf; slf = Hlp_GetNPC (slfInstance);
	if (!Hlp_IsValidNPC (slf)) { return; };

	Npc_AddBloodTexture (slf, scaleUp, slf.bloodTexture);
};

func int oCNpc_Get_modeBlood () {
	//0x0085862C private: static enum oCNpc::oEBloodMode oCNpc::modeBlood
	const int oCNpc__modeBlood_G1 = 8750636;

	//0x008B0404 private: static enum oCNpc::oEBloodMode oCNpc::modeBlood
	const int oCNpc__modeBlood_G2 = 9110532;
	return + MEM_ReadInt (MEMINT_SwitchG1G2 (oCNpc__modeBlood_G1, oCNpc__modeBlood_G2));
};

/*
 *	Game_SetBloodDetail
 *	 - function sets blood details
 */
func void Game_SetBloodDetail (var int bloodMode) {
	MEM_SetGothOpt ("GAME", "bloodDetail", IntToString (bloodMode));

	//0x0085862C private: static enum oCNpc::oEBloodMode oCNpc::modeBlood
	const int oCNpc__modeBlood_G1 = 8750636;

	//0x008B0404 private: static enum oCNpc::oEBloodMode oCNpc::modeBlood
	const int oCNpc__modeBlood_G2 = 9110532;
	MEM_WriteInt (MEMINT_SwitchG1G2 (oCNpc__modeBlood_G1, oCNpc__modeBlood_G2), bloodMode);
};

/*
 *	Game_GetBloodDetail
 *	 - function returns blood details
 */
func int Game_GetBloodDetail () {
	var int bloodMode; bloodMode = 0;
	var string sBloodMode; sBloodMode = MEM_GetGothOpt ("GAME", "bloodDetail");
	/*
	enum oEBloodMode {
		oEBloodMode_None,
		oEBloodMode_Particles,
		oEBloodMode_Decals,
		oEBloodMode_Trails,
		oEBloodMode_Amplification
	};
	*/

	bloodMode = STR_ToInt (sBloodMode);
	return + bloodMode;
};
