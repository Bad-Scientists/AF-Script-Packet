## G12 Sprint mode

## :construction: :construction_worker: :construction: README UNDER CONSTRUCTION :construction: :construction_worker: :construction:
 
- Enables simple sprint mode:
   - adds stamina bar on screen
   - depleting stamina bar will result in sprint being disabled together with 4 seconds cooldown period
   - jumping and fighting consumes significant amount of stamina
   - potions of speed disable stamina consumption with the potions still having the same effect
   - potions of speed have their own texture of stamina bar - you will see how much time is left from potion effect
   - this feature restores speed potion effect (timed overlay) on game load
   - it also fixes error where multiple potion effects (multiple timed overlays with different times) would remove overlay

```c++
/*
 *	Sprint mode
 *		- toggle 'afsp.keySprintModeToggleKey' key to enable/disable sprint mode
 *		- 'afsp.keySprintModeToggleKey' can be defined either in Gothic.ini file section [KEYS] or mod.ini file section [KEYS]. (master is Gothic.ini)
 *		- if 'afsp.keySprintModeToggleKey' is not defined then by default KEY_RSHIFT will be used for toggling
 *
 *		- you need to maintain stamina levels for player by yourself - set PC_SprintModeStaminaMax to whatever value makes sense to you at the beginning of the game in your STARTUP function:
 *			PC_SprintModeStaminaMax = 80;				//Max stamina level
 *			PC_SprintModeStamina = PC_SprintModeStaminaMax;		//Current stamina level
 *			PC_SprintModeConsumeStamina = TRUE;			//Make sure this is set to true
 *
 *	Requires LeGo flags: LeGo_HookEngine | LeGo_FrameFunctions | LeGo_Bars
 */
```

    [![G1&2 Sprint mode](https://img.youtube.com/vi/x8N7AS1mawo/0.jpg)](https://www.youtube.com/watch?v=x8N7AS1mawo)

Init function: `G12_SprintMode_Init();`
1. Required LeGo flags: `LeGo_HookEngine | LeGo_FrameFunctions | LeGo_Bars`.

[API file](../Standalone-Packages/G12-SprintMode/sprintMode_API.d)
