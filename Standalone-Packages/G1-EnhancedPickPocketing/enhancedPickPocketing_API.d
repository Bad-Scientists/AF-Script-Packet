/*
 *	[Enhanced PickPocketing]
 *
 *	How does it work:
 *		- with LeGo HookDaedalusFunc function we hook vanilla G1 function G_CanSteal and call instead _daedalusHook_G_CanSteal, G_CanSteal is called by engine when player attempts to steal items from NPC:
 *			- our hooked _daedalusHook_G_CanSteal function will call C_CanPickPocket (self, other) [self = thief, other = victim] and will check distance to NPC.
 *			- if NPC is close enough and C_CanPickPocket returns true then _daedalusHook_G_CanSteal will insert to world new NPC StealHelper onto waypoint TOT. NPC is inserted dead.
 *			- inventory of NPC will be temporarily transferred from NPC to StealHelper.
 *			- hero.focus_vob is changed to dead StealHelper and by calling oCNPC_OpenDeadNpc (StealHelper) script opens StealHelper's inventory.
 *		- script starts ZS_PickPocketing ai state for hero:
 *			- ZS_PickPocketing makes sure that victim does not see hero, if he does, it closes inventory and steal victim attacks hero.
 *			- ZS_PickPocketing checks distance between hero and victim, if victim goes away script again closes inventory.
 *			- ZS_PickPocketing also enables perception PERC_ASSESSDAMAGE, where if hero receives any damage inventory again closes.
 *		- there are also 2 more hooked engine inventory 'events':
 *			- transfer item event - when 1 item is transferred from StealHelper to hero's inventory, script closes inventory, transfers inventory from StealHelper back to StealVictim.
 *			- inventory closing event - this will transfer inventory back from StealHelper to StealVictim.
 *
 *	AI constraints:
 *		- G1 vanilla AI is fundamentally broken, without fixing it this feature is useles ...
 *			- (!C_BodyStateContains(other,BS_SNEAK)) doesn't work, because bodystate BS_SNEAK is present only when hero is moving.
 *
 *		- You need to update B_AssessSC - check if player is in ZS_PickPocketing AI state, if yes - close player's inventory and start ZS_CatchThief on NPC
 *

			FUNC VOID B_AssessSC () {

				if (NPC_GetWalkMode (hero) != NPC_SNEAK)
				|| (NPC_CanSeeNPC (self, hero) && (NPC_IsNpcInAngleX (self, hero, 60)))
				{
					if (NPC_IsInState (hero, ZS_PickPocketing))
					{
						//Nastavime target na hero, a other na hero
						NPC_SetTarget (self, hero);
						NPC_GetTarget (self);

						oCNPC_CloseInventory (hero);

						B_FullStop (self);
						AI_StartState (self, ZS_CatchThief, 0, "");

						return;
					};

					...
				};

				...
			};
 *
 *	C_CanPickPocket - define your own conditions
 *
 *	This feature requires 1 reserved AI variable !
 */
const int AIV_MOD_PICKPOCKET				= 49;
	const int PickPocketing_CanBePickPocketed	= 0;
	const int PickPocketing_PickPocketed		= 1;

//slf - thief
//oth - victim
func int C_CanPickPocket (var C_NPC slf, var C_NPC oth) {
	//My custom mod function located outside of this package
	var int retVal;
	MEM_PushInstParam (slf);
	MEM_PushInstParam (oth);
	MEM_CallByString ("C_ModCanPickPocket");
	retVal = MEM_PopIntResult ();

	return retVal;
};

/*
For example here is my function, where I am checking whether NPC can be pickpocketed or not:
func int C_ModCanPickPocket (var C_NPC slf, var C_NPC oth) {
	//Player Talent PickPocketing
	if (!vPT_PickPocketing) { return FALSE; };

	//If NPC was already pickpocketed we wont be able to steal more items
	if (oth.aivar [AIV_MOD_PICKPOCKET] == PickPocketing_PickPocketed) { return FALSE; };

	//We can't steal anything from traders
	if (C_NPCIsTrader (oth)) { return FALSE; };

	//We can't steal anything from monsters
	if (C_NPCIsMonster (oth)) { return FALSE; };

	//We can't steal anything with low dexterity
	if (oth.attribute [ATR_DEXTERITY] >= slf.attribute [ATR_DEXTERITY]) { return FALSE; };

	//Additional conditions (quests/NPCs/items)
	if (!C_NpcCanBePickPocketed (slf, oth)) { return FALSE; };

	return TRUE;
};
*/

func void B_PickPocketing_Successfull () {
	//My custom mod function located outside of this package
	MEM_CallByString ("B_PickPocketing_GiveXP");

	var C_NPC npc; npc = Hlp_GetNPC (StealVictim);
	npc.aivar [AIV_MOD_PICKPOCKET] = PickPocketing_PickPocketed;
};
