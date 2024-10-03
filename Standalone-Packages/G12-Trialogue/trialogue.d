/*
 *	Trialogue [WIP / experimental]
 *	 - my attempt at 'trialogue' implementation :)
 *
 *	We are overriding ZS state and talking with pointers to really engage Npcs into conversations.
 *	This should allow us to properly work with AI queues and to have more wysiwyg/comprehensive dialogue script-structure.
 */

// -- Internal variables --
const int Trialogue_MaxNpc = 255;
var int Trialogue_NpcPtr[Trialogue_MaxNpc];
var int Trialogue_NpcPtrCount;

instance trialogueLastSelf (C_NPC);

//override camera target when ActivateDialogCam is called (AI_Output will always update .talkOther target)
var int trialogueOverrideCameraTarget;
var int trialogueIsActive;

//Backup default dialogue distance
var int trialogueBackupDiaDistance;

// -- ZS state --
func void ZS_Trialogue() {
};

func int ZS_Trialogue_Loop() {
    if (InfoManager_hasFinished()) {
        return LOOP_END;
    } else {
        return LOOP_CONTINUE;
    };
};

func void ZS_Trialogue_End() {
};

// -- Implementation --

/*
 *	Trialogue_AddNpcPtr
 */
func void Trialogue_AddNpcPtr (var int npcPtr) {
	if (Trialogue_NpcPtrCount == Trialogue_MaxNpc) {
		zSpy_Info ("Trialogue: max number of Npcs in trialogue is 255.");
		return;
	};

    MEM_WriteStatArr(Trialogue_NpcPtr, Trialogue_NpcPtrCount, npcPtr);
    Trialogue_NpcPtrCount += 1;
};

/*
 *	NpcPtr_SetTalkingWithPtr
 */
func void NpcPtr_SetTalkingWithPtr (var int slfPtr, var int othPtr) {
	var oCNpc slf; slf = _^ (slfPtr);
	slf.talkOther = othPtr;
};

/*
 *	Trialogue_Start
 */
func void Trialogue_Start () {
	//Backup default dialogue distance - we will be increasing it if required
	trialogueBackupDiaDistance = G12_GetDefaultDialogueDistance ();
	trialogueLastSelf = Hlp_GetNpc (self);

	//Reset pointer
	trialogueOverrideCameraTarget = 0;

	//Reset number of Npcs
	Trialogue_NpcPtrCount = 0;

	//Add self & hero to list of Npcs
	Trialogue_AddNpcPtr (_@ (self));
	Trialogue_AddNpcPtr (_@ (hero));

	trialogueIsActive = TRUE;
};

/*
 *	Trialogue_Invite
 */
func void Trialogue_Invite (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	//Clear all AI queue messages up until this point
	if (Npc_IsInActiveVobList (slf)) {
		Npc_ClearAIQueue (slf);
	};

	//Npc_StartAIState updates self - back it up
	var C_NPC bSelf; bSelf = Hlp_GetNpc (self);
    var int retVal; retVal = Npc_StartAIState (slf, "ZS_Trialogue", 0, 0, FLOATNULL, 0);
	self = Hlp_GetNpc (bSelf);

	//Add npc to the list of all Npcs in trialogue
	Trialogue_AddNpcPtr (_@ (slf));
};

/*
 *	Trialogue_Wait
 */
func void Trialogue_Wait (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);

	AI_WaitTillEnd (trialogueLastSelf, slf);
	AI_WaitTillEnd (slf, trialogueLastSelf);

	//Sync hero with new npc & npc with hero
	AI_WaitTillEnd (hero, slf);
	AI_WaitTillEnd (slf, hero);

	//Sync all Npcs invited to trialogue

	var oCNpc lastNpc;
	var oCNpc nextNpc;

	var int npcPtr; npcPtr = MEM_ReadStatArr(Trialogue_NpcPtr, 0);
	if (!npcPtr) { return; };

	lastNpc = _^ (npcPtr);

	var int i; i = 1;
	while (i < Trialogue_NpcPtrCount);
		npcPtr = MEM_ReadStatArr(Trialogue_NpcPtr, i);

		if (npcPtr) {
			nextNpc = _^ (npcPtr);
			AI_WaitTillEnd (nextNpc, lastNpc);
			lastNpc = Hlp_GetNpc (nextNpc);
		};

		i += 1;
	end;
};

/*
 *	Trialogue_Next
 */
func void _Trialogue_Next (var int slfPtr) {
	var oCNpc slf; slf = _^ (slfPtr);

	//Override talking with target ... otherwise Npc OU wont play as engine will think Npc is talking with someone else:
	//"U: NPC: Output-Unit "+csg->name+" not started. Another NSC is having a conversation with targetNpc :"

	//We have to override .talkOther with 0 for self --> self might be talking with 'third' npc and not the player!
	NpcPtr_SetTalkingWithPtr (slfPtr, 0);

	//Safety check - if Npc is too far, engine won't display subtitles ... so we will adjust dialogue distance if needed
	var int npcDistance; npcDistance = Npc_GetDistToNpc (slf, hero);
	var int dialogueDistance; dialogueDistance = G12_GetDefaultDialogueDistance ();

	if (npcDistance > dialogueDistance) {
		G12_SetDisplayDialogueDistance (npcDistance);
	};

	//'Pretend' that Npc is in ZS_TALK state - otherwise OU would play as 'noise' dialogue
	Npc_SetAIState (slf, "ZS_TALK");
};

func void Trialogue_Next (var int slfInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	if (!Hlp_IsValidNpc (slf)) { return; };

	Trialogue_Wait (slfInstance);

	trialogueLastSelf = Hlp_GetNpc (slfInstance);

 	AI_Function_I (hero, _Trialogue_Next, _@ (slf));
};

/*
 *	Trialogue_SetCamera
 */
func void _Trialogue_SetCameraPtr (var int slfPtr, var int othPtr) {
	var oCNpc slf; slf = _^ (slfPtr);
	var oCNpc oth; oth = _^ (othPtr);

	//Setup override variable (has to be setup before calling oCNpc_ActivateDialogCam)
	trialogueOverrideCameraTarget = slfPtr;

	//Activate camera immediately
	if (oCNpc_ActivateDialogCam (oth, slf, FLOATNULL)) {
		var int aiPtr; aiPtr = zCSession_GetCameraAI ();
		zCAICamera_ReceiveMsg (aiPtr, _@ (zPLAYER_BEAMED));
	};
};

func void Trialogue_SetCamera (var int slfInstance, var int othInstance) {
	var oCNpc slf; slf = Hlp_GetNpc (slfInstance);
	var oCNpc oth; oth = Hlp_GetNpc (othInstance);

	Trialogue_Wait (slfInstance);

	AI_Function_II (hero, _Trialogue_SetCameraPtr, _@ (slf), _@ (oth));
};

/*
 *	Trialogue_Finish
 */
func void _Trialogue_Finish () {
	//Reset pointer
	trialogueOverrideCameraTarget = 0;

	trialogueIsActive = FALSE;

	//Restore default dialogue distance
	G12_SetDisplayDialogueDistance (trialogueBackupDiaDistance);
};

func void Trialogue_Finish () {
	if (!MEM_Game.infoman) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.npc)) { return; };
	if (!Hlp_Is_oCNpc (MEM_InformationMan.player)) { return; };

	var C_NPC slf; slf = _^ (MEM_InformationMan.npc);
	var C_NPC oth; oth = _^ (MEM_InformationMan.player);

	AI_WaitTillEnd (slf, oth);
	AI_WaitTillEnd (oth, slf);

	Trialogue_Wait (slf);
	Trialogue_Wait (oth);

	AI_Function (hero, _Trialogue_Finish);
};

/*
 *	_hook_oCNpc_ActivateDialogCam
 *	 - hook overriding .talkOther property before activating camera
 */
func void _hook_oCNpc_ActivateDialogCam () {
	if (!Hlp_Is_oCNpc (ECX)) { return; };
	var oCNpc slf; slf = _^ (ECX);

	//Camera switches to .talkOther - override here
	if (trialogueOverrideCameraTarget) {
		slf.talkOther = trialogueOverrideCameraTarget;
	};
};

func void G12_Trialogue_Init () {
	const int once = 0;

	if (!once) {
		//0x006B2430 public: int __thiscall oCNpc::ActivateDialogCam(float)
		const int oCNpc__ActivateDialogCam_G1 = 7021616;

		//0x00758130 public: int __thiscall oCNpc::ActivateDialogCam(float)
		const int oCNpc__ActivateDialogCam_G2 = 7700784;
		HookEngine (MEMINT_SwitchG1G2 (oCNpc__ActivateDialogCam_G1, oCNpc__ActivateDialogCam_G2), 6, "_hook_oCNpc_ActivateDialogCam");

		once = 1;
	};
};
