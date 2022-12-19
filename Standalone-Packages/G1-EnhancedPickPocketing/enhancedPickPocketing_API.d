/*
 *	[Enhanced PickPocketing]
 *
 *	How does it work:
 *		- with LeGo HookDaedalusFunc function we hook vanilla G1 function G_CanSteal and call instead _daedalusHook_G_CanSteal, G_CanSteal is called by engine when player attempts to steal items from NPC:
 *			- our hooked _daedalusHook_G_CanSteal function will call C_Npc_CanBePickPocketed (self, other) [self = thief, other = victim] and will check distance to NPC.
 *			- if NPC is close enough and C_Npc_CanBePickPocketed returns true then _daedalusHook_G_CanSteal will insert to world new NPC StealHelper onto waypoint TOT. NPC is inserted dead.
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

			func void B_AssessSC () {

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
 */

/*
//Minimal required distance
const int PICKPOCKETINGDIST = 250;

//C_Npc_CanBePickPocketed
// - check if Npc can be pickpocketed. Return true if yes.
//slf - thief
//oth - victim
func int C_Npc_CanBePickPocketed (var C_NPC slf, var C_NPC oth) {
	return TRUE;
};

//B_WasPickPocketed
// - called when pickpocketing is successful - add here your own aivar update (assuming that you will use aivar to prevent multiple pickpocketings)
// - oth - steal victim
func void B_WasPickPocketed (var C_NPC oth) {
};
*/
