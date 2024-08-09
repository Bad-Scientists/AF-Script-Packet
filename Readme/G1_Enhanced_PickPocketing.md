## G1 Enhanced Pickpocketing
 - Improves pickpocketing:
    - patches additional body-states in which player can pickpocket Npcs. (vanilla `BS_STAND, BS_ITEMINTERACT` + patched `BS_SIT, BS_LIE, BS_MOBINTERACT, BS_MOBINTERACT_INTERRUPT` where Npc is interacting with mobs)
	- adds API function for failed pickpocketing attempt if Npc is too far `void EnhancedPickPocketing_TooFar()`
	- fixes behaviour for failed pickpocketing attempts Npc is aware of. In vanilla only `T_DONTKNOW` animation would be played and nothing would happen. We call `oCNpc_StopTheft` which will send perception `PERC_CATCHTHIEF` to victim.
	- we allow inventory opening even when Npc does not have any items. Vanilla would only play `T_DONTKNOW` ani.
	- we allow player to insert items into Npc inventory. Vanilla would allow only stealing.
	
	- we are using 2 API functions to determine whether item can be
		- stolen from Npc `C_PP_CanBeStolenFromInventory(var C_NPC npc, var int itemPtr)`
		- put into Npc inventory `C_PP_CanBePutToInventory(var C_NPC npc, var int itemPtr)`
			- if these 2 functions return `false` - if player fails to steal/put items into inventory, they will be caught.

	- customizable option to allow player stealing item even when they will get caught via variable `EnhancedPickpocketing_StealItemAnyway`
		- if this option is enabled feature also calls API function `EnhancedPickPocketing_DoStealItemAnyway(var C_NPC npc, var int itemPtr)` when player gets caught
	
Init function: `G1_EnhancedPickPocketing_Init();`

[API file](../Standalone-Packages/G1-EnhancedPickPocketing/enhancedPickPocketing_API.d)
