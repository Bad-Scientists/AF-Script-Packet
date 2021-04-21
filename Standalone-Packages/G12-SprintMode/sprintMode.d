/*
 *	Sprint mode
 *		- double tap Caps Lock to turn on sprinting:
 *		  NPC_RUN > NPC_WALK > NPC_RUN (HUMANS_SPRINT.MDS) > NPC_WALK > NPC_RUN > NPC_RUN (HUMANS_SPRINT.MDS)
 */

var int PC_SprintMode;

func void _hook_oCAniCtrl_Human__ToggleWalkMode () {
	var oCAniCtrl_Human aniCtrl; aniCtrl = _^ (ECX);
	
	var oCNPC slf; slf = _^ (aniCtrl.npc);
	
	if (NPC_IsPlayer (slf)) {

		if (aniCtrl.nextwalkmode == NPC_RUN) {
			PC_SprintMode = (!PC_SprintMode);

			if (PC_SprintMode) {
				Mdl_ApplyOverlayMds (slf, "HUMANS_SPRINT.MDS");
			};
		} else {
			if (PC_SprintMode) {
				Mdl_RemoveOverlayMds (slf, "HUMANS_SPRINT.MDS");
			};
		};
	};
};

func void G12_SprintMode_Init () {
	const int once = 0;

	if (!once) {
		HookEngine (oCAniCtrl_Human__ToggleWalkMode, 6, "_hook_oCAniCtrl_Human__ToggleWalkMode");
		once = 1;
	};
};
