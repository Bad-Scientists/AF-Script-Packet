//Minimal required distance
const int PickPocketingDist = 250;

//Internal variables

//Pickpocketing status
var int PickPocketingStatus;
	const int PickPocketingStatus_InActive		= 0;
	const int PickPocketingStatus_Active		= 1;
	const int PickPocketingStatus_Finished		= 2;
	const int PickPocketingStatus_Cancelled		= 3;

var C_NPC StealVictim;

//Armor, which will prevent our StealHelper from despawning
instance ARMOR_PREVENT_DESPAWN (C_Item)
{
	name			= "Dummy armor";
	mainflag		= ITEM_KAT_ARMOR | ITEM_MISSION;        //flag ITEM_MISSION prevents NPC wearing this armor from despawning !

	Flags			= 0;

	protection[PROT_EDGE]	= 0;
	protection[PROT_BLUNT]	= 0;
	protection[PROT_POINT]	= 0;
	protection[PROT_FIRE]	= 0;
	protection[PROT_MAGIC]	= 0;

	value			= 0;
	cond_value [2]		= 0;

	wear			= WEAR_TORSO;
	ownerGuild		= GIL_EBR;
	visual			= "ebrh2.3ds";
	visual_change		= "Hum_EBRS_ARMOR2.asc";
	visual_skin		= 0;
	material		= MAT_METAL;

	description		= name;
	text[1] = NAME_Prot_Edge;	count[1] = protection[PROT_EDGE];
	text[2] = NAME_Prot_Point;	count[2] = protection[PROT_POINT];
	text[3] = NAME_Prot_Fire;	count[3] = protection[PROT_FIRE];
	text[4] = NAME_Prot_Magic;	count[4] = protection[PROT_MAGIC];
	text[5] = NAME_Value;		count[5] = value;
};    

instance StealHelper (C_NPC) {
	name				= "StealHelper";
	id				= 0;

	attribute [ATR_HITPOINTS_MAX]	= 1;
	attribute [ATR_HITPOINTS]	= -1;

	Mdl_SetVisual (self, "HUMANS.MDS");
	Mdl_SetVisualBody (self, "hum_body_Naked0", 0, 1, "Hum_Head_FatBald", 79, 1, ARMOR_PREVENT_DESPAWN);
};

//--- Custom AI state ZS_PickPocketing for player

func void B_AssessDamage_PickPocketing () {
	//Close inventory
	oCNPC_CloseInventory (self);
};

func void ZS_PickPocketing () {
	//Assess damage - close inventory (exit pickpocketing) if attacked
	NPC_PercEnable (self, PERC_ASSESSDAMAGE, B_AssessDamage_PickPocketing);
};

func int ZS_PickPocketing_Loop () {
	//If player cancelled action ... exit AI state
	//If player successfully stole item ... exit AI state
	if ((PickPocketingStatus == PickPocketingStatus_Cancelled) || (PickPocketingStatus == PickPocketingStatus_Finished)) {		
		PickPocketingStatus = PickPocketingStatus_InActive;
		return LOOP_END;
	};

	var string aniName; aniName = NPC_GetAniName (self);

	//At this point function C_NPCIsDown is not yet parsed, so we have to call it using MEM_Call
	var int npcIsDown;
	MEM_PushInstParam (StealVictim);
	MEM_Call (C_NPCIsDown);
	npcIsDown = MEMINT_PopInt();
	
	//Npc can see player! (and is not sleeping/down)
	if (NPC_CanSeeNPC (StealVictim, self))
	&& (!STR_StartsWith (aniName, "S_BED"))
	&& (!Hlp_StrCmp (aniName, "S_VICTIM_SLE"))
	&& (!npcIsDown)
	{
		//Close inventory
		oCNPC_CloseInventory (self);
		
		NPC_SetTarget (StealVictim, self);
		NPC_GetTarget (StealVictim);
		AI_StartState (StealVictim, ZS_AssessEnemy, 0, "");
		
		PickPocketingStatus = PickPocketingStatus_InActive;
		return LOOP_END;
	};

	//NPC is too far away
	if (NPC_GetDistToNPC (StealVictim, self) > PickPocketingDist + 50)
	&& (!npcIsDown)
	{
		//Close inventory
		oCNPC_CloseInventory (self);

		//Attack
		NPC_SetTarget (StealVictim, self);
		NPC_GetTarget (StealVictim);
		AI_StartState (StealVictim, ZS_AssessEnemy, 0, "");

		PickPocketingStatus = PickPocketingStatus_InActive;
		return LOOP_END;
	};

	return LOOP_CONTINUE;
};

func void ZS_PickPocketing_End () {
};

//
func int _daedalusHook_G_CanSteal () {
	//self == thief
	//other == victim

	if (!Hlp_IsValidNPC (self)) || (!Hlp_IsValidNPC (other)) { return FALSE; };

	//You have to define your own rules in new function C_CanPickPocket
	if (C_CanPickPocket (self, other))
	&& (NPC_GetDistToNPC (self, other) <= PickPocketingDist)
	{
		var oCNPC npc; npc = Hlp_GetNPC (StealHelper);
		if (!Hlp_IsValidNPC (npc)) {
			var C_NPC selfBackup; selfBackup = Hlp_GetNPC (self);
			Wld_InsertNPC (StealHelper, "TOT");
			self = Hlp_GetNPC (selfBackup);

			npc = Hlp_GetNPC (StealHelper);
			if (!Hlp_IsValidNPC (npc)) {
				return FALSE;
			};
		};

		StealVictim = Hlp_GetNPC (other);

		//Transfer inventory from StealVictim to StealHelper
		NPC_TransferInventory (StealVictim, StealHelper, FALSE, FALSE, TRUE);

		//Change focus to StealHelper
		oCNPC_SetFocusVob (self, _@ (npc));

		//Open StealHelper
		oCNPC_OpenDeadNpc (self);

		PickPocketingStatus = PickPocketingStatus_Active;

		PC_IgnoreAnimations += 1;
	
		//Start state on thief (player)
		AI_StartState (self, ZS_PickPocketing, 1, "");
	};

	return FALSE;
};

func void _eventTransferItem_PickPocketing (var int dummyVariable) {
	if (PickPocketingStatus != PickPocketingStatus_Active) { return; };

	//Even though this function is supposedly method of oCItemContainer class, reading out vtbl in ECX gives me 8245076 (oCNPCContainer_vtbl)
	//After some trial-error testing, we can safely use oCNpcContainer here
	var oCNpcContainer NpcContainer;

	if (!Hlp_Is_oCNpcContainer (ECX)) { return; };
	NpcContainer = _^ (ECX);

	//ECX		oCItemContainer -> 8245076 -> oCNPCContainer
	//ESP + 4	?
	//ESP + 8	1 -> quantity

	var oCNPC her;
	
	//PickPocketingStatus finished
	PickPocketingStatus = PickPocketingStatus_Finished;

	if (!Hlp_Is_oCNpc (NpcContainer.inventory2_owner)) { return; };

	//Get inventory owner
	var oCNPC npc; npc = _^ (NpcContainer.inventory2_owner);

	//Get item
	var oCItem itm; itm = _^ (List_GetS (NpcContainer.inventory2_oCItemContainer_contents, NpcContainer.inventory2_oCItemContainer_selectedItem + 2));
	
	//Get amount
	var int amount; amount = itm.amount;
	
	//Get item instance
	var int itmInstance; itmInstance = Hlp_GetInstanceID (itm);

	//Create selected item * amount in players inventory
	CreateInvItems (hero, itmInstance, amount);
	NPC_RemoveInvItems (npc, itmInstance, amount);

	//Adjust 'stolen qty' - set to 0 - this will not transfer anything in original function
	MEM_WriteInt (ESP + 8, 0);
			
	oCNPC_SetFocusVob (hero, 0);

	//Close inventory
	//0x0066C1E0 public: virtual void __thiscall oCNpcInventory::Close(void) 
	const int oCNpcInventory__Close = 6734304;
	CALL__thiscall (_@ (NpcContainer), oCNpcInventory__Close);

	//Transfer inventory back to victim
	NPC_TransferInventory (StealHelper, StealVictim, FALSE, FALSE, TRUE);

	//API function called (for XP, anything else you want)
	B_PickPocketing_Successfull ();
};

func void _eventCloseInventory_PickPocketing (var int eventType) {
	//Is player in pickpocketing dialog?
	if (PickPocketingStatus == PickPocketingStatus_Active) {

		//In certain situations we have to close inventory dead npc inventary by ourselves (otherwise it would remain opened)
		if (eventType == evOpenScreenMap) || (eventType == evStatusScreenShow) || (eventType == evLogScreenShow) {
			oCNPC_CloseDeadNpc (StealHelper);
		};

		oCNPC_SetFocusVob (hero, 0);
		NPC_TransferInventory (StealHelper, StealVictim, FALSE, FALSE, TRUE);
		PickPocketingStatus = PickPocketingStatus_Cancelled;
	};
};

func void G1_EnhancedPickPocketing_Init () {
	//Initialize close inventory events
	G12_GameEvents_Init ();

	//Enable new player states
	G12_EnablePlayerStates_Init ();

	//Intercept NPC event states (prevent T_DONTKNOW ani)
	G12_InterceptNpcEventMessages_Init ();

	//Add listener for inventory closing event
	CloseInventoryEvent_AddListener (_eventCloseInventory_PickPocketing);

	//Add listener for item transfer event
	TransferItemEvent_AddListener (_eventTransferItem_PickPocketing);

	const int once = 0;
	if (!once) {
		//We will exploit G_CanSteal function - in vanilla G1 version this one determines whether you can/can't pickpocket NPC.
		//Here I will replace it with new function - that will always return FALSE - this will never trigger vanilla pickpocketing.
		//Instead we will create our own pickpocketing system.
		HookDaedalusFunc (G_CanSteal, _daedalusHook_G_CanSteal);
		
		//Function is called on transfer from npc to npc, from npc to chest
		//HookEngine (oCItemContainer__TransferItem, 5, "_hook_oCItemContainer__TransferItem");

		once = 1;
	};
};
